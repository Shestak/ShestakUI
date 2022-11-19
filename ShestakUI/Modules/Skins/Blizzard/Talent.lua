local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ClassTalentFrame
	T.SkinFrame(frame)

	ClassTalentFrame.TalentsTab.BlackBG:SetAlpha(0)
	ClassTalentFrame.TalentsTab.BottomBar:SetAlpha(0)

	ClassTalentFrame.TalentsTab.ApplyButton:SkinButton(true)

	T.SkinDropDownBox(ClassTalentFrame.TalentsTab.LoadoutDropDown.DropDownControl.DropDownMenu, 190)

	T.SkinEditBox(ClassTalentFrame.TalentsTab.SearchBox)
	ClassTalentFrame.TalentsTab.SearchBox.backdrop:SetPoint("TOPLEFT", -4, -4)
	ClassTalentFrame.TalentsTab.SearchBox.backdrop:SetPoint("BOTTOMRIGHT", 0, 5)
	ClassTalentFrame.TalentsTab.SearchPreviewContainer:StripTextures()
	ClassTalentFrame.TalentsTab.SearchPreviewContainer:CreateBackdrop("Transparent")

	for _, tab in next, {ClassTalentFrame.TabSystem:GetChildren()} do
		T.SkinTab(tab)
	end

	-- Profiles
	local function SkinTalentFrameDialog(dialog)
		if not dialog then return end

		dialog:StripTextures()
		dialog:CreateBackdrop("Transparent")

		if dialog.AcceptButton then dialog.AcceptButton:SkinButton() end
		if dialog.CancelButton then dialog.CancelButton:SkinButton() end
		if dialog.DeleteButton then dialog.DeleteButton:SkinButton() end

		T.SkinEditBox(dialog.NameControl.EditBox)
		dialog.NameControl.EditBox.backdrop:SetPoint("TOPLEFT", -5, -10)
		dialog.NameControl.EditBox.backdrop:SetPoint("BOTTOMRIGHT", 5, 10)
	end

	local ImportDialog = _G.ClassTalentLoadoutImportDialog
	if ImportDialog then
		SkinTalentFrameDialog(ImportDialog)
		ImportDialog.ImportControl.InputContainer:StripTextures()
		ImportDialog.ImportControl.InputContainer:CreateBackdrop("Transparent")
	end

	local CreateDialog = _G.ClassTalentLoadoutCreateDialog
	if CreateDialog then
		SkinTalentFrameDialog(CreateDialog)
	end

	local EditDialog = _G.ClassTalentLoadoutEditDialog
	if EditDialog then
		SkinTalentFrameDialog(EditDialog)

		local editbox = EditDialog.LoadoutName
		if editbox then
			T.SkinEditBox(editbox)
			editbox.backdrop:SetPoint("TOPLEFT", -5, -5)
			editbox.backdrop:SetPoint("BOTTOMRIGHT", 5, 5)
		end

		local check = EditDialog.UsesSharedActionBars
		if check then
			T.SkinCheckBox(check.CheckButton)
		end
	end

	-- Spec tab
	ClassTalentFrame.SpecTab:CreateBackdrop("Overlay")
	ClassTalentFrame.SpecTab.backdrop:SetPoint("TOPLEFT", 4, -4)
	ClassTalentFrame.SpecTab.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)
	ClassTalentFrame.SpecTab.Background:SetAlpha(0)
	ClassTalentFrame.SpecTab.BlackBG:SetAlpha(0)
	hooksecurefunc(ClassTalentFrame.SpecTab, "UpdateSpecFrame", function(frame)
		for specContentFrame in frame.SpecContentFramePool:EnumerateActive() do
			if not specContentFrame.isSkinned then
				specContentFrame.ActivateButton:SkinButton()

				if specContentFrame.SpellButtonPool then
					for button in specContentFrame.SpellButtonPool:EnumerateActive() do
						if button.Ring then
							button.Ring:Hide()
						end

						if button.spellID then
							local texture = GetSpellTexture(button.spellID)
							if texture then
								button.Icon:SetTexture(texture)
							end
						end

						button.Icon:SkinIcon()
					end
				end

				specContentFrame.isSkinned = true
			end
		end
	end)

	-- PvP
	ClassTalentFrame.TalentsTab.PvPTalentList:StripTextures()
	ClassTalentFrame.TalentsTab.PvPTalentList:CreateBackdrop("Overlay")
	ClassTalentFrame.TalentsTab.PvPTalentList.backdrop:SetFrameStrata(ClassTalentFrame.TalentsTab.PvPTalentList:GetFrameStrata())
	ClassTalentFrame.TalentsTab.PvPTalentList.backdrop:SetFrameLevel(2000)
end

T.SkinFuncs["Blizzard_ClassTalentUI"] = LoadSkin