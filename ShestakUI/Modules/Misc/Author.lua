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
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		PlaySound("ReadyCheck", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" or event == "PARTY_INVITE_REQUEST" or event == "CONFIRM_SUMMON" then
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
--	Auto SetFilter for PetJournal
----------------------------------------------------------------------------------------
local PetFilter = CreateFrame("Frame")
PetFilter:RegisterEvent("ADDON_LOADED")
PetFilter:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_PetJournal" then
		C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
		C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, true)
		C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, false)
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
--	Unregister some events
----------------------------------------------------------------------------------------
AlertFrame:UnregisterEvent("LOOT_ITEM_ROLL_WON")
AlertFrame:UnregisterEvent("SHOW_LOOT_TOAST")

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
			"PVP_POWER",
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
	DRUID = {3, 1, 1, 3},
	HUNTER = {2, 2, 2},
	MAGE = {3, 3, 3},
	PALADIN = {3, 1, 1},
	PRIEST = {3, 3, 3},
	ROGUE = {1, 1, 1},
	SHAMAN = {3, 1, 3},
	WARLOCK = {3, 3, 3},
	WARRIOR = {1, 1, 1},
	MONK = {1, 1, 1},
}

local handler = CreateFrame("Frame")
handler:RegisterEvent("PLAYER_TALENT_UPDATE")
handler:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
handler:SetScript("OnEvent", function()
	local spec = GetSpecialization()
	if spec == 0 then return end

	if spec then
		PaperDoll_InitStatCategories = function()
			orig(sort[classes[class][spec]], nil, nil, "player")
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