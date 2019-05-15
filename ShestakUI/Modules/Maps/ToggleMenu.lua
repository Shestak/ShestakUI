local T, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true or C.minimap.toggle_menu ~= true then return end

----------------------------------------------------------------------------------------
--	Toggle menu(by Hydra, Foof, Gorlasch and HyPeRnIcS)
----------------------------------------------------------------------------------------
-- Override prefix method to collapse addons
C["toggleprefix"] = {
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
	{
		["text"] = CLOSE,
		["function"] = function()
			ToggleMenu_Toggle()
		end
	},
	{
		["text"] = ADDONS,
		["function"] = function()
			ToggleFrame(TTMenuAddOnBackground)
			ToggleFrame(TTMenuBackground)
		end
	},
	{
		["text"] = HELP_LABEL,
		["function"] = function()
			SlashCmdList.UIHELP()
		end
	},
	{
		["text"] = RELOADUI,
		["function"] = function()
			ReloadUI()
		end
	},
	{
		["text"] = "Move UI",
		["function"] = function()
			SlashCmdList.MOVING()
		end
	},
	{
		["text"] = "Test UI",
		["function"] = function()
			if C.raidcooldown.enable == true then
				SlashCmdList.RaidCD()
			end
			if C.enemycooldown.enable == true then
				SlashCmdList.EnemyCD()
			end
			if C.pulsecooldown.enable == true then
				SlashCmdList.PulseCD()
			end
			if C.unitframe.enable == true then
				SlashCmdList.TEST_UF()
			end
			if C.announcements.pull_countdown == true then
				SlashCmdList.PULLCOUNTDOWN()
			end
			if C.loot.rolllootframe == true then
				SlashCmdList.TESTROLL()
			end
			if C.threat.enable == true then
				SlashCmdList.alThreat()
			end
			SlashCmdList.DBMTEST()
			if not T.classic then
				SlashCmdList.TEST_EXTRABUTTON()
				SlashCmdList.TEST_ACHIEVEMENT()
			end
			--SlashCmdList.GRIDONSCREEN()
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
	["ACP"] = function()
		ToggleFrame(ACP_AddonList)
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
}

-- Button size
local function buttonwidth(num)
	return num * (C.minimap.size - 6)
end
local function buttonheight(num)
	return num * 20
end
local function buttonspacing(num)
	return num * 3
end
local function borderwidth(num)
	return buttonwidth(num) + buttonspacing(num + 1)
end
local function borderheight(num)
	return buttonheight(num) + buttonspacing(num + 1)
end
local defaultframelevel = 0

local function updateTextures(button, checkable)
	if checkable then
		local texture = button:CreateTexture(nil, nil, self)
		texture:SetColorTexture(1, 1, 1, 0.3)
		texture:SetPoint("TOPLEFT", button, 2, -2)
		texture:SetPoint("BOTTOMRIGHT", button, -2, 2)
		button:SetCheckedTexture(texture)
	end
	button:HookScript("OnEnter", T.SetModifiedBackdrop)
	button:HookScript("OnLeave", T.SetOriginalBackdrop)
end

local MenuBG = CreateFrame("Frame", "TTMenuBackground", UIParent)
MenuBG:CreatePanel("Transparent", borderwidth(1), 1, "BOTTOMRIGHT", Minimap, "TOPRIGHT", 2, 3)
MenuBG:SetFrameLevel(defaultframelevel)
MenuBG:SetFrameStrata("HIGH")
MenuBG:EnableMouse(true)
MenuBG:Hide()

local AddonBG = CreateFrame("Frame", "TTMenuAddOnBackground", UIParent)
AddonBG:CreatePanel("Transparent", borderwidth(1), 1, "BOTTOMRIGHT", MenuBG, "BOTTOMRIGHT", 0, 0)
AddonBG:SetFrameLevel(defaultframelevel)
AddonBG:SetFrameStrata("HIGH")
AddonBG:EnableMouse(true)
AddonBG:Hide()

tinsert(UISpecialFrames, "TTMenuBackground")
tinsert(UISpecialFrames, "TTMenuAddOnBackground")

function ToggleMenu_Toggle()
	if TTMenuAddOnBackground:IsShown() or TTMenuBackground:IsShown() then
		TTMenuAddOnBackground:Hide()
		TTMenuBackground:Hide()
	else
		TTMenuAddOnBackground:Show()
		TTOpenMenuBackground:FadeOut()
	end
end

-- Add slash command
SLASH_UITOGGLEMENU1 = "/ttm"
SlashCmdList.UITOGGLEMENU = ToggleMenu_Toggle

local Text
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
			menuItems[index]:CreatePanel("Overlay", buttonwidth(1), buttonheight(1), "BOTTOM", menuBackground, "BOTTOM", 0, buttonspacing(1))
			menuItems[index]:SetFrameLevel(defaultframelevel + 1)
			menuItems[index]:SetFrameStrata("HIGH")
			if mainmenusize == 0 then
				menuItems[index]:SetPoint("BOTTOMRIGHT", menuBackground, "BOTTOMRIGHT", buttonspacing(-1), buttonspacing(-1))
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

			local hideItem = (value.text == ADDONS)
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
addMainMenuButtons(addonmenuitems, "AddonMenu", AddonBG)

local OpenMenuBG = CreateFrame("Button", "TTOpenMenuBackground", UIParent)
OpenMenuBG:CreatePanel("Overlay", borderwidth(1), buttonheight(1) / 1.3, "BOTTOM", MenuBG, "BOTTOM", 0, 0)
OpenMenuBG:EnableMouse(true)
OpenMenuBG:RegisterForClicks("AnyUp")
OpenMenuBG:SetFrameLevel(defaultframelevel)
OpenMenuBG:SetFrameStrata("HIGH")
OpenMenuBG:SetScript("OnMouseUp", function()
	ToggleMenu_Toggle()
	if (T.class == "MAGE" and T.level >= 17) and _G["TeleportMenu"]:IsShown() then
		_G["TeleportMenu"]:Hide()
	end
end)
OpenMenuBG:HookScript("OnEnter", function(self)
	if (T.class == "MAGE" and T.level >= 17) and _G["TeleportMenu"]:IsShown() then
	else
		self:FadeIn()
	end
end)
OpenMenuBG:HookScript("OnLeave", function(self) self:FadeOut() end)

Text = OpenMenuBG:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Text:SetPoint("CENTER", OpenMenuBG, 0, 0)
Text:SetText("+ + +")
Text:SetTextColor(0.3, 0.3, 0.9)
TTOpenMenuBackground:FadeOut()

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

local addonInfo
local lastMainAddon = "XYZNonExistantDummyAddon"
local menusize
local lastMainAddonID = 0
if not addonInfo then
	addonInfo = {{}}
	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i)
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
						local name_j = GetAddOnInfo(j)
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
	local name = GetAddOnInfo(i)
	if C.toggleaddons[name] then
		if IsAddOnLoaded(i) then
			C.toggleaddons[name]()
		end
	end
end

local addonToggleOnly = true

local function refreshAddOnMenu()
	menusize = mainmenusize
	for i = 1, GetNumAddOns() do
		local name = GetAddOnInfo(i)
		if addonInfo[i].is_main or (addonInfo[i].parent == i) or not addonInfo[addonInfo[i].parent].collapsed then
			if not addonToggleOnly or (C.toggleaddons[name] and IsAddOnLoaded(i)) then
				menusize = menusize + 1
			end
		end
	end
	menuwidth = ceil(menusize / 25)
	menuheight = ceil(menusize / menuwidth)

	local lastMenuEntryID = lastMainMenuEntryID
	menusize = mainmenusize
	for i = 1, GetNumAddOns() do
		j = totalmainmenusize + i
		local name = GetAddOnInfo(i)
		addonmenuitems[j]:Hide()
		if addonInfo[i].is_main or addonInfo[i].parent == i or not addonInfo[addonInfo[i].parent].collapsed then
			if (not addonToggleOnly or (C.toggleaddons[name] and IsAddOnLoaded(i))) then
				addonmenuitems[j]:ClearAllPoints()
				if menusize % menuheight == 0 then
					addonmenuitems[j]:SetPoint("BOTTOMRIGHT", addonmenuitems[lastMenuEntryID], "BOTTOMLEFT", buttonspacing(-1), (buttonheight(-menuheight + 1) + buttonspacing(-menuheight + 1)))
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
	AddonBG:SetHeight(borderheight(menuheight + 1) - buttonheight(1) / 2)
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
	j = totalmainmenusize + i
	local name = GetAddOnInfo(i)
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
		Text:SetPoint("CENTER", expandAddonButton, 2, 0)
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