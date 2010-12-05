----------------------------------------------------------------------------------------
--	By Foof and Tohveli
----------------------------------------------------------------------------------------
if SettingsDB.class ~= "MAGE" or SettingsDB.level < 19 then return end
 
local spells = (UnitFactionGroup("player") == "Horde") and {
		[1] = {3567,11417},		-- Orgrimmar
		[2] = {3563,11418},		-- Undercity
		[3] = {3566,11420},		-- Thunder Bluff
		[4] = {32272,32267},	-- Silvermoon
		[5] = {49358,49361},	-- Stonard
		[6] = {35715,35717},	-- Shattrath
		[7] = {53140,53142},	-- Dalaran
		[8] = {88344,88346},	-- Tol Barad
	} or { -- ALLIANCE
		[1] = {3561,10059},		-- Stormwind
		[2] = {3562,11416},		-- Ironforge
		[3] = {3565,11419},		-- Darnassus
		[4] = {32271,32266},	-- Exodar
		[5] = {49359,49360},	-- Theramore
		[6] = {33690,33691},	-- Shattrath
		[7] = {53140,53142},	-- Dalaran
		[8] = {88342,88345},	-- Tol Barad
	};

local f = CreateFrame("Frame", "TeleportMenu", UIParent)
SettingsDB.CreatePanel(f, SettingsCF["minimap"].size + 4, (#spells+1) * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
f:SetBackdropBorderColor(0, 0, 0, 0)
f:SetBackdropColor(0, 0, 0, 0)
f.bg:SetVertexColor(0, 0, 0, 0)

local r = CreateFrame("Frame", nil, f)
SettingsDB.CreateFadedPanel(r, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
r:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)

local l = r:CreateFontString("TeleportMenuReagentText", "OVERLAY", nil)
l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
l:SetPoint("CENTER", r, "CENTER")

for i, spell in pairs(spells) do
	local teleport = GetSpellInfo(spell[1])
 
	local b = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
	SettingsDB.CreateFadedPanel(b, SettingsCF["minimap"].size + 4, 20, "BOTTOMLEFT", f, "BOTTOMLEFT", 0, (i * 21))
	b:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	b:SetFrameStrata("HIGH")
 
	local l = b:CreateFontString(nil, "OVERLAY", nil)
	l:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
	l:SetText(string.sub(teleport, string.find(teleport,":") + 1))
	b:SetFontString(l)
 
	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", teleport)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
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
bt:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
bt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
bt:SetPoint("TOPLEFT", b, SettingsDB.Scale(2), SettingsDB.Scale(-2))
bt:SetPoint("BOTTOMRIGHT", b, SettingsDB.Scale(-2), SettingsDB.Scale(2))

b:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["TeleportMenu"]:IsShown() then
			_G["TeleportMenu"]:Hide()
		else
			_G["TeleportMenuReagentText"]:SetText(MINIMAP_TRACKING_VENDOR_REAGENT..": [ "..GetItemCount(17031).." ] | [ "..GetItemCount(17032).." ]")
			_G["TeleportMenu"]:Show()
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

f:RegisterEvent("UNIT_SPELLCAST_START")
f:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)