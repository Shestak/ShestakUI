local T, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Switch layout mouseover button on minimap
----------------------------------------------------------------------------------------
local switch = CreateFrame("Button", "SwitchLayout", UIParent)
switch:SetTemplate("Transparent")
if C.actionbar.toggle_mode == true then
	switch:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -3, 18)
else
	switch:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -3, -2)
end
switch:SetSize(19, 19)
switch:SetAlpha(0)

switch.t = switch:CreateTexture(nil, "OVERLAY")
switch.t:SetTexture("Interface\\LFGFrame\\LFGROLE")
switch.t:SetPoint("TOPLEFT", switch, 2, -2)
switch.t:SetPoint("BOTTOMRIGHT", switch, -2, 2)

switch:EnableMouse(true)
switch:RegisterForClicks("AnyUp")
switch:SetScript("OnClick", function(self, button)
	if button == "LeftButton" then
		if SavedOptions.PerChar == true then
			SavedOptionsPerChar.RaidLayout = "HEAL"
		else
			SavedOptions.RaidLayout = "HEAL"
		end
		ReloadUI()
	elseif button == "RightButton" then
		if SavedOptions.PerChar == true then
			SavedOptionsPerChar.RaidLayout = "DPS"
		else
			SavedOptions.RaidLayout = "DPS"
		end
		ReloadUI()
	elseif button == "MiddleButton" then
		if SavedOptions.PerChar == true then
			SavedOptionsPerChar.RaidLayout = "NONE"
		else
			SavedOptions.RaidLayout = "NONE"
		end
		ReloadUI()
	end
end)

switch:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	switch:FadeIn()
	GameTooltip:SetOwner(switch, "ANCHOR_LEFT")
	GameTooltip:AddLine(RAID_FRAMES_LABEL)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L_MINIMAP_HEAL_LAYOUT)
	GameTooltip:AddLine(L_MINIMAP_DPS_LAYOUT)
	GameTooltip:AddLine(L_MINIMAP_BLIZZ_LAYOUT)
	GameTooltip:Show()
end)

switch:SetScript("OnLeave", function()
	switch:FadeOut()
	GameTooltip:Hide()
end)

switch:RegisterEvent("PLAYER_LOGIN")
switch:SetScript("OnEvent", function(self)
	if (SavedOptions and SavedOptions.PerChar == false and SavedOptions.RaidLayout == "DPS") or (SavedOptionsPerChar and SavedOptions.PerChar == true and SavedOptionsPerChar.RaidLayout == "DPS") then
		if C.media.dps then
			switch.t:SetTexture(C.media.dps)
			switch.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		else
			switch.t:SetTexCoord(0.25, 0.5, 0, 1)
		end
	elseif (SavedOptions and SavedOptions.PerChar == false and SavedOptions.RaidLayout == "HEAL") or (SavedOptionsPerChar and SavedOptions.PerChar == true and SavedOptionsPerChar.RaidLayout == "HEAL") then
		if C.media.healer then
			switch.t:SetTexture(C.media.healer)
			switch.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		else
			switch.t:SetTexCoord(0.75, 1, 0, 1)
		end
	elseif (SavedOptions and SavedOptions.PerChar == false and SavedOptions.RaidLayout == "NONE") or (SavedOptionsPerChar and SavedOptions.PerChar == true and SavedOptionsPerChar.RaidLayout == "NONE") then
		switch.t:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-Blizz")
		switch.t:SetTexCoord(0.2, 0.8, -0.1, 1.1)
	else
		switch.t:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01")
		switch.t:SetTexCoord(0.2, 0.8, 0.2, 0.8)
	end
end)

----------------------------------------------------------------------------------------
--	Switch theme mouseover button on minimap
----------------------------------------------------------------------------------------
local theme = CreateFrame("Button", "SwitchTheme", UIParent)
theme:SetTemplate("Transparent")
theme:SetPoint("BOTTOM", switch, "TOP", 0, 1)
theme:SetSize(19, 19)
theme:SetAlpha(0)

theme.t = theme:CreateTexture(nil, "OVERLAY")
theme.t:SetTexture(C.media.blank)
theme.t:SetVertexColor(unpack(C.skins.color_theme))
theme.t:SetPoint("TOPLEFT", theme, 2, -2)
theme.t:SetPoint("BOTTOMRIGHT", theme, -2, 2)

local function ThemeSetup(r, g, b)
	if not GUIConfigAll then return end
	if GUIConfigAll[T.realm][T.name] == true then
		if GUIConfig == nil then GUIConfig = {} end
		if GUIConfig["skins"] == nil then GUIConfig["skins"] = {} end
		GUIConfig["skins"]["color_theme"] = {r, g, b}
	else
		if GUIConfigSettings == nil then GUIConfigSettings = {} end
		if GUIConfigSettings["skins"] == nil then GUIConfigSettings["skins"] = {} end
		GUIConfigSettings["skins"]["color_theme"] = {r, g, b}
	end
end

local menuFrame = CreateFrame("Frame", "MinimapSwitchThemeButton", UIParent, "UIDropDownMenuTemplate")
local thememenu = {
	{text = L_MINIMAP_THEME, isTitle = 1, notCheckable = 1, notClickable = 1},
	{text = L_INSTALL_STEP3_RED, notCheckable = 1, func = function()
		ThemeSetup(0.9, 0.2, 0.2)
		ReloadUI()
	end},
	{text = L_INSTALL_STEP3_GREEN, notCheckable = 1, func = function()
		ThemeSetup(0.3, 0.9, 0.3)
		ReloadUI()
	end},
	{text = L_INSTALL_STEP3_BLUE, notCheckable = 1, func = function()
		ThemeSetup(0.1, 0.5, 0.9)
		ReloadUI()
	end},
	{text = format("|cff%02x%02x%02x%s|r", 255 * T.color.r, 255 * T.color.g, 255 * T.color.b, L_INSTALL_STEP3_CLASS), notCheckable = 1, func = function()
		ThemeSetup(T.color.r, T.color.g, T.color.b)
		ReloadUI()
	end},
}

theme:EnableMouse(true)
theme:SetScript("OnClick", function()
	EasyMenu(thememenu, menuFrame, "cursor", 0, 0, "MENU")
end)

theme:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	theme:FadeIn()
end)

theme:SetScript("OnLeave", function()
	theme:FadeOut()
end)

----------------------------------------------------------------------------------------
--	Farm mode for minimap(by Elv22)
----------------------------------------------------------------------------------------
local show = false
SlashCmdList.FARMMODE = function()
	if show == false then
		MinimapAnchor:SetSize(C.minimap.size * 1.65, C.minimap.size * 1.65)
		Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
		show = true
	else
		MinimapAnchor:SetSize(C.minimap.size, C.minimap.size)
		Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())
		show = false
	end
end
SLASH_FARMMODE1 = "/farmmode"
SLASH_FARMMODE2 = "/афкььщву"
SLASH_FARMMODE3 = "/fm"
SLASH_FARMMODE4 = "/аь"

----------------------------------------------------------------------------------------
--	Farm mode mouseover button(by m2jest1c)
----------------------------------------------------------------------------------------
local farm = CreateFrame("Button", "FarmMode", UIParent)
farm:SetTemplate("Default")
farm:SetPoint("BOTTOM", theme, "TOP", 0, 1)
farm:SetSize(19, 19)
farm:SetAlpha(0)

farm.t = farm:CreateTexture(nil, "OVERLAY")
farm.t:SetTexture("Interface\\Icons\\inv_misc_map_01")
farm.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
farm.t:SetPoint("TOPLEFT", farm, 2, -2)
farm.t:SetPoint("BOTTOMRIGHT", farm, -2, 2)

farm:SetScript("OnClick", function()
	SlashCmdList.FARMMODE()
end)

farm:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	farm:FadeIn()
end)

farm:SetScript("OnLeave", function()
	farm:FadeOut()
end)