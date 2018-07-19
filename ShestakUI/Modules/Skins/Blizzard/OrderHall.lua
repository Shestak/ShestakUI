local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

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
			for i, child in ipairs({self:GetChildren()}) do
				if child.Icon and child.Count and child.TroopPortraitCover then
					index = index + 1
					child.TroopPortraitCover:Hide()
					child.Icon:SetSize(38, 21)
				end
			end
			self:SetWidth(270 + index * 112)
		end)
	end)

	-- TalentFrame
	OrderHallTalentFrame:StripTextures()
	OrderHallTalentFrame:SetTemplate("Transparent")
	T.SkinCloseButton(OrderHallTalentFrameCloseButton)
	ClassHallTalentInset:StripTextures()
	OrderHallTalentFrame.Currency:SetFont(C["media"].normal_font, 16)
	OrderHallTalentFrame.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
end

T.SkinFuncs["Blizzard_OrderHallUI"] = LoadSkin