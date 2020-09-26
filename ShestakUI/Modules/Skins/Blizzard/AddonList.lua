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

	for i = 1, MAX_ADDONS_DISPLAYED do
		T.SkinCheckBox(_G["AddonListEntry"..i.."Enabled"])
		_G["AddonListEntry"..i.."Load"]:SkinButton()
	end

	T.SkinScrollBar(AddonListScrollFrameScrollBar)
	T.SkinCloseButton(AddonListCloseButton)
	T.SkinDropDownBox(AddonCharacterDropDown)
	T.SkinCheckBox(AddonListForceLoad)
	AddonListForceLoad:SetSize(25, 25)

	--FIXME hooksecurefunc("TriStateCheckbox_SetState", function(_, checkButton)
		-- local tex = checkButton:GetCheckedTexture()
		-- if checkButton.state == 2 then
			-- tex:SetColorTexture(1, 0.82, 0, 0.8)
		-- elseif checkButton.state == 1 then
			-- tex:SetColorTexture(0.6, 0.6, 0.6, 0.75)
		-- end
	-- end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)