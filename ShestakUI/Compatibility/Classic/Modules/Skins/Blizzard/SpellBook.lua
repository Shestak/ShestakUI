local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	SpellBook skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	SpellBookFrame:StripTextures()
	SpellBookFrame:CreateBackdrop("Transparent")
	SpellBookFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	SpellBookFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinNextPrevButton(SpellBookPrevPageButton)
	T.SkinNextPrevButton(SpellBookNextPageButton)
	SpellBookNextPageButton:SetPoint("BOTTOMRIGHT", SpellBookFrame.backdrop, "BOTTOMRIGHT", -15, 10)
	SpellBookPrevPageButton:SetPoint("BOTTOMRIGHT", SpellBookNextPageButton, "BOTTOMLEFT", -6, 0)

	T.SkinCloseButton(SpellBookCloseButton, SpellBookFrame.backdrop)

	SpellBookTitleText:ClearAllPoints()
	SpellBookTitleText:SetPoint("TOP", SpellBookFrame.backdrop, "TOP", 0, -6)

	-- Skin SpellButtons
	local function SpellButtons(self, first)
		for i = 1, SPELLS_PER_PAGE do
			local button = _G["SpellButton"..i]
			local icon = _G["SpellButton"..i.."IconTexture"]

			if first then
				-- _G["SpellButton"..i.."SlotFrame"]:SetAlpha(0)
				button:StripTextures()

				button.EmptySlot:SetAlpha(0)
				-- button.TextBackground:Hide()
				-- button.TextBackground2:Hide()
				-- button.UnlearnedFrame:SetAlpha(0)
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

			local r, g, b = _G["SpellButton"..i.."SpellName"]:GetTextColor()

			if r < 0.8 then
				_G["SpellButton"..i.."SpellName"]:SetTextColor(0.6, 0.6, 0.6)
			end
			_G["SpellButton"..i.."SubSpellName"]:SetTextColor(0.6, 0.6, 0.6)
			_G["SpellButton"..i.."AutoCastable"]:SetTexture("Interface\\Buttons\\UI-AutoCastableOverlay")
			_G["SpellButton"..i.."AutoCastable"]:ClearAllPoints()
			_G["SpellButton"..i.."AutoCastable"]:SetPoint("TOPLEFT", -12, 12)
			_G["SpellButton"..i.."AutoCastable"]:SetPoint("BOTTOMRIGHT", 14, -14)
			_G["SpellButton"..i.."AutoCastable"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)

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
			if i == 1 then
				tab:SetPoint(point, relatedTo, point2, -30, -64)
			else
				tab:SetPoint(point, relatedTo, point2, 0, -16)
			end
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

	-- Bottom Tabs
	SpellBookFrameTabButton1:ClearAllPoints()
	SpellBookFrameTabButton1:SetPoint("TOPLEFT", SpellBookFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 3 do
		local tab = _G["SpellBookFrameTabButton"..i]
		local lastTab = _G["SpellBookFrameTabButton"..(i-1)]
		if lastTab then
			tab:ClearAllPoints()
			tab:SetPoint("LEFT", lastTab, "RIGHT", -16, 0)
		end
		tab:StripTextures()
		tab:SetNormalTexture("")
		tab:SetHighlightTexture("")
		tab:SetSize(tab:GetWidth() * 0.75, 32)
		T.SkinTab(tab)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)