local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	TradeSkillUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TRADE_SKILLS_DISPLAYED = 25

	UIPanelWindows["TradeSkillFrame"] = {area = "doublewide", pushable = 0, whileDead = 1}

	local TradeSkillFrame = _G["TradeSkillFrame"]
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:CreateBackdrop("Transparent")
	TradeSkillFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	TradeSkillFrame.backdrop:SetPoint("BOTTOMRIGHT", -34, 0)
	TradeSkillFrame:SetSize(720, 508)

	TradeSkillFrame.bg1 = CreateFrame("Frame", nil, TradeSkillFrame)
	TradeSkillFrame.bg1:SetTemplate("Transparent")
	TradeSkillFrame.bg1:SetPoint("TOPLEFT", 14, -92)
	TradeSkillFrame.bg1:SetPoint("BOTTOMRIGHT", -367, 4)
	TradeSkillFrame.bg1:SetFrameLevel(TradeSkillFrame.bg1:GetFrameLevel() - 1)

	TradeSkillFrame.bg2 = CreateFrame("Frame", nil, TradeSkillFrame)
	TradeSkillFrame.bg2:SetTemplate("Transparent")
	TradeSkillFrame.bg2:SetPoint("TOPLEFT", TradeSkillFrame.bg1, "TOPRIGHT", 3, 0)
	TradeSkillFrame.bg2:SetPoint("BOTTOMRIGHT", TradeSkillFrame, "BOTTOMRIGHT", -38, 4)
	TradeSkillFrame.bg2:SetFrameLevel(TradeSkillFrame.bg2:GetFrameLevel() - 1)

	TradeSkillRankFrameBorder:StripTextures()

	TradeSkillRankFrame:StripTextures()
	TradeSkillRankFrame:CreateBackdrop()
	TradeSkillRankFrame:SetSize(420, 18)
	TradeSkillRankFrame:ClearAllPoints()
	TradeSkillRankFrame:SetPoint("TOP", -10, -38)
	TradeSkillRankFrame:SetStatusBarTexture(C.media.blank)

	TradeSkillRankFrameSkillName:Hide()
	TradeSkillRankFrameSkillRank:ClearAllPoints()
	TradeSkillRankFrameSkillRank:SetParent(TradeSkillRankFrame)
	TradeSkillRankFrameSkillRank:SetPoint("CENTER", TradeSkillRankFrame, "CENTER", 58, 0)

	TradeSkillListScrollFrame:StripTextures()
	TradeSkillListScrollFrame:SetSize(310, 405)
	TradeSkillListScrollFrame:ClearAllPoints()
	TradeSkillListScrollFrame:SetPoint("TOPLEFT", 17, -95)

	TradeSkillDetailScrollFrame:StripTextures()
	TradeSkillDetailScrollFrame:SetSize(300, 381)
	TradeSkillDetailScrollFrame:ClearAllPoints()
	TradeSkillDetailScrollFrame:SetPoint("TOPRIGHT", TradeSkillFrame, -60, -95)
	TradeSkillDetailScrollFrame.scrollBarHideable = nil

	TradeSkillDetailScrollChildFrame:StripTextures()
	TradeSkillDetailScrollChildFrame:SetSize(300, 150)

	T.SkinScrollBar(TradeSkillListScrollFrameScrollBar)
	T.SkinScrollBar(TradeSkillDetailScrollFrameScrollBar)
	TradeSkillDetailScrollFrameScrollBar:SetPoint("TOPLEFT", TradeSkillDetailScrollFrame, "TOPRIGHT", 3, -16)

	T.SkinDropDownBox(TradeSkillInvSlotDropDown, 160)
	TradeSkillInvSlotDropDown:ClearAllPoints()
	TradeSkillInvSlotDropDown:SetPoint("RIGHT", TradeSkillRankFrame, "RIGHT", 9, -30)

	T.SkinDropDownBox(TradeSkillSubClassDropDown, 160)
	TradeSkillSubClassDropDown:SetPoint("RIGHT", TradeSkillInvSlotDropDown, "LEFT", 10, 0)

	TradeSkillCancelButton:SetWidth(75)
	TradeSkillCancelButton:ClearAllPoints()
	TradeSkillCancelButton:SetPoint("TOPRIGHT", TradeSkillDetailScrollFrame, "BOTTOMRIGHT", 19, -3)
	TradeSkillCancelButton:SkinButton()

	TradeSkillCreateButton:SetWidth(75)
	TradeSkillCreateButton:ClearAllPoints()
	TradeSkillCreateButton:SetPoint("TOPRIGHT", TradeSkillCancelButton, "TOPLEFT", -3, 0)
	TradeSkillCreateButton:SkinButton()

	TradeSkillCreateAllButton:ClearAllPoints()
	TradeSkillCreateAllButton:SetPoint("TOPLEFT", TradeSkillDetailScrollFrame, "BOTTOMLEFT", 0, -3)
	TradeSkillCreateAllButton:SkinButton()

	T.SkinNextPrevButton(TradeSkillDecrementButton)

	T.SkinEditBox(TradeSkillInputBox)
	TradeSkillInputBox:SetSize(40, 16)
	TradeSkillInputBox:SetPoint("LEFT", TradeSkillDecrementButton, "RIGHT", 4, 0)

	T.SkinNextPrevButton(TradeSkillIncrementButton)
	TradeSkillIncrementButton:SetPoint("LEFT", TradeSkillInputBox, "RIGHT", 4, 0)

	TradeSkillSkillIcon:StripTextures()
	TradeSkillSkillIcon:SetTemplate("Default")
	TradeSkillSkillIcon:StyleButton(true)
	TradeSkillSkillIcon:SetSize(47, 47)
	TradeSkillSkillIcon:SetPoint("TOPLEFT", 1, -3)

	TradeSkillSkillName:SetPoint("TOPLEFT", 55, -3)

	TradeSkillRequirementLabel:SetTextColor(1, 0.80, 0.10)

	T.SkinCloseButton(TradeSkillFrameCloseButton, TradeSkillFrame.backdrop)

	TradeSkillExpandButtonFrame:StripTextures()
	TradeSkillCollapseAllButton:SetPoint("LEFT", TradeSkillExpandTabLeft, "RIGHT", -1, 6)

	TradeSkillCollapseAllButtonText:ClearAllPoints()
	TradeSkillCollapseAllButtonText:SetPoint("LEFT", TradeSkillCollapseAllButton, "RIGHT", 6, 0)

	TradeSkillCollapseAllButton:SetSize(14, 14)
	TradeSkillCollapseAllButton:SetPoint("CENTER")
	TradeSkillCollapseAllButton:SetHitRectInsets(1, 1, 1, 1)

	hooksecurefunc(TradeSkillCollapseAllButton, "SetNormalTexture", function(self, texture)
		self:StripTextures()
		self:SetTemplate("Overlay")

		self.minus = self:CreateTexture(nil, "OVERLAY")
		self.minus:SetSize(7, 1)
		self.minus:SetPoint("CENTER")
		self.minus:SetTexture(C.media.blank)

		if not string.find(texture, "MinusButton") then
			self.plus = self:CreateTexture(nil, "OVERLAY")
			self.plus:SetSize(1, 7)
			self.plus:SetPoint("CENTER")
			self.plus:SetTexture(C.media.blank)
		end
	end)

	for i = 9, 25 do
		CreateFrame("Button", "TradeSkillSkill"..i, TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", _G["TradeSkillSkill"..i - 1], "BOTTOMLEFT")
	end

	local function UpdateTradeskill()
		local numSkills = GetNumTradeSkills()
		local offset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame)
		local index, button, highlight, text

		for i = 1, TRADE_SKILLS_DISPLAYED do
			button = _G["TradeSkillSkill"..i]
			highlight = _G["TradeSkillSkill"..i.."Highlight"]
			text = _G["TradeSkillSkill"..i.."Text"]
			index = offset + i

			if index <= numSkills then
				local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(index)

				if skillType == "header" then
					button:SetSize(14, 14)
					button:SetPoint("CENTER")
					button:SetHitRectInsets(1, 1, 1, 1)

					highlight:SetTexture("")
					highlight.SetTexture = T.dummy

					text:ClearAllPoints()
					text:SetPoint("LEFT", button, "RIGHT", 6, 0)

					hooksecurefunc(button, "SetNormalTexture", function(self, texture)
						self:StripTextures()
						self:SetTemplate("Overlay")

						self.minus = self:CreateTexture(nil, "OVERLAY")
						self.minus:SetSize(7, 1)
						self.minus:SetPoint("CENTER")
						self.minus:SetTexture(C.media.blank)

						if not string.find(texture, "MinusButton") then
							self.plus = self:CreateTexture(nil, "OVERLAY")
							self.plus:SetSize(1, 7)
							self.plus:SetPoint("CENTER")
							self.plus:SetTexture(C.media.blank)
						end
					end)
				end
			end
		end
	end
	hooksecurefunc("TradeSkillFrame_Update", UpdateTradeskill)

	for i = 1, MAX_TRADE_SKILL_REAGENTS do
		local reagent = _G["TradeSkillReagent"..i]
		local icon = _G["TradeSkillReagent"..i.."IconTexture"]
		local count = _G["TradeSkillReagent"..i.."Count"]
		local name = _G["TradeSkillReagent"..i.."Name"]
		local nameFrame = _G["TradeSkillReagent"..i.."NameFrame"]

		reagent:SetTemplate("Default")
		reagent:StyleButton(true)
		reagent:SetSize(143, 40)

		icon.backdrop = CreateFrame("Frame", nil, reagent)
		icon.backdrop:SetTemplate("Default")
		icon.backdrop:SetPoint("TOPLEFT", icon, -1, 1)
		icon.backdrop:SetPoint("BOTTOMRIGHT", icon, 1, -1)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetDrawLayer("OVERLAY")
		icon:SetSize(38, 38)
		icon:SetPoint("TOPLEFT", 1, -1)
		icon:SetParent(icon.backdrop)

		count:SetParent(icon.backdrop)
		count:SetDrawLayer("OVERLAY")

		name:SetPoint("LEFT", nameFrame, "LEFT", 20, 0)

		nameFrame:Kill()
	end

	TradeSkillReagentLabel:ClearAllPoints()
	TradeSkillReagentLabel:SetPoint("TOPLEFT", TradeSkillSkillIcon, "BOTTOMLEFT", 5, -10)

	TradeSkillReagent1:SetPoint("TOPLEFT", TradeSkillReagentLabel, "BOTTOMLEFT", -3, -3)
	TradeSkillReagent2:SetPoint("LEFT", TradeSkillReagent1, "RIGHT", 3, 0)
	TradeSkillReagent4:SetPoint("LEFT", TradeSkillReagent3, "RIGHT", 3, 0)
	TradeSkillReagent6:SetPoint("LEFT", TradeSkillReagent5, "RIGHT", 3, 0)
	TradeSkillReagent8:SetPoint("LEFT", TradeSkillReagent7, "RIGHT", 3, 0)

	hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
		TradeSkillRankFrame:SetStatusBarColor(0.13, 0.28, 0.85)

		if TradeSkillSkillIcon:GetNormalTexture() then
			TradeSkillReagentLabel:SetAlpha(1)
			TradeSkillSkillIcon:SetAlpha(1)
			TradeSkillSkillIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			TradeSkillSkillIcon:GetNormalTexture():SetInside()
		else
			TradeSkillReagentLabel:SetAlpha(0)
			TradeSkillSkillIcon:SetAlpha(0)
		end

		--[[
		local skillLink = GetTradeSkillItemLink(id) -- Causing crashes
		if skillLink then
			local _, _, quality = GetItemInfo(string.match(skillLink, "item:(%d+)"))
			if quality then
				TradeSkillSkillIcon:SetBackdropBorderColor(GetItemQualityColor(quality))
				TradeSkillSkillName:SetTextColor(GetItemQualityColor(quality))
			else
				TradeSkillSkillIcon:SetBackdropBorderColor(unpack(C.media.border_color))
				TradeSkillSkillName:SetTextColor(1, 1, 1)
			end
		end
		--]]

		local numReagents = GetTradeSkillNumReagents(id)
		for i = 1, numReagents, 1 do
			local _, _, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i)
			local reagentLink = GetTradeSkillReagentItemLink(id, i)
			local reagent = _G["TradeSkillReagent"..i]
			local icon = _G["TradeSkillReagent"..i.."IconTexture"]
			local name = _G["TradeSkillReagent"..i.."Name"]
			local count = _G["TradeSkillReagent"..i.."Count"]

			if reagentLink then
				local _, _, quality = GetItemInfo(string.match(reagentLink, "item:(%d+)"))
				if quality then
					icon.backdrop:SetBackdropBorderColor(GetItemQualityColor(quality))
					reagent:SetBackdropBorderColor(GetItemQualityColor(quality))
					if playerReagentCount < reagentCount then
						name:SetTextColor(0.5, 0.5, 0.5)
					else
						name:SetTextColor(GetItemQualityColor(quality))
					end
					count:ClearAllPoints()
					count:SetPoint("BOTTOMLEFT", icon, "BOTTOMLEFT", 0, -1)
				else
					reagent:SetBackdropBorderColor(unpack(C.media.border_color))
					icon.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			end
		end
		--]]
	end)
end

T.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin