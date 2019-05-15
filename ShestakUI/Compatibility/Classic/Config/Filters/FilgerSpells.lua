local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.unitframe.enable ~= true or C.filger.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

--[[
How to add Abilities in Filger For Dummies (http://shestak.org/forum/showthread.php?t=126)

What is filger???? Filger creates icons/bars for aura tracking which appear on screen, like so (http://shestak.org/forum/picture.php?albumid=9&pictureid=44).


In order to add a aura to Filger, you need to:

	1. Ask yourself: "Do I need this?"
	2. Open the ShestakUI/Config/Filters/FilgerSpells.lua file (see notes)
	3. Determine the type of missing aura:
		1. Player applied buffs on self (P_BUFF_ICON)
		2. Proc-based buffs (enchants/talents/accessories/etc.) on self (P_PROC_ICON)
		3. Player applied buffs/debuffs on target (T_DEBUFF_ICON)
		4. Player applied HoTs/DoTs on target (T_DE/BUFF_BAR)
		5. Player applied CC on focus (PVE/PVP_CC)
		6. Player ability cooldowns (COOLDOWN)
		7. Consumable based (items/potions/etc.) on self (SPECIAL_P_BUFF_ICON)
		8. Enemy applied CC and root/slowing effects on self (PVE / PVP_DEBUFF)
		9. Important defensive abilities or CC on the target (from all sources) (T_BUFF)
	4. If the aura belongs to groups 1-6, you need:
		1. Find a section for your class in the file.
		2. Find the sub-section corresponding to the aura type (section names list above in brackets).
	5. If the aura belongs to groups 7-9, you need:
		1. Find the section near the end (after ALL the classes) in the file.
		2. Find the sub-section corresponding to the aura type (section names list above in brackets).
	6. Ensure that the aura you'd like to track actually exists and isn't already being tracked.
	7. Find out the spell ID. For this you can:
		1. In the ShestakUI configuration, navigate to the tooltips section and enable spell IDs on toooltips. Once applied, hver your mouse over an ability on your action bar or spellbook an reference the tooltip.
		2. Look up the spell ID in a database like Wowhead and copy the numbers from the URL (see: spell=).
	8. Add the desired aura, referencing existing entries to ensure proper format. See the notes for further information.
	9. ...
	10. PROFIT!

Note 1: Description of the contents of a single cell with a spell
	A simple aura tracking (in this case a DoT on the target).
		-- Vampiric Touch		-- 1
		{
			spellID = 34914,	-- 2
			unitId = "target",	-- 3
			caster = "player",	-- 4
			filter = "DEBUFF",	-- 5
			absID = true,		-- 6
			count = 2			-- 7
		},

		1.	Spell name
		2.	Spell ID
		3.	Unit to track (player / target / focus)
		4.	Unit who applied the aura (player / target / focus / all)
			Restrospectively:
				player - the player
				target - the player's target
				foocus - the player's focus target
				all    - any source (only usable for "caster")
		5.	Spell tracking type (BUFF / DEBUFF / CD)
		6.	Strict spell name matching (will not trigger off spells with the same name or different ranks)
		7.	The number of stacks required before displaying

	A hidden CD
		-- Power Torrent
		{
			spellID = 74241,	-- 1
			slotID = 16,		-- 2
			filter = "ICD",		-- 3
			trigger = "BUFF",	-- 4
			duration = 45		-- 5
		},
		-- Cauterize
		{
			spellID = 87023,	-- 1
			filter = "ICD",		-- 3
			trigger = "DEBUFF",	-- 4
			duration = 60		-- 5
		},

		1.	ID of buff/debuff to track
		2.	If specified, instead of displaying the aura icon, Filger will display the item's icon by gear slotID.
		3.	Spell tracking type
		4.	Proc type (BUFF / DEBUFF)
		5.	Hidden CD duration

	Active spell without an aura
		-- Summon Gargoyle
		{
			spellID = 49206,	-- 1
			filter = "ICD",		-- 2
			trigger = "NONE",	-- 3
			duration = 40		-- 4
		},

		1.	ID of spell cast
		2.	Spell tracking type (ICD)
		3.	Proc type (NONE)
		4.	Active duration

Note 2: An illustrative example of each section in how it displays on screen.
	http://shestak.org/forum/picture.php?albumid=9&pictureid=44


Note: To help facilitatein the above process, it is recommended that you open the .lua file using a decent text editor such as Notepad++ (see example - http://shestak.org/forum/picture.php?albumid=9&pictureid=45).

------
-- Ravager
			{spellID = 152277, unitID = "player", caster = "player", filter = "BUFF", spec = 3},
--]]

P_BUFF_ICON_Anchor = CreateFrame("Frame", "P_BUFF_ICON_Anchor", UIParent)
P_PROC_ICON_Anchor = CreateFrame("Frame", "P_PROC_ICON_Anchor", UIParent)
SPECIAL_P_BUFF_ICON_Anchor = CreateFrame("Frame", "SPECIAL_P_BUFF_ICON_Anchor", UIParent)
T_DEBUFF_ICON_Anchor = CreateFrame("Frame", "T_DEBUFF_ICON_Anchor", UIParent)
T_BUFF_Anchor = CreateFrame("Frame", "T_BUFF_Anchor", UIParent)
PVE_PVP_DEBUFF_Anchor = CreateFrame("Frame", "PVE_PVP_DEBUFF_Anchor", UIParent)
PVE_PVP_CC_Anchor = CreateFrame("Frame", "PVE_PVP_CC_Anchor", UIParent)
COOLDOWN_Anchor = CreateFrame("Frame", "COOLDOWN_Anchor", UIParent)
T_DE_BUFF_BAR_Anchor = CreateFrame("Frame", "T_DE_BUFF_BAR_Anchor", UIParent)

C["filger_spells"] = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 5229, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frenzied Regeneration
			{spellID = 22842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grace
			{spellID = 16886, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 16689, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Swiftness
			{spellID = 17116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Clearcasting [Omen of Clarity]
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Trinkets
			-- Class
			-- Metamorphosis Rune (Special, Use) [Rune of Metamorphosis]
			{spellID = 23724, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nimble Healing Touch (Special, Use) [Wushoolay's Charm of Nature]
			{spellID = 24542, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Bash
			{spellID = 5211, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Celestial Focus (Starfire Stun)
			{spellID = 16922, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Challenging Roar
			{spellID = 5209, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Demoralizing Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Faerie Fire
			{spellID = 770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Faerie Fire (Feral)
			{spellID = 16857, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Feral Charge Effect
			{spellID = 19675, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Hurricane
			-- {spellID = 16914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Insect Swarm
			{spellID = 5570, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mangle
			{spellID = 22570, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Moonfire
			{spellID = 8921, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pounce Bleed
			{spellID = 9007, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 1822, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Soothe Animal
			-- {spellID = 2908, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Abolish Poison
			{spellID = 2893, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},

			-- Trinket Effects
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Entangling Roots
			{spellID = 339, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- -- Entangling Roots (Nature's Grasp)
			-- {spellID = 19975, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Bash
			{spellID = 5211, filter = "CD"},
			-- Challenging Roar
			{spellID = 5209, filter = "CD"},
			-- Cower
			{spellID = 8998, filter = "CD"},
			-- Dash
			{spellID = 1850, filter = "CD"},
			-- Enrage
			{spellID = 5229, filter = "CD", absID = true},
			-- Enraged Defense
			{spellID = 6542, filter = "CD"},
			-- Faerie Fire (Feral)
			{spellID = 16857, filter = "CD"},
			-- Feral Charge
			{spellID = 16979, filter = "CD"},
			-- Frenzied Regeneration
			{spellID = 22842, filter = "CD"},
			-- Growl
			{spellID = 6795, filter = "CD"},
			-- Hurricane
			{spellID = 16914, filter = "CD"},
			-- Innervate
			{spellID = 29166, filter = "CD"},
			-- Mangle
			{spellID = 22570, filter = "CD"},
			-- Nature's Grasp
			{spellID = 16689, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 17116, filter = "CD"},
			-- Prowl
			{spellID = 5215, filter = "CD"},
			-- Rebirth
			{spellID = 20484, filter = "CD"},
			-- Swiftmend
			{spellID = 18562, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},
			-- Tranquility
			{spellID = 740, filter = "CD"},

			-- Racial
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20600, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- -- Aspect of the Beast
			-- {spellID = 13161, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Aspect of the Hawk
			-- {spellID = 13165, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Aspect of the Monkey
			-- {spellID = 13163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Pack
			{spellID = 13159, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Aspect of the Wild
			-- {spellID = 20043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bestial Wrath
			{spellID = 19574, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Cobra Reflexes
			{spellID = 25077, unitID = "pet", caster = "all", filter = "BUFF"},
			-- -- Dash (Boar / Cat / Hyena / Raptor / Tallstrider / Wolf)
			-- {spellID = 23099, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Dive (Bat / Bird of Prey / Carrion Bird / Wind Serpent)
			-- {spellID = 23145, unitID = "pet", caster = "all", filter = "BUFF"},
			-- -- Eyes of the Beast
			-- {spellID = 1002, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Feed Pet Effect
			-- {spellID = 1539, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzy Effect
			{spellID = 19615, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Furious Howl (Wolf)
			{spellID = 24604, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},
			-- -- Prowl (Cat)
			-- {spellID = 24450, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell Shield (Turtle)
			{spellID = 26064, unitID = "pet", caster = "all", filter = "BUFF"},
			-- -- Spirit Bond
			-- {spellID = 19579, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Tame Beast
			-- {spellID = 1515, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Trinkets
			-- Class
			-- Arcane Infused (Special, Use) [Arcane Infused Gem]
			{spellID = 23721, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- -- Beast Lore
			-- {spellID = 1462, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Charge (Boar)
			{spellID = 25999, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Concussive Shot
			{spellID = 5116, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Counterattack
			{spellID = 19306, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Explosive Trap Effect
			-- {spellID = 13812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Flare
			-- {spellID = 1543, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Trap Aura
			{spellID = 13810, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hunter's Mark
			{spellID = 1130, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Immolation Trap Effect
			-- {spellID = 13797, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Improved Concussive Shot
			{spellID = 19410, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Improved Wing Clip
			{spellID = 19229, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scatter Shot
			{spellID = 19503, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Scorpid Poison (Scorpid)
			{spellID = 24640, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Sting
			{spellID = 3043, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Screech (Bat / Bird of Prey / Carrion Bird)
			{spellID = 24423, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Serpent Sting
			{spellID = 1978, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Viper Sting
			{spellID = 3034, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wing Clip
			{spellID = 2974, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Item Sets
			-- Expose Weakness (Special, Proc) [Dragonstalker Armor]
			{spellID = 23577, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Freezing Trap Effect
			{spellID = 3355, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Scare Beast
			{spellID = 1513, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Arcane Shot
			{spellID = 3044, filter = "CD"},
			-- Aimed Shot
			{spellID = 19434, filter = "CD"},
			-- Bestial Wrath
			{spellID = 19574, filter = "CD"},
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counterattack
			{spellID = 19306, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Distracting Shot
			{spellID = 20736, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Feign Death
			{spellID = 5384, filter = "CD"},
			-- Flare
			{spellID = 1543, filter = "CD", absID = true},
			-- Freezing Trap
			{spellID = 1499, filter = "CD"},
			-- Frost Trap
			{spellID = 13809, filter = "CD"},
			-- Immolation Trap
			{spellID = 13795, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD", absID = true},
			-- Mongoose Bite
			{spellID = 1495, filter = "CD"},
			-- Multi-Shot
			{spellID = 2643, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Raptor Strike
			{spellID = 2973, filter = "CD"},
			-- Readiness
			{spellID = 23989, filter = "CD"},
			-- Scare Beast
			{spellID = 1513, filter = "CD"},
			-- Scatter Shot
			{spellID = 19503, filter = "CD"},
			-- Tranquilizing Shot
			{spellID = 19801, filter = "CD"},
			-- Viper Sting
			{spellID = 3034, filter = "CD"},
			-- Volley
			{spellID = 1510, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},

			-- Pets
			-- Charge (Boar)
			{spellID = 7371, filter = "CD"},
			-- Dash (Boar / Cat / Hyena / Raptor / Tallstrider / Wolf)
			{spellID = 23099, filter = "CD"},
			-- Dive (Bat / Bird of Prey / Carrion Bird / Wind Serpent)
			{spellID = 23145, filter = "CD"},
			-- Shell Shield (Turtle)
			{spellID = 26064, filter = "CD"},
			-- Thunderstomp (Gorilla)
			{spellID = 26090, filter = "CD"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Blood Fury
			{spellID = 20572, filter = "CD", absID = true},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20600, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combustion
			{spellID = 28682, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward
			{spellID = 543, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward
			{spellID = 6143, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ice Block
			{spellID = 11958, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mana Shield
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Presence of Mind
			{spellID = 12043, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Clearcasting [Arcane Concentration]
			{spellID = 12536, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Item Sets
			-- Enigma's Answer (Spell Hit, Proc) [Enigma Vestments]
			{spellID = 26129, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire Resistance (Fire Resistance, Proc) [Frostfire Regalia]
			{spellID = 28765, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Resistance (Frost Resistance, Proc) [Frostfire Regalia]
			{spellID = 28766, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature Resistance (Nature Resistance, Proc) [Frostfire Regalia]
			{spellID = 28768, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Shadow Resistance (Shadow Resistance, Proc) [Frostfire Regalia]
			{spellID = 28769, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Arcane Resistance (Arcane Resistance, Proc) [Frostfire Regalia]
			{spellID = 28770, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Netherwind Focus (Special, Proc) [Netherwind Regalia]
			{spellID = 22008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Not There (Special, Proc) [Frostfire Regalia]
			{spellID = 28762, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Arcane Potency (Spell Power, Use) [Hazza'rah's Charm of Magic]
			{spellID = 24544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mind Quickening (Spell Haste, Use) [Mind Quickening Gem]
			{spellID = 23723, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blast Wave
			{spellID = 11113, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Blizzard
			-- {spellID = 10, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Chilled (Blizzard)
			-- {spellID = 12484, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- -- Chilled (Frost Armor)
			-- {spellID = 6136, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Chilled (Ice Armor)
			{spellID = 7321, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Counterspell - Silenced
			{spellID = 18469, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Fireball
			{spellID = 133, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fire Vulnerability (Improved Scorch)
			{spellID = 22959, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- -- Flamestrike
			-- {spellID = 2120, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostbite
			{spellID = 12494, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostbolt
			{spellID = 116, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Impact
			{spellID = 12355, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Winter's Chill
			{spellID = 12579, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Item Sets
			-- Elemental Vulnerability (Special, Proc) [Frostfire Regalia]
			{spellID = 28772, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Special, Proc) [Magister's Regalia / Sorcerer's Regalia]
			{spellID = 27868, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Polymorph
			{spellID = 118, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Blast Wave
			{spellID = 11113, filter = "CD"},
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Combustion
			{spellID = 11129, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Fire Blast
			{spellID = 2136, filter = "CD"},
			-- Fire Ward
			{spellID = 543, filter = "CD"},
			-- Frost Nova
			{spellID = 122, filter = "CD"},
			-- Frost Ward
			{spellID = 6143, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Ice Block
			{spellID = 11958, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Presence of Mind
			{spellID = 12043, filter = "CD"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- -- Concentration Aura
			-- {spellID = 19746, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Devotion Aura
			-- {spellID = 465, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Favor
			{spellID = 20216, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Fire Resistance Aura
			-- {spellID = 19891, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Frost Resistance Aura
			-- {spellID = 19888, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Shield
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Retribution Aura
			-- {spellID = 7294, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Sanctity Aura
			-- {spellID = 20218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Command
			{spellID = 20735, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Justice
			{spellID = 20164, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Light
			{spellID = 20165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Righteousness
			{spellID = 21084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Wisdom
			{spellID = 20166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of the Crusader
			{spellID = 21082, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Shadow Resistance Aura
			-- {spellID = 19876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vengeance
			{spellID = 20050, unitID = "player", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Reckoning
			{spellID = 20178, unitID = "player", caster = "player", filter = "BUFF"},
			-- Redoubt
			{spellID = 20128, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Crusader's Wrath (Spell Power, Proc) [Lightforge Armor / Soulforge Armor]
			{spellID = 27499, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Blinding Light (Haste, Use) [Tome of Fiery Redemption]
			{spellID = 23733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brilliant Light (Spell Critical Strike, Use) [Gri'lek's Charm of Valor]
			{spellID = 24498, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Deflection (Block Value, Use) [Glyph of Deflection]
			{spellID = 28773, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			--[[
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Strength of the Champion (Strength, Proc) [Arcanite Champion]
			{spellID = 16916, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- -- Consecration
			-- {spellID = 26573, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Justice
			{spellID = 20184, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Light
			{spellID = 20185, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Wisdom
			{spellID = 20186, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of the Crusader
			{spellID = 21183, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice (Stun)
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Vindication
			{spellID = 67, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Turn Undead
			{spellID = 2878, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Blessing of Freedom
			{spellID = 1044, filter = "CD"},
			-- Blessing of Protection
			{spellID = 1022, filter = "CD"},
			-- Blessing of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Divine Favor
			{spellID = 20216, filter = "CD"},
			-- Divine Intervention
			{spellID = 19752, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD", absID = true},
			-- Divine Shield
			{spellID = 642, filter = "CD"},
			-- Exorcism
			{spellID = 879, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Hammer of Wrath
			{spellID = 24275, filter = "CD"},
			-- Holy Shield
			{spellID = 20925, filter = "CD", absID = true},
			-- Holy Shock
			{spellID = 20473, filter = "CD"},
			-- Holy Wrath
			{spellID = 2812, filter = "CD"},
			-- Judgement
			{spellID = 20271, filter = "CD", absID = true},
			-- Lay on Hands
			{spellID = 633, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Turn Evil
			{spellID = 10326, filter = "CD"},
			-- Turn Undead
			{spellID = 2878, filter = "CD"},

			-- Racial
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Elune's Grace
			{spellID = 2651, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Feedback
			{spellID = 13896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Fire
			{spellID = 588, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Focus
			{spellID = 14751, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowform
			{spellID = 15473, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowguard
			{spellID = 18137, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit of Redemption
			{spellID = 27827, unitID = "player", caster = "player", filter = "BUFF"},
			-- Touch of Weakness
			{spellID = 2652, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Vampiric Embrace
			-- {spellID = 15290, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Blessed Recovery
			{spellID = 27813, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Casting [Martyrdom]
			{spellID = 14743, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Tap
			{spellID = 15271, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Divine Protection (Absorb, Proc) [Vestments of the Devout / Vestments of the Virtuous]
			{spellID = 27779, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Epiphany (Mp5, Proc) [Vestments of Faith]
			{spellID = 28804, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reactive Fade (Special, Proc) [Vestments of Transcendence]
			{spellID = 21976, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Aegis of Preservation (Special, Use) [Aegis of Preservation]
			{spellID = 23780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Healing (Special, Use) [Hazza'rah's Charm of Healing]
			{spellID = 24546, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blackout
			{spellID = 15269, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hex of Weakness
			{spellID = 9035, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Holy Fire
			{spellID = 14914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Control
			{spellID = 605, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Flay
			{spellID = 15407, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Soothe
			{spellID = 453, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Vision
			{spellID = 2096, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadow Vulnerability (Shadow Weaving)
			{spellID = 15258, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Starshards
			{spellID = 10797, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Touch of Weakness
			{spellID = 2943, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Abolish Disease
			{spellID = 552, unitID = "target", caster = "player", filter = "BUFF"},
			-- Armor of Faith (Absorb, Proc) [Vestments of Faith]
			{spellID = 28810, unitID = "target", caster = "player", filter = "BUFF"},
			-- Greater Heal (HoT, Proc) [Vestments of Transcendence]
			{spellID = 22009, unitID = "target", caster = "player", filter = "BUFF"},
			-- Inspiration
			{spellID = 14893, unitID = "target", caster = "player", filter = "BUFF"},
			-- Lightwell Renew
			{spellID = 7001, unitID = "target", caster = "player", filter = "BUFF"},
			-- Power Word: Shield
			{spellID = 17, unitID = "target", caster = "player", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Weakened Soul
			{spellID = 6788, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Shackle Undead
			{spellID = 9484, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Desperate Prayer
			{spellID = 13908, filter = "CD"},
			-- Devouring Plague
			{spellID = 2944, filter = "CD"},
			-- Elune's Grace
			{spellID = 2651, filter = "CD"},
			-- Fade
			{spellID = 586, filter = "CD", absID = true},
			-- Fear Ward
			{spellID = 6346, filter = "CD"},
			-- Feedback
			{spellID = 13896, filter = "CD"},
			-- Inner Focus
			{spellID = 14751, filter = "CD"},
			-- Lightwell
			{spellID = 724, filter = "CD"},
			-- Mind Blast
			{spellID = 8092, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Power Word: Shield
			{spellID = 17, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD", absID = true},
			-- Starshards
			{spellID = 10797, filter = "CD"},
			-- Vampiric Embrace
			{spellID = 15286, filter = "CD"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cold Blood
			{spellID = 14177, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ghostly Strike
			{spellID = 14278, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Stealth
			-- {spellID = 1784, unitID = "player", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Remorseless Attacks
			{spellID = 14143, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Bloodfang (HoT, Proc) [Bloodfang Armor]
			{spellID = 23580, unitID = "player", caster = "player", filter = "BUFF"},
			-- Revealed Flaw (Speecial, Proc) [Bonescythe Armor]
			{spellID = 28815, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Venomous Totem (Special, Use) [Venomous Totem]
			{spellID = 23726, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			--[[
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]

			-- Enchants
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Crippling Poison
			{spellID = 3409, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Expose Armor
			{spellID = 8647, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Kick - Silenced
			{spellID = 18425, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Riposte
			{spellID = 14251, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wound Poison
			{spellID = 13218, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Blind
			{spellID = 2094, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Blade Flurry
			{spellID = 13877, filter = "CD"},
			-- Blind
			{spellID = 2094, filter = "CD"},
			-- Cold Blood
			{spellID = 14177, filter = "CD"},
			-- Distract
			{spellID = 1725, filter = "CD"},
			-- Evasion
			{spellID = 5277, filter = "CD"},
			-- Feint
			{spellID = 1966, filter = "CD"},
			-- Ghostly Strike
			{spellID = 14278, filter = "CD"},
			-- Gouge
			{spellID = 1776, filter = "CD"},
			-- Kick
			{spellID = 1766, filter = "CD"},
			-- Kidney Shot
			{spellID = 408, filter = "CD"},
			-- Premeditation
			{spellID = 14183, filter = "CD"},
			-- Preparation
			{spellID = 14185, filter = "CD"},
			-- Riposte
			{spellID = 14251, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Stealth
			{spellID = 1784, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},

			-- Racial
			-- Berserking (Energy)
			{spellID = 26297, filter = "CD", absID = true},
			-- Blood Fury
			{spellID = 20572, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Elemental Devastation
			{spellID = 30165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Fire Resistance Totem
			-- {spellID = 8185, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Flurry
			{spellID = 16257, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Frost Resistance Totem
			-- {spellID = 8182, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Ghost Wolf
			-- {spellID = 2645, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Grace of Air
			-- {spellID = 8836, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Healing Stream
			-- {spellID = 5672, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Mana Spring Totem
			-- {spellID = 5677, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature's Swiftness
			{spellID = 16188, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Nature Resistance Totem
			-- {spellID = 10596, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Sentry Totem
			-- {spellID = 6495, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Stoneskin Totem
			-- {spellID = 8072, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Strength of Earth
			-- {spellID = 8076, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Windwall Totem
			-- {spellID = 15108, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Wrath of Air Totem
			-- {spellID = 2895, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Clearcasting (Elemental Focus)
			{spellID = 16246, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Casting (Eye of the Storm)
			{spellID = 29063, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- -- Lightning Shield (Mp5, Proc) [The Earthshatterer]
			-- {spellID = 28820, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Stormcaller's Wrath (Spell Power, Proc) [Stormcaller's Garb]
			{spellID = 26121, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Furious Storm (Spell Power, Proc) [The Elements / The Five Thunders]
			{spellID = 27775, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Energized Shield (Special, Use) [Wushoolay's Charm of Spirits]
			{spellID = 24499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Aligned (Spell Power, Use) [Natural Alignment Crystal]
			{spellID = 23734, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			--[[
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]

			-- Enchants
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Earthbind
			{spellID = 3600, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Ancestral Fortitude
			{spellID = 16177, unitID = "target", caster = "player", filter = "BUFF"},
			-- Healing Way
			{spellID = 29203, unitID = "target", caster = "player", filter = "BUFF"},
			-- -- Lightning Shield (Special, Proc) [The Ten Storms]
			-- {spellID = 23552, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Armor, Proc) [The Earthshatterer]
			{spellID = 28827, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Attack Power, Proc) [The Earthshatterer]
			{spellID = 28826, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Mp5, Proc) [The Earthshatterer]
			{spellID = 28824, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Spell Power, Proc) [The Earthshatterer]
			{spellID = 28825, unitID = "target", caster = "player", filter = "BUFF", absID = true},

			-- Trinket Effects
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		--[[
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},
		},
		--]]
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Chain Lightning
			{spellID = 421, filter = "CD"},
			-- Earth Shock
			{spellID = 8042, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Elemental Mastery
			{spellID = 16166, filter = "CD"},
			-- Fire Nova Totem
			{spellID = 1535, filter = "CD"},
			-- Flame Shock
			{spellID = 8050, filter = "CD"},
			-- Frost Shock
			{spellID = 8056, filter = "CD"},
			-- Grounding Totem
			{spellID = 8177, filter = "CD"},
			-- Mana Tide Totem
			{spellID = 16190, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 16188, filter = "CD"},
			-- Reincarnation
			{spellID = 20608, filter = "CD"},
			-- Stoneclaw Totem
			{spellID = 5730, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Blood Fury
			{spellID = 20572, filter = "CD", absID = true},
			-- War Stomp (Tauren)
			{spellID = 20600, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Amplify Curse
			{spellID = 18288, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Blood Pact (Imp)
			-- {spellID = 6307, unitID = "player", caster = "all", filter = "BUFF"},
			-- -- Consume Shadows (Voidwalker)
			-- {spellID = 17767, unitID = "pet", caster = "all", filter = "BUFF"},
			-- -- Eye of Kilrogg
			-- {spellID = 126, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire Shield (Imp)
			{spellID = 2947, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- -- Health Funnel
			-- {spellID = 755, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Hellfire
			-- {spellID = 1949, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Master Demonologist (Imp - Reduced Threat)
			{spellID = 23759, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Voidwalker - Reduced Physical Taken)
			{spellID = 23760, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Succubus - Increased Damage)
			{spellID = 23761, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Felhunter - Increased Resistance)
			{spellID = 23762, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- -- Paranoia (Felhunter)
			-- {spellID = 19480, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- -- Phase Shift (Imp)
			-- {spellID = 4511, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Sacrifice (Voidwalker)
			{spellID = 7812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Ward
			{spellID = 6229, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Soul Link
			-- {spellID = 25228, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Tainted Blood (Felhunter)
			-- {spellID = 19478, unitID = "pet", caster = "all", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Shadow Trance
			{spellID = 17941, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Blessing of the Black Book (Special, Use) [The Black Book]
			{spellID = 23720, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Massive Destruction (Spell Critical Strike, Use) [Hazza'rah's Charm of Destruction]
			{spellID = 24543, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			--The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Aftermath
			{spellID = 18118, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption
			{spellID = 172, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cripple (Doomguard)
			{spellID = 20812, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Idiocy
			{spellID = 1010, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Recklessness
			{spellID = 704, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Tongues
			{spellID = 1714, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Weakness
			{spellID = 702, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of the Elements
			{spellID = 1490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Death Coil
			{spellID = 6789, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Life
			{spellID = 689, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Mana
			{spellID = 5138, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Soul
			{spellID = 1120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroclasm
			{spellID = 18093, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- -- Rain of Fire
			-- {spellID = 5740, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Vulnerability (Improved Shadow Bolt)
			{spellID = 17794, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Siphon Life
			{spellID = 18265, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rend (Doomguard)
			{spellID = 21949, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Tainted Blood Effect (Felhunter)
			{spellID = 19479, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Banish
			{spellID = 710, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Fear
			{spellID = 5782, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Amplify Curse
			{spellID = 18288, filter = "CD"},
			-- Conflagrate
			{spellID = 17962, filter = "CD"},
			-- Curse of Doom
			{spellID = 603, filter = "CD"},
			-- Death Coil
			{spellID = 6789, filter = "CD"},
			-- Fel Domination
			{spellID = 18708, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Inferno
			{spellID = 1122, filter = "CD", absID = true},
			-- Ritual of Doom
			{spellID = 18540, filter = "CD"},
			-- Shadow Ward
			{spellID = 6229, filter = "CD"},
			-- Shadowburn
			{spellID = 17877, filter = "CD"},
			-- Soul Fire
			{spellID = 6353, filter = "CD"},

			-- Pets
			-- Rain of Fire (Doomguard)
			{spellID = 4629, filter = "CD", absID = true},
			-- Spell Lock (Felhunter)
			{spellID = 19244, filter = "CD"},
			-- Suffering (Voidwalker)
			{spellID = 17735, filter = "CD"},

			-- Racial
			-- Blood Fury
			{spellID = 20572, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Battle Shout
			{spellID = 6673, unitID = "player", caster = "player", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodrage
			{spellID = 29131, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodthirst
			{spellID = 23885, unitID = "player", caster = "player", filter = "BUFF"},
			-- Death Wish
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Flurry
			{spellID = 12966, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recklessness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Retaliation
			{spellID = 20230, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sweeping Strikes
			{spellID = 12328, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Blood Craze
			{spellID = 16488, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 12880, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Item Sets
			-- Cheat Death (Special, Proc) [Dreadnaught's Battlegear]
			{spellID = 28846, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parry (Parry, Proc) [Battlegear of Wrath]
			{spellID = 23547, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Warrior's Wrath (Special, Proc) [Battlegear of Wrath]
			{spellID = 21887, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Gift of Life (Health, Use) [Lifegiving Gem]
			{spellID = 23725, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Deflection (Block Value, Use) [Glyph of Deflection]
			{spellID = 28773, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			--[[
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Strength of the Champion (Strength, Proc) [Arcanite Champion]
			{spellID = 16916, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Challenging Shout
			{spellID = 1161, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Charge Stun
			{spellID = 7922, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Disarm
			{spellID = 676, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Hamstring
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Improved Hamstring
			{spellID = 23694, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intercept Stun
			{spellID = 20253, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidating Shout (Cower)
			{spellID = 20511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidating Shout (Fear)
			{spellID = 5246, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mocking Blow
			{spellID = 694, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mortal Strike
			{spellID = 12294, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rend
			{spellID = 772, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Shield Bash - Silenced
			{spellID = 18498, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunder Armor
			{spellID = 7386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Thunder Clap
			{spellID = 6343, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		--[[
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},
		},
		--]]
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Berserker Rage
			{spellID = 18499, filter = "CD"},
			-- Bloodrage
			{spellID = 2687, filter = "CD"},
			-- Bloodthirst
			{spellID = 23881, filter = "CD"},
			-- Challenging Shout
			{spellID = 1161, filter = "CD"},
			-- Charge
			{spellID = 100, filter = "CD"},
			-- Concussion Blow
			{spellID = 12809, filter = "CD"},
			-- Death Wish
			{spellID = 12292, filter = "CD"},
			-- Disarm
			{spellID = 676, filter = "CD", absID = true},
			-- Intercept
			{spellID = 20252, filter = "CD"},
			-- Intimidating Shout
			{spellID = 5246, filter = "CD"},
			-- Last Stand
			{spellID = 12975, filter = "CD"},
			-- Mocking Blow
			{spellID = 694, filter = "CD"},
			-- Mortal Strike
			{spellID = 12294, filter = "CD"},
			-- Overpower
			{spellID = 7384, filter = "CD"},
			-- Pummel
			{spellID = 6552, filter = "CD", absID = true},
			-- Recklessness
			{spellID = 1719, filter = "CD"},
			-- Retaliation
			{spellID = 20230, filter = "CD"},
			-- Revenge
			{spellID = 6572, filter = "CD"},
			-- Shield Bash
			{spellID = 72, filter = "CD"},
			-- Shield Block
			{spellID = 2565, filter = "CD"},
			-- Shield Slam
			{spellID = 23922, filter = "CD"},
			-- Shield Wall
			{spellID = 871, filter = "CD"},
			-- Sweeping Strikes
			{spellID = 12328, filter = "CD"},
			-- Taunt
			{spellID = 355, filter = "CD"},
			-- Thunder Clap
			{spellID = 6343, filter = "CD", absID = true},
			-- Whirlwind
			{spellID = 1680, filter = "CD", absID = true},

			-- Racial
			-- Berserking (Rage)
			{spellID = 26296, filter = "CD", absID = true},
			-- Blood Fury
			{spellID = 20572, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20600, filter = "CD", absID = true},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["ALL"] = {
		{
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", SPECIAL_P_BUFF_ICON_Anchor},

			-- Potions: Classic
			-- Greater Stoneshield Potion
			{spellID = 17540, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mighty Rage Potion
			{spellID = 17528, unitID = "player", caster = "player", filter = "BUFF"},
			-- Magic Resistance Potion
			{spellID = 11364, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Arcane Protection Potion
			{spellID = 17549, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Fire Protection Potion
			{spellID = 17543, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Frost Protection Potion
			{spellID = 17544, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Nature Protection Potion
			{spellID = 17546, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Greater Shadow Protection Potion
			-- {spellID = 17548, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Holy Protection Potion
			{spellID = 17545, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Potions: Miscellaneous
			-- Swiftness Potion
			{spellID = 2379, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Invisibility Potion
			{spellID = 3680, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Invisibility Potion
			{spellID = 11392, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Free Action Potion
			{spellID = 6615, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Action Potion
			{spellID = 24364, unitID = "player", caster = "player", filter = "BUFF"},
			-- Swim Speed Potion
			{spellID = 7840, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Restorative Potion
			{spellID = 11359, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Miscellaneous
			-- Oil of Immolation
			{spellID = 11350, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Professions
			-- Goblin Rocket Boots
			{spellID = 8892, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gnomish Rocket Boots
			{spellID = 13141, unitID = "player", caster = "player", filter = "BUFF"},
			-- -- Parachute
			-- {spellID = 12438, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Berserking (Rage)
			-- {spellID = 26296, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- -- Berserking (Energy)
			-- {spellID = 26297, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blood Fury
			{spellID = 20572, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Perception (Human)
			{spellID = 20600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneform (Dwarf)
			{spellID = 20594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, unitID = "player", caster = "player", filter = "BUFF"},

			-- Zone Buffs
			-- Speed (Battlegrounds)
			{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Alliance Battle Standard
			{spellID = 23034, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Horde Battle Standard
			{spellID = 23035, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Stormpike Battle Standard 
			{spellID = 23539, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Frostwolf Battle Standard
			{spellID = 23538, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Damage Reduction
			-- Blessing of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lay on Hands (Armor Bonus)
			{spellID = 20233, unitID = "player", caster = "all", filter = "BUFF"},

			-- Other
			-- Innervate
			{spellID = 29166, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mana Tide
			{spellID = 16191, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Divine Intervention
			{spellID = 19752, unitID = "player", caster = "all", filter = "BUFF"},
			-- Slow Fall
			{spellID = 130, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Levitate
			{spellID = 1706, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "all", filter = "BUFF"},
			-- Soulstone Resurrection
			{spellID = 20707, unitID = "player", caster = "all", filter = "BUFF"},

			-- Trinket Effects
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "player", caster = "all", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.pvp_size,
			Position = {"TOP", PVE_PVP_DEBUFF_Anchor},

			-- Crowd Controls
			-- Druid
			-- Bash
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Celestial Focus (Starfire Stun)
			{spellID = 16922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Hibernate
			{spellID = 2637, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mangle
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pounce
			{spellID = 9005, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Hunter
			-- Charge (Boar)
			{spellID = 25999, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Freezing Trap Effect
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Concussive Shot
			{spellID = 19410, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Scatter Shot
			{spellID = 19503, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Mage
			-- Impact
			{spellID = 12355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- -- Polymorph (Turtle)
			-- {spellID = 28271, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- -- Polymorph (Pig)
			-- {spellID = 28272, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Paladin
			-- Hammer of Justice
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice (Stun)
			{spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Turn Undead
			{spellID = 2878, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Priest
			-- Blackout
			{spellID = 15269, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Control
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Psychic Scream
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shackle Undead
			{spellID = 9484, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Kidney Shot
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Riposte
			{spellID = 14251, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman

			-- Warlock
			-- Banish
			{spellID = 710, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Death Coil
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Fear
			{spellID = 5782, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pyroclasm
			{spellID = 18093, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Charge Stun
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Disarm
			{spellID = 676, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intercept Stun
			{spellID = 20253, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidating Shout (Cower)
			{spellID = 20511, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidating Shout (Fear)
			{spellID = 5246, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Racial
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Silences
			-- Counterspell - Silenced
			{spellID = 18469, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Kick - Silenced
			{spellID = 18425, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shield Bash - Silenced
			{spellID = 18498, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Roots
			-- Feral Charge Effect
			{spellID = 19675, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- -- Entangling Roots (Nature's Grasp)
			-- {spellID = 19975, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Counterattack
			{spellID = 19306, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Wing Clip
			{spellID = 19229, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbite
			{spellID = 12494, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Hamstring
			{spellID = 23694, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Slows
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Trap Aura
			{spellID = 13810, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wing Clip
			{spellID = 2974, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave
			{spellID = 11113, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- -- Chilled (Blizzard)
			-- {spellID = 12484, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- -- Chilled (Frost Armor)
			-- {spellID = 6136, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Chilled (Ice Armor)
			{spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Crippling Poison
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock
			{spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Aftermath
			{spellID = 18118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cripple (Doomguard)
			{spellID = 20812, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			--[[
			-- Raids: Classic
			--]]
			
		},
		--[[
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.pvp_size,
			Position = {"TOP", T_BUFF_Anchor},

			-- Druid
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 106951, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Turtle
			{spellID = 186265, unitID = "target", caster = "all", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 113862, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 198111, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Spellwarding
			{spellID = 204018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spectral Guise
			{spellID = 119030, unitID = "target", caster = "all", filter = "BUFF"},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Dominate Mind
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 185313, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Between the Eyes
			{spellID = 199804, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Grounding Totem
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Intimidating Shout
			{spellID = 5246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- Arcane Torrent
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- War Stomp
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Professions
			-- Shieldtronic Shield
			{spellID = 173260, unitID = "target", caster = "all", filter = "BUFF"},

			-- Player vs. Player
			-- Ashran
			-- Ancient Artifact
			{spellID = 168506, unitID = "target", caster = "all", filter = "BUFF"},
			-- Boulder Shield
			{spellID = 169373, unitID = "target", caster = "all", filter = "BUFF"},
			-- Scroll of Protection
			{spellID = 171249, unitID = "target", caster = "all", filter = "BUFF"},
			-- Star Root Tuber
			{spellID = 161495, unitID = "target", caster = "all", filter = "BUFF"},
			-- Battlegrounds
			-- Netherstorm Flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Orb of Power
			{spellID = 121175, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Warsong Flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Seaforium Bombs
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Drinking in Arena
			-- Ba'ruun's Bountiful Bloom
			{spellID = 167268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Drinking
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mage Food
			{spellID = 167152, unitID = "target", caster = "all", filter = "BUFF"},
		},
		--]]
	},
}