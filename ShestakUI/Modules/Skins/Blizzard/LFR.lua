local T, C, L = unpack(select(2, ...))
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
		"LFRQueueFrameNoLFRWhileLFDLeaveQueueButton",
	}

	LFRParentFrame:StripTextures()
	LFRParentFrame:CreateBackdrop("Transparent")
	LFRParentFrame.backdrop:Point("TOPLEFT", 16, -12)
	LFRParentFrame.backdrop:Point("BOTTOMRIGHT", -1, 0)
	LFRQueueFrameNoLFRWhileLFD:StripTextures()
	LFRQueueFrameNoLFRWhileLFD:CreateBackdrop("Overlay")
	LFRQueueFrameNoLFRWhileLFD.backdrop:Point("TOPLEFT", 4, 0)
	LFRQueueFrameNoLFRWhileLFD.backdrop:Point("BOTTOMRIGHT", -3, -1)
	LFRQueueFrame:StripTextures()
	LFRBrowseFrame:StripTextures()

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	LFRQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFRParentFrame.backdrop, "BOTTOMLEFT", 9, 7)
	LFRQueueFrameAcceptCommentButton:Point("BOTTOMRIGHT", LFRParentFrame.backdrop, "BOTTOMRIGHT", -9, 7)

	-- Close button
	for i = 1, LFRParentFrame:GetNumChildren() do
		local child = select(i, LFRParentFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child, LFRParentFrame.backdrop)
		end
	end

	T.SkinTab(LFRParentFrameTab1)
	T.SkinTab(LFRParentFrameTab2)

	-- Reposition tabs
	LFRParentFrameTab1:ClearAllPoints()
	LFRParentFrameTab1:SetPoint("TOPLEFT", LFRParentFrame.backdrop, "BOTTOMLEFT", 0, 2)

	T.SkinDropDownBox(LFRBrowseFrameRaidDropDown)
	LFRQueueFrameSpecificListScrollFrame:StripTextures()

	LFRQueueFrameCommentTextButton:CreateBackdrop("Overlay")
	LFRQueueFrameCommentTextButton.backdrop:Point("TOPLEFT", -6, 2)
	LFRQueueFrameCommentTextButton.backdrop:Point("BOTTOMRIGHT", 1, 0)

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
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)