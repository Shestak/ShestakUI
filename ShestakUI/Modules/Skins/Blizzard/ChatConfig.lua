local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ChatConfig skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ChatConfigFrame:StripTextures()
	ChatConfigFrame:SetTemplate("Transparent")

	ChatConfigFrameHeader:SetTexture(nil)
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:Point("TOP", ChatConfigFrame, 0, 7)

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
		"CombatConfigColorsColorizeEntireLine",
		--"ChatConfigCombatSettingsFiltersScrollFrame"
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
		end
	end

	_G["ChatConfigFrameDefaultButton"]:Width(125)
	_G["ChatConfigFrameDefaultButton"]:ClearAllPoints()
	_G["ChatConfigFrameDefaultButton"]:Point("TOP", _G["ChatConfigCategoryFrame"], "BOTTOM", 0, -4)
	_G["ChatConfigFrameOkayButton"]:ClearAllPoints()
	_G["ChatConfigFrameOkayButton"]:Point("TOPRIGHT", _G["ChatConfigBackgroundFrame"], "BOTTOMRIGHT", 0, -4)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)