local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

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
		"CombatConfigColorsHighlighting"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:SetTemplate("Overlay")
		end
	end

	local colorize = {
		"CombatConfigColorsColorizeUnitName",
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine"
	}

	for i = 1, getn(colorize) do
		local frame = _G[colorize[i]]
		if frame then
			local bg = CreateFrame("Frame", nil, frame)
			bg:SetPoint("TOPLEFT", 0, 0)
			bg:SetPoint("BOTTOMRIGHT", 0, 2)
			bg:SetTemplate("Overlay")
		end
	end

	local buttons = {
		"ChatConfigFrameDefaultButton",
		"ChatConfigFrameOkayButton",
		"ChatConfigFrameCancelButton",
		"ChatConfigFrameRedockButton",
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
		"CombatConfigSettingsRaid",
		"CombatConfigColorsColorizeEntireLineBySource",
		"CombatConfigColorsColorizeEntireLineByTarget"
	}

	for i = 1, getn(checkboxes) do
		T.SkinCheckBox(_G[checkboxes[i]])
	end

	local ReskinColourSwatch = function(f)
		f:StripTextures()
		f:CreateBackdrop("Overlay")
		f:SetFrameLevel(f:GetFrameLevel() + 2)
		f.backdrop:SetPoint("TOPLEFT", 1, 0)
		f.backdrop:SetPoint("BOTTOMRIGHT", 1, 1)

		f:SetNormalTexture(C.media.texture)
		local nt = f:GetNormalTexture()

		nt:SetPoint("TOPLEFT", 3, -2)
		nt:SetPoint("BOTTOMRIGHT", -1, 3)
	end

	hooksecurefunc("ChatConfig_CreateCheckboxes", function(frame, checkBoxTable, checkBoxTemplate)
			if frame.styled then return end

			local checkBoxNameString = frame:GetName().."CheckBox"

			if checkBoxTemplate == "ChatConfigCheckBoxTemplate" then
				for index in ipairs(checkBoxTable) do
					local checkBoxName = checkBoxNameString..index
					local checkbox = _G[checkBoxName]

					local bg = CreateFrame("Frame", nil, checkbox)
					bg:SetPoint("TOPLEFT", 2, -1)
					bg:SetPoint("BOTTOMRIGHT", -2, 1)
					bg:SetTemplate("Overlay")

					T.SkinCheckBox(_G[checkBoxName.."Check"])
				end
			elseif checkBoxTemplate == "ChatConfigCheckBoxWithSwatchTemplate" or checkBoxTemplate == "ChatConfigWideCheckBoxWithSwatchTemplate" or checkBoxTemplate == "MovableChatConfigWideCheckBoxWithSwatchTemplate" then
				for index in ipairs(checkBoxTable) do
					local checkBoxName = checkBoxNameString..index
					local checkbox = _G[checkBoxName]

					local bg = CreateFrame("Frame", nil, checkbox)
					bg:SetPoint("TOPLEFT", 2, -1)
					bg:SetPoint("BOTTOMRIGHT", -2, 1)
					bg:SetTemplate("Overlay")

					ReskinColourSwatch(_G[checkBoxName.."ColorSwatch"])

					T.SkinCheckBox(_G[checkBoxName.."Check"])
				end
			end

			frame.styled = true
		end)

	hooksecurefunc("ChatConfig_CreateColorSwatches", function(frame, swatchTable)
		if frame.styled then return end

		local nameString = frame:GetName().."Swatch"

		for index in ipairs(swatchTable) do
			local swatchName = nameString..index
			local swatch = _G[swatchName]

			swatch:SetBackdrop(nil)

			local bg = CreateFrame("Frame", nil, swatch)
			bg:SetPoint("TOPLEFT", 0, 0)
			bg:SetPoint("BOTTOMRIGHT", 0, 0)
			bg:SetFrameLevel(swatch:GetFrameLevel() - 1)
			bg:CreateBorder(true)
			bg.iborder:SetBackdropBorderColor(unpack(C.media.border_color))

			local bg2 = CreateFrame("Frame", nil, bg)
			bg2:SetPoint("TOPLEFT", 1, -1)
			bg2:SetPoint("BOTTOMRIGHT", -1, 1)
			bg2:CreateBorder(true, true)

			ReskinColourSwatch(_G[swatchName.."ColorSwatch"])
		end

		frame.styled = true
	end)

	ChatConfigBackgroundFrame:SetScript("OnShow", function(self)
		ReskinColourSwatch(CombatConfigColorsColorizeSpellNamesColorSwatch)
		ReskinColourSwatch(CombatConfigColorsColorizeDamageNumberColorSwatch)

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
			T.SkinTab(tab, true)
			tab:SetHeight(tab:GetHeight() - 2)
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
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterUpButton"], nil, "Up")
	T.SkinNextPrevButton(_G["ChatConfigMoveFilterDownButton"], nil, "Down")
	_G["ChatConfigFrameDefaultButton"]:SetWidth(125)
	_G["CombatLogDefaultButton"]:SetWidth(125)

	_G["ChatConfigMoveFilterUpButton"]:SetPoint("TOPLEFT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMLEFT", 0, -1)
	_G["ChatConfigMoveFilterDownButton"]:SetPoint("TOPLEFT", _G["ChatConfigMoveFilterUpButton"], "TOPRIGHT", 1, 0)
	_G["ChatConfigFrameDefaultButton"]:SetPoint("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
	ChatConfigFrameRedockButton:SetPoint("LEFT", ChatConfigFrameDefaultButton, "RIGHT", 3, 0)
	_G["ChatConfigFrameOkayButton"]:SetPoint("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
	_G["CombatLogDefaultButton"]:SetPoint("TOPLEFT", _G["ChatConfigCategoryFrame"], "BOTTOMLEFT", 0, -4)
	_G["CombatConfigSettingsSaveButton"]:SetPoint("TOPLEFT", _G["CombatConfigSettingsNameEditBox"], "TOPRIGHT", 5, 2)
	_G["ChatConfigCombatSettingsFiltersDeleteButton"]:SetPoint("TOPRIGHT", _G["ChatConfigCombatSettingsFilters"], "BOTTOMRIGHT", 0, -1)
	_G["ChatConfigCombatSettingsFiltersCopyFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersDeleteButton"], "LEFT", -3, 0)
	_G["ChatConfigCombatSettingsFiltersAddFilterButton"]:SetPoint("RIGHT", _G["ChatConfigCombatSettingsFiltersCopyFilterButton"], "LEFT", -3, 0)

	hooksecurefunc(ChatConfigFrameChatTabManager, "UpdateWidth", function(self)
		for tab in self.tabPool:EnumerateActive() do
			if not tab.IsSkinned then
				tab:StripTextures()

				tab.IsSkinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)