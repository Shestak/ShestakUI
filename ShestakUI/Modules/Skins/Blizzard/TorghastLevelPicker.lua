local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Torghast Level Picker skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = TorghastLevelPickerFrame
	T.SkinCloseButton(frame.CloseButton)
	frame.CloseButton:SetPoint("TOPRIGHT", -50, -50)

	T.SkinNextPrevButton(frame.Pager.PreviousPage)
	T.SkinNextPrevButton(frame.Pager.NextPage)

	frame.OpenPortalButton:SkinButton()
end

T.SkinFuncs["Blizzard_TorghastLevelPicker"] = LoadSkin