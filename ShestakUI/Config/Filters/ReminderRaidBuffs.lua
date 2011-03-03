----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example : Incinerate Flesh from Lord Jaraxxus -> http://www.wowhead.com/?spell=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))
if not C.reminder.raid_buffs_enable == true then return end

T.ReminderRaidBuffs = {
	Flask = {
		79471,	-- Flask of the Winds
		79637,	-- Flask of Enhancement
		92679,	-- Flask of Battle
		79469,	-- Flask of Steelskin
		79470,	-- Flask of the Draconic Mind
		79472,	-- Flask of Titanic Strength
		94160,	-- Flask of Flowing Water
	},
	BattleElixir = {
		-- Scrolls
		89343,	-- Scroll of Agility IX
		89344,	-- Scroll of Protection IX
		89347,	-- Scroll of Intellect IX
		89342,	-- Scroll of Spirit IX
		89345,	-- Scroll of Stamina IX
		89346,	-- Scroll of Strength IX
		-- Elixirs
		79635,	-- Elixir of the Master
		79632,	-- Elixir of Mighty Speed
		79481,	-- Elixir of Impossible Accuracy
		79477,	-- Elixir of the Cobra
		79474,	-- Elixir of the Naga
		79468,	-- Ghost Elixir
	},
	GuardianElixir = {
		79631,	-- Prismatic Elixir
		79480,	-- Elixir of Deep Earth
	},
	Food = {
		87635,	-- Crocolisk Au Gratin
		87545,	-- Beer-Basted Crocolisk
		87546,	-- Skewered Eel
		87547,	-- Severed Sagefish Head
		87548,	-- Delicious Sagefish Tail
		87549,	-- Lavascale Minestrone
		87550,	-- Grilled Dragon
		87551,	-- Baked Rockfish
		87552,	-- Basilisk Liverdog
		87554,	-- Mushroom Sauce Mudfish
		87555,	-- Blackbelly Sushi
		87556,	-- Hearty Seafood Soup
		87634,	-- Lavascale Fillet
		87564,	-- Lurker Lunch
		87563,	-- Broiled Mountain Trout
		87562,	-- Lightly Fried Lurker
		87561,	-- Seasoned Crab
		87560,	-- Salted Eye
		87559,	-- Whitecrest Gumbo
		87558,	-- Pickled Guppy
		87557,	-- Tender Baked Turtle
	},
}