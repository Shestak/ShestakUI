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
		"LFRQueueFrameNoLFRWhileLFDLeaveQueueButton"
	}

	LFRParentFrame:StripTextures()
	LFRQueueFrameNoLFRWhileLFD:StripTextures()
	LFRQueueFrameNoLFRWhileLFD:CreateBackdrop("Overlay")
	LFRQueueFrameNoLFRWhileLFD.backdrop:Point("TOPLEFT", 5, 0)
	LFRQueueFrameNoLFRWhileLFD.backdrop:Point("BOTTOMRIGHT", -2, -3)
	LFRQueueFrame:StripTextures()
	LFRBrowseFrame:StripTextures()

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
	end

	LFRQueueFrameFindGroupButton:Point("BOTTOMLEFT", LFRParentFrame, "BOTTOMLEFT", 9, 4)
	LFRQueueFrameAcceptCommentButton:Point("BOTTOMRIGHT", LFRParentFrame, "BOTTOMRIGHT", -9, 4)

	-- Close button
	for i = 1, LFRParentFrame:GetNumChildren() do
		local child = select(i, LFRParentFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child, LFRParentFrame.backdrop)
		end
	end

	T.SkinTab(LFRParentFrameTab1)
	T.SkinTab(LFRParentFrameTab2)

	T.SkinDropDownBox(LFRBrowseFrameRaidDropDown)
	LFRQueueFrameSpecificListScrollFrame:StripTextures()

	LFRQueueFrameCommentTextButton:CreateBackdrop("Overlay")
	LFRQueueFrameCommentTextButton.backdrop:Point("TOPLEFT", -4, 2)
	LFRQueueFrameCommentTextButton.backdrop:Point("BOTTOMRIGHT", 3, 2)

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
		if tab then
			local icon = tab:GetNormalTexture():GetTexture()

			tab:StripTextures()
			tab:SetNormalTexture(icon)
			tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			tab:GetNormalTexture():ClearAllPoints()
			tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
			tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

			tab:CreateBackdrop("Default")
			tab.backdrop:SetAllPoints()
			tab:StyleButton(true)
		end
		LFRParentFrameSideTab1:Point("TOPLEFT", FriendsFrame, "TOPRIGHT", 1, 0)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)