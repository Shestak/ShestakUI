local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	LFR skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"LFRQueueFrameFindGroupButton",
		"LFRQueueFrameAcceptCommentButton",
		"LFRBrowseFrameSendMessageButton",
		"LFRBrowseFrameInviteButton",
		"LFRBrowseFrameRefreshButton",
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	RaidBrowserFrame:StripTextures()
	RaidBrowserFrame:CreateBackdrop("Transparent")
	RaidBrowserFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	RaidBrowserFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	LFRBrowseFrame:StripTextures()
	LFRBrowseFrameRoleInset:StripTextures()
	LFRQueueFrameSpecificListScrollFrame:StripTextures()

	LFRQueueFrameFindGroupButton:SetPoint("BOTTOMLEFT", RaidBrowserFrame, "BOTTOMLEFT", 9, 4)
	LFRQueueFrameAcceptCommentButton:SetPoint("BOTTOMRIGHT", RaidBrowserFrame, "BOTTOMRIGHT", -9, 4)
	LFRBrowseFrameSendMessageButton:SetPoint("BOTTOMLEFT", LFRBrowseFrame, "BOTTOMLEFT", 9, 4)
	LFRBrowseFrameRefreshButton:SetPoint("BOTTOMRIGHT", LFRBrowseFrame, "BOTTOMRIGHT", -9, 4)

	T.SkinCloseButton(RaidBrowserFrameCloseButton)

	T.SkinDropDownBox(LFRBrowseFrameRaidDropDown)
	T.SkinScrollBar(LFRQueueFrameSpecificListScrollFrame)
	T.SkinScrollBar(LFRBrowseFrameListScrollFrame)

	LFRQueueFrameCommentTextButton:CreateBackdrop("Overlay")
	LFRQueueFrameCommentTextButton.backdrop:SetPoint("TOPLEFT", -4, 2)
	LFRQueueFrameCommentTextButton.backdrop:SetPoint("BOTTOMRIGHT", 15, 2)

	for i = 1, 7 do
		local button = "LFRBrowseFrameColumnHeader"..i
		_G[button.."Left"]:Kill()
		_G[button.."Middle"]:Kill()
		_G[button.."Right"]:Kill()
	end

	hooksecurefunc("LFRQueueFrameSpecificListButton_SetDungeon", function(button, dungeonID)
		T.SkinCheckBox(button.enableButton)
	end)

	T.SkinCheckBox(LFRQueueFrameRoleButtonTank:GetChildren())
	T.SkinCheckBox(LFRQueueFrameRoleButtonHealer:GetChildren())
	T.SkinCheckBox(LFRQueueFrameRoleButtonDPS:GetChildren())
	LFRQueueFrameRoleButtonTank:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonTank:GetChildren():GetFrameLevel() + 2)
	LFRQueueFrameRoleButtonHealer:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonHealer:GetChildren():GetFrameLevel() + 2)
	LFRQueueFrameRoleButtonDPS:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonDPS:GetChildren():GetFrameLevel() + 2)

	for i = 1, 2 do
		local tab = _G["LFRParentFrameSideTab"..i]
		local icon = select(2, tab:GetRegions())

		tab:GetRegions():Hide()
		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()
		tab:StyleButton(true)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		LFRParentFrameSideTab1:SetPoint("TOPLEFT", RaidBrowserFrame, "TOPRIGHT", 1, 0)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)