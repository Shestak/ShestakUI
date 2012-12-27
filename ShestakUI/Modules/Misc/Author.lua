local T, C, L, _ = unpack(select(2, ...))
if T.author ~= true then return end

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("PARTY_INVITE_REQUEST")
ForceWarning:RegisterEvent("CONFIRM_SUMMON")
ForceWarning:RegisterEvent("PET_BATTLE_QUEUE_PROPOSE_MATCH")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		PlaySound("ReadyCheck", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" or event == "PARTY_INVITE_REQUEST" or event == "CONFIRM_SUMMON" or event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then
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
EnchantPopup:SetScript("OnEvent", function(self, event)
	if event == "REPLACE_ENCHANT" then
		ReplaceEnchant()
		StaticPopup_Hide("REPLACE_ENCHANT")
	end
end)

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
--	Hide character controls
----------------------------------------------------------------------------------------
CharacterModelFrameControlFrame:HookScript("OnShow", function(self) self:Hide() end)
DressUpModelControlFrame:HookScript("OnShow", function(self) self:Hide() end)
SideDressUpModelControlFrame:HookScript("OnShow", function(self) self:Hide() end)

----------------------------------------------------------------------------------------
--	Hide subzone text
----------------------------------------------------------------------------------------
SubZoneTextFrame:SetScript("OnShow", function() SubZoneTextFrame:Hide() end)

----------------------------------------------------------------------------------------
--	Disable flash tab
----------------------------------------------------------------------------------------
ChatTypeInfo.WHISPER = {sticky = 1, flashTab = false, flashTabOnGeneral = false}
ChatTypeInfo.BN_WHISPER = {sticky = 1, flashTab = false, flashTabOnGeneral = false}

----------------------------------------------------------------------------------------
--	Switch resolution
----------------------------------------------------------------------------------------
SlashCmdList.SWITCHRESO = function()
	if ({GetScreenResolutions()})[GetCurrentResolution()] == "1366x768" then
		SetCVar("gxWindow", 1)
		SetCVar("gxResolution", "1280x600")
	else
		SetCVar("gxWindow", 0)
		SetCVar("gxResolution", "1366x768")
	end
	RestartGx()
end
SLASH_SWITCHRESO1 = "/sr"
SLASH_SWITCHRESO2 = "/ык"

----------------------------------------------------------------------------------------
--	Auto hide unnecessary stats from CharacterFrame(module from Inomena by p3lim)
----------------------------------------------------------------------------------------
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
			"CRITCHANCE",
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
			"SPELLCRIT",
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
			"PVP_POWER",
		},
	},
}

local orig = PaperDoll_InitStatCategories
local class = select(3, UnitClass("player"))

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
local specs = {
	{1, 1, 1},
	{3, 1, 1},
	{2, 2, 2},
	{1, 1, 1},
	{3, 3, 3},
	{1, 1, 1},
	{3, 1, 3},
	{3, 3, 3},
	{3, 3, 3},
	{1, 3, 1},
	{3, 1, 1, 3},
}

local handler = CreateFrame("Frame")
handler:RegisterEvent("PLAYER_TALENT_UPDATE")
handler:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
handler:SetScript("OnEvent", function()
	spec = GetSpecialization()

	if spec then
		PaperDoll_InitStatCategories = function()
			orig(sort[specs[class][spec]], nil, nil, "player")
			PaperDollFrame_CollapseStatCategory(CharacterStatsPaneCategory4)
		end
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
	function PaperDollFrame_SetStat(self, ...)
		if index == 1 and class ~= 6 and class ~= 2 and class ~= 1 then
			return self:Hide()
		end

		setStat(self, ...)
	end

	local setSpellHit = PaperDollFrame_SetSpellHitChance
	function PaperDollFrame_SetSpellHitChance(self, ...)
		if class == 5 and spec ~= 3 then
			return self:Hide()
		elseif (class == 11 or class == 7) and spec == 3 then
			return self:Hide()
		end

		setSpellHit(self, ...)
	end

	local setParry = PaperDollFrame_SetParry
	function PaperDollFrame_SetParry(self, ...)
		if class ~= 2 and class ~= 1 and class ~= 6 and not (class == 10 and spec == 2) then
			return self:Hide()
		end

		setParry(self, ...)
	end

	local setBlock = PaperDollFrame_SetBlock
	function PaperDollFrame_SetBlock(self, ...)
		if class ~= 2 and class ~= 1 then
			return self:Hide()
		end

		setBlock(self, ...)
	end
end