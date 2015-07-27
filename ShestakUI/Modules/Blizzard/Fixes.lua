local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Fix blank tooltip
----------------------------------------------------------------------------------------
local FixTooltip = CreateFrame("Frame")
FixTooltip:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
FixTooltip:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
FixTooltip:SetScript("OnEvent", function()
	for i = 1, 12 do
		local button = _G["ActionButton" .. i]
		if GameTooltip:GetOwner() == button then
			GameTooltip:Hide()
		end
	end
end)

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		GameTooltip:Hide()
	end
end)

----------------------------------------------------------------------------------------
--	Disable tooltip for player arrow on map
----------------------------------------------------------------------------------------
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

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

----------------------------------------------------------------------------------------
-- killing the anoying Blizz error "Interface\FrameXML\RaidFrame.lua:181" - by Semlar
----------------------------------------------------------------------------------------
function RaidInfoFrame_Update(scrollToSelected)
	RaidInfoFrame_UpdateSelectedIndex();
	
	local scrollFrame = RaidInfoScrollFrame;
	local savedInstances = GetNumSavedInstances();
	local savedWorldBosses = GetNumSavedWorldBosses();
	local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName;
	local frameName, frameNameText, frameID, frameReset, width;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
	local buttonHeight = buttons[1]:GetHeight();
	
	if ( scrollToSelected == true and RaidInfoFrame.selectedIndex ) then --Using == true in case the HybridScrollFrame .update is changed to pass in the parent.
		local button = buttons[RaidInfoFrame.selectedIndex - offset]
		if ( not button or (button:GetTop() > scrollFrame:GetTop()) or (button:GetBottom() < scrollFrame:GetBottom()) ) then
			local scrollFrame = RaidInfoScrollFrame;
			local buttonHeight = scrollFrame.buttons[1]:GetHeight();
			local scrollValue = min(((RaidInfoFrame.selectedIndex - 1) * buttonHeight), scrollFrame.range)
			if ( scrollValue ~= scrollFrame.scrollBar:GetValue() ) then
				scrollFrame.scrollBar:SetValue(scrollValue);
			end
		end
	end

	offset = HybridScrollFrame_GetOffset(scrollFrame);	--May have changed in the previous section to move selected parts into view.

	local mouseIsOverScrollFrame = scrollFrame:IsVisible() and scrollFrame:IsMouseOver();

	for i=1, numButtons do
		local frame = buttons[i];
		local index = i  offset;

		if ( index <= savedInstances  savedWorldBosses) then
			if (index <= savedInstances) then
				instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(index);
				frame.worldBossID = nil;
				frame.instanceID = instanceID;
				--frame.longInstanceID = string.format("%x%x", instanceIDMostSig, instanceID);
				frame.longInstanceID = instanceIDMostSig .. '.' .. instanceID
			else
				instanceName, instanceID, instanceReset = GetSavedWorldBossInfo(index - savedInstances);
				locked = true;
				extended = false;
				difficultyName = RAID_INFO_WORLD_BOSS;
				frame.worldBossID = instanceID;
				frame.instanceID = nil;
				frame.longInstanceID = nil;
			end
			
			frame:SetID(index);

			if ( RaidInfoFrame.selectedIndex == index ) then
				frame:LockHighlight();
			else
				frame:UnlockHighlight();
			end

			frame.difficulty:SetText(difficultyName);

			if ( extended or locked ) then
				frame.reset:SetText(SecondsToTime(instanceReset, true, nil, 3));
				frame.name:SetText(instanceName);
			else
				frame.reset:SetFormattedText("|cff808080%s|r", RAID_INSTANCE_EXPIRES_EXPIRED);
				frame.name:SetFormattedText("|cff808080%s|r", instanceName);
			end
			
			if ( extended ) then
				frame.extended:Show();
			else
				frame.extended:Hide();
			end
			
			frame:Show();
			
			if ( mouseIsOverScrollFrame and frame:IsMouseOver() ) then
				RaidInfoInstance_OnEnter(frame);
			end
		else
			frame:Hide();
		end	
	end
	HybridScrollFrame_Update(scrollFrame, (savedInstances  savedWorldBosses) * buttonHeight, scrollFrame:GetHeight());
end

function RaidInfoFrame_UpdateSelectedIndex()
	if (RaidInfoFrame.selectedRaidID) then
		local savedInstances = GetNumSavedInstances();
		for index=1, savedInstances do
			local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig = GetSavedInstanceInfo(index);
			if ( (instanceIDMostSig .. '.' .. instanceID) == RaidInfoFrame.selectedRaidID ) then
				RaidInfoFrame.selectedIndex = index;
				RaidInfoExtendButton:Enable();
				if ( extended ) then
					RaidInfoExtendButton.doExtend = false;
					RaidInfoExtendButton:SetText(UNEXTEND_RAID_LOCK);
				else
					RaidInfoExtendButton.doExtend = true;
					if ( locked ) then
						RaidInfoExtendButton:SetText(EXTEND_RAID_LOCK);
					else
						RaidInfoExtendButton:SetText(REACTIVATE_RAID_LOCK);
					end
				end
				return;
			end
		end
	elseif (RaidInfoFrame.selectedWorldBossID) then
		local savedInstances = GetNumSavedWorldBosses();
		for index=1, savedInstances do
			local _, worldBossID, _ = GetSavedWorldBossInfo(index);
			if (worldBossID == RaidInfoFrame.selectedWorldBossID) then
				RaidInfoExtendButton:SetText(EXTEND_RAID_LOCK);
				RaidInfoExtendButton:Disable();
				RaidInfoFrame.selectedIndex = index  GetNumSavedInstances();
				return;
			end
		end
	end
	RaidInfoFrame.selectedIndex = nil;
	RaidInfoExtendButton:Disable();
end
