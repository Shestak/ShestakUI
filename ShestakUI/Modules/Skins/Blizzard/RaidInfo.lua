local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	RaidInfo skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"RaidInfoScrollFrame",
		"RaidInfoFrame",
		"RaidInfoInstanceLabel",
		"RaidInfoIDLabel",
	}

	if T.PTRVersion() then
		tinsert(StripAllTextures, "RaidParentFrame")
		tinsert(StripAllTextures, "RaidParentFrameInset")
		tinsert(StripAllTextures, "RaidFinderQueueFrame")
		tinsert(StripAllTextures, "RaidFinderFrameRoleInset")
		tinsert(StripAllTextures, "RaidFinderQueueFrameScrollFrame")
	end

	local KillTextures = {
		"RaidInfoScrollFrameScrollBarBG",
		"RaidInfoScrollFrameScrollBarTop",
		"RaidInfoScrollFrameScrollBarBottom",
		"RaidInfoScrollFrameScrollBarMiddle",
	}

	local buttons = {
		"RaidFrameConvertToRaidButton",
		"RaidFrameRaidInfoButton",
		"RaidFrameNotInRaidRaidBrowserButton",
		"RaidInfoExtendButton",
		"RaidInfoCancelButton",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	RaidInfoFrame:CreateBackdrop("Transparent")
	RaidInfoFrame.backdrop:Point("TOPLEFT", RaidInfoFrame, "TOPLEFT")
	RaidInfoFrame.backdrop:Point("BOTTOMRIGHT", RaidInfoFrame, "BOTTOMRIGHT")
	T.SkinCloseButton(RaidInfoCloseButton, RaidInfoFrame)

	if T.PTRVersion() then
		RaidParentFrame:CreateBackdrop("Transparent")
		RaidParentFrame.backdrop:Point("TOPLEFT", RaidParentFrame, "TOPLEFT")
		RaidParentFrame.backdrop:Point("BOTTOMRIGHT", RaidParentFrame, "BOTTOMRIGHT")
		T.SkinCloseButton(RaidParentFrameCloseButton)
		T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown, 300)
		RaidFinderQueueFrameSelectionDropDown:Point("RIGHT", -10, 0)

		RaidFinderFrameFindRaidButton:SkinButton(true)
		RaidFinderFrameCancelButton:SkinButton(true)

		for i = 1, 2 do
			T.SkinTab(_G["RaidParentFrameTab"..i])
		end

		local checkButtons = {
			"RaidFinderQueueFrameRoleButtonTank",
			"RaidFinderQueueFrameRoleButtonHealer",
			"RaidFinderQueueFrameRoleButtonDPS",
			"RaidFinderQueueFrameRoleButtonLeader",
		}

		for _, object in pairs(checkButtons) do
			_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
			T.SkinCheckBox(_G[object].checkButton)
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)