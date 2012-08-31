local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Fixes bugs in default UI
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
--	Fix SearchLFGLeave() taint
----------------------------------------------------------------------------------------
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function(self, elapsed)
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)

----------------------------------------------------------------------------------------
--	Fix LFRBrowseFrameList/LFRQueueFrameSpecificList scroll frames
----------------------------------------------------------------------------------------
LFRBrowseFrameListScrollFrame:ClearAllPoints()
LFRBrowseFrameListScrollFrame:SetPoint("TOPLEFT", LFRBrowseFrameListButton1, "TOPLEFT", 0, 0)
LFRBrowseFrameListScrollFrame:SetPoint("BOTTOMRIGHT", LFRBrowseFrameListButton19, "BOTTOMRIGHT", 5, -2)
LFRQueueFrameSpecificListScrollFrame:ClearAllPoints()
LFRQueueFrameSpecificListScrollFrame:SetPoint("TOPLEFT", LFRQueueFrameSpecificListButton1, "TOPLEFT", 0, 0)
LFRQueueFrameSpecificListScrollFrame:SetPoint("BOTTOMRIGHT", LFRQueueFrameSpecificListButton14, "BOTTOMRIGHT", 0, -2)

----------------------------------------------------------------------------------------
--	Collect garbage
----------------------------------------------------------------------------------------
local eventcount = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1

	if (InCombatLockdown() and eventcount > 25000) or eventcount > 10000 or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)

----------------------------------------------------------------------------------------
--	Fix TalentUI taint
----------------------------------------------------------------------------------------
StaticPopupDialogs.UI_TALENT_FIX = {
	text = L_POPUP_TALENT_FIX,
	button1 = L_ALOAD_RL,
	OnAccept = ReloadUI,
	timeout = 0,
	whileDead = 1,
	showAlert = true,
	hideOnEscape = false,
	preferredIndex = 5,
}

local function LoadTalentFix()
	local function TalentFix()
		if INSPECTED_UNIT then
			if InspectFrame and InspectFrame:IsShown() then HideUIPanel(InspectFrame) end
			HideUIPanel(PlayerTalentFrame)
			for i = 1, 4 do
				local p = _G["StaticPopup"..i]
				p:Hide()
			end
			StaticPopup_Show("UI_TALENT_FIX")
		end
	end
	for i = 1, MAX_NUM_TALENT_TIERS do
		local row = _G["PlayerTalentFrameTalentsTalentRow"..i]
		for j = 1, NUM_TALENT_COLUMNS do
			local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
			bu:HookScript("OnClick", TalentFix)
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TalentUI" then
		LoadTalentFix()
	end
end)