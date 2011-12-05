local T, C, L = unpack(select(2, ...))
if C.misc.auto_buy_reagents ~= true and T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Rune of Teleportation -> http://www.wowhead.com/item=17031
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.AutoBuy = {
	MAGE = {
		[17031] = 20,	-- Rune of Teleportation
		[17032] = 20,	-- Rune of Portals
		[17020] = 100,	-- Arcane Powder
	},
	ROGUE = {
		[6947] = 20,	-- Instant Poison
		[2892] = 20,	-- Deadly Poison
		[3775] = 20,	-- Crippling Poison
		[5237] = 20,	-- Mind-Numbing Poison
		[10918] = 20,	-- Wound Poison
	},
}