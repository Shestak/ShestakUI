local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LFD skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"LFDParentFrame",
		"LFDQueueFrame",
		"LFDQueueFrameSpecific",
		"LFDQueueFrameRandom",
		"LFDQueueFrameRandomScrollFrame",
		"LFDQueueFrameCapBar",
		"LFDQueueFrameRandomScrollFrameScrollBar",
		"LFDQueueFrameNoLFDWhileLFR",
		"LFDQueueFrameSpecificListScrollFrame",
		"LFDQueueFrameCooldownFrame",
		"LFGDungeonReadyDialog",
		"LFGDungeonReadyStatus",
		"LFGInvitePopup"
	}

	local KillTextures = {
		"LFDQueueFrameBackground",
		"LFDParentFrameInset",
		"LFDParentFrameEyeFrame",
		"LFDQueueFrameRoleButtonTankBackground",
		"LFDQueueFrameRoleButtonHealerBackground",
		"LFDQueueFrameRoleButtonDPSBackground",
		"LFGDungeonReadyDialogBackground"
	}

	local buttons = {
		"LFDQueueFrameFindGroupButton",
		"LFDQueueFrameCancelButton",
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
		"LFDQueueFrameNoLFDWhileLFRLeaveQueueButton",
		"LFGDungeonReadyDialogEnterDungeonButton",
		"LFGDungeonReadyDialogLeaveQueueButton",
		"LFGInvitePopupAcceptButton",
		"LFGInvitePopupDeclineButton"
	}

	local checkButtons = {
		"LFDQueueFrameRoleButtonTank",
		"LFDQueueFrameRoleButtonHealer",
		"LFDQueueFrameRoleButtonDPS",
		"LFDQueueFrameRoleButtonLeader"
	}

	for _, object in pairs(checkButtons) do
		_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
		T.SkinCheckBox(_G[object].checkButton)
	end

	hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", function()
		local dungeonID = LFDQueueFrame.type
		if type(dungeonID) == "string" then return end
		local _, _, _, _, _, numRewards = GetLFGDungeonRewards(dungeonID)

		for i = 1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]
			local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
			local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
			local role1 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon1"]
			local role2 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon2"]
			local role3 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon3"]

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
					if role1 then
						role1:SetParent(button.backdrop)
					end
					if role2 then
						role2:SetParent(button.backdrop)
					end
					if role3 then
						role3:SetParent(button.backdrop)
					end
				end
			end
		end
	end)

	hooksecurefunc("LFDQueueFrameSpecificListButton_SetDungeon", function(button, dungeonID, mode, submode)
		for _, object in pairs(checkButtons) do
			local button = _G[object]
			if not button.checkButton:GetChecked() then
				button.checkButton:SetDisabledTexture(nil)
			else
				button.checkButton:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			end
		end
	end)

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	for i = 1, NUM_LFD_CHOICE_BUTTONS do
		T.SkinCheckBox(_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"])
	end

	LFDQueueFrameCapBar:SetPoint("LEFT", 40, 0)

	LFDQueueFrameNoLFDWhileLFR:CreateBackdrop("Overlay")
	LFDQueueFrameNoLFDWhileLFR.backdrop:Point("TOPLEFT", 2, 5)
	LFDQueueFrameNoLFDWhileLFR.backdrop:Point("BOTTOMRIGHT", 0, 6)
	LFDQueueFrameCooldownFrame:CreateBackdrop("Overlay")
	LFDQueueFrameCooldownFrame.backdrop:Point("TOPLEFT", 2, 4)
	LFDQueueFrameCooldownFrame.backdrop:Point("BOTTOMRIGHT", 0, 6)
	LFDQueueFrameSpecific:Point("TOPLEFT", -5, 0)
	LFDQueueFrameSpecific:Point("BOTTOMRIGHT", 0, 10)
	LFDParentFrame:CreateBackdrop("Transparent")
	LFDParentFrame.backdrop:Point("TOPLEFT", LFDParentFrame, "TOPLEFT")
	LFDParentFrame.backdrop:Point("BOTTOMRIGHT", LFDParentFrame, "BOTTOMRIGHT", 0, 4)
	T.SkinCloseButton(LFDParentFrameCloseButton, LFDParentFrame)
	T.SkinDropDownBox(LFDQueueFrameTypeDropDown, 300)
	LFDQueueFrameTypeDropDown:Point("RIGHT", -10, 0)
	LFDQueueFrameCapBar:CreateBackdrop("Transparent")
	LFDQueueFrameCapBar.backdrop:Point("TOPLEFT", LFDQueueFrameCapBar, "TOPLEFT", 1, -1)
	LFDQueueFrameCapBar.backdrop:Point("BOTTOMRIGHT", LFDQueueFrameCapBar, "BOTTOMRIGHT", -1, 1)
	LFDQueueFrameCapBarProgress:SetTexture(C.media.texture)
	LFDQueueFrameCapBarCap1:SetTexture(C.media.texture)
	LFDQueueFrameCapBarCap2:SetTexture(C.media.texture)
	T.SkinScrollBar(LFDQueueFrameSpecificListScrollFrameScrollBar)
	RolePollPopup:SetTemplate("Transparent")
	LFGInvitePopup:SetTemplate("Transparent")
	LFGDungeonReadyPopup:SetTemplate("Transparent")
	LFGDungeonReadyDialog.SetBackdrop = T.dummy
	LFGDungeonReadyDialog.filigree:SetAlpha(0)
	LFGDungeonReadyDialog.bottomArt:SetAlpha(0)
	T.SkinCloseButton(LFGDungeonReadyDialogCloseButton, LFGDungeonReadyDialog, "-")
	LFDQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFDParentFrame.backdrop, "BOTTOMLEFT", 4, 4)
	LFDQueueFrameCancelButton:Point("BOTTOMRIGHT", LFDParentFrame.backdrop, "BOTTOMRIGHT", -6, 4)
	LFDQueueFrameRandomScrollFrame:Height(LFDQueueFrameRandomScrollFrame:GetHeight() + 10)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)