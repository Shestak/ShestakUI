local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.loot.auto_greed ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Amani Hex Stick -> http://www.wowhead.com/item=33865
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.NeedLoot = {
	33865,	-- Amani Hex Stick
}