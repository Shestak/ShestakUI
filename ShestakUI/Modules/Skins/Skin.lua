----------------------------------------------------------------------------------------
--	Reskin Blizzard windows(by Tukz and Co)
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))

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
				_G["StaticPopup"..i.."Button"..j]:SkinButton()
			end
		end

		for i = 1, getn(bgskins) do
			_G[bgskins[i]]:SetTemplate("Transparent")
		end
		
		for i = 1, getn(insetskins) do
			_G[insetskins[i]]:SetTemplate("Overlay")
		end
		
		local ChatMenus = {
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu",
		}
		
		for i = 1, getn(ChatMenus) do
			if _G[ChatMenus[i]] == _G["ChatMenu"] then
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Transparent") self:ClearAllPoints() self:Point("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 30) end)
			else
				_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end)
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
					title:Point("TOP", GameMenuFrame, 0, 7)
				elseif title == _G["ColorPickerFrameHeader"] then
					title:Point("TOP", ColorPickerFrame, 0, 7)
				elseif title == _G["ChatConfigFrameHeader"] then
					title:Point("TOP", ChatConfigFrame, 0, 7)
				else
					title:Point("TOP", BlizzardHeader[i], 0, 0)
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
				UIButtons:SkinButton()
			end
		end
		
		-- Button position or text
		_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
		_G["VideoOptionsFrameDefaults"]:Point("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["VideoOptionsFrameApply"]:ClearAllPoints()
		_G["VideoOptionsFrameApply"]:Point("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:Point("RIGHT", _G["VideoOptionsFrameApply"], "LEFT", -4, 0)
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:Point("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
		_G["AudioOptionsFrameDefaults"]:ClearAllPoints()
		_G["AudioOptionsFrameDefaults"]:Point("TOPLEFT", _G["AudioOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["AudioOptionsFrameCancel"]:ClearAllPoints()
		_G["AudioOptionsFrameCancel"]:Point("TOPRIGHT", _G["AudioOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["AudioOptionsFrameOkay"]:ClearAllPoints()
		_G["AudioOptionsFrameOkay"]:Point("RIGHT", _G["AudioOptionsFrameCancel"], "LEFT", -4, 0)
		_G["InterfaceOptionsFrameDefaults"]:ClearAllPoints()
		_G["InterfaceOptionsFrameDefaults"]:Point("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "BOTTOMLEFT", 0, -14)
		_G["InterfaceOptionsFrameCancel"]:ClearAllPoints()
		_G["InterfaceOptionsFrameCancel"]:Point("TOPRIGHT", _G["InterfaceOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
		_G["InterfaceOptionsFrameOkay"]:Point("RIGHT", _G["InterfaceOptionsFrameCancel"], "LEFT", -4, 0)
		_G["ColorPickerOkayButton"]:ClearAllPoints()
		_G["ColorPickerOkayButton"]:Point("BOTTOMLEFT", _G["ColorPickerFrame"], "BOTTOMLEFT", 6, 6)
		_G["ColorPickerCancelButton"]:ClearAllPoints()
		_G["ColorPickerCancelButton"]:Point("BOTTOMRIGHT", _G["ColorPickerFrame"], "BOTTOMRIGHT", -6, 6)
		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameYesButton"]:ClearAllPoints()
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:ClearAllPoints()
		_G["ReadyCheckFrameYesButton"]:Point("RIGHT", _G["ReadyCheckFrame"], "CENTER", 0, -22)
		_G["ReadyCheckFrameNoButton"]:Point("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 6, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameText"]:ClearAllPoints()
		_G["ReadyCheckFrameText"]:Point("TOP", 0, -12)
		_G["InterfaceOptionsFrameTab1"]:ClearAllPoints()
		_G["InterfaceOptionsFrameTab1"]:Point("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "TOPLEFT", 5, 27)
		_G["InterfaceOptionsFrameTab2"]:ClearAllPoints()
		_G["InterfaceOptionsFrameTab2"]:Point("TOPLEFT", _G["InterfaceOptionsFrameTab1"], "TOPRIGHT", 6, 0)
		_G["ChatConfigFrameDefaultButton"]:Width(125)
		_G["ChatConfigFrameDefaultButton"]:ClearAllPoints()
		_G["ChatConfigFrameDefaultButton"]:Point("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
		_G["ChatConfigFrameOkayButton"]:ClearAllPoints()
		_G["ChatConfigFrameOkayButton"]:Point("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
		
		-- Others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)
	end
	
	-- MAC menu/option panel(by Affli)
	if IsMacClient() then
		-- Skin main frame and reposition the header
		MacOptionsFrame:SetTemplate("Transparent")
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:Point("TOP", MacOptionsFrame, 0, 0)
	 
		-- Skin internal frames
		MacOptionsFrameMovieRecording:SetTemplate("Overlay")
		MacOptionsITunesRemote:SetTemplate("Overlay")
	 
		-- Skin buttons
		_G["MacOptionsFrameCancel"]:SkinButton()
		_G["MacOptionsFrameOkay"]:SkinButton()
		_G["MacOptionsButtonKeybindings"]:SkinButton()
		_G["MacOptionsFrameDefaults"]:SkinButton()
		_G["MacOptionsButtonCompress"]:SkinButton()
	 
		-- Reposition and resize buttons
		local tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:Width(136)
		_G["MacOptionsButtonCompress"]:ClearAllPoints()
		_G["MacOptionsButtonCompress"]:Point(tPoint, tRTo, tRP, 4, tY)
	 
		_G["MacOptionsFrameCancel"]:Width(96)
		_G["MacOptionsFrameCancel"]:Height(22)
		tPoint, tRTo, tRP, tX, tY =  _G["MacOptionsFrameCancel"]:GetPoint()
		_G["MacOptionsFrameCancel"]:ClearAllPoints()
		_G["MacOptionsFrameCancel"]:Point(tPoint, tRTo, tRP, -14, tY)
	 
		_G["MacOptionsFrameOkay"]:ClearAllPoints()
		_G["MacOptionsFrameOkay"]:Width(96)
		_G["MacOptionsFrameOkay"]:Height(22)
		_G["MacOptionsFrameOkay"]:Point("LEFT", _G["MacOptionsFrameCancel"], -99, 0)
	 
		_G["MacOptionsButtonKeybindings"]:ClearAllPoints()
		_G["MacOptionsButtonKeybindings"]:Width(96)
		_G["MacOptionsButtonKeybindings"]:Height(22)
		_G["MacOptionsButtonKeybindings"]:Point("LEFT", _G["MacOptionsFrameOkay"], -99, 0)
	 
		_G["MacOptionsFrameDefaults"]:Width(96)
		_G["MacOptionsFrameDefaults"]:Height(22)
		
		_G["MacOptionsButtonCompressLeft"]:SetAlpha(0)
		_G["MacOptionsButtonCompressMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonCompressRight"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsLeft"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsMiddle"]:SetAlpha(0)
		_G["MacOptionsButtonKeybindingsRight"]:SetAlpha(0)
	end

	-- DBM-GUI Frame
	if addon == "DBM-GUI" then
		_G["DBM_GUI_OptionsFrame"]:SetTemplate("Transparent")
		_G["DBM_GUI_OptionsFramePanelContainer"]:SetTemplate("Overlay")

		_G["DBM_GUI_OptionsFrameTab1"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab1"]:Point("TOPLEFT", _G["DBM_GUI_OptionsFrameBossMods"], "TOPLEFT", 10, 27)
		_G["DBM_GUI_OptionsFrameTab2"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab2"]:Point("TOPLEFT", _G["DBM_GUI_OptionsFrameTab1"], "TOPRIGHT", 6, 0)
		
		_G["DBM_GUI_OptionsFrameBossMods"]:HookScript("OnShow", function(self) self:SetTemplate("Overlay") end)
		_G["DBM_GUI_OptionsFrameDBMOptions"]:HookScript("OnShow", function(self) self:SetTemplate("Overlay") end)
		_G["DBM_GUI_OptionsFrameHeader"]:SetTexture("")
		_G["DBM_GUI_OptionsFrameHeader"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameHeader"]:Point("TOP", DBM_GUI_OptionsFrame, 0, 7)
		
		local dbmbskins = {
			"DBM_GUI_OptionsFrameOkay",
			"DBM_GUI_OptionsFrameTab1",
			"DBM_GUI_OptionsFrameTab2",
		}
		
		for i = 1, getn(dbmbskins) do
			local DBMButtons = _G[dbmbskins[i]]
			if DBMButtons then
				DBMButtons:SkinButton()
			end
		end
	end
end)