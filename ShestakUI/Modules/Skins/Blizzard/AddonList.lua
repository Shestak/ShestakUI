local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AddonList skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"AddonListEnableAllButton",
		"AddonListDisableAllButton",
		"AddonListCancelButton",
		"AddonListOkayButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	AddonList:StripTextures()
	AddonList:SetTemplate("Transparent")
	AddonList:SetHeight(AddonList:GetHeight() + 3)

	AddonListInset:StripTextures()
	AddonListInset:SetTemplate("Overlay")
	AddonListInset:SetPoint("BOTTOMRIGHT", -6, 29)

	-- BETA for i = 1, MAX_ADDONS_DISPLAYED do
		--T.SkinCheckBox(_G["AddonList"..i.."Enabled"])
		--_G['AddonList'..i].LoadAddonButton:SkinButton(nil, nil, true)
	--end

	T.SkinScrollBar(AddonList.ScrollBar)
	T.SkinCloseButton(AddonListCloseButton)
	T.SkinDropDownBox(AddonCharacterDropDown)
	T.SkinCheckBox(AddonListForceLoad)
	AddonListForceLoad:SetSize(25, 25)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)