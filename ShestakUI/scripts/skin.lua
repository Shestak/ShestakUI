----------------------------------------------------------------------------------------
--	Reskin Blizzard windows(by Tukz and Co)
----------------------------------------------------------------------------------------
local SkinBlizzUI = CreateFrame("Frame")
SkinBlizzUI:RegisterEvent("ADDON_LOADED")
SkinBlizzUI:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	
	-- Stuff not in Blizzard load-on-demand
	if addon == "ShestakUI" then
		-- Blizzard Frame reskin
		local bgskins = {
			"StaticPopup1",
			"StaticPopup2",
			"StaticPopup3",
			"StaticPopup4",
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"VideoOptionsFrame",
			"AudioOptionsFrame",
			"LFDDungeonReadyStatus",
			"BNToastFrame",
			"TicketStatusFrameButton",
			"DropDownList1MenuBackdrop",
			"DropDownList2MenuBackdrop",
			"DropDownList1Backdrop",
			"DropDownList2Backdrop",
			"LFDSearchStatus",
			"AutoCompleteBox",
			"ReadyCheckFrame",
			"ColorPickerFrame",
			"ConsolidatedBuffsTooltip",
			"LFDRoleCheckPopup",
			"ChannelPulloutBackground",			
			"FriendsTooltip",
			"LFDDungeonReadyDialog",
			"GuildInviteFrame",
			"ChatConfigFrame",
			"RolePollPopup",
			"AddFriendFrame",
			"ChannelFrameDaughterFrame",
			"aLoadFrame",
			"aLoadScroll",
			"AddonSets",
		}
		
		local insetskins = {
			"InterfaceOptionsFramePanelContainer",
			"InterfaceOptionsFrameAddOns",
			"InterfaceOptionsFrameCategories",
			"InterfaceOptionsFrameTab1",
			"InterfaceOptionsFrameTab2",
			"VideoOptionsFrameCategoryFrame",
			"VideoOptionsFramePanelContainer",			
			"AudioOptionsFrameCategoryFrame",
			"AudioOptionsSoundPanel",
			"AudioOptionsSoundPanelPlayback",
			"AudioOptionsSoundPanelHardware",
			"AudioOptionsSoundPanelVolume",
			"AudioOptionsVoicePanel",
			"AudioOptionsVoicePanelTalking",
			"AudioOptionsVoicePanelBinding",
			"AudioOptionsVoicePanelListening",
			"GhostFrameContentsFrame",
			"ChatConfigCategoryFrame",
			"ChatConfigBackgroundFrame",
			"ChatConfigChatSettingsClassColorLegend",
			"ChatConfigChatSettingsLeft",
		}
		
		-- Reskin popup buttons
		for i = 1, 4 do
			for j = 1, 3 do
				SettingsDB.SkinButton(_G["StaticPopup"..i.."Button"..j])
			end
		end

		for i = 1, getn(bgskins) do
			SettingsDB.SkinFadedPanel(_G[bgskins[i]])
		end
		
		for i = 1, getn(insetskins) do
			SettingsDB.SkinPanel(_G[insetskins[i]])
		end
		
		local ChatMenus = {
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu",
		}
		
		for i = 1, getn(ChatMenus) do
			if _G[ChatMenus[i]] == _G["ChatMenu"] then
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) SettingsDB.SkinFadedPanel(self) self:ClearAllPoints() self:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, SettingsDB.Scale(30)) end)
			else
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) SettingsDB.SkinFadedPanel(self) end)
			end
		end
		
		-- Hide header textures and move text/buttons
		local BlizzardHeader = {
			"GameMenuFrame", 
			"InterfaceOptionsFrame", 
			"AudioOptionsFrame", 
			"VideoOptionsFrame",
			"ColorPickerFrame",
			"ChatConfigFrame",
		}
		
		for i = 1, getn(BlizzardHeader) do
			local title = _G[BlizzardHeader[i].."Header"]			
			if title then
				title:SetTexture("")
				title:ClearAllPoints()
				if title == _G["GameMenuFrameHeader"] then
					title:SetPoint("TOP", GameMenuFrame, 0, 7)
				elseif title == _G["ColorPickerFrameHeader"] then
					title:SetPoint("TOP", ColorPickerFrame, 0, 7)
				elseif title == _G["ChatConfigFrameHeader"] then
					title:SetPoint("TOP", ChatConfigFrame, 0, 7)
				else
					title:SetPoint("TOP", BlizzardHeader[i], 0, 0)
				end
			end
		end
		
		-- Reskin buttons
		local BlizzardButtons = {
			"GameMenuButtonOptions",
			"GameMenuButtonSoundOptions",
			"GameMenuButtonUIOptions",
			"GameMenuButtonKeybindings",
			"GameMenuButtonMacros",
			"GameMenuButtonRatings",
			"GameMenuButtonAddOns",
			"GameMenuButtonLogout",
			"GameMenuButtonQuit",
			"GameMenuButtonContinue",
			"GameMenuButtonMacOptions",
			"GameMenuButtonOptionHouse",
			"GameMenuButtonAddonManager",
			"GameMenuButtonSettingsGUI",
			"VideoOptionsFrameOkay",
			"VideoOptionsFrameCancel",
			"VideoOptionsFrameDefaults",
			"VideoOptionsFrameApply",
			"AudioOptionsFrameOkay",
			"AudioOptionsFrameCancel",
			"AudioOptionsFrameDefaults",
			"InterfaceOptionsFrameDefaults",
			"InterfaceOptionsFrameOkay",
			"InterfaceOptionsFrameCancel",
			"ReadyCheckFrameYesButton",
			"ReadyCheckFrameNoButton",
			"ColorPickerOkayButton",
			"ColorPickerCancelButton",
			"BaudErrorFrameClearButton",
			"BaudErrorFrameCloseButton",
			"GuildInviteFrameJoinButton",
			"GuildInviteFrameDeclineButton",
			"LFDDungeonReadyDialogLeaveQueueButton",
			"LFDDungeonReadyDialogEnterDungeonButton",
			"ChatConfigFrameDefaultButton",
			"ChatConfigFrameOkayButton",
			"RolePollPopupAcceptButton",
			"LFDRoleCheckPopupDeclineButton",
			"LFDRoleCheckPopupAcceptButton",
			"InterfaceOptionsFrameTab1",
			"InterfaceOptionsFrameTab2",
			"AddFriendEntryFrameCancelButton",
			"AddFriendEntryFrameAcceptButton",
			"ChannelFrameDaughterFrameOkayButton",
			"ChannelFrameDaughterFrameCancelButton",
			"AddonSet1",
			"AddonSet2",
			"AddonSet3",
			"AddonSet4",
			"AddonSet5",
			"AddonSet6",
			"aLoadReload",
		}
		
		for i = 1, getn(BlizzardButtons) do
			local UIButtons = _G[BlizzardButtons[i]]
			if UIButtons then
				SettingsDB.SkinButton(UIButtons)
			end
		end
		
		-- Button position or text
		_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
		_G["VideoOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["VideoOptionsFrameApply"]:ClearAllPoints()
		_G["VideoOptionsFrameApply"]:SetPoint("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:SetPoint("RIGHT", _G["VideoOptionsFrameApply"], "LEFT", -4, 0)
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
		_G["AudioOptionsFrameDefaults"]:ClearAllPoints()
		_G["AudioOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["AudioOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["AudioOptionsFrameCancel"]:ClearAllPoints()
		_G["AudioOptionsFrameCancel"]:SetPoint("TOPRIGHT", _G["AudioOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["AudioOptionsFrameOkay"]:ClearAllPoints()
		_G["AudioOptionsFrameOkay"]:SetPoint("RIGHT", _G["AudioOptionsFrameCancel"], "LEFT", -4, 0)
		_G["InterfaceOptionsFrameDefaults"]:ClearAllPoints()
		_G["InterfaceOptionsFrameDefaults"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "BOTTOMLEFT", 0, -14)
		_G["InterfaceOptionsFrameCancel"]:ClearAllPoints()
		_G["InterfaceOptionsFrameCancel"]:SetPoint("TOPRIGHT", _G["InterfaceOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
		_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT", _G["InterfaceOptionsFrameCancel"], "LEFT", -4, 0)
		_G["ColorPickerOkayButton"]:ClearAllPoints()
		_G["ColorPickerOkayButton"]:SetPoint("BOTTOMLEFT", _G["ColorPickerFrame"], "BOTTOMLEFT", 6, 6)
		_G["ColorPickerCancelButton"]:ClearAllPoints()
		_G["ColorPickerCancelButton"]:SetPoint("BOTTOMRIGHT", _G["ColorPickerFrame"], "BOTTOMRIGHT", -6, 6)
		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameYesButton"]:SetPoint("RIGHT", _G["ReadyCheckFrame"], "CENTER", -6, 0)
		_G["ReadyCheckFrameNoButton"]:SetPoint("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 6, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameText"]:ClearAllPoints()
		_G["ReadyCheckFrameText"]:SetPoint("TOP", 0, -12)
		_G["InterfaceOptionsFrameTab1"]:ClearAllPoints()
		_G["InterfaceOptionsFrameTab1"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "TOPLEFT", 5, 27)
		_G["InterfaceOptionsFrameTab2"]:ClearAllPoints()
		_G["InterfaceOptionsFrameTab2"]:SetPoint("TOPLEFT", _G["InterfaceOptionsFrameTab1"], "TOPRIGHT", 6, 0)
		_G["ChatConfigFrameDefaultButton"]:SetWidth(125)
		_G["ChatConfigFrameDefaultButton"]:ClearAllPoints()
		_G["ChatConfigFrameDefaultButton"]:SetPoint("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
		_G["ChatConfigFrameOkayButton"]:ClearAllPoints()
		_G["ChatConfigFrameOkayButton"]:SetPoint("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
		
		-- Others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)
	end
	
	-- MAC menu/option panel(by Affli)
	if IsMacClient() then
		-- Skin main frame and reposition the header
		SettingsDB.SkinFadedPanel(MacOptionsFrame)
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)
	 
		-- Skin internal frames
		SettingsDB.SkinPanel(MacOptionsFrameMovieRecording)
		SettingsDB.SkinPanel(MacOptionsITunesRemote)
	 
		-- Skin buttons
		SettingsDB.SkinButton(_G["MacOptionsFrameCancel"])
		SettingsDB.SkinButton(_G["MacOptionsFrameOkay"])
		SettingsDB.SkinButton(_G["MacOptionsButtonKeybindings"])
		SettingsDB.SkinButton(_G["MacOptionsFrameDefaults"])
		SettingsDB.SkinButton(_G["MacOptionsButtonCompress"])
	 
		-- Reposition and resize buttons
		local tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:SetWidth(136)
		_G["MacOptionsButtonCompress"]:ClearAllPoints()
		_G["MacOptionsButtonCompress"]:SetPoint(tPoint, tRTo, tRP, SettingsDB.Scale(4), tY)
	 
		_G["MacOptionsFrameCancel"]:SetWidth(96)
		_G["MacOptionsFrameCancel"]:SetHeight(22)
		tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsFrameCancel"]:GetPoint()
		_G["MacOptionsFrameCancel"]:ClearAllPoints()
		_G["MacOptionsFrameCancel"]:SetPoint(tPoint, tRTo, tRP, SettingsDB.Scale(-14), tY)
	 
		_G["MacOptionsFrameOkay"]:ClearAllPoints()
		_G["MacOptionsFrameOkay"]:SetWidth(96)
		_G["MacOptionsFrameOkay"]:SetHeight(22)
		_G["MacOptionsFrameOkay"]:SetPoint("LEFT", _G["MacOptionsFrameCancel"], -99, 0)
	 
		_G["MacOptionsButtonKeybindings"]:ClearAllPoints()
		_G["MacOptionsButtonKeybindings"]:SetWidth(96)
		_G["MacOptionsButtonKeybindings"]:SetHeight(22)
		_G["MacOptionsButtonKeybindings"]:SetPoint("LEFT", _G["MacOptionsFrameOkay"], -99, 0)
	 
		_G["MacOptionsFrameDefaults"]:SetWidth(96)
		_G["MacOptionsFrameDefaults"]:SetHeight(22)
		
		_G["MacOptionsButtonCompressLeft"]:SetAlpha(0)
		_G["MacOptionsButtonCompressMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonCompressRight"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsLeft"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsRight"]:SetAlpha(0)
	end

	-- DBM-GUI Frame
	if addon == "DBM-GUI" then
		SettingsDB.SkinFadedPanel(_G["DBM_GUI_OptionsFrame"])
		SettingsDB.SkinPanel(_G["DBM_GUI_OptionsFramePanelContainer"])

		_G["DBM_GUI_OptionsFrameTab1"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab1"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameBossMods"], "TOPLEFT", 10, 27)
		_G["DBM_GUI_OptionsFrameTab2"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab2"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameTab1"], "TOPRIGHT", 6, 0)
		
		_G["DBM_GUI_OptionsFrameBossMods"]:HookScript("OnShow", function(self) SettingsDB.SkinPanel(self) end)
		_G["DBM_GUI_OptionsFrameDBMOptions"]:HookScript("OnShow", function(self) SettingsDB.SkinPanel(self) end)
		_G["DBM_GUI_OptionsFrameHeader"]:SetTexture("")
		_G["DBM_GUI_OptionsFrameHeader"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameHeader"]:SetPoint("TOP", DBM_GUI_OptionsFrame, 0, 7)
		
		local dbmbskins = {
			"DBM_GUI_OptionsFrameOkay",
			"DBM_GUI_OptionsFrameTab1",
			"DBM_GUI_OptionsFrameTab2",
		}
		
		for i = 1, getn(dbmbskins) do
			local DBMButtons = _G[dbmbskins[i]]
			if DBMButtons then
				SettingsDB.SkinButton(DBMButtons)
			end
		end
	end
end)