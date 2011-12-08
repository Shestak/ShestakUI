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
		"RaidParentFrame",
		"RaidParentFrameInset",
		"RaidFinderQueueFrame",
		"RaidFinderFrameRoleInset",
		"RaidFinderQueueFrameScrollFrame",
		"RaidFinderQueueFrameIneligibleFrame",
		"RaidFinderQueueFrameCooldownFrame"
	}

	local KillTextures = {
		"RaidInfoScrollFrameScrollBarBG",
		"RaidInfoScrollFrameScrollBarTop",
		"RaidInfoScrollFrameScrollBarBottom",
		"RaidInfoScrollFrameScrollBarMiddle",
		"RaidFinderQueueFrameBackground",
		"RaidFinderFrameRoleBackground"
	}

	local buttons = {
		"RaidFrameConvertToRaidButton",
		"RaidFrameRaidInfoButton",
		"RaidInfoExtendButton",
		"RaidInfoCancelButton",
		"RaidFinderQueueFrameIneligibleFrameLeaveQueueButton"
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

	RaidParentFrame:CreateBackdrop("Transparent")
	RaidParentFrame.backdrop:Point("TOPLEFT", RaidParentFrame, "TOPLEFT")
	RaidParentFrame.backdrop:Point("BOTTOMRIGHT", RaidParentFrame, "BOTTOMRIGHT")
	RaidFinderQueueFrameIneligibleFrame:CreateBackdrop("Overlay")
	RaidFinderQueueFrameIneligibleFrame.backdrop:Point("TOPLEFT", 2, 0)
	RaidFinderQueueFrameIneligibleFrame.backdrop:Point("BOTTOMRIGHT", 0, 2)
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
		"RaidFinderQueueFrameRoleButtonLeader"
	}

	for _, object in pairs(checkButtons) do
		_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
		T.SkinCheckBox(_G[object].checkButton)
	end

	for i = 1, 1 do
		local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i]
		local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."IconTexture"]
		local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."Count"]

		if button then
			local __texture = _G[button:GetName().."IconTexture"]:GetTexture()
			button:StripTextures()
			icon:SetTexture(__texture)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:Point("TOPLEFT", 2, -2)
			icon:SetDrawLayer("OVERLAY")
			count:SetDrawLayer("OVERLAY")

			if not button.backdrop then
				button:CreateBackdrop("Default")
				button.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
				button.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
				icon:SetParent(button.backdrop)
				icon.SetPoint = T.dummy

				if count then
					count:SetParent(button.backdrop)
				end
			end
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)