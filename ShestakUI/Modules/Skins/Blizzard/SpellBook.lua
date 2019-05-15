local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	SpellBook skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"SpellBookFrame",
		"SpellBookFrameInset",
		"SpellBookSpellIconsFrame",
		"SpellBookSideTabsFrame",
		"SpellBookPageNavigationFrame"
	}

	local KillTextures = {
		"SpellBookPage1",
		"SpellBookPage2"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local pagebackdrop = CreateFrame("Frame", nil, SpellBookPage1:GetParent())
	pagebackdrop:SetTemplate("Overlay")
	pagebackdrop:SetPoint("TOPLEFT", SpellBookFrame, "TOPLEFT", 50, -50)
	pagebackdrop:SetPoint("BOTTOMRIGHT", SpellBookFrame, "BOTTOMRIGHT", -26, 23)

	T.SkinNextPrevButton(SpellBookPrevPageButton)
	T.SkinNextPrevButton(SpellBookNextPageButton)
	SpellBookNextPageButton:SetPoint("BOTTOMRIGHT", pagebackdrop, "BOTTOMRIGHT", -15, 10)
	SpellBookPrevPageButton:SetPoint("BOTTOMRIGHT", SpellBookNextPageButton, "BOTTOMLEFT", -6, 0)

	SpellBookFrameTutorialButton.Ring:Hide()
	SpellBookFrameTutorialButton:SetPoint("TOPLEFT", SpellBookFrame, "TOPLEFT", -5, 10)

	SpellLockedTooltip:StripTextures()
	SpellLockedTooltip:SetTemplate("Transparent")
	T.SkinCloseButton(SpellLockedTooltip.CloseButton)

	-- Skin SpellButtons
	local function SpellButtons(self, first)
		for i = 1, SPELLS_PER_PAGE do
			local button = _G["SpellButton"..i]
			local icon = _G["SpellButton"..i.."IconTexture"]

			if first then
				_G["SpellButton"..i.."SlotFrame"]:SetAlpha(0)

				button.EmptySlot:SetAlpha(0)
				button.TextBackground:Hide()
				button.TextBackground2:Hide()
				button.UnlearnedFrame:SetAlpha(0)
				button:SetCheckedTexture("")
				button:SetPushedTexture("")
			end

			if _G["SpellButton"..i.."Highlight"] then
				_G["SpellButton"..i.."Highlight"]:SetColorTexture(1, 1, 1, 0.3)
				_G["SpellButton"..i.."Highlight"]:ClearAllPoints()
				_G["SpellButton"..i.."Highlight"]:SetAllPoints(icon)
			end

			if icon then
				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:SetAllPoints()

				if not button.backdrop then
					button:SetFrameLevel(button:GetFrameLevel() + 1)
					button:CreateBackdrop("Default")
				end
			end

			local r = _G["SpellButton"..i.."SpellName"]:GetTextColor()

			if r < 0.8 then
				_G["SpellButton"..i.."SpellName"]:SetTextColor(0.6, 0.6, 0.6)
			end
			_G["SpellButton"..i.."SubSpellName"]:SetTextColor(0.6, 0.6, 0.6)
			_G["SpellButton"..i.."RequiredLevelString"]:SetTextColor(0.6, 0.6, 0.6)
		end
	end
	SpellButtons(nil, true)
	hooksecurefunc("SpellButton_UpdateButton", SpellButtons)

	SpellBookPageText:SetTextColor(0.6, 0.6, 0.6)

	-- Skill Line Tabs
	for i = 1, MAX_SKILLLINE_TABS do
		local tab = _G["SpellBookSkillLineTab"..i]
		_G["SpellBookSkillLineTab"..i.."Flash"]:Kill()
		if tab then
			tab:StripTextures()
			tab:GetNormalTexture():ClearAllPoints()
			tab:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			tab:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
			tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

			tab:CreateBackdrop("Default")
			tab.backdrop:SetAllPoints()
			tab:StyleButton(true)

			local point, relatedTo, point2 = tab:GetPoint()
			tab:SetPoint(point, relatedTo, point2, 16, -1)
		end
	end

	local function SkinSkillLine()
		for i = 1, MAX_SKILLLINE_TABS do
			local tab = _G["SpellBookSkillLineTab"..i]
			local _, _, _, _, isGuild = GetSpellTabInfo(i)
			if isGuild then
				tab:GetNormalTexture():ClearAllPoints()
				tab:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
				tab:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
				tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end
		end
	end
	hooksecurefunc("SpellBookFrame_UpdateSkillLineTabs", SkinSkillLine)

	SpellBookFrame:CreateBackdrop("Transparent")
	SpellBookFrame.backdrop:SetPoint("TOPLEFT", 5, -1)
	SpellBookFrame.backdrop:SetPoint("BOTTOMRIGHT", 15, -1)

	T.SkinCloseButton(SpellBookFrameCloseButton, SpellBookFrame.backdrop)

	-- Profession Tab
	local professionbuttons = {
		"PrimaryProfession1SpellButtonTop",
		"PrimaryProfession1SpellButtonBottom",
		"PrimaryProfession2SpellButtonTop",
		"PrimaryProfession2SpellButtonBottom",
		"SecondaryProfession1SpellButtonLeft",
		"SecondaryProfession1SpellButtonRight",
		"SecondaryProfession2SpellButtonLeft",
		"SecondaryProfession2SpellButtonRight",
		"SecondaryProfession3SpellButtonLeft",
		"SecondaryProfession3SpellButtonRight"
	}

	local professionheaders = {
		"PrimaryProfession1",
		"PrimaryProfession2",
		"SecondaryProfession1",
		"SecondaryProfession2",
		"SecondaryProfession3"
	}

	for _, header in pairs(professionheaders) do
		_G[header.."Missing"]:SetTextColor(1, 0.8, 0)
		_G[header.."Missing"]:SetShadowColor(0, 0, 0)
		_G[header.."Missing"]:SetShadowOffset(1, -1)
		_G[header].missingText:SetTextColor(0.6, 0.6, 0.6)
	end

	for _, button in pairs(professionbuttons) do
		local icon = _G[button.."IconTexture"]
		local rank = _G[button.."SubSpellName"]
		local button = _G[button]
		button:StripTextures()

		if rank then
			rank:SetTextColor(1, 1, 1)
		end

		button:GetCheckedTexture():SetColorTexture(0, 1, 0, 0.3)
		button:GetCheckedTexture():SetPoint("TOPLEFT", button, 4, -4)
		button:GetCheckedTexture():SetPoint("BOTTOMRIGHT", button, -4, 4)

		button.cooldown:SetPoint("TOPLEFT", button, 4, -4)
		button.cooldown:SetPoint("BOTTOMRIGHT", button, -4, 4)

		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 4, -4)
			icon:SetPoint("BOTTOMRIGHT", -4, 4)

			if not button.backdrop then
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				button:CreateBackdrop("Default")
				button.backdrop:SetPoint("TOPLEFT", 2, -2)
				button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
			end
		end
	end

	hooksecurefunc("UpdateProfessionButton", function(self)
		for _, button in pairs(professionbuttons) do
			local button = _G[button]
			button:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
			button:GetHighlightTexture():SetPoint("TOPLEFT", button, 4, -4)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, -4, 4)
		end
	end)

	local professionstatusbars = {
		"PrimaryProfession1StatusBar",
		"PrimaryProfession2StatusBar",
		"SecondaryProfession1StatusBar",
		"SecondaryProfession2StatusBar",
		"SecondaryProfession3StatusBar"
	}

	for _, statusbar in pairs(professionstatusbars) do
		local statusbar = _G[statusbar]
		statusbar:StripTextures()
		statusbar:SetStatusBarTexture(C.media.texture)
		statusbar:SetStatusBarColor(0, 0.8, 0)
		statusbar:CreateBackdrop("Overlay")

		statusbar.rankText:ClearAllPoints()
		statusbar.rankText:SetPoint("CENTER")
	end

	-- Bottom Tabs
	for i = 1, 5 do
		T.SkinTab(_G["SpellBookFrameTabButton"..i])
	end
	_G["SpellBookFrameTabButton1"]:ClearAllPoints()
	_G["SpellBookFrameTabButton1"]:SetPoint("TOPLEFT", _G["SpellBookFrame"], "BOTTOMLEFT", -5, 1)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)