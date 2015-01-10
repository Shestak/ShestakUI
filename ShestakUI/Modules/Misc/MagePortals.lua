local T, C, L, _ = unpack(select(2, ...))
if T.class ~= "MAGE" or T.level < 17 then return end

----------------------------------------------------------------------------------------
--	Mage portals menu(by Foof and Tohveli)
----------------------------------------------------------------------------------------
if T.client == "zhCN" then
	Portalname = {"暴风城", "铁炉堡", "达纳苏斯", "埃索达", "塞拉摩", "撒塔斯", "达拉然", "托尔巴拉德", "远古达拉然", "锦绣谷", "暴風之盾", "奥格瑞玛", "幽暗城", "雷霆崖", "银月城", "斯通纳德", "战争之矛"}
elseif T.client == "zhTW" then
	Portalname = {"暴風城", "鐵爐堡", "達納蘇斯", "艾克索達", "塞拉摩", "撒塔斯", "達拉然", "托巴拉德", "遠古達拉然", "恆春谷", "暴風之盾", "奧格瑪", "幽暗城", "雷霆崖", "銀月城", "斯通納德", "戰爭之矛"}
else
	Portalname = nil
end

local spells = (UnitFactionGroup("player") == "Horde") and {
	[1] = {3567,11417, Portalname[12]},		-- Orgrimmar
	[2] = {3563,11418, Portalname[13]},		-- Undercity
	[3] = {3566,11420, Portalname[14]},		-- Thunder Bluff
	[4] = {32272,32267, Portalname[15]},	-- Silvermoon
	[5] = {49358,49361, Portalname[16]},	-- Stonard
	[6] = {35715,35717, Portalname[6]},	-- Shattrath
	[7] = {53140,53142, Portalname[7]},	-- Dalaran
	[8] = {88344,88346, Portalname[8]},	-- Tol Barad
	[9] = {120145,120146, Portalname[9]},	-- Ancient Dalaran
	[10] = {132627,132626, Portalname[10]},	-- Vale of Eternal Blossoms
	[11] = {176242,176244, Portalname[17]},	-- Warspear
} or { -- Alliance
	[1] = {3561,10059, Portalname[1]},		-- Stormwind
	[2] = {3562,11416, Portalname[2]},		-- Ironforge
	[3] = {3565,11419, Portalname[3]},		-- Darnassus
	[4] = {32271,32266, Portalname[4]},	-- Exodar
	[5] = {49359,49360, Portalname[5]},	-- Theramore
	[6] = {33690,33691, Portalname[6]},	-- Shattrath
	[7] = {53140,53142, Portalname[7]},	-- Dalaran
	[8] = {88342,88345, Portalname[8]},	-- Tol Barad
	[9] = {120145,120146, Portalname[9]},	-- Ancient Dalaran
	[10] = {132621,132620, Portalname[10]},	-- Vale of Eternal Blossoms
	[11] = {176248,176246, Portalname[11]},	-- Stormshield
}

local frame = CreateFrame("Frame", "TeleportMenu", UIParent)
frame:CreatePanel("Invisible", C.minimap.size, (#spells) * 20 + 4, "BOTTOMLEFT", Minimap, "TOPLEFT", -2, 3)
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:SetScript("OnEvent", function(self)
	if self:IsShown() then
		self:Hide()
	end
end)
frame:Hide()
tinsert(UISpecialFrames, "TeleportMenu")

for i, spell in pairs(spells) do
	local teleport = GetSpellInfo(spell[1])

	local b = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	b:CreatePanel("Transparent", C.minimap.size, 20, "BOTTOMLEFT", frame, "BOTTOMLEFT", 0, ((i - 1) * 21))
	b:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	b:SetFrameStrata("HIGH")

	local l = b:CreateFontString("TeleportMenuName"..i, "OVERLAY")
	l:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	if (T.client == "zhCN") or (T.client == "zhTW") then
		l:SetText(spell[3])
	else
		l:SetText(string.sub(teleport, string.find(teleport, ":") + 1))
	end
	b:SetFontString(l)

	b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	b:SetAttribute("type1", "spell")
	b:SetAttribute("spell1", teleport)
	b:SetAttribute("type2", "spell")
	b:SetAttribute("spell2", GetSpellInfo(spell[2]))
end

local learnSpell = CreateFrame("Frame")
learnSpell:RegisterEvent("PLAYER_LOGIN")
learnSpell:RegisterEvent("LEARNED_SPELL_IN_TAB")
learnSpell:SetScript("OnEvent", function()
	for i, spell in pairs(spells) do
		if not IsSpellKnown(spell[1]) then
			_G["TeleportMenuName"..i]:SetTextColor(0.4, 0.4, 0.4)
		else
			_G["TeleportMenuName"..i]:SetTextColor(1, 1, 1)
		end
	end
end)

local button = CreateFrame("Button", nil, UIParent)
button:SetTemplate("ClassColor")
button:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
button:SetSize(20, 20)
button:SetAlpha(0)

button.t = button:CreateTexture(nil, "OVERLAY")
button.t:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
button.t:SetPoint("TOPLEFT", button, 2, -2)
button.t:SetPoint("BOTTOMRIGHT", button, -2, 2)

button:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["TeleportMenu"]:IsShown() then
			_G["TeleportMenu"]:Hide()
		else
			_G["TeleportMenu"]:Show()
		end
		if C.minimap.toggle_menu and _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if C.minimap.toggle_menu and _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end
end)

button:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	button:FadeIn()
end)

button:SetScript("OnLeave", function()
	button:FadeOut()
end)
