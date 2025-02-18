var/global/account_hack_attempted = 0

/datum/event/money_hacker
	var/datum/money_account/affected_account
	endWhen = 100
	var/end_time

/datum/event/money_hacker/setup()
	end_time = world.time + 6000
	if(all_money_accounts.len)
		affected_account = pick(all_money_accounts)

		account_hack_attempted = 1
	else
		kill()

/datum/event/money_hacker/announce()
	var/obj/machinery/message_server/MS = get_message_server()
	if(MS)
		// Hide the account number for now since it's all you need to access a standard-security account. Change when that's no longer the case.
		var/message = "Зафиксирована атака на финансовую систему с помощью метода полного перебора, выполняемая с момента [stationtime2text()]. Целью атаки является: Финансовый счет #[affected_account.account_number], \
		без вмешательства эта атака будет успешной примерно через 10 минут. Необходимое вмешательство: временная приостановка работы затронутых учетных записей до тех пор, пока атака не прекратится. \
		Уведомления будут отправляться по мере появления обновлений."
		var/my_department = "Системы Внутренней Безопасности ЭКСО [location_name()]"
		MS.send_rc_message("XO's Desk", my_department, message, "", "", 2)

/datum/event/money_hacker/tick()
	if(world.time >= end_time)
		endWhen = activeFor
	else
		endWhen = activeFor + 10

/datum/event/money_hacker/end()
	var/message = "Атака прекратилась, теперь пострадавшие аккаунты могут быть продолжены использоваться."
	if(affected_account && !affected_account.suspended)
		//hacker wins
		message = "Попытка взлома увенчалась успехом."

		//subtract the money
		var/amount = affected_account.money * 0.8 + (rand(2,4) - 2) / 10

		//create a taunting log entry
		var/name = pick("","[pick("Biesel","New Gibson")] GalaxyNet Terminal #[rand(111,999)]","your mums place","nantrasen high CommanD")
		var/purpose = pick("Ne$ ---ount fu%ds init*&lisat@*n","PAY BACK YOUR MUM","Funds withdrawal","pWnAgE","l33t hax","liberationez")
		var/datum/transaction/singular/T = new(affected_account, name, -amount, purpose)
		var/date1 = "31 December, 1999"
		var/date2 = "[num2text(rand(1,31))] [pick("January","February","March","April","May","June","July","August","September","October","November","December")], [rand(1000,3000)]"
		T.date = pick("", stationdate2text(), date1, date2)
		var/time1 = rand(0, 99999999)
		var/time2 = "[round(time1 / 36000)+12]:[pad_left(time1 / 600 % 60, 2, "0")]"
		T.time = pick("", stationtime2text(), time2)

		T.perform()

	var/obj/machinery/message_server/MS = get_message_server()
	if(MS)
		var/my_department = "Системы Внутренней Безопасности ЭКСО [location_name()]"
		MS.send_rc_message("XO's Desk", my_department, message, "", "", 2)
