----------------------------------------------------------------------------------------
--	By Foof and Tohveli
----------------------------------------------------------------------------------------
if SettingsDB.class ~= "PALADIN" then return end
 
local spells = {
	[1] = {20165,20165},
	[2] = {20154,20154},
	[3] = {20164,20164},
	[4] = {31801,31801},
}

local f = CreateFrame("Frame", "SealMenu", UIParent)
SettingsDB.CreatePanel(f, SettingsCF["minimap"].size + 4, #spells * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
f:SetBackdropBorderColor(0, 0, 0, 0)
f:SetBackdropColor(0, 0, 0, 0)
f.bg:SetVertexColor(0, 0, 0, 0)

for i, spell in pairs(spells) do
	local seal = GetSpellInfo(spell[1])
 
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	SettingsDB.CreateFadedPanel(b, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	b:SetFrameStrata("HIGH")
 
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
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
SettingsDB.SkinFadedPanel(b)
b:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
b:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
b:SetWidth(SettingsDB.Scale(20))
b:SetHeight(SettingsDB.Scale(20))
b:SetAlpha(0)

local bt = b:CreateTexture(nil, "BORDER")
bt:SetTexture("Interface\\Icons\\Spell_Holy_RighteousnessAura")
bt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
bt:SetPoint("TOPLEFT", b, SettingsDB.Scale(2), SettingsDB.Scale(-2))
bt:SetPoint("BOTTOMRIGHT", b, SettingsDB.Scale(-2), SettingsDB.Scale(2))

b:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["SealMenu"]:IsShown() then
			_G["SealMenu"]:Hide()
		else
			_G["SealMenu"]:Show()
		end
	end
end)

b:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	SettingsDB.FadeIn(b)
end)

b:SetScript("OnLeave", function()
	SettingsDB.FadeOut(b)
end)

f:RegisterEvent("UNIT_SPELLCAST_SENT")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)