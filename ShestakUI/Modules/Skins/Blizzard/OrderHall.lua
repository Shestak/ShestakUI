local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	OrderHallUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	OrderHallCommandBar:StripTextures()
	OrderHallCommandBar:SetTemplate("Transparent")
	OrderHallCommandBar:ClearAllPoints()
	OrderHallCommandBar:SetPoint("TOP", UIParent, 0, -1)
	OrderHallCommandBar.ClassIcon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
	OrderHallCommandBar.ClassIcon:SetSize(46, 20)
	OrderHallCommandBar.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
	OrderHallCommandBar.AreaName:ClearAllPoints()
	OrderHallCommandBar.AreaName:SetPoint("LEFT", OrderHallCommandBar.CurrencyIcon, "RIGHT", 25, 0)
	OrderHallCommandBar.AreaName:SetVertexColor(T.color.r, T.color.g, T.color.b)
	OrderHallCommandBar.WorldMapButton:Kill()

	hooksecurefunc(OrderHallCommandBar, "RefreshCategories", function(self)
		local index = 0
		C_Timer.After(0.5, function()
			for _, child in ipairs({self:GetChildren()}) do
				if child.Icon and child.Count and child.TroopPortraitCover then
					index = index + 1
					child.TroopPortraitCover:Hide()
					child.Icon:SetSize(38, 21)
				end
			end
			self:SetWidth(270 + index * 112)
		end)
	end)

	-- TalentFrame skin from ElvUI
	local function colorBorder(child, backdrop, atlas)
		if child.AlphaIconOverlay:IsShown() then --isBeingResearched or (talentAvailability and not selected)
			local alpha = child.AlphaIconOverlay:GetAlpha()
			if alpha <= 0.5 then --talentAvailability
				backdrop:SetBackdropBorderColor(0.5, 0.5, 0.5) --[border = grey, shadow x2]
				child.darkOverlay:SetColorTexture(0, 0, 0, 0.50)
				child.darkOverlay:Show()
			elseif alpha <= 0.7 then --isBeingResearched
				backdrop:SetBackdropBorderColor(0, 1, 1) --[border = teal, shadow x1]
				child.darkOverlay:SetColorTexture(0, 0, 0, 0.25)
				child.darkOverlay:Show()
			end
		elseif atlas == "orderhalltalents-spellborder-green" then
			backdrop:SetBackdropBorderColor(0, 1, 0) --[border = green, no shadow]
			child.darkOverlay:Hide()
		elseif atlas == "orderhalltalents-spellborder-yellow" then
			backdrop:SetBackdropBorderColor(1, 1, 0) --[border = yellow, no shadow]
			child.darkOverlay:Hide()
		elseif atlas == "orderhalltalents-spellborder" then
			backdrop:SetBackdropBorderColor(0.2, 0.2, 0.2) --[border = dark grey, shadow x3]
			child.darkOverlay:SetColorTexture(0, 0, 0, 0.75)
			child.darkOverlay:Show()
		end
	end

	OrderHallTalentFrame:StripTextures()
	OrderHallTalentFrame:SetTemplate("Transparent")
	OrderHallTalentFrame.NineSlice:Hide()
	OrderHallTalentFrame.OverlayElements:Hide()
	T.SkinCloseButton(OrderHallTalentFrameCloseButton)
	OrderHallTalentFrame:HookScript("OnShow", function(self)
		if self.CloseButton.Border then
			self.CloseButton.Border:Hide()
		end
		if self.portrait then
			self.portrait:Hide()
		end
		if self.skinned then return end
		self.Currency.Icon:SkinIcon()
		self.Background:ClearAllPoints()
		self.Background:SetPoint("TOPLEFT")
		self.Background:SetPoint("BOTTOMRIGHT")
		self.Background:SetDrawLayer("BACKGROUND", 2)
		self.BackButton:SkinButton()

		for i = 1, self:GetNumChildren() do
			local child = select(i, self:GetChildren())
			if child and child.Icon and child.DoneGlow and not child.backdrop then
				child:StyleButton()
				child:CreateBackdrop()
				child.Border:SetAlpha(0)
				child.Highlight:SetAlpha(0)
				child.AlphaIconOverlay:SetTexture(nil)
				child.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				child.Icon:SetInside(child.backdrop)
				child.hover:SetInside(child.backdrop)
				child.pushed:SetInside(child.backdrop)
				child.backdrop:SetFrameLevel(child.backdrop:GetFrameLevel()+1)

				child.darkOverlay = child:CreateTexture()
				child.darkOverlay:SetAllPoints(child.Icon)
				child.darkOverlay:SetDrawLayer('OVERLAY')
				child.darkOverlay:Hide()

				colorBorder(child, child.backdrop, child.Border:GetAtlas())

				child.TalentDoneAnim:HookScript("OnFinished", function()
					child.Border:SetAlpha(0) -- clear the yellow glow border again, after it finishes the animation
				end)
			end
		end

		self.choiceTexturePool:ReleaseAll()
		hooksecurefunc(self, "RefreshAllData", function(frame)
			frame.choiceTexturePool:ReleaseAll()

			for i = 1, frame:GetNumChildren() do
				local child = select(i, frame:GetChildren())
				if child and child.Icon and child.Border and child.backdrop then
					colorBorder(child, child.backdrop, child.Border:GetAtlas())
				end
			end
		end)

		self.skinned = true
	end)
end

T.SkinFuncs["Blizzard_OrderHallUI"] = LoadSkin