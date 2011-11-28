local T, C, L = unpack(select(2, ...))
if C.misc.auto_buy_reagents ~= true and T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example : Huge Seaforium Bombs from Isle of Conquest -> http://www.wowhead.com/item=67049
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.AutoBuy = {
	MAGE = {
		[17031] = 40,	-- Rune of Teleportation
		[17032] = 40,	-- Rune of Portals
		[17020] = 100,	-- Arcane Powder
	},
	ROGUE = {
		[6947] = 40,	-- Instant Poison
		[2892] = 40,	-- Deadly Poison
		[3775] = 40,	-- Crippling Poison
		[5237] = 40,	-- Mind-Numbing Poison
		[10918] = 20,	-- Wound Poison
	},
}