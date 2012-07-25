local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end
if T.MOPVersion then return end

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
	RaidBrowserFrame.backdrop:Point("TOPLEFT", 0, 0)
	RaidBrowserFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	LFRBrowseFrame:StripTextures()
	LFRBrowseFrameRoleInset:StripTextures()

	LFRQueueFrameFindGroupButton:Point("BOTTOMLEFT", RaidBrowserFrame, "BOTTOMLEFT", 9, 4)
	LFRQueueFrameAcceptCommentButton:Point("BOTTOMRIGHT", RaidBrowserFrame, "BOTTOMRIGHT", -9, 4)
	LFRBrowseFrameSendMessageButton:Point("BOTTOMLEFT", LFRBrowseFrame, "BOTTOMLEFT", 9, 4)
	LFRBrowseFrameRefreshButton:Point("BOTTOMRIGHT", LFRBrowseFrame, "BOTTOMRIGHT", -9, 4)

	T.SkinCloseButton(RaidBrowserFrameCloseButton)

	T.SkinDropDownBox(LFRBrowseFrameRaidDropDown)
	LFRQueueFrameSpecificListScrollFrame:StripTextures()

	LFRQueueFrameCommentTextButton:CreateBackdrop("Overlay")
	LFRQueueFrameCommentTextButton.backdrop:Point("TOPLEFT", -4, 2)
	LFRQueueFrameCommentTextButton.backdrop:Point("BOTTOMRIGHT", 15, 2)

	for i = 1, 7 do
		local button = "LFRBrowseFrameColumnHeader"..i
		_G[button.."Left"]:Kill()
		_G[button.."Middle"]:Kill()
		_G[button.."Right"]:Kill()
	end

	for i = 1, NUM_LFR_CHOICE_BUTTONS do
		local button = _G["LFRQueueFrameSpecificListButton"..i]
		T.SkinCheckBox(button.enableButton)
	end

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
		tab:StyleButton()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)

		LFRParentFrameSideTab1:Point("TOPLEFT", RaidBrowserFrame, "TOPRIGHT", 1, 0)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)