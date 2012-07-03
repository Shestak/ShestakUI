local T, C, L = unpack(select(2, ...))
if T.author ~= true then return end

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("PARTY_INVITE_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		PlaySound("ReadyCheck", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" or event == "PARTY_INVITE_REQUEST" then
		PlaySound("ReadyCheck", "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Auto SetFilter for AchievementUI
----------------------------------------------------------------------------------------
local AchFilter = CreateFrame("Frame")
AchFilter:RegisterEvent("ADDON_LOADED")
AchFilter:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		AchievementFrame_SetFilter(3)
	end
end)

----------------------------------------------------------------------------------------
--	Force quit
----------------------------------------------------------------------------------------
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Delete Replace Enchant popup
----------------------------------------------------------------------------------------
local EnchantPopup = CreateFrame("Frame")
EnchantPopup:RegisterEvent("REPLACE_ENCHANT")
EnchantPopup:SetScript("OnEvent", function(...)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local popup = _G["StaticPopup"..i]
		if popup.which == "REPLACE_ENCHANT" then
			StaticPopup_OnClick(popup, 1)
		end
	end
end)

----------------------------------------------------------------------------------------
--	Block damage meter spam(Decount by Tekkub)
----------------------------------------------------------------------------------------
local filterstrings = {
	"^Recount - (.*)$",
	"%d+%. %S+%s*%d+ %([%d.]+, [%d.]+%%%)",			-- Recount
	--"^(%d+). (.*)$",								-- Also Recount
	"%d+%. - [%d.]+%%% %S+%s*%d+",					-- 
	"%d+%.%s+[%w%s]+%s+[%d.]+ %([%d.]+%)",			-- 10. Khal 2397.9 (5.8%)
	--"%d+%.%s+%S+%s+<%S+>%s+[%d.]+%s+%([%d.]+%)",	-- 2. Bonehead <Demante> 129.9 (3.9%)
	"%d+%.%s+%S+%s+[%d.]+",							-- 10. Khal 2397.9
}

local function filter(self, event, msg)
	for _, str in pairs(filterstrings) do if msg:match(str) then return true end end
end

for _,event in pairs{"CHAT_MSG_YELL", "CHAT_MSG_SAY", "CHAT_MSG_RAID", "CHAT_MSG_PARTY"} do
	ChatFrame_AddMessageEventFilter(event, filter)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(EventBossAutoSelect by Nathanyel)
----------------------------------------------------------------------------------------
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Check date
----------------------------------------------------------------------------------------
function T.DateCheck(m, d)
	local month = tonumber(date("%m"))
	local day = tonumber(date("%d"))
	if month == m and day == d then
		return true
	else
		return false
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if T.DateCheck(1, 1) == true then
		T.Delay(15, print, "|cffffff00Happy New Year. From Shestak.|r")
		T.Delay(16, T.InfoTextShow, "Happy New Year. From Shestak.")
	--elseif T.DateCheck(1, 8) == true then
	--	T.Delay(15, print, "|cffffff00Blah blah. From Shestak.|r")
	--	T.Delay(16, T.InfoTextShow, "Blah blah. From Shestak.")
	end
	self:UnregisterAllEvents()
end)

----------------------------------------------------------------------------------------
--	Enables Launcher to download Mist of Pandaria data files
----------------------------------------------------------------------------------------
if GetCVar("accounttype") ~= "MP" then
	SetCVar("accounttype", "MP")
end

----------------------------------------------------------------------------------------
--	Auto hide unnecessary stats from CharacterFrame(module from Inomena by p3lim)
----------------------------------------------------------------------------------------
if T.MOPVersion then return end
PAPERDOLL_STATCATEGORIES = {
	GENERAL = {
		id = 1,
		stats = {
			"ITEMLEVEL",
			"MOVESPEED",
		},
	},
	MELEE = {
		id = 2,
		stats = {
			"STRENGTH",
			"AGILITY",
			"MELEE_AP",
			"ENERGY_REGEN",
			"RUNE_REGEN",
			"HASTE",
			"CRITCHANCE",
			"HITCHANCE",
			"EXPERTISE",
			"MASTERY",
		},
	},
	RANGED = {
		id = 2,
		stats = {
			"AGILITY",
			"RANGED_AP",
			"RANGED_HASTE",
			"FOCUS_REGEN",
			"RANGED_CRITCHANCE",
			"RANGED_HITCHANCE",
			"MASTERY",
		},
	},
	SPELL = {
		id = 2,
		stats = {
			"SPIRIT",
			"INTELLECT",
			"SPELLDAMAGE",
			"SPELLHEALING",
			"SPELL_HASTE",
			"MANAREGEN",
			"SPELL_CRITCHANCE",
			"SPELL_HITCHANCE",
			"MASTERY",
		},
	},
	DEFENSE = {
		id = 3,
		stats = {
			"STAMINA",
			"ARMOR",
			"DODGE",
			"PARRY",
			"BLOCK",
			"RESILIENCE_REDUCTION",
			"ARCANE",
			"FIRE",
			"FROST",
			"NATURE",
			"SHADOW",
		},
	},
}

local orig = PaperDoll_InitStatCategories
local class = select(2, UnitClass("player"))

local sort = {
	{
		"GENERAL",
		"MELEE",
		"DEFENSE",
	},
	{
		"GENERAL",
		"RANGED",
		"DEFENSE",
	},
	{
		"GENERAL",
		"SPELL",
		"DEFENSE",
	},
}

local spec
local classes = {
	DEATHKNIGHT = {1, 1, 1},
	DRUID = {3, 1, 3},
	HUNTER = {2, 2, 2},
	MAGE = {3, 3, 3},
	PALADIN = {3, 1, 1},
	PRIEST = {3, 3, 3},
	ROGUE = {1, 1, 1},
	SHAMAN = {3, 1, 3},
	WARLOCK = {3, 3, 3},
	WARRIOR = {1, 1, 1},
}

local handler = CreateFrame("Frame")
handler:RegisterEvent("PLAYER_TALENT_UPDATE")
handler:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
handler:SetScript("OnEvent", function()
	local tabs = GetNumSpecializations()
	if tabs == 0 then return end

	local mostPoints = -1
	for index = 1, tabs do
		local _, _, _, _, points = GetSpecializationInfo(index)
		if points > mostPoints then
			mostPoints = points
			spec = index
		end
	end

	PaperDoll_InitStatCategories = function()
		orig(sort[classes[class][spec]], nil, nil, "player")
		PaperDollFrame_CollapseStatCategory(CharacterStatsPaneCategory4)
	end
end)

for index = 1, 3 do
	local toolbar = _G["CharacterStatsPaneCategory"..index.."Toolbar"]
	toolbar:SetScript("OnEnter", nil)
	toolbar:SetScript("OnClick", nil)
	toolbar:RegisterForDrag()
end

do
	local setStat = PaperDollFrame_SetStat
	function PaperDollFrame_SetStat(self, unit, index)
		if index == 1 and class ~= "DEATHKNIGHT" and class ~= "PALADIN" and class ~= "WARRIOR" then
			return self:Hide()
		end

		setStat(self, unit, index)
	end

	local setSpellHit = PaperDollFrame_SetSpellHitChance
	function PaperDollFrame_SetSpellHitChance(self, unit)
		if class == "PRIEST" and spec ~= 3 then
			return self:Hide()
		elseif (class == "DRUID" or class == "SHAMAN") and spec == 3 then
			return self:Hide()
		end

		setSpellHit(self, unit)
	end

	local setParry = PaperDollFrame_SetParry
	function PaperDollFrame_SetParry(self, unit)
		if class ~= "PALADIN" and class ~= "WARRIOR" and class ~= "DEATHKNIGHT" then
			return self:Hide()
		end
	end

	local setBlock = PaperDollFrame_SetBlock
	function PaperDollFrame_SetBlock(self, unit)
		if class ~= "PALADIN" and class ~= "WARRIOR" then
			return self:Hide()
		end
	end
end