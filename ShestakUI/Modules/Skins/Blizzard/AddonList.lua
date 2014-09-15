local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AddonList skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local Frames = {
		AddonList,
		AddonListInset,
	}

	local Buttons = {
		AddonListEnableAllButton,
		AddonListDisableAllButton,
		AddonListCancelButton,
		AddonListOkayButton,
	}

	for _, Frames in pairs(Frames) do
		Frames:StripTextures()
	end

	for _, Buttons in pairs(Buttons) do
		Buttons:SkinButton()
	end

	AddonList:SetTemplate("Transparent")
	AddonListInset:SetTemplate("Overlay")

	T.SkinCheckBox(AddonListForceLoad)
	AddonListForceLoad:SetSize(25, 25)
	T.SkinDropDownBox(AddonCharacterDropDown)
	AddonListEnableAllButton:SetHeight(AddonListEnableAllButton:GetHeight() - 3)
	AddonListDisableAllButton:SetHeight(AddonListDisableAllButton:GetHeight() - 3)
	AddonListCancelButton:SetHeight(AddonListCancelButton:GetHeight() - 3)
	AddonListOkayButton:SetHeight(AddonListOkayButton:GetHeight() - 3)

	for i = 1, MAX_ADDONS_DISPLAYED do
		T.SkinCheckBox(_G["AddonListEntry" .. i .. "Enabled"])
	end

	T.SkinScrollBar(AddonListScrollFrameScrollBar)
	T.SkinCloseButton(AddonListCloseButton)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)