local T, C, L = unpack(select(2, ...))
if C.misc.auto_buy_reagents ~= true and T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Rune of Teleportation -> http://www.wowhead.com/item=17031
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.AutoBuy = {

}