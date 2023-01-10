local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Edit Mode Manager skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.EditModeManagerFrame
	T.SkinFrame(frame)

	frame.Tutorial:Kill()

	frame.RevertAllChangesButton:SkinButton()
	frame.SaveChangesButton:SkinButton()
	T.SkinDropDownBox(frame.LayoutDropdown.DropDownMenu, 240)

	T.SkinCheckBox(frame.ShowGridCheckButton.Button, 30)
	T.SkinCheckBox(frame.EnableSnapCheckButton.Button, 30)

	T.SkinSliderStep(frame.GridSpacingSlider.Slider, true)

	for _, frame in next, {frame.AccountSettings.Settings:GetChildren()} do
		if frame.Button then
			T.SkinCheckBox(frame.Button, 30)
		end
	end

	local function HandleDialogs()
		local dialog = _G.EditModeSystemSettingsDialog
		for _, button in next, {dialog.Buttons:GetChildren()} do
			if button.Controller and not button.isSkinned then
				button:SkinButton()
			end
		end

		for _, frame in next, {dialog.Settings:GetChildren()} do
			local dd = frame.Dropdown
			if dd and (dd.DropDownMenu and not dd.isSkinned) then
				T.SkinDropDownBox(dd.DropDownMenu, 240)
				dd.isSkinned = true
			end

			local checkbox = frame.Button
			if checkbox and not checkbox.backdrop then
				T.SkinCheckBoxAtlas(checkbox)
			end

			local slider = frame.Slider
			if slider and not slider.isSkinned then
				T.SkinSliderStep(slider, true)
				slider.isSkinned = true
			end
		end
	end

	-- Layout Creator
	local layout = _G.EditModeNewLayoutDialog
	layout:StripTextures()
	layout:CreateBackdrop("Transparent")
	layout.AcceptButton:SkinButton()
	layout.CancelButton:SkinButton()
	T.SkinEditBox(layout.LayoutNameEditBox)
	T.SkinCheckBoxAtlas(layout.CharacterSpecificLayoutCheckButton.Button, 26)

	-- Layout Unsaved
	local unsaved = _G.EditModeUnsavedChangesDialog
	unsaved:StripTextures()
	unsaved:CreateBackdrop("Transparent")
	unsaved.CancelButton:SkinButton()
	unsaved.ProceedButton:SkinButton()
	unsaved.SaveAndProceedButton:SkinButton()

	-- Layout Importer
	local import = _G.EditModeImportLayoutDialog
	import:StripTextures()
	import:CreateBackdrop("Transparent")
	import.AcceptButton:SkinButton()
	import.CancelButton:SkinButton()
	T.SkinCheckBoxAtlas(import.CharacterSpecificLayoutCheckButton.Button, 26)

	local importBox = import.ImportBox
	T.SkinEditBox(importBox)

	local importBackdrop = importBox.backdrop
	importBackdrop:ClearAllPoints()
	importBackdrop:SetPoint("TOPLEFT", importBox, -4, 4)
	importBackdrop:SetPoint("BOTTOMRIGHT", importBox, 0, -4)

	local scrollbar = importBox.ScrollBar
	T.SkinScrollBar(scrollbar)
	scrollbar:ClearAllPoints()
	scrollbar:SetPoint("TOPLEFT", importBox, "TOPRIGHT", 4, 4)
	scrollbar:SetPoint("BOTTOMLEFT", importBox, "BOTTOMRIGHT", 0, -4)

	local editbox = import.LayoutNameEditBox
	T.SkinEditBox(editbox)

	local editbackdrop = editbox.backdrop
	editbackdrop:ClearAllPoints()
	editbackdrop:SetPoint("TOPLEFT", editbox, -2, -4)
	editbackdrop:SetPoint("BOTTOMRIGHT", editbox, 2, 4)

	-- Dialog (Mover Settings)
	local dialog = _G.EditModeSystemSettingsDialog
	dialog:StripTextures()
	dialog:CreateBackdrop("Transparent")
	T.SkinCloseButton(dialog.CloseButton)

	hooksecurefunc(dialog.Buttons, "AddLayoutChildren", HandleDialogs)
	HandleDialogs()
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)