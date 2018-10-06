

/mob/proc/rightandwrong(var/summon_type) //0 = Summon Guns, 1 = Summon Magic, 2 = Summon Swords
	to_chat(usr, "<B>You summoned [summon_type]!</B>")
	message_admins("[key_name_admin(usr, 1)] summoned [summon_type]!")
	log_game("[key_name(usr)] summoned [summon_type]!")

	var/datum/role/survivor_type

	switch (summon_type)
		if ("swords")
			survivor_type = /datum/role/traitor/survivor/crusader/
		if ("magic")
			survivor_type = /datum/role/wizard/summon_magic/
		else
			survivor_type = /datum/role/traitor/survivor/

	for(var/mob/living/carbon/human/H in player_list)
		H.equip_survivor(summon_type)
		if (prob(65) || iswizard(H))
			continue
		if(H.stat == DEAD || !(H.client))
			continue

		var/datum/role/R = new survivor_type()

		if (!(isrole(R.id, H)))
			R.AssignToRole(H.mind)
			R.Greet()
			R.OnPostSetup()
			R.ForgeObjectives()
			R.AnnounceObjectives()



/mob/living/carbon/human/proc/equip_survivor(var/summon_type)
	switch (summon_type)
		if ("swords")
			return equip_swords()
		if ("magic")
			return equip_magician()
		else
			return equip_guns()

/mob/living/carbon/human/proc/equip_guns()
	var/randomizeguns = pick("taser","stunrevolver","egun","laser","retro","laserak","revolver","detective","c20r","nuclear","deagle","gyrojet","pulse","silenced","cannon","doublebarrel","shotgun","combatshotgun","mateba","smg","uzi","microuzi","crossbow","saw","hecate","osipr","gatling","bison","ricochet","spur","nagant","obrez","beegun","beretta","usp","glock","luger","colt","plasmapistol")
	switch (randomizeguns)
		if("taser")
			new /obj/item/weapon/gun/energy/taser(get_turf(src))
		if("stunrevolver")
			new /obj/item/weapon/gun/energy/stunrevolver(get_turf(src))
		if("egun")
			new /obj/item/weapon/gun/energy/gun(get_turf(src))
		if("laser")
			new /obj/item/weapon/gun/energy/laser(get_turf(src))
		if("retro")
			new /obj/item/weapon/gun/energy/laser/retro(get_turf(src))
		if("laserak")
			new /obj/item/weapon/gun/energy/laser/LaserAK(get_turf(src))
		if("plasmapistol")
			new /obj/item/weapon/gun/energy/plasma/pistol(get_turf(src))
		if("revolver")
			new /obj/item/weapon/gun/projectile(get_turf(src))
		if("detective")
			new /obj/item/weapon/gun/projectile/detective(get_turf(src))
		if("c20r")
			new /obj/item/weapon/gun/projectile/automatic/c20r(get_turf(src))
		if("nuclear")
			new /obj/item/weapon/gun/energy/gun/nuclear(get_turf(src))
		if("deagle")
			new /obj/item/weapon/gun/projectile/deagle/camo(get_turf(src))
		if("gyrojet")
			new /obj/item/weapon/gun/projectile/gyropistol(get_turf(src))
		if("pulse")
			new /obj/item/weapon/gun/energy/pulse_rifle(get_turf(src))
		if("silenced")
			new /obj/item/weapon/gun/projectile/pistol(get_turf(src))
			new /obj/item/gun_part/silencer(get_turf(src))
		if("cannon")
			new /obj/item/weapon/gun/energy/laser/cannon(get_turf(src))
		if("doublebarrel")
			new /obj/item/weapon/gun/projectile/shotgun/pump/(get_turf(src))
		if("shotgun")
			new /obj/item/weapon/gun/projectile/shotgun/pump/(get_turf(src))
		if("combatshotgun")
			new /obj/item/weapon/gun/projectile/shotgun/pump/combat(get_turf(src))
		if("mateba")
			new /obj/item/weapon/gun/projectile/mateba(get_turf(src))
		if("smg")
			new /obj/item/weapon/gun/projectile/automatic(get_turf(src))
		if("uzi")
			new /obj/item/weapon/gun/projectile/automatic/uzi(get_turf(src))
		if("microuzi")
			new /obj/item/weapon/gun/projectile/automatic/uzi/micro(get_turf(src))
		if("crossbow")
			new /obj/item/weapon/gun/energy/crossbow(get_turf(src))
		if("saw")
			new /obj/item/weapon/gun/projectile/automatic/l6_saw(get_turf(src))
		if("hecate")
			new /obj/item/weapon/gun/projectile/hecate(get_turf(src))
			new /obj/item/ammo_casing/BMG50(get_turf(src))//can't give a full box of such deadly bullets. 3 shots is plenty.
			new /obj/item/ammo_casing/BMG50(get_turf(src))
		if("osipr")
			new /obj/item/weapon/gun/osipr(get_turf(src))
		if("gatling")
			new /obj/item/weapon/gun/gatling(get_turf(src))
		if("bison")
			new /obj/item/weapon/gun/energy/bison(get_turf(src))
		if("ricochet")
			new /obj/item/weapon/gun/energy/ricochet(get_turf(src))
		if("spur")
			new /obj/item/weapon/gun/energy/polarstar(get_turf(src))
			new /obj/item/device/modkit/spur_parts(get_turf(src))
		if("nagant")
			new /obj/item/weapon/gun/projectile/nagant(get_turf(src))
		if("obrez")
			new /obj/item/weapon/gun/projectile/nagant/obrez(get_turf(src))
		if("beegun")
			new /obj/item/weapon/gun/gatling/beegun(get_turf(src))
		if("beretta")
			new /obj/item/weapon/gun/projectile/beretta(get_turf(src))
		if("usp")
			new /obj/item/weapon/gun/projectile/NTUSP/fancy(get_turf(src))
		if("glock")
			new /obj/item/weapon/gun/projectile/sec/fancy(get_turf(src))
		if("luger")
			new /obj/item/weapon/gun/projectile/luger(get_turf(src))
		if("colt")
			new /obj/item/weapon/gun/projectile/colt(get_turf(src))
	playsound(src,'sound/effects/summon_guns.ogg', 50, 1)

/mob/living/carbon/human/proc/equip_swords()
	var/randomizeswords = pick("unlucky", "misc", "glass", "throw", "armblade", "pickaxe", "pcutter", "esword", "alt-esword", "machete", "kitchen", "spear", "katana", "axe", "venom", "boot", "saw", "scalpel", "bottle", "switchtool")
	var/randomizeknightcolor = pick("green", "yellow", "blue", "red", "templar")
	switch (randomizeknightcolor) //everyone gets some armor as well
		if("green")
			new /obj/item/clothing/suit/armor/knight(get_turf(src))
			new /obj/item/clothing/head/helmet/knight(get_turf(src))
		if("yellow")
			new /obj/item/clothing/suit/armor/knight/yellow(get_turf(src))
			new /obj/item/clothing/head/helmet/knight/yellow(get_turf(src))
		if("blue")
			new /obj/item/clothing/suit/armor/knight/blue(get_turf(src))
			new /obj/item/clothing/head/helmet/knight/blue(get_turf(src))
		if("red")
			new /obj/item/clothing/suit/armor/knight/red(get_turf(src))
			new /obj/item/clothing/head/helmet/knight/red(get_turf(src))
		if("templar")
			new /obj/item/clothing/suit/armor/knight/templar(get_turf(src))
			new /obj/item/clothing/head/helmet/knight/templar(get_turf(src))

	switch (randomizeswords)
		if("unlucky") //so the chance to get an unlucky item does't clutter the main pool of swords
			var/noluck = pick(/obj/item/weapon/kitchen/utensil/knife/plastic, /obj/item/weapon/screwdriver, /obj/item/weapon/wirecutters, /obj/item/toy/foamblade, /obj/item/toy/sword)
			new noluck(get_turf(src))
		if("misc")
			var/miscpick = pick(/obj/item/weapon/scythe, /obj/item/weapon/harpoon, /obj/item/weapon/sword, /obj/item/weapon/sword/executioner, /obj/item/weapon/claymore, /obj/item/weapon/sord)
			new miscpick(get_turf(src))
		if("glass")
			if(prob(50))
				new /obj/item/weapon/shard(get_turf(src))
			else
				new /obj/item/weapon/shard/plasma(get_turf(src))
		if("throw")
			if(prob(20))
				new /obj/item/weapon/kitchen/utensil/knife/nazi(get_turf(src))
			else
				new /obj/item/weapon/hatchet(get_turf(src))
		if("armblade") // good luck getting it off. Maybe cut your own arm off :^)
			new /obj/item/weapon/armblade(get_turf(src))
		if("pickaxe")
			var/pickedaxe = pick(/obj/item/weapon/pickaxe, /obj/item/weapon/pickaxe/silver, /obj/item/weapon/pickaxe/gold, /obj/item/weapon/pickaxe/diamond)
			new pickedaxe(get_turf(src))
		if("pcutter")
			new /obj/item/weapon/pickaxe/plasmacutter(get_turf(src))
		if("esword")
			new /obj/item/weapon/melee/energy/sword(get_turf(src))
			if(prob(70)) //chance for a second one to make a double esword
				new /obj/item/weapon/melee/energy/sword(get_turf(src))
		if("alt-esword")
			if(prob(75))
				new /obj/item/weapon/melee/energy/sword/pirate(get_turf(src))
				if(prob(70))
					new /obj/item/weapon/melee/energy/sword/pirate(get_turf(src))
			else //hope you're the clown
				new /obj/item/weapon/melee/energy/sword/bsword(get_turf(src))
				if(prob(70))
					new /obj/item/weapon/melee/energy/sword/bsword(get_turf(src))
		if("machete")
			new /obj/item/weapon/melee/energy/hfmachete(get_turf(src))
			if(prob(70))
				new /obj/item/weapon/melee/energy/hfmachete(get_turf(src))
		if("kitchen")
			if(prob(60))
				if(prob(25))
					new /obj/item/weapon/kitchen/utensil/knife/large(get_turf(src))
				else
					new /obj/item/weapon/kitchen/utensil/knife/large/butch(get_turf(src))
			else
				new /obj/item/weapon/kitchen/utensil/knife/large/butch/meatcleaver(get_turf(src))
		if("spear")
			if(prob(50))
				new /obj/item/weapon/spear(get_turf(src))
			else
				new /obj/item/weapon/melee/lance(get_turf(src))
		if("katana")
			new /obj/item/weapon/katana(get_turf(src))
					//No fun allowed, maybe nerf later and readd
					/*
					if(prob(5))
						new /obj/item/weapon/katana/hfrequency(get_turf(src))
					else
						new /obj/item/weapon/katana(get_turf(src))
					*/
		if("axe")
			if(prob(50))
				if(prob(5))
					new /obj/item/weapon/melee/energy/axe(get_turf(src))
				else
					new /obj/item/weapon/melee/energy/axe/rusty(get_turf(src))
			else
				new /obj/item/weapon/fireaxe(get_turf(src))
		if("venom")
			new /obj/item/weapon/sword/venom(get_turf(src))
		if("boot")
			if(prob(50))
				new /obj/item/clothing/accessory/holster/knife/boot/preloaded/tactical(get_turf(src))
			else
				new /obj/item/clothing/accessory/holster/knife/boot/preloaded/skinning(get_turf(src))
		if("saw")
			if(prob(40))
				new /obj/item/weapon/circular_saw/plasmasaw(get_turf(src))
			else
				new /obj/item/weapon/circular_saw(get_turf(src))
		if("scalpel")
			if(prob(60))
				if(prob(50))
					new /obj/item/weapon/scalpel/laser(get_turf(src))
				else
					new /obj/item/weapon/scalpel/laser/tier2(get_turf(src))
			else
				new /obj/item/weapon/scalpel(get_turf(src))
		if("bottle")
			new /obj/abstract/map/spawner/space/drinks(get_turf(src))
		if("switchtool")
			if(prob(40))
				if(prob(50))
					new /obj/item/weapon/switchtool(get_turf(src))
				else
					new /obj/item/weapon/switchtool/surgery(get_turf(src))
			else
				new /obj/item/weapon/switchtool/swiss_army_knife(get_turf(src))
	playsound(src,'sound/items/zippo_open.ogg', 50, 1)

/mob/living/carbon/human/proc/equip_magician()
	var/randomizemagic = pick("fireball","smoke","blind","mindswap","forcewall","knock","horsemask","blink","disorient","staffchange","armor","scrying", "clowncurse", "mimecurse", "shoesnatch", "robesummon")
	switch (randomizemagic)
		if("fireball")
			new /obj/item/weapon/spellbook/oneuse/fireball(get_turf(src))
		if("smoke")
			new /obj/item/weapon/spellbook/oneuse/smoke(get_turf(src))
		if("blind")
			new /obj/item/weapon/spellbook/oneuse/blind(get_turf(src))
		if("mindswap")
			new /obj/item/weapon/spellbook/oneuse/mindswap(get_turf(src))
		if("forcewall")
			new /obj/item/weapon/spellbook/oneuse/forcewall(get_turf(src))
		if("knock")
			new /obj/item/weapon/spellbook/oneuse/knock(get_turf(src))
		if("horsemask")
			new /obj/item/weapon/spellbook/oneuse/horsemask(get_turf(src))
		if("blink")
			new /obj/item/weapon/spellbook/oneuse/teleport/blink(get_turf(src))
		if("disorient")
			new /obj/item/weapon/spellbook/oneuse/disorient(get_turf(src))
		if("clowncurse")
			new /obj/item/weapon/spellbook/oneuse/clown(get_turf(src))
		if("mimecurse")
			new /obj/item/weapon/spellbook/oneuse/mime(get_turf(src))
		if("shoesnatch")
			new /obj/item/weapon/spellbook/oneuse/shoesnatch(get_turf(src))
		if("robesummon")
			new /obj/item/weapon/spellbook/oneuse/robesummon(get_turf(src))
		if("staffchange")
			new /obj/item/weapon/gun/energy/staff(get_turf(src))
		if("armor")
			new /obj/item/clothing/suit/space/rig/wizard(get_turf(src))
			new /obj/item/clothing/head/helmet/space/rig/wizard(get_turf(src))
		if("scrying")
			if (!istype(src))
				return
			new /obj/item/weapon/scrying(get_turf(src))
			if (!(M_XRAY in mutations))
				mutations.Add(M_XRAY)
				change_sight(adding = SEE_MOBS|SEE_OBJS|SEE_TURFS)
				see_in_dark = 8
				see_invisible = SEE_INVISIBLE_LEVEL_TWO
				to_chat(src, "<span class='notice'>The walls suddenly disappear.</span>")