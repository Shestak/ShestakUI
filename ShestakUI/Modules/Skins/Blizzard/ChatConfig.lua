local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ChatConfig skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ChatConfigFrame:StripTextures()
	ChatConfigFrame:SetTemplate("Transparent")

	ChatConfigFrameHeader:SetTexture(nil)
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:SetPoint("TOP", ChatConfigFrame, 0, 7)

	local frames = {
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
		"CombatConfigColorsColorizeEntireLine"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:SetTemplate("Overlay")
		end
	end

	local buttons = {
		"ChatConfigFrameDefaultButton",
		"ChatConfigFrameOkayButton",
		"ChatConfigFrameCancelButton",
		"ChatConfigCombatSettingsFiltersCopyFilterButton",
		"ChatConfigCombatSettingsFiltersAddFilterButton",
		"ChatConfigCombatSettingsFiltersDeleteButton",
		"CombatConfigSettingsSaveButton",
		"CombatLogDefaultButton"
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton()
			button:ClearAllPoints()
		end
	end

	local checkboxes = {
		"CombatConfigColorsHighlightingLine",
		"CombatConfigColorsHighlightingAbility",
		"CombatConfigColorsHighlightingDamage",
		"CombatConfigColorsHighlightingSchool",
		"CombatConfigColorsColorizeUnitNameCheck",
		"CombatConfigColorsColorizeSpellNamesCheck",
		"CombatConfigColorsColorizeSpellNamesSchoolColoring",
		"CombatConfigColorsColorizeDamageNumberCheck",
		"CombatConfigColorsColorizeDamageNumberSchoolColoring",
		"CombatConfigColorsColorizeDamageSchoolCheck",
		"CombatConfigColorsColorizeEntireLineCheck",
		"CombatConfigFormattingShowTimeStamp",
		"CombatConfigFormattingShowBraces",
		"CombatConfigFormattingUnitNames",
		"CombatConfigFormattingSpellNames",
		"CombatConfigFormattingItemNames",
		"CombatConfigFormattingFullText",
		"CombatConfigSettingsShowQuickButton",
		"CombatConfigSettingsSolo",
		"CombatConfigSettingsParty",
		"CombatConfigSettingsRaid"
	}

	for i = 1, getn(checkboxes) do
		T.SkinCheckBox(_G[checkboxes[i]])
	end

	ChatConfigChannelSettingsLeft:SetScript("OnShow", function(self)
		for i = 1, #ChatConfigChannelSettingsLeft.checkBoxTable do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	end)

	CreateChatChannelList(self, GetChannelList())
	ChatConfig_CreateCheckboxes(ChatConfigChannelSettingsLeft, CHAT_CONFIG_CHANNEL_LIST, "ChatConfigCheckBoxWithSwatchAndClassColorTemplate", CHANNELS)
	ChatConfig_UpdateCheckboxes(ChatConfigChannelSettingsLeft)

	ChatConfigBackgroundFrame:SetScript("OnShow", function(self)
		for i = 1, #CHAT_CONFIG_CHAT_LEFT do
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:SetFrameLevel(4)
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end

		for i = 1, #CHAT_CONFIG_OTHER_COMBAT do
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:SetFrameLevel(4)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCombatCheckBox"..i.."Check"])
		end

		for i = 1, #CHAT_CONFIG_OTHER_PVP do
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:SetFrameLevel(4)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsPVPCheckBox"..i.."Check"])
		end

		for i = 1, #CHAT_CONFIG_OTHER_SYSTEM do
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:SetFrameLevel(4)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsSystemCheckBox"..i.."Check"])
		end

		for i = 1, #CHAT_CONFIG_CHANNEL_LIST do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:SetFrameLevel(4)
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"])
		end

		for i = 1, #CHAT_CONFIG_CHAT_CREATURE_LEFT do
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:CreateBackdrop("Overlay")
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:SetFrameLevel(4)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCreatureCheckBox"..i.."Check"])
		end

		for i = 1, #COMBAT_CONFIG_MESSAGESOURCES_BY do
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:CreateBackdrop("Overlay")
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:SetFrameLevel(5)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneByCheckBox"..i.."Check"])
		end

		for i = 1, #COMBAT_CONFIG_MESSAGESOURCES_TO do
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:CreateBackdrop("Overlay")
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:SetPoint("TOPLEFT", 3, -1)
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:SetPoint("BOTTOMRIGHT", -3, 1)
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:SetFrameLevel(5)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneToCheckBox"..i.."Check"])
		end

		for i = 1, #COMBAT_CONFIG_UNIT_COLORS do
			_G["CombatConfigColorsUnitColorsSwatch"..i]:StripTextures()
		end

		for i = 1, 4 do
			for j = 1, 4 do
				if _G["CombatConfigMessageTypesLeftCheckBox"..i] and _G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j])
				end
			end
			for j = 1, 10 do
				if _G["CombatConfigMessageTypesRightCheckBox"..i] and _G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j])
				end
			end
			T.SkinCheckBox(_G["CombatConfigMessageTypesMiscCheckBox"..i])
		end
	end)

	for i = 1, #COMBAT_CONFIG_TABS do
		local tab = _G["CombatConfigTab"..i]
		if tab then
			tab:SkinButton(true)
			tab:SetHeight(tab:GetHeight() - 9)
			tab:ClearAllPoints()
			if i == 1 then
				tab:SetPoint("BOTTOMLEFT", _G["ChatConfigBackgroundFrame"], "TOPLEFT", 0, 1)
			else
				tab:SetPoint("LEFT", _G["CombatConfigTab"..i-1], "RIGHT", 1, 0)
			end
			_G["CombatConfigTab"..i.."Text"]:SetPoint("BOTTOM", 0, 7)
		end
	end

	T.SkinEditBox(_G["CombatConfigSettingsNameEditBox"], nil, _G["CombatConfigSettingsNameEditBox"]:GetHeight() - 2)
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterUpButton"], true)
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterDownButton"], true)
	_G["ChatConfigMoveFilterUpButton"]:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up")
	_G["ChatConfigMoveFilterUpButton"]:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down")
	_G["ChatConfigFrameDefaultButton"]:SetWidth(125)
	_G["CombatLogDefaultButton"]:SetWidth(125)

	_G["ChatConfigMoveFilterUpButton"]:SetPoint("TOPLEFT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMLEFT", 0, -1)
	_G["ChatConfigMoveFilterDownButton"]:SetPoint("TOPLEFT", _G["ChatConfigMoveFilterUpButton"], "TOPRIGHT", 1, 0)
	_G["ChatConfigFrameDefaultButton"]:SetPoint("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
	_G["ChatConfigFrameOkayButton"]:SetPoint("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
	_G["CombatLogDefaultButton"]:SetPoint("TOPLEFT", _G["ChatConfigCategoryFrame"], "BOTTOMLEFT", 0, -4)
	_G["CombatConfigSettingsSaveButton"]:SetPoint("TOPLEFT", _G["CombatConfigSettingsNameEditBox"], "TOPRIGHT", 5, 2)
	_G["ChatConfigCombatSettingsFiltersDeleteButton"]:SetPoint("TOPRIGHT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMRIGHT", 0, -1)
	_G["ChatConfigCombatSettingsFiltersCopyFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersDeleteButton"], "LEFT", -1, 0)
	_G["ChatConfigCombatSettingsFiltersAddFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersCopyFilterButton"], "LEFT", -1, 0)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)