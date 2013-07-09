local T, C, L, _ = unpack(select(2, ...))
if C.skins.my_role_play ~= true or not IsAddOnLoaded("MyRolePlay") then return end

----------------------------------------------------------------------------------------
--	MyRolePlay skin
----------------------------------------------------------------------------------------
hooksecurefunc(mrp, "AddMRPTab", function()
	T.SkinTab(CharacterFrameTab5)
	CharacterFrameTab5:SetText("MyRolePlay")
end)

hooksecurefunc(mrp, "CreateOptionsPanel", function()
	T.SkinCheckBox(MyRolePlayOptionsPanel_Enable)
	T.SkinCheckBox(MyRolePlayOptionsPanel_MRPButton)
	T.SkinCheckBox(MyRolePlayOptionsPanel_RPChatName)
	T.SkinCheckBox(MyRolePlayOptionsPanel_Biog)
	T.SkinCheckBox(MyRolePlayOptionsPanel_FormAC)
	T.SkinCheckBox(MyRolePlayOptionsPanel_EquipAC)

	T.SkinDropDownBox(MyRolePlayOptionsPanel_TTStyle)
	T.SkinDropDownBox(MyRolePlayOptionsPanel_HeightUnit)
	T.SkinDropDownBox(MyRolePlayOptionsPanel_WeightUnit)
end)

local function reskinHeader(c, field)
	for i = 1, field:GetNumChildren() do
		local f = select(i, field:GetChildren())
		if not f.reskinned then
			f.h:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground"})
			f.h:SetBackdropColor(0.5, 0.5, 0.5, 0.1)
			f.h.SetBackdrop = T.dummy

			f.h.fs:SetPoint("TOPLEFT", f.h, "TOPLEFT", 0, 0)

			if f.sep then
				f.sep:SetAlpha(0)
			end

			f.reskinned = true
		end
	end
end

hooksecurefunc(mrp, "CreateCFpfield", reskinHeader)
hooksecurefunc(mrp, "CreateBFpfield", reskinHeader)

hooksecurefunc(mrp, "CreateBrowseFrame", function()
	MyRolePlayBrowseFrameInset:StripTextures()
	MyRolePlayBrowseFrame:StripTextures()
	MyRolePlayBrowseFrame:SetTemplate("Transparent")

	T.SkinTab(MyRolePlayBrowseFrameTab1)
	T.SkinTab(MyRolePlayBrowseFrameTab2)

	T.SkinCloseButton(MyRolePlayBrowseFrameCloseButton)
end)

hooksecurefunc(mrp, "CreateEditFrames", function()
	MyRolePlayMultiEditFrame:DisableDrawLayer("BORDER")
	MyRolePlayMultiEditFrameBg:Hide()
	MyRolePlayMultiEditFrameScrollFrameTop:Hide()
	MyRolePlayMultiEditFrameScrollFrameBottom:Hide()

	MyRolePlayMultiEditFrameOK:SkinButton()
	MyRolePlayMultiEditFrameCancel:SkinButton()
	MyRolePlayMultiEditFrameInherit:SkinButton()
	MyRolePlayComboEditFrameOK:SkinButton()
	MyRolePlayComboEditFrameCancel:SkinButton()
	MyRolePlayComboEditFrameInherit:SkinButton()
	MyRolePlayCharacterFrame_NewProfileButton:SkinButton()
	MyRolePlayCharacterFrame_RenProfileButton:SkinButton()
	MyRolePlayCharacterFrame_DelProfileButton:SkinButton()
	MyRolePlayEditFrameOK:SkinButton()
	MyRolePlayEditFrameCancel:SkinButton()
	MyRolePlayEditFrameInherit:SkinButton()

	MyRolePlayEditFrame.editbox:StripTextures()
	MyRolePlayEditFrame.editbox:CreateBackdrop("Overlay")
	MyRolePlayEditFrame.editbox.backdrop:SetPoint("TOPLEFT", 7, -8)
	MyRolePlayEditFrame.editbox.backdrop:SetPoint("BOTTOMRIGHT", -7, 8)

	MyRolePlayCharacterFrame.ver:SetText("")

	MyRolePlayCharacterFrame_ProfileComboBox:SetPoint("TOP", CharacterFrameInset, "TOP", 0, 22)
	MyRolePlayCharacterFrame_ProfileComboBox.text:SetPoint("LEFT", MyRolePlayCharacterFrame_ProfileComboBox, "LEFT", 27, 3)

	T.SkinDropDownBox(MyRolePlayCharacterFrame_ProfileComboBox)
	T.SkinDropDownBox(MyRolePlayComboEditFrameComboBox)

	MyRolePlayCharacterFrame_RenProfileButton:SetSize(21, 21)
	MyRolePlayCharacterFrame_DelProfileButton:SetSize(21, 21)
	MyRolePlayCharacterFrame_NewProfileButton:SetSize(21, 21)
	MyRolePlayCharacterFrame_NewProfileButton:ClearAllPoints()
	MyRolePlayCharacterFrame_NewProfileButton:SetPoint("LEFT", MyRolePlayCharacterFrame_ProfileComboBox.backdrop, "RIGHT", 1, 0)
end)