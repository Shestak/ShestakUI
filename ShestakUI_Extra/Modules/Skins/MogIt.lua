local T, C, L = unpack(ShestakUI)
if C.extra_skins.mog_it ~= true then return end

----------------------------------------------------------------------------------------
--	MogIt skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("MogIt") then return end

	MogItTooltip:SetBackdrop(nil)
	MogItTooltip:CreateBackdrop("Transparent")
	MogItTooltip.backdrop:Point("TOPLEFT", 0, -3)
	MogItTooltip.backdrop:Point("BOTTOMRIGHT", 0, 3)

	MogItFrame:StripTextures()
	MogItFrameInset:StripTextures()
	MogItFilters:StripTextures()
	MogItFiltersInset:StripTextures()
	MogItPreview:StripTextures()
	MogItPreviewInset:StripTextures()

	MogItFrame:SetTemplate("Transparent")
	MogItPreview:SetTemplate("Transparent")
	MogItFilters:CreateBackdrop("Transparent")
	MogItFilters.backdrop:Point("TOPLEFT", 3, 0)
	MogItFilters.backdrop:Point("BOTTOMRIGHT", 0, 3)

	T.SkinScrollBar(MogItScroll)
	MogItFiltersScrollScrollBar.top:SetTexture(nil)
	MogItFiltersScrollScrollBar.bottom:SetTexture(nil)
	MogItFiltersScrollScrollBar.middle:SetTexture(nil)

	T.SkinCloseButton(MogItPreviewCloseButton)
	T.SkinCloseButton(MogItFrameCloseButton)
	T.SkinCloseButton(MogItFiltersCloseButton)

	MogItFramePreviewAddItem:SetText(ADD)
	MogItFramePreviewImport:ClearAllPoints()
	MogItFramePreviewImport:Point("LEFT", MogItFramePreviewAddItem, "RIGHT", 3, 0)
	MogItFramePreviewLink:ClearAllPoints()
	MogItFramePreviewLink:Point("LEFT", MogItFramePreviewImport, "RIGHT", 3, 0)
	MogItFramePreviewLoad:ClearAllPoints()
	MogItFramePreviewLoad:Point("LEFT", MogItFramePreviewSave, "RIGHT", 3, 0)
	MogItFramePreviewClear:ClearAllPoints()
	MogItFramePreviewClear:Point("LEFT", MogItFramePreviewLoad, "RIGHT", 3, 0)
	MogItFramePreviewButton:ClearAllPoints()
	MogItFramePreviewButton:Point("LEFT", MogItFrameFiltersButton, "RIGHT", 3, 0)
	MogItFrameOptionsButton:ClearAllPoints()
	MogItFrameOptionsButton:Point("LEFT", MogItFramePreviewButton, "RIGHT", 3, 0)
	MogItFrameHelpButton:ClearAllPoints()
	MogItFrameHelpButton:Point("LEFT", MogItFrameOptionsButton, "RIGHT", 3, 0)

	local buttons = {
		"MogItFrameFiltersButton",
		"MogItFramePreviewButton",
		"MogItFrameOptionsButton",
		"MogItFrameHelpButton",
		"MogItFrameFiltersDefaults",
		"MogItFramePreviewSave",
		"MogItFramePreviewLoad",
		"MogItFramePreviewClear",
		"MogItFramePreviewAddItem",
		"MogItFramePreviewImport",
		"MogItFramePreviewLink",
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			button:SkinButton(true)
		end
	end

	local slots = {
		"HeadSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"MainHandSlot",
		"SecondaryHandSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["MogItPreview"..slot.."IconTexture"]
		local slot = _G["MogItPreview"..slot]

		slot:StyleButton()
		slot:SetNormalTexture(nil)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)

		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()
	end
end)