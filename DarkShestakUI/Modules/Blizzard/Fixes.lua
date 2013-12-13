local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Fix RemoveTalent() taint
----------------------------------------------------------------------------------------
FCF_StartAlertFlash = T.dummy

----------------------------------------------------------------------------------------
--	Fix DeclensionFrame strata
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

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
LFRBrowseFrameListScrollFrame:SetPoint("BOTTOMRIGHT", LFRBrowseFrameListButton19, "BOTTOMRIGHT", 17, -30)
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

	if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)

----------------------------------------------------------------------------------------
--	Clear Button on the TradeSkill search box(TradeSkillClearButton by Kunda)
----------------------------------------------------------------------------------------
local TradeSkillClearButton = CreateFrame("Button", nil, UIParent)

local function CreateButton()
	TradeSkillClearButton:SetParent(TradeSkillFrameSearchBox)
	TradeSkillClearButton:EnableMouse(true)
	TradeSkillClearButton:SetWidth(18)
	TradeSkillClearButton:SetHeight(18)
	TradeSkillClearButton:SetPoint("RIGHT", TradeSkillFrameSearchBox, "RIGHT", 0, 0)
	TradeSkillClearButton:Hide()

	TradeSkillClearButton.Texture = TradeSkillClearButton:CreateTexture(nil, "ARTWORK")
	TradeSkillClearButton.Texture:SetWidth(18)
	TradeSkillClearButton.Texture:SetHeight(18)
	TradeSkillClearButton.Texture:SetPoint("CENTER", 0, 0)
	TradeSkillClearButton.Texture:SetVertexColor(0.6, 0.6, 0.6)
	TradeSkillClearButton.Texture:SetTexture("Interface\\FriendsFrame\\ClearBroadcastIcon")

	TradeSkillClearButton:SetScript("OnEnter", function()
		TradeSkillClearButton.Texture:SetVertexColor(1, 1, 1)
	end)
	TradeSkillClearButton:SetScript("OnLeave", function()
		TradeSkillClearButton.Texture:SetVertexColor(0.6, 0.6, 0.6)
	end)
	TradeSkillClearButton:SetScript("OnClick", function()
		TradeSkillFrameSearchBox:ClearFocus()
		TradeSkillFrameSearchBox:SetText(SEARCH)
		TradeSkillFrameSearchBox:SetFontObject("GameFontDisable")
		TradeSkillClearButton:Hide()
	end)
end

local function OnEvent(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_TradeSkillUI" then
			CreateButton()
			TradeSkillFrame:HookScript("OnHide", function()
				TradeSkillClearButton:Hide()
			end)
			TradeSkillFrameSearchBox:HookScript("OnEditFocusGained", function()
				TradeSkillClearButton:Show()
			end)
			TradeSkillFrameSearchBox:HookScript("OnEditFocusLost", function()
				if TradeSkillFrameSearchBox:GetText() == "" then
					TradeSkillFrameSearchBox:ClearFocus()
					TradeSkillFrameSearchBox:SetText(SEARCH)
					TradeSkillFrameSearchBox:SetFontObject("GameFontDisable")
					TradeSkillClearButton:Hide()
				end
			end)
			TradeSkillClearButton:UnregisterEvent("ADDON_LOADED")
		end
	end
end

TradeSkillClearButton:RegisterEvent("ADDON_LOADED")
TradeSkillClearButton:SetScript("OnEvent", OnEvent)