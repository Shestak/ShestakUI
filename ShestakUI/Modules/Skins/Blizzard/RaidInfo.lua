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

	local KillTextures = {
		"RaidInfoScrollFrameScrollBarBG",
		"RaidInfoScrollFrameScrollBarTop",
		"RaidInfoScrollFrameScrollBarBottom",
		"RaidInfoScrollFrameScrollBarMiddle",
	}

	local buttons = {
		"RaidFrameConvertToRaidButton",
		"RaidFrameRaidInfoButton",
		"RaidInfoExtendButton",
		"RaidInfoCancelButton",
	}

	if T.PTRVersion() then
		tinsert(StripAllTextures, "RaidParentFrame")
		tinsert(StripAllTextures, "RaidParentFrameInset")
		tinsert(StripAllTextures, "RaidFinderQueueFrame")
		tinsert(StripAllTextures, "RaidFinderFrameRoleInset")
		tinsert(StripAllTextures, "RaidFinderQueueFrameScrollFrame")
		tinsert(StripAllTextures, "RaidFinderQueueFrameIneligibleFrame")
		tinsert(StripAllTextures, "RaidFinderQueueFrameCooldownFrame")
		tinsert(KillTextures, "RaidFinderQueueFrameBackground")
		tinsert(buttons, "RaidFinderQueueFrameIneligibleFrameLeaveQueueButton")
	else
		tinsert(buttons, "RaidFrameNotInRaidRaidBrowserButton")
	end

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
		RaidFinderQueueFrameIneligibleFrame:CreateBackdrop("Overlay")
		RaidFinderQueueFrameIneligibleFrame.backdrop:Point("TOPLEFT", 2, 0)
		RaidFinderQueueFrameIneligibleFrame.backdrop:Point("BOTTOMRIGHT", 0, 1)
		RaidFinderQueueFrameCooldownFrame:CreateBackdrop("Overlay")
		RaidFinderQueueFrameCooldownFrame.backdrop:Point("TOPLEFT", 2, 0)
		RaidFinderQueueFrameCooldownFrame.backdrop:Point("BOTTOMRIGHT", 0, 1)
		T.SkinCloseButton(RaidParentFrameCloseButton)
		T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown, 300)
		RaidFinderQueueFrameSelectionDropDown:Point("RIGHT", -10, 0)

		RaidFinderFrameFindRaidButton:SkinButton(true)
		RaidFinderFrameCancelButton:SkinButton(true)

		for i = 1, 3 do
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