local T, C, L = unpack(select(2, ...))
if T.class ~= "PALADIN" or T.level < 3 then return end

----------------------------------------------------------------------------------------
--	Paladin seals menu(by Foof and Tohveli)
----------------------------------------------------------------------------------------
local spells = {
	[1] = {20165,20165},
	[2] = {20154,20154},
	[3] = {20164,20164},
	[4] = {31801,31801},
}

local f = CreateFrame("Frame", "SealMenu", UIParent)
f:CreatePanel("Default", C.minimap.size, #spells * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
f:SetBackdropBorderColor(0, 0, 0, 0)
f:SetBackdropColor(0, 0, 0, 0)
tinsert(UISpecialFrames, "SealMenu")

for i, spell in pairs(spells) do
	local seal = GetSpellInfo(spell[1])
 
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	b:CreatePanel("Transparent", C.minimap.size, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	b:SetFrameStrata("HIGH")
 
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	l:SetText(seal)
	b:SetFontString(l)
 
	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", seal)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", seal)
end
f:Hide()

local b = CreateFrame("Button", nil, UIParent)
b:SetTemplate("ClassColor")
b:Point("TOPLEFT", Minimap, "TOPLEFT")
b:Width(20)
b:Height(20)
b:SetAlpha(0)

local bt = b:CreateTexture(nil, "OVERLAY")
bt:SetTexture("Interface\\Icons\\Spell_Holy_RighteousnessAura")
bt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
bt:Point("TOPLEFT", b, 2, -2)
bt:Point("BOTTOMRIGHT", b, -2, 2)

b:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["SealMenu"]:IsShown() then
			_G["SealMenu"]:Hide()
		else
			_G["SealMenu"]:Show()
		end
		if _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end
end)

b:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	b:FadeIn()
end)

b:SetScript("OnLeave", function()
	b:FadeOut()
end)

f:RegisterEvent("UNIT_SPELLCAST_SENT")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)