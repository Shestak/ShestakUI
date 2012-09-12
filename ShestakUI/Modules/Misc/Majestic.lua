local T, C, L, _ = unpack(select(2, ...))
if T.name == "Занштек" or T.name == "Гранн" or T.name == "Тёми" or T.name == "Палтасар" or T.name == "Ллевалалуз" or T.name == "Сиамад" then 
	T.soauthor = true 
end
if T.soauthor ~= true then return end

AlertFrame:UnregisterEvent("LOOT_ITEM_ROLL_WON")
AlertFrame:UnregisterEvent("SHOW_LOOT_TOAST")