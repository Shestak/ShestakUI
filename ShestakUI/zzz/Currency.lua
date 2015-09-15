local T, C, L, _ = unpack(select(2, ...))
if C.zzz.Currency ~= true then return end

----------------------------------------------------------------------------------------
--	常用货币显示
----------------------------------------------------------------------------------------
local x, y, point = 350, 3, "BOTTOMLEFT"	--位置
local f = CreateFrame("Frame")
local Currency = {
	390,
	392,
	994,	--钢化命运印记
	1129,	--既定命运徽记
	823,	--埃匹希斯水晶
	824,	--要塞物资
	1101	--原油
} 
f.icon = {} 

for i = 1, #Currency do 
	local icon = CreateFrame("Frame", nil, UIParent) 
	icon:SetPoint(point, UIParent, point, 50*i+3*(i+1)+x, y) 
	icon:SetSize(13, 13)
	icon.texture = icon:CreateTexture(nil, "ARTWORK") 
	icon.texture:SetAllPoints(icon) 
	icon.texture:SetTexCoord(.1, .9, .1, .9) 
	icon.text = icon:CreateFontString() 
	icon.text:SetPoint("LEFT", icon, "RIGHT", 1, 0) 
	icon.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE") 
	icon.text:SetShadowOffset(1, 1) 
	icon.text:SetShadowColor(0,0,0,.7) 
	f.icon[i] = icon 
end 

local GetCurrencyInfo, select, sub = GetCurrencyInfo, select, string.sub 

for i = 1, #Currency do 
	local label, _, icon = GetCurrencyInfo(Currency[i]) 
	f.icon[i].texture:SetTexture(icon) 
	f.icon[i]:SetScript("OnEnter", function() 
		_G["GameTooltip"]:ClearLines() 
		_G["GameTooltip"]:SetOwner(f.icon[i], "ANCHOR_LEFT") 
		_G["GameTooltip"]:AddLine(sub(label, 1, 6)) 
		_G["GameTooltip"]:Show() 
	end)
	f.icon[i]:SetScript("OnLeave", function() 
		_G["GameTooltip"]:Hide() 
	end) 
end 

f:RegisterEvent("CURRENCY_DISPLAY_UPDATE") 
f:SetScript("OnEvent", function() 
	for i = 1, #Currency do 
		f.icon[i].text:SetText(select(2, GetCurrencyInfo(Currency[i]))) 
	end 
end)