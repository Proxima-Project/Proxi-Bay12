import os
import io
import re
from pathlib import Path
import shutil
from ruamel import yaml
from github import Github, InputGitAuthor

CL_BODY = re.compile(r"(:cl:|🆑)(.+)?\r\n((.|\n|\r)+?)\r\n\/(:cl:|🆑)", re.MULTILINE)
CL_SPLIT = re.compile(r"(^\w+):\s+(\w.+)", re.MULTILINE)

# Blessed is the GoOnStAtIoN birb ZeWaKa for thinking of this first
repo = os.getenv("GITHUB_REPOSITORY")
sha = os.getenv("GITHUB_SHA")

os.putenv("PR_NUM", "-1")  # Don't commit if we don't need to

git = Github()
repo = git.get_repo(repo)
commit = repo.get_commit(sha)
pr_list = commit.get_pulls()

if not pr_list.totalCount:
    print("Direct commit detected")
    exit(0) # Change to '0' if you do not want the action to fail when a direct commit is detected

pr = pr_list[0]

pr_body = pr.body
pr_number = pr.number
pr_author = pr.user.login

write_cl = {}
try:
    cl = CL_BODY.search(pr_body)
    cl_list = CL_SPLIT.findall(cl.group(3))
except AttributeError:
    print("No CL found!")
    exit(0) # Change to '0' if you do not want the action to fail when no CL is provided


if cl.group(2) is not None:
    write_cl['author'] = cl.group(2).lstrip()
else:
    write_cl['author'] = pr_author

write_cl['delete-after'] = True

with open(Path.cwd().joinpath("tools/changelog/tags.yml")) as file:
    tags = yaml.safe_load(file)

write_cl['changes'] = []

for k, v in cl_list:
    if k in tags['tags'].keys(): # Check to see if there are any valid tags, as determined by tags.yml
        v = v.rstrip()
        if v not in list(tags['defaults'].values()): # Check to see if the tags are associated with something that isn't the default text
            write_cl['changes'].append({tags['tags'][k]: v})

if write_cl['changes']:
    with io.StringIO() as cl_contents:
        yaml = yaml.YAML()
        yaml.indent(sequence=4, offset=2)
        yaml.dump(write_cl, cl_contents)
        cl_contents.seek(0)

        with open(f"html/changelogs/AutoChangeLog-pr-{pr_number}.yml", 'w') as f:
            shutil.copyfileobj(cl_contents, f)

    os.putenv("PR_NUM", f"{pr_number}")  # For the PR number in the commit info
    print("Done!")
else:
    print("No CL changes detected!")
    exit(0) # Change to a '1' if you want the action to count lacking CL changes as a failure
