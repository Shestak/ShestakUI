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
	AddonList:SetHeight(AddonList:GetHeight() + 3)
	AddonListInset:SetTemplate("Overlay")
	AddonListInset:SetPoint("BOTTOMRIGHT", -6, 29)

	for i = 1, MAX_ADDONS_DISPLAYED do
		T.SkinCheckBox(_G["AddonListEntry" .. i .. "Enabled"])
	end

	T.SkinScrollBar(AddonListScrollFrameScrollBar)
	T.SkinCloseButton(AddonListCloseButton)
	T.SkinDropDownBox(AddonCharacterDropDown)
	T.SkinCheckBox(AddonListForceLoad)
	AddonListForceLoad:SetSize(25, 25)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)