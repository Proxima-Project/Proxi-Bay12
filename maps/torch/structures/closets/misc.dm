/decl/closet_appearance/secure_closet/torch/sol
	color = COLOR_WALL_GUNMETAL
	extra_decals = list(
		"stripe_vertical_mid_full" =  COLOR_NT_RED
	)

/decl/closet_appearance/secure_closet/torch/sol/rep
	color = COLOR_BABY_BLUE
	extra_decals = list(
		"stripe_vertical_left_full" =  COLOR_OFF_WHITE,
		"stripe_vertical_right_full" =  COLOR_OFF_WHITE
	)

/decl/closet_appearance/secure_closet/torch/corporate
	color = COLOR_BOTTLE_GREEN
	extra_decals = list(
		"stripe_vertical_mid_full" = COLOR_OFF_WHITE
	)

/decl/closet_appearance/secure_closet/torch/corporate/liaison
	extra_decals = list(
		"stripe_vertical_left_full" =  COLOR_OFF_WHITE,
		"stripe_vertical_right_full" = COLOR_OFF_WHITE,
		"command" = COLOR_OFF_WHITE
	)

/decl/closet_appearance/secure_closet/torch/corporate/research_guard
	extra_decals = list(
		"stripe_vertical_left_full" =  COLOR_OFF_WHITE,
		"stripe_vertical_right_full" = COLOR_OFF_WHITE,
		"security" = COLOR_OFF_WHITE
	)

/obj/structure/closet/secure_closet/liaison
	name = "\improper corporate liaison's locker"
	req_access = list(access_liaison)
	closet_appearance = /decl/closet_appearance/secure_closet/torch/corporate/liaison

/obj/structure/closet/secure_closet/liaison/WillContain()
	return list(
		/obj/item/device/flash,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/tape/random = 3,
		/obj/item/storage/secure/briefcase,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/under/rank/internalaffairs/plain/nt,
		/obj/item/clothing/suit/storage/toggle/suit/black,
		/obj/item/clothing/glasses/sunglasses/big,
		/obj/item/storage/belt/general,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack, /obj/item/storage/backpack/satchel, /obj/item/storage/backpack/messenger)),
		/obj/item/device/radio/headset/heads/torchntcommand,
		/obj/item/device/radio/headset/heads/torchntcommand/alt
	)

/obj/structure/closet/secure_closet/representative
	name = "\improper Naval Judge Advocate's locker"
	req_access = list(access_representative)
	closet_appearance = /decl/closet_appearance/secure_closet/torch/sol/rep

/obj/structure/closet/secure_closet/representative/WillContain()
	return list(
		/obj/item/device/camera_film = 2,
		/obj/item/material/clipboard,
		/obj/item/folder,
		/obj/item/device/tape/random = 3,
		/obj/item/storage/secure/briefcase,
		/obj/item/device/holowarrant,
		/obj/item/material/knife/folding/swiss/officer,
		/obj/item/device/radio/headset/jua,
		/obj/item/device/radio/headset/jua/alt,
		/obj/item/device/megaphone,
		/obj/item/melee/telebaton,
		/obj/item/device/flash,
		/obj/item/clothing/suit/armor/pcarrier/medium/command,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/under/rank/internalaffairs/plain/solgov,
		/obj/item/clothing/suit/storage/toggle/suit/black,
		/obj/item/clothing/glasses/sunglasses/big,
		/obj/item/storage/belt/general,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/command, /obj/item/storage/backpack/satchel/com, /obj/item/storage/backpack/messenger/com)),
	)

//equipment closets that everyone on the crew or in research can access, for storing things securely

/obj/structure/closet/secure_closet/crew
	name = "crew equipment locker"
	req_access = list(access_solgov_crew)
	closet_appearance = /decl/closet_appearance/secure_closet/torch/sol

/obj/structure/closet/secure_closet/crew/WillContain()
	return list(
		/obj/item/device/radio,
		/obj/item/crowbar,
		/obj/item/device/flashlight,
		/obj/item/storage/box
	)

/obj/structure/closet/secure_closet/crew/research
	name = "research equipment locker"
	req_access = list(access_nanotrasen)
	closet_appearance = /decl/closet_appearance/secure_closet/torch/corporate


/obj/structure/closet/secure_closet/guncabinet/sidearm
	name = "sidearm cabinet"
	req_access = list(list(access_armory,access_emergency_armory,access_hos,access_hop,access_ce,access_cmo,access_rd,access_senadv))

/obj/structure/closet/secure_closet/guncabinet/sidearm/WillContain()
	return list(
			/obj/item/clothing/accessory/storage/holster/thigh = 2,
			/obj/item/gun/energy/gun/secure = 3,
			/obj/item/cell/guncell/pistol/large = 3
	)

/obj/structure/closet/secure_closet/guncabinet/sidearm/small
	name = "personal sidearm cabinet"

/obj/structure/closet/secure_closet/guncabinet/sidearm/small/WillContain()
	return list(/obj/item/gun/energy/gun/small/secure = 4,
				/obj/item/cell/guncell/pistol/large = 4)

/obj/structure/closet/secure_closet/guncabinet/sidearm/combined
	name = "combined sidearm cabinet"

/obj/structure/closet/secure_closet/guncabinet/sidearm/combined/WillContain()
	return list(
		/obj/item/storage/belt/holster/general = 3,
		/obj/item/gun/energy/gun/secure = 3,
		/obj/item/gun/energy/gun/small/secure = 1,
		/obj/item/cell/guncell/pistol/large = 4
	)

/obj/structure/closet/secure_closet/guncabinet/PPE
	name = "Bridge PPE cabinet"
	req_access = list(list(access_armory,access_emergency_armory,access_hos,access_hop,access_ce,access_cmo,access_rd,access_senadv))

/obj/structure/closet/secure_closet/guncabinet/PPE/WillContain()
	return list(
		/obj/item/gun/energy/gun/small/secure = 3,
		/obj/item/clothing/suit/armor/pcarrier/medium/command = 3,
		/obj/item/clothing/head/helmet/solgov/command = 3
	)
