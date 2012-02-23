local T, C, L = unpack(select(2, ...))
if C.minimap.toggle_menu ~= true then return end

----------------------------------------------------------------------------------------
-- Toggle menu(by Hydra, Foof, Gorlasch and HyPeRnIcS)
----------------------------------------------------------------------------------------
C["togglemenu"] = {
	-- Style
	["buttonwidth"] = C.minimap.size - 6,	-- Width of menu buttons
	["buttonheight"] = 20,					-- Height of menu buttons
	["buttonspacing"] = 3,					-- Spacing of menu buttons
	-- Menus
	["defaultIsToggleOnly"] = true,			-- Sets the default value for the addon menu (true - toggle-only, false - enhanced version)
	["dontShowToggleOnlyMenu"] = false,		-- Always show enhanced addon menu
	["mergeMenus"] = C.minimap.merge_menus,	-- Merge main and addon menu
	["maxMenuEntries"] = 30,				-- Maximum number of menu entries per column (0 - unlimited number)
	-- Access
	["showByDefault"] = false,				-- Show the menu by default
	["addOpenMenuButton"] = true,			-- Creates a mouseover button to open the menu
}

-- Override prefix method to collapse addons
C["toggleprefix"] = {
--  prefix            parent addon
	["DBM"]			= "DBM-Core",
	["ShestakUI"]	= "ShestakUI",
	["Auc-"]		= "Auc-Advanced",
	["!Swatter"]	= "Auc-Advanced",
	["BeanCounter"]	= "Auc-Advanced",
	["Enchantrix"]	= "Auc-Advanced",
	["Informant"]	= "Auc-Advanced",
	["SlideBar"]	= "Auc-Advanced",
	["Stubby"]		= "Auc-Advanced",
}

-- Define buttons in main menu and corresponding functions
C["togglemainmenu"] = {
	{	["text"] = CLOSE,
		["function"] = function()
			ToggleMenu_Toggle()
		end
	},
	{	["text"] = ADDONS,
		["function"] = function()
			ToggleFrame(TTMenuAddOnBackground)
			ToggleFrame(TTMenuBackground)
		end
	},
	{	["text"] = HELP_LABEL,
		["function"] = function()
			SlashCmdList.UIHELP()
		end
	},
	{	["text"] = L_ALOAD_RL,
		["function"] = function()
			ReloadUI()
		end
	},
	{	["text"] = "Move UI",
		["function"] = function()
			SlashCmdList.MOVING()
		end
	},
}

-- Definde toggle functions
C["toggleaddons"] = {
	-- Damage Meters
	["alDamageMeter"] = function()
		ToggleFrame(alDamageMeterFrame)
	end,
	["Recount"] = function()
		ToggleFrame(Recount.MainWindow)
		Recount.RefreshMainWindow()
	end,
	["Skada"] = function()
		Skada:ToggleWindow()
	end,
	["TinyDPS"] = function()
		ToggleFrame(tdpsFrame)
	end,
	-- Threat Meters
	["Omen"] = function()
		ToggleFrame(Omen.Anchor)
	end,
	-- Boss Addons
	["BigWigs"] = function()
		SlashCmdList.BigWigs()
	end,
	["DBM-Core"] = function()
		DBM:LoadGUI()
	end,
	["DXE"] = function()
		_G.DXE:ToggleConfig()
	end,
	["PhoenixStyle"] = function()
		PS_MinimapButton:Click()
	end,
	["RaidAchievement"] = function()
		RA_MinimapButton:Click()
	end,
	-- Other Addons
	["Archy"] = function()
		ToggleFrame(ArchyDigSiteFrame)
		ToggleFrame(ArchyArtifactFrame)
	end,
	["stArchaeologist"] = function()
		SlashCmdList.STARCHAEOLOGIST()
		if _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end,
	["AtlasLoot"] = function()
		ToggleFrame(AtlasLootDefaultFrame)
	end,
	["GatherMate2"] = function()
		GatherMate2.db.profile["showMinimap"] = not GatherMate2.db.profile["showMinimap"]
		GatherMate2.db.profile["showWorldMap"] = not GatherMate2.db.profile["showWorldMap"]
		GatherMate2:GetModule("Config"):UpdateConfig()
	end,
	["ShestakUI_Config"] = function()
		SlashCmdList.CONFIG()
	end,
	["Panda"] = function()
		ToggleFrame(PandaPanel)
	end,
	["PallyPower"] = function()
		ToggleFrame(PallyPowerFrame)
	end,
	["ACP"] = function()
		ToggleFrame(ACP_AddonList)
	end,
	["ScrollMaster"] = function()
		LibStub("AceAddon-3.0"):GetAddon("ScrollMaster").GUI:OpenFrame(1)
	end,
	["PugLax"] = function()
		T.RunSlashCmd("/puglax")
	end,
	["epgp"] = function()
		EPGP:ToggleUI()
	end,
	["WIM"] = function()
		WIM.ShowAllWindows()
	end,
	["!BaudErrorFrame"] = function()
		SlashCmdList.BaudErrorFrame()
	end,
	["RollTracker"] = function()
		T.RunSlashCmd("/rolltracker")
	end,
	["CoolLine"] = function()
		T.RunSlashCmd("/coolline")
	end,
	["PreformAVEnabler"] = function()
		SlashCmdList.PREFORMAV()
	end,
}

-- Button size
local function buttonwidth(num)
	return num * C.togglemenu.buttonwidth
end
local function buttonheight(num)
	return num * C.togglemenu.buttonheight
end
local function buttonspacing(num)
	return num * C.togglemenu.buttonspacing
end
local function borderwidth(num)
	return buttonwidth(num) + buttonspacing(num + 1)
end
local function borderheight(num)
	return buttonheight(num) + buttonspacing(num + 1)
end
local defaultframelevel = 0

local function updateTextures(button, checkable)
	button:StyleButton(checkable)
	if checkable then
		button:GetCheckedTexture():SetTexture(1, 1, 1, 0.3)
	end
	button:GetHighlightTexture():SetTexture(0, 0, 0, 0)
	button:GetPushedTexture():SetTexture(0, 0, 0, 0)
	button:HookScript("OnEnter", T.SetModifiedBackdrop)
	button:HookScript("OnLeave", T.SetOriginalBackdrop)
end

local MenuBG = CreateFrame("Frame", "TTMenuBackground", UIParent)
local AddonBG = CreateFrame("Frame", "TTMenuAddOnBackground", UIParent)
MenuBG:CreatePanel("Transparent", borderwidth(1), 1, "BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 3)
AddonBG:CreatePanel("Transparent", borderwidth(1), 1, "BOTTOMRIGHT", MenuBG, "BOTTOMRIGHT", 0, 0)
MenuBG:SetFrameLevel(defaultframelevel)
MenuBG:SetFrameStrata("HIGH")
if not C.togglemenu.showByDefault or C.togglemenu.mergeMenus then
	MenuBG:Hide()
end
AddonBG:SetFrameLevel(defaultframelevel)
AddonBG:SetFrameStrata("HIGH")
if not C.togglemenu.showByDefault or not C.togglemenu.mergeMenus then
	AddonBG:Hide()
end
MenuBG:EnableMouse(true)
AddonBG:EnableMouse(true)
tinsert(UISpecialFrames, "TTMenuBackground")
tinsert(UISpecialFrames, "TTMenuAddOnBackground")

function ToggleMenu_Toggle()
	if TTMenuAddOnBackground:IsShown() or TTMenuBackground:IsShown() then
		TTMenuAddOnBackground:Hide()
		TTMenuBackground:Hide()
	else
		if C.togglemenu.mergeMenus then
			TTMenuAddOnBackground:Show()
		else
			TTMenuBackground:Show()
		end
		if C.togglemenu.addOpenMenuButton then
			TTOpenMenuBackground:FadeOut()
		end
	end
end

-- Add slash command
SLASH_UITOGGLEMENU1 = "/ttm"
SlashCmdList.UITOGGLEMENU = ToggleMenu_Toggle

local mainmenusize
local lastMainMenuEntryID
local totalmainmenusize
local function addMainMenuButtons(menuItems, menuName, menuBackground)
	lastMainMenuEntryID = 0
	mainmenusize = 0

	local function InsertButton(items, i, hide)
		if hide then
			items[i]:Hide()
		else
			lastMainMenuEntryID = i
			mainmenusize = mainmenusize + 1
		end
	end

	for index, value in ipairs(C.togglemainmenu) do
		if value.text then
			menuItems[index] = CreateFrame("Button", menuName..index, menuBackground)
			menuItems[index]:CreatePanel("Overlay", buttonwidth(1), buttonheight(1), "BOTTOM", menuBackground, "BOTTOM", 0, buttonspacing(-1))
			menuItems[index]:SetFrameLevel(defaultframelevel + 1)
			menuItems[index]:SetFrameStrata("HIGH")
			if mainmenusize == 0 then
				menuItems[index]:SetPoint("BOTTOMLEFT", menuBackground, "BOTTOMLEFT", buttonspacing(1), buttonspacing(1))
			else
				menuItems[index]:SetPoint("BOTTOM", menuItems[lastMainMenuEntryID], "TOP", 0, buttonspacing(1))
			end
			menuItems[index]:EnableMouse(true)
			menuItems[index]:RegisterForClicks("AnyUp")
			menuItems[index]:SetScript("OnClick", function() value["function"]() end)

			Text = menuItems[index]:CreateFontString(nil, "OVERLAY")
			Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
			Text:SetPoint("CENTER", menuItems[index], 0, 0)
			Text:SetText(value.text)

			local hideItem = (C.togglemenu.mergeMenus and (value.text == ADDONS))
			InsertButton(menuItems, index, hideItem)
			updateTextures(menuItems[index])
			totalmainmenusize = index
		end
	end
end

-- Main buttons
local menu = {}
addMainMenuButtons(menu, "Menu", MenuBG)
MenuBG:SetHeight(borderheight(mainmenusize))

local addonmenuitems = {}
if C.togglemenu.mergeMenus then
	addMainMenuButtons(addonmenuitems, "AddonMenu", AddonBG)
else
	mainmenusize = 1
	lastMainMenuEntryID = 1
	totalmainmenusize = 1
	addonmenuitems[1] = CreateFrame("Button", "AddonMenuReturnButton", AddonBG)
	addonmenuitems[1]:CreatePanel("Overlay", buttonwidth(1), buttonheight(1), "BOTTOMLEFT", AddonBG, "BOTTOMLEFT", buttonspacing(1), buttonspacing(1))
	addonmenuitems[1]:EnableMouse(true)
	addonmenuitems[1]:RegisterForClicks("AnyUp")
	addonmenuitems[1]:SetFrameLevel(defaultframelevel + 1)
	addonmenuitems[1]:SetFrameStrata("HIGH")
	addonmenuitems[1]:SetScript("OnMouseUp", function() ToggleFrame(TTMenuAddOnBackground) ToggleFrame(TTMenuBackground) end)
	updateTextures(addonmenuitems[1])
	Text = addonmenuitems[1]:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	Text:SetPoint("CENTER", addonmenuitems[1], 0, 0)
	Text:SetText(BACK)
end

local OpenMenuBG = CreateFrame("Button", "TTOpenMenuBackground", UIParent)
OpenMenuBG:CreatePanel("Overlay", borderwidth(1), buttonheight(1) / 1.3, "BOTTOM", MenuBG, "BOTTOM", 0, 0)
OpenMenuBG:SetFrameLevel(defaultframelevel)
OpenMenuBG:SetFrameStrata("HIGH")
OpenMenuBG:EnableMouse(true)
OpenMenuBG:RegisterForClicks("AnyUp")
OpenMenuBG:SetFrameLevel(defaultframelevel)
OpenMenuBG:SetFrameStrata("HIGH")
OpenMenuBG:SetScript("OnMouseUp", function()
	ToggleMenu_Toggle()
	if (T.class == "MAGE" and T.level > 19) and _G["TeleportMenu"]:IsShown() then
		_G["TeleportMenu"]:Hide()
	end
	if (T.class == "PALADIN" and T.level > 3) and _G["SealMenu"]:IsShown() then
		_G["SealMenu"]:Hide()
	end
end)
OpenMenuBG:HookScript("OnEnter", function(self) self:FadeIn() end)
OpenMenuBG:HookScript("OnLeave", function(self) self:FadeOut() end)
--updateTextures(OpenMenuBG)
Text = OpenMenuBG:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Text:SetPoint("CENTER", OpenMenuBG, 0, 0)
Text:SetText("+ + +")
Text:SetTextColor(0.3, 0.3, 0.9)
if not C.togglemenu.addOpenMenuButton then
	TTOpenMenuBackground:Hide()
else
	TTOpenMenuBackground:FadeOut()
end

local expandbutton = CreateFrame("Button", "AddonMenuExpandButton", AddonBG)
expandbutton:CreatePanel("Overlay", buttonwidth(1), buttonheight(1) / 2, "TOP", AddonBG, "TOP", 0, buttonspacing(-1))
expandbutton:EnableMouse(true)
expandbutton:RegisterForClicks("AnyUp")
expandbutton:SetFrameLevel(defaultframelevel + 1)
expandbutton:SetFrameStrata("HIGH")
updateTextures(expandbutton)
Text = expandbutton:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Text:SetPoint("CENTER", expandbutton, 0, 0)
Text:SetText("+ + +")
Text:SetTextColor(0.3, 0.3, 0.9)
expandbutton.txt = Text
if C.togglemenu.dontShowToggleOnlyMenu then
	expandbutton:Hide()
	C.togglemenu.defaultIsToggleOnly = false
end

local addonInfo
local lastMainAddon = "XYZNonExistantDummyAddon"
local menusize
local lastMainAddonID = 0
if not addonInfo then
	addonInfo = {{}}
	for i = 1, GetNumAddOns() do
		name, title, _, enabled, _, _, _ = GetAddOnInfo(i)
		if name and enabled then
			addonInfo[i] = {["enabled"] = true, ["is_main"] = false, collapsed = true, ["parent"] = i}
		else
			addonInfo[i] = {["enabled"] = false, ["is_main"] = false, collapsed = true, ["parent"] = i}
		end
		-- Check special addon list first
		local addonFound = false
		for key, value in pairs(C["toggleprefix"]) do
			if strsub(name, 0, strlen(key)) == key then
				addonFound = true
				if name == value then
					lastMainAddon = name
					lastMainAddonID = i
					addonInfo[i].is_main = true
				else
					addonInfo[i].parent = lastMainAddonID
					for j = 1, GetNumAddOns() do
						name_j, _, _, _, _, _, _ = GetAddOnInfo(j)
						if name_j == value then
							addonInfo[i].parent = j
						end
					end
				end
			end
		end
		-- Collapse addons with common prefix
		if not addonFound then
			if strsub(name, 0, strlen(lastMainAddon)) == lastMainAddon then
				addonInfo[lastMainAddonID].is_main = true
				addonInfo[i].parent = lastMainAddonID
			else
				lastMainAddon = name
				lastMainAddonID = i
			end
		end
	end
end

local function addonEnableToggle(self, i)
	local was_enabled = addonInfo[i].enabled
	for j = 1, GetNumAddOns() do
		if (addonInfo[j].parent == i and addonInfo[i].collapsed) or (i == j and not addonInfo[addonInfo[i].parent].collapsed) then
			if was_enabled then
				DisableAddOn(j)
			else
				EnableAddOn(j)
			end
			addonInfo[j].enabled = not was_enabled
		end
	end
end

local function addonFrameToggle(self, i)
	local name, _, _, _, _, _, _ = GetAddOnInfo(i)
	if C.toggleaddons[name] then
		if IsAddOnLoaded(i) then
			C.toggleaddons[name]()
		end
	end
end

local addonToggleOnly = C.togglemenu.defaultIsToggleOnly

local function refreshAddOnMenu()
	menusize = mainmenusize
	for i = 1, GetNumAddOns() do
		local name, _, _, _, _, _, _ = GetAddOnInfo(i)
		if addonInfo[i].is_main or (addonInfo[i].parent == i) or not addonInfo[addonInfo[i].parent].collapsed then
			if not addonToggleOnly or (C.toggleaddons[name] and IsAddOnLoaded(i)) then
				menusize = menusize + 1
			end
		end
	end
	if C.togglemenu.maxMenuEntries and C.togglemenu.maxMenuEntries > 0 then
		menuwidth = ceil(menusize / C.togglemenu.maxMenuEntries)
	else
		menuwidth = 1
	end
	menuheight = ceil(menusize / menuwidth)

	local lastMenuEntryID = lastMainMenuEntryID
	menusize = mainmenusize
	for i = 1, GetNumAddOns() do
		j = totalmainmenusize + i
		local name, _, _, _, _, _, _ = GetAddOnInfo(i)
		addonmenuitems[j]:Hide()
		if addonInfo[i].is_main or addonInfo[i].parent == i or not addonInfo[addonInfo[i].parent].collapsed then
			if (not addonToggleOnly or (C.toggleaddons[name] and IsAddOnLoaded(i))) then
				addonmenuitems[j]:ClearAllPoints()
				if menusize % menuheight == 0 then
					addonmenuitems[j]:SetPoint("BOTTOMLEFT", addonmenuitems[1], "BOTTOMRIGHT", buttonspacing(1), 0)
				else
					addonmenuitems[j]:SetPoint("BOTTOM", addonmenuitems[lastMenuEntryID], "TOP", 0, buttonspacing(1))
				end
				addonmenuitems[j]:Show()
				lastMenuEntryID = j
				menusize = menusize + 1
			end
		end
		if addonInfo[i].is_main then
			if addonToggleOnly then
				addonmenuitems[j].expandbtn:Hide()
			else
				addonmenuitems[j].expandbtn:Show()
			end
		end
	end
	if not C.togglemenu.dontShowToggleOnlyMenu then
		AddonBG:SetHeight(borderheight(menuheight + 1) - buttonheight(1) / 2)
	else
		AddonBG:SetHeight(borderheight(menuheight))
	end
	AddonBG:SetWidth(borderwidth(menuwidth))
	expandbutton:SetWidth(buttonwidth(menuwidth) + buttonspacing(menuwidth - 1))
end

expandbutton:SetScript("OnMouseUp", function(self) 
	addonToggleOnly = not addonToggleOnly
	if addonToggleOnly then
		self.txt:SetText("+ + +")
		self.txt:SetTextColor(0.3, 0.3, 0.9)
	else
		self.txt:SetText("- - -")
		self.txt:SetTextColor(0.9, 0.3, 0.3)
	end
	refreshAddOnMenu()
end)

for i = 1, GetNumAddOns() do
	j = totalmainmenusize+i
	local name, _, _, _, _, _, _ = GetAddOnInfo(i)
	addonmenuitems[j] = CreateFrame("CheckButton", "AddonMenu"..j, AddonBG)
	addonmenuitems[j]:CreatePanel("Overlay", buttonwidth(1), buttonheight(1), "BOTTOM", AddonBG, "BOTTOM", 0, buttonspacing(1))
	addonmenuitems[j]:EnableMouse(true)
	addonmenuitems[j]:RegisterForClicks("AnyUp")
	addonmenuitems[j]:SetFrameLevel(defaultframelevel + 1)
	addonmenuitems[j]:SetFrameStrata("HIGH")
	updateTextures(addonmenuitems[j], true)

	addonmenuitems[j]:SetChecked(not addonInfo[i].enabled)
	addonmenuitems[j]:SetScript("OnMouseUp", function(self, btn)
		if btn == "RightButton" then
			addonEnableToggle(self, i)
		else
			addonFrameToggle(self, i)
			self:SetChecked(not self:GetChecked())
		end
	end)
	addonmenuitems[j]:HookScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:AddLine(L_TOGGLE_ADDON..name)
		GameTooltip:AddLine("|cffffffff"..L_TOGGLE_RCLICK..name.."\n"..L_TOGGLE_RELOAD)
		if C.toggleaddons[name] then
			if IsAddOnLoaded(i) then
				GameTooltip:AddLine("|cffffffff"..L_TOGGLE_LCLICK..name)
			end
		end
		GameTooltip:Show()
	end)
	addonmenuitems[j]:HookScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	Text = addonmenuitems[j]:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	Text:SetPoint("CENTER", addonmenuitems[j], 1, 0)
	Text:SetText(select(2, GetAddOnInfo(i)))
	Text:SetWidth(buttonwidth(1) - buttonspacing(1))
	Text:SetHeight(C.media.pixel_font_size)
	if addonInfo[i].is_main then
		local expandAddonButton = CreateFrame("Button", "AddonMenuExpand"..j, addonmenuitems[j])
		expandAddonButton:CreatePanel("Overlay", buttonheight(1) - 4, buttonheight(1) - 4, "TOPLEFT", addonmenuitems[j], "TOPLEFT", 2, -2)
		expandAddonButton:SetFrameLevel(defaultframelevel + 2)
		expandAddonButton:SetFrameStrata("HIGH")
		expandAddonButton:EnableMouse(true)
		expandAddonButton:RegisterForClicks("AnyUp")
		updateTextures(expandAddonButton)

		expandAddonButton:HookScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			if addonInfo[i].collapsed then
				GameTooltip:AddLine(L_TOGGLE_EXPAND..name..L_TOGGLE_ADDONS)
			else
				GameTooltip:AddLine(L_TOGGLE_COLLAPSE..name..L_TOGGLE_ADDONS)
			end
			GameTooltip:Show()
		end)
		expandAddonButton:HookScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)

		Text = expandAddonButton:CreateFontString(nil, "OVERLAY")
		Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		Text:SetPoint("CENTER", expandAddonButton, 1, 0)
		Text:SetText("+")
		Text:SetTextColor(0.3, 0.3, 0.9)
		expandAddonButton.txt = Text
		expandAddonButton:SetScript("OnMouseUp", function(self)
			addonInfo[i].collapsed = not addonInfo[i].collapsed
			if addonInfo[i].collapsed then
				self.txt:SetText("+")
				self.txt:SetTextColor(0.3, 0.3, 0.9)
			else
				self.txt:SetText("-")
				self.txt:SetTextColor(0.9, 0.3, 0.3)
			end
			refreshAddOnMenu()
		end)
		addonmenuitems[j].expandbtn = expandAddonButton
	end
	addonmenuitems[j]:Hide()
end

refreshAddOnMenu()