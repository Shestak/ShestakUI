local T, C, L = unpack(select(2, ...))

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
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"VideoOptionsFrame",
			"BNToastFrame",
			"TicketStatusFrameButton",
			"AutoCompleteBox",
			"ReadyCheckFrame",
			"ColorPickerFrame",
			"LFDRoleCheckPopup",
			"ChannelPulloutBackground",
			"ChannelPulloutTab",
			"LFDDungeonReadyDialog",
			"GuildInviteFrame",
			"ChatConfigFrame",
			"RolePollPopup",
			"AddFriendFrame",
			"ChannelFrameDaughterFrame",
			"aLoadFrame",
			"AddonSets",
			"BaudErrorFrame",
			"StackSplitFrame",
			"OpacityFrame",
			"GeneralDockManagerOverflowButtonList",
		}

		if not T.PTRVersion() then
			tinsert(bgskins, "LFDDungeonReadyStatus")
			tinsert(bgskins, "LFDSearchStatus")
		else
			tinsert(bgskins, "LFGSearchStatus")
		end

		for i = 1, getn(bgskins) do
			local frame = _G[bgskins[i]]
			if frame then
				_G[bgskins[i]]:SetTemplate("Transparent")
			end
		end

		local insetskins = {
			"InterfaceOptionsFramePanelContainer",
			"InterfaceOptionsFrameAddOns",
			"InterfaceOptionsFrameCategories",
			"InterfaceOptionsFrameTab1",
			"InterfaceOptionsFrameTab2",
			"VideoOptionsFrameCategoryFrame",
			"VideoOptionsFramePanelContainer",
			"AudioOptionsSoundPanel",
			"AudioOptionsSoundPanelPlayback",
			"AudioOptionsSoundPanelHardware",
			"AudioOptionsSoundPanelVolume",
			"AudioOptionsVoicePanel",
			"AudioOptionsVoicePanelTalking",
			"AudioOptionsVoicePanelBinding",
			"AudioOptionsVoicePanelListening",
			"ChatConfigCategoryFrame",
			"ChatConfigBackgroundFrame",
			"ChatConfigChatSettingsClassColorLegend",
			"ChatConfigChatSettingsLeft",
			"ChatConfigChannelSettingsLeft",
			"ChatConfigChannelSettingsClassColorLegend",
			"ChatConfigOtherSettingsCombat",
			"ChatConfigOtherSettingsSystem",
			"ChatConfigOtherSettingsCreature",
			"ChatConfigOtherSettingsPVP",
			"ChatConfigCombatSettingsFilters",
			"CombatConfigMessageSourcesDoneBy",
			"CombatConfigMessageSourcesDoneTo",
			"CombatConfigColorsUnitColors",
			"CombatConfigColorsHighlighting",
			"CombatConfigColorsColorizeUnitName",
			"CombatConfigColorsColorizeSpellNames",
			"CombatConfigColorsColorizeDamageNumber",
			"CombatConfigColorsColorizeDamageSchool",
			"CombatConfigColorsColorizeEntireLine",
			"aLoadScroll",
			"BaudErrorFrameListScrollBox",
			"BaudErrorFrameDetailScrollBox",
		}

		for i = 1, getn(insetskins) do
			local frame = _G[insetskins[i]]
			if frame then
				_G[insetskins[i]]:SetTemplate("Overlay")
			end
		end

		-- Reskin popup
		for i = 1, 4 do
			for j = 1, 3 do
				_G["StaticPopup"..i.."Button"..j]:SkinButton()
			end
			_G["StaticPopup"..i]:SetTemplate("Transparent")
			T.SkinEditBox(_G["StaticPopup"..i.."EditBox"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameGold"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameSilver"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameCopper"])
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("TOPLEFT", -3, -6)
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("BOTTOMRIGHT", -3, 6)
			_G["StaticPopup"..i.."MoneyInputFrameGold"].backdrop:Point("TOPLEFT", -3, 0)
			_G["StaticPopup"..i.."MoneyInputFrameSilver"].backdrop:Point("TOPLEFT", -3, 0)
			_G["StaticPopup"..i.."MoneyInputFrameCopper"].backdrop:Point("TOPLEFT", -3, 0)
			_G["StaticPopup"..i.."ItemFrameNameFrame"]:Kill()
			_G["StaticPopup"..i.."ItemFrame"]:GetNormalTexture():Kill()
			_G["StaticPopup"..i.."ItemFrame"]:SetTemplate("Default")
			_G["StaticPopup"..i.."ItemFrame"]:StyleButton()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:ClearAllPoints()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end

		-- Reskin Dropdown menu
		hooksecurefunc("UIDropDownMenu_InitializeHelper", function(frame)
			for i = 1, UIDROPDOWNMENU_MAXLEVELS do
				_G["DropDownList"..i.."Backdrop"]:SetTemplate("Transparent", true)
				_G["DropDownList"..i.."MenuBackdrop"]:SetTemplate("Transparent", true)
			end
		end)

		-- Reskin menu
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
			"GameMenuButtonHelp",
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
			"StackSplitOkayButton",
			"StackSplitCancelButton",
			"CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton",
			"DisbandRaidButton",
			"SwitchRaidButton",
			"MainTankButton",
			"MainAssistButton",
			"RoleCheckButton",
			"ReadyCheckButton",
			"ShowButton",
			"CloseButton",
			"RaidControlButton",
			"InterfaceOptionsHelpPanelResetTutorials",
			"InterfaceOptionsUnitFramePanelResetPartyPosition",
			"InterfaceOptionsRaidFramePanelResetPosition",
			"CombatLogDefaultButton",
			"ChatConfigCombatSettingsFiltersCopyFilterButton",
			"ChatConfigCombatSettingsFiltersAddFilterButton",
			"ChatConfigCombatSettingsFiltersDeleteButton",
			"CombatConfigSettingsSaveButton",
			"ChatConfigFrameCancelButton",
			"RecordLoopbackSoundButton",
			"PlayLoopbackSoundButton",
			"AudioOptionsVoicePanelChatMode1KeyBindingButton",
		}

		if not T.PTRVersion() then
			tinsert(BlizzardButtons, "LFDDungeonReadyDialogEnterDungeonButton")
			tinsert(BlizzardButtons, "LFDDungeonReadyDialogLeaveQueueButton")
		end

		for i = 1, getn(BlizzardButtons) do
			local buttons = _G[BlizzardButtons[i]]
			if buttons then
				buttons:SkinButton()
			end
		end

		-- Button position or text
		_G["VideoOptionsFrameDefaults"]:ClearAllPoints()
		_G["VideoOptionsFrameDefaults"]:Point("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:Point("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:Point("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
		_G["VideoOptionsFrameApply"]:ClearAllPoints()
		_G["VideoOptionsFrameApply"]:Point("RIGHT", _G["VideoOptionsFrameOkay"], "LEFT", -4, 0)
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
		_G["InterfaceOptionsFrameTab1"]:Point("TOPLEFT", _G["InterfaceOptionsFrameCategories"], "TOPLEFT", 0, 27)
		_G["InterfaceOptionsFrameTab1"]:Width(60)
		_G["InterfaceOptionsFrameTab1"].SetWidth = T.dummy
		_G["InterfaceOptionsFrameTab2"]:ClearAllPoints()
		_G["InterfaceOptionsFrameTab2"]:Point("TOPLEFT", _G["InterfaceOptionsFrameTab1"], "TOPRIGHT", 3, 0)
		_G["InterfaceOptionsFrameTab2"]:Width(112)
		_G["InterfaceOptionsFrameTab2"].SetWidth = T.dummy
		_G["InterfaceOptionsFrameTab1TabSpacer"]:Kill()
		_G["InterfaceOptionsFrameTab2TabSpacer1"]:Kill()
		_G["InterfaceOptionsFrameTab2TabSpacer2"]:Kill()
		_G["ChatConfigFrameDefaultButton"]:Width(125)
		_G["ChatConfigFrameDefaultButton"]:ClearAllPoints()
		_G["ChatConfigFrameDefaultButton"]:Point("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
		_G["ChatConfigFrameOkayButton"]:ClearAllPoints()
		_G["ChatConfigFrameOkayButton"]:Point("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
		_G["ChannelPulloutTabText"]:ClearAllPoints()
		_G["ChannelPulloutTabText"]:Point("TOP", _G["ChannelPulloutTab"], "TOP", 0, -6)
		_G["ChannelPulloutTab"]:SetHeight(20)
		_G["ChannelPullout"]:ClearAllPoints()
		_G["ChannelPullout"]:Point("TOP", _G["ChannelPulloutTab"], "BOTTOM", 0, -3)
		_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:ClearAllPoints()
		_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:Point("CENTER", _G["AudioOptionsVoicePanelBinding"], "CENTER", 0, -10)

		-- Frame level
		_G["AudioOptionsSoundPanel"]:SetFrameLevel(1)
		_G["AudioOptionsVoicePanel"]:SetFrameLevel(1)
		_G["AudioOptionsSoundPanelPlayback"]:SetFrameLevel(2)
		_G["AudioOptionsSoundPanelHardware"]:SetFrameLevel(2)
		_G["AudioOptionsSoundPanelVolume"]:SetFrameLevel(2)
		_G["AudioOptionsVoicePanelTalking"]:SetFrameLevel(2)
		_G["AudioOptionsVoicePanelBinding"]:SetFrameLevel(2)
		_G["AudioOptionsVoicePanelListening"]:SetFrameLevel(2)
		_G["GeneralDockManagerOverflowButtonList"]:SetFrameStrata("HIGH")

		-- Others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end)
		_G["StackSplitFrame"]:GetRegions():Hide()
		_G["StackSplitFrame"]:SetFrameStrata("TOOLTIP")
		_G["ChannelPulloutTabLeft"]:SetTexture(nil)
		_G["ChannelPulloutTabMiddle"]:SetTexture(nil)
		_G["ChannelPulloutTabRight"]:SetTexture(nil)
		if C.skins.blizzard_frames == true then
			_G["StaticPopup1CloseButton"]:HookScript("OnShow", function(self)
				self:StripTextures(true)
				T.SkinCloseButton(StaticPopup1CloseButton, nil, "-")
			end)
			if not T.PTRVersion() then
				T.SkinCloseButton(LFDDungeonReadyStatusCloseButton, nil, "-")
			else
				T.SkinCloseButton(LFGDungeonReadyStatusCloseButton, nil, "-")
			end
			T.SkinCloseButton(ChannelPulloutCloseButton)
			T.SkinCloseButton(RolePollPopupCloseButton)
			T.SkinCloseButton(ItemRefCloseButton)
			T.SkinCloseButton(aLoadCloseButton)
		end
	end

	if addon == "Blizzard_GuildUI" then
		_G["GuildFrameTab1"]:ClearAllPoints()
		_G["GuildFrameTab1"]:Point("TOPLEFT", _G["GuildFrame"], "BOTTOMLEFT", -4, 2)
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
		local tPoint, tRTo, tRP, tX, tY = _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:Width(136)
		_G["MacOptionsButtonCompress"]:ClearAllPoints()
		_G["MacOptionsButtonCompress"]:Point(tPoint, tRTo, tRP, 4, tY)

		_G["MacOptionsFrameCancel"]:Width(96)
		_G["MacOptionsFrameCancel"]:Height(22)
		tPoint, tRTo, tRP, tX, tY = _G["MacOptionsFrameCancel"]:GetPoint()
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
	end
end)