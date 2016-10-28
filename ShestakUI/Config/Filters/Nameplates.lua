local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
	[SpellName(107079)] = true,	-- Quaking Palm
}

T.DebuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.PlateBlacklist = {
	-- Army of the Dead
	["Army of the Dead"] = true,
	["Войско мертвых"] = true,
	-- Wild Imp
	["Wild Imp"] = true,
	["Дикий бес"] = true,
	-- Hunter Trap
	["Venomous Snake"] = true,
	["Ядовитая змея"] = true,
	["Viper"] = true,
	["Гадюка"] = true,
	-- Raid
	["Liquid Obsidian"] = true,
	["Жидкий обсидиан"] = true,
	["Lava Parasites"] = true,
	["Лавовый паразит"] = true,
	-- Gundrak
	["Fanged Pit Viper"] = true,
	["Клыкастая глубинная гадюка"] = true,
}