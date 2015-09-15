-- [ Skada 按钮；左键显示/关闭；右键清除数据 ]--
local T, C, L, _ = unpack(select(2, ...))
if  C.zzz.MicroButton ~= true then return end

--cfg
local cfont = "Fonts\\ARIALN.ttf"
local bsize = 16  --button大小定義
local tsize = 13  --Text大小定義

local function CreateButton(btn, text)
	
	btn:SetTemplate("Default")
	btn:SetWidth(bsize)
	btn:SetHeight(bsize)
--[[
	btn.t = btn:CreateTexture(nil, "ARTWORK")
	btn.t:SetTexture(T.media.blank)
	btn.t:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
	btn.t:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
	--btn.t:SetVertexColor(unpack(T.mycolor))
]]--
	btn.f = btn:CreateFontString("rollText", "OVERLAY")
	btn.f:SetFont(cfont, 13, "OUTLINE")
	btn.f:SetJustifyH("CENTER")
	btn.f:SetWidth(tsize)
	btn.f:SetHeight(tsize)
	btn.f:SetText(text) -- 显示的文字
	btn.f:SetPoint("CENTER")
	btn.f:SetTextColor(unpack(T.color)) -- 颜色
end

----------------------------------------------------------------------------------------------------
-- Create Skada Button
----------------------------------------------------------------------------------------------------
local Skada_btn = CreateFrame("Button", "Skada_btn", UIParent)
Skada_btn:SetAlpha(0)
CreateButton(Skada_btn, "S")
Skada_btn:SetPoint("bottomright", UIParent, "bottomright", -2, 2)

if IsAddOnLoaded("Skada") then
	Skada_btn:SetScript("OnMouseDown", function(_, btn)
	if btn == "LeftButton" then
			if SkadaBarWindowSkada:IsShown() then
				SkadaBarWindowSkada:Hide()
			else
				SkadaBarWindowSkada:Show()
			end
	end
	if btn == "RightButton" then
	Skada:Reset()
	end
	end)
end

Skada_btn:SetScript("OnEnter", function(self, ...)
	self:FadeIn()
end)
Skada_btn:SetScript("OnLeave", function(self, ...)
	self:FadeOut()
end)


----------------------------------------------------------------------------------------------------
-- Create Roll Button
----------------------------------------------------------------------------------------------------
local Roll = CreateFrame("Button", "Roll_btn", UIParent)
Roll:SetAlpha(0)
CreateButton(Roll, "R")
Roll:SetPoint("bottomleft",UIParent,"bottomleft", 2, 2)

Roll:SetScript("OnMouseDown", function(self, btn)
	if btn == "LeftButton" then
		RandomRoll(1, 100)
	end
end)

Roll:SetScript("OnEnter", function(self, ...)
	self:FadeIn()
end)
Roll:SetScript("OnLeave", function(self, ...)
	self:FadeOut()
end)