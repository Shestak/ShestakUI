local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Enabled/disable addons without logging out(stAddonManager by Safturento)
----------------------------------------------------------------------------------------
local AddonManager = CreateFrame("Frame", "AddonManager", UIParent)
AddonManager:SetFrameStrata("HIGH")
AddonManager:Hide()

AddonManager.header = CreateFrame("Frame", "AddonManagerHeader", AddonManager)
AddonManager.header:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 317)
AddonManager.header:SetSize(350, 400)
AddonManager:SetPoint("TOP", AddonManager.header, "TOP", 0, 0)

local function GetEnabledAddons()
	local EnabledAddons = {}
	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i)
		if enabled then
			tinsert(EnabledAddons, name)
		end
	end
	return EnabledAddons
end

local function CreateMenuButton(parent, width, height, text, ...)
	local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	button:SetSize(width, height)
	button:SkinButton()
	button:SetText(text)
	if ... then button:SetPoint(...) end
	return button
end

function AddonManager:UpdateAddonList(query)
	local addons = {}
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
		local lwrTitle, lwrName = strlower(title), strlower(name)
		if (query and (strfind(lwrTitle, strlower(query)) or strfind(lwrName, strlower(query)))) or (not query) then
			addons[i] = {}
			addons[i].name = name
			addons[i].title = title
			addons[i].notes = notes
			addons[i].enabled = enabled
			if GetAddOnMetadata(i, "version") then
				addons[i].version = GetAddOnMetadata(i, "version")
			end
			if GetAddOnDependencies(i) then
				addons[i].dependencies = {GetAddOnDependencies(i)}
			end
			if GetAddOnOptionalDependencies(i) then
				addons[i].optionaldependencies = {GetAddOnOptionalDependencies(i)}
			end
			if GetAddOnMetadata(i, "author") then
				addons[i].author = GetAddOnMetadata(i, "author")
			end
		end
	end
	return addons
end

function AddonManager:LoadProfileWindow()
	local self = AddonManager
	if self.ProfileWindow then ToggleFrame(self.ProfileWindow) return end

	local window = CreateFrame("Frame", "AddonManagerProfileWindow", self)
	window:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 0)
	window:SetSize(175, 20)
	window:CreateBackdrop("Transparent")
	window.backdrop:SetPoint("TOPLEFT", 0, 2)
	window.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)

	local title = window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	title:SetPoint("CENTER")
	title:SetText(L_ALOAD_PROFILES)
	window.title = title

	local EnableAll = CreateMenuButton(window, (window:GetWidth() - 15) / 2, 20, L_ALOAD_ENABLE_ALL, "TOPLEFT", window, "BOTTOMLEFT", 5, -5)
	EnableAll:SetScript("OnClick", function(self)
		for i, addon in pairs(AddonManager.AllAddons) do
			EnableAddOn(addon.name)
			if AddonManager.Buttons[i].overlay then
				AddonManager.Buttons[i].overlay:SetVertexColor(1, 0.82, 0, 0.8)
			end
			addon.enabled = true
		end
	end)
	self.EnableAll = EnableAll

	local DisableAll = CreateMenuButton(window, EnableAll:GetWidth(), EnableAll:GetHeight(), L_ALOAD_DISABLE_ALL, "TOPRIGHT", window, "BOTTOMRIGHT", -5, -5)
	DisableAll:SetScript("OnClick", function(self)
		for i, addon in pairs(AddonManager.AllAddons) do
			if addon.name ~= "ShestakUI" then
				DisableAddOn(addon.name)
				if AddonManager.Buttons[i].overlay then
					AddonManager.Buttons[i].overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
				addon.enabled = false
			end
		end
	end)
	self.DisableAll = DisableAll

	local SaveProfile = CreateMenuButton(window, window:GetWidth() - 10, 20, NEW_COMPACT_UNIT_FRAME_PROFILE, "TOPLEFT", EnableAll, "BOTTOMLEFT", 0, -5)
	SaveProfile:SetScript("OnClick", function(self)
		if not self.editbox then
			local editbox = CreateFrame("EditBox", nil, self)
			editbox:SetTemplate("Overlay")
			editbox:SetAllPoints(self)
			editbox:SetFont(C.media.normal_font, 13)
			editbox:SetText(L_ALOAD_PROFILE_NAME)
			editbox:SetAutoFocus(false)
			editbox:SetFocus(true)
			editbox:HighlightText()
			editbox:SetTextInsets(3, 0, 0, 0)
			editbox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
			editbox:SetScript("OnEscapePressed", function(self) self:SetText(L_ALOAD_PROFILE_NAME) self:ClearFocus() self:Hide() end)
			editbox:SetScript("OnEnterPressed", function(self)
				local profileName = self:GetText()
				self:ClearFocus()
				self:SetText(L_ALOAD_PROFILE_NAME)
				self:Hide()
				if not profileName then return end
				SavedAddonProfiles[profileName] = GetEnabledAddons()
				AddonManager:UpdateProfileList()
			end)
			self.editbox = editbox
		else
			self.editbox:Show()
			self.editbox:SetFocus(true)
			self.editbox:HighlightText()
		end
	end)
	self.SaveProfile = SaveProfile

	self:SetScript("OnHide", function(self)
		if self.SaveProfile.editbox then self.SaveProfile.editbox:Hide() end
		window:Hide()
	end)

	local buttons = {}
	function AddonManager:UpdateProfileList()
		local sort = function(t, func)
			local temp = {}
			local i = 0

			for n in pairs(t) do
				table.insert(temp, n)
			end

			table.sort(temp, func)

			local iter = function()
				i = i + 1
				if temp[i] == nil then
					return nil
				else
					return temp[i], t[temp[i]]
				end
			end

			return iter
		end

		local function CollapseAllProfiles()
			for i = 1, #buttons do
				buttons[i].overlay2:Hide()
				buttons[i]:SetHeight(20)
			end
		end

		for i = 1, #buttons do
			buttons[i]:Hide()
			CollapseAllProfiles()
		end

		local i = 1
		for profileName, addonList in sort(SavedAddonProfiles, function(a, b) return strlower(b) > strlower(a) end) do
			if not buttons[i] then
				local button = CreateMenuButton(window, window:GetWidth() - 10, 20)

				local overlay2 = CreateFrame("Frame", nil, button)
				overlay2:SetHeight(1)
				overlay2:SetPoint("TOP", button, "TOP", 0, -18)
				overlay2:SetWidth(button:GetWidth() - 10)
				overlay2:SetFrameLevel(button:GetFrameLevel() + 1)
				overlay2:Hide()

				overlay2.set = CreateMenuButton(overlay2, overlay2:GetWidth(), 20, L_ALOAD_SET_TO, "TOP", button, "TOP", 0, -5)
				overlay2.add = CreateMenuButton(overlay2, overlay2:GetWidth(), 20, L_ALOAD_ADD_TO, "TOP", overlay2.set, "BOTTOM", 0, -3)
				overlay2.remove = CreateMenuButton(overlay2, overlay2:GetWidth(), 20, L_ALOAD_REMOVE_FROM, "TOP", overlay2.add, "BOTTOM", 0, -3)
				overlay2.delete = CreateMenuButton(overlay2, overlay2:GetWidth(), 20, L_ALOAD_DELETE_PROFILE, "TOP", overlay2.remove, "BOTTOM", 0, -3)

				button.overlay2 = overlay2

				button:SetScript("OnClick", function(self)
					if self.overlay2:IsShown() then
						CollapseAllProfiles()
					else
						CollapseAllProfiles()
						self.overlay2:Show()
						self:SetHeight((20 * 5) - 1)
					end
				end)

				buttons[i] = button
			end

			buttons[i]:Show()
			buttons[i]:SetText(profileName)
			local overlay2 = buttons[i].overlay2
			overlay2.set:SetScript("OnClick", function(self)
				DisableAllAddOns()
				EnableAddOn("ShestakUI")
				for i, name in pairs(addonList) do EnableAddOn(name) end
				AddonManager.AllAddons = AddonManager:UpdateAddonList()
				AddonManager:UpdateList(AddonManager.AllAddons)
				CollapseAllProfiles()
			end)
			overlay2.add:SetScript("OnClick", function(self)
				for i, name in pairs(addonList) do EnableAddOn(name) end
				AddonManager.AllAddons = AddonManager:UpdateAddonList()
				AddonManager:UpdateList(AddonManager.AllAddons)
				CollapseAllProfiles()
			end)
			overlay2.remove:SetScript("OnClick", function(self)
				for i, name in pairs(addonList) do if name ~= "ShestakUI" then DisableAddOn(name) end end
				AddonManager.AllAddons = AddonManager:UpdateAddonList()
				AddonManager:UpdateList(AddonManager.AllAddons)
				CollapseAllProfiles()
			end)
			overlay2.delete:SetScript("OnClick", function(self)
				if IsShiftKeyDown() then
					SavedAddonProfiles[profileName] = nil
					AddonManager:UpdateProfileList()
					CollapseAllProfiles()
				else
					print("|cffff0000"..L_ALOAD_CONFIRM_DELETE.."|r")
				end
			end)
			i = i + 1
		end

		local prevButton
		for i, button in pairs(buttons) do
			if i == 1 then
				button:SetPoint("TOP", SaveProfile, "BOTTOM", 0, -5)
			else
				button:SetPoint("TOP", prevButton, "BOTTOM", 0, -5)
			end
			prevButton = button
		end

		if not prevButton then prevButton = SaveProfile end
		window.backdrop:ClearAllPoints()
		window.backdrop:SetPoint("TOPLEFT", window, "TOPLEFT", 0, 2)
		window.backdrop:SetPoint("TOPRIGHT", window, "TOPRIGHT", 0, 2)
		window.backdrop:SetPoint("BOTTOM", prevButton, "BOTTOM", 0, -5)
	end
	self.ProfileWindow = window

	AddonManager:UpdateProfileList()
end

function AddonManager:LoadWindow()
	if AddonManager.Loaded then AddonManager:Show() return end
	local window = AddonManager
	local header = window.header

	tinsert(UISpecialFrames, window:GetName())

	window:Show()
	window:SetSize(350, 400)
	window:CreateBackdrop("Transparent")
	window.backdrop:SetPoint("TOPLEFT", -2, 2)
	window.backdrop:SetPoint("BOTTOMRIGHT", 2, -19)

	header:SetSize(350, 400)

	local hTitle = AddonManager.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	hTitle:SetPoint("TOP", 0, -3)
	hTitle:SetText(ADDONS)
	header.title = hTitle

	local close = CreateFrame("Button", window:GetName().."CloseButton", header, "UIPanelCloseButton")
	T.SkinCloseButton(close, window.backdrop)
	close:SetScript("OnClick", function() window:Hide() end)
	header.close = close

	local addonListBG = CreateFrame("Frame", window:GetName().."ScrollBackground", window)
	addonListBG:SetPoint("TOPLEFT", header, "TOPLEFT", 10, -50)
	addonListBG:SetWidth(window:GetWidth() - 20)
	addonListBG:SetHeight(window:GetHeight() - 60)
	addonListBG:CreateBackdrop("Overlay")

	local scrollFrame = CreateFrame("ScrollFrame", window:GetName().."ScrollFrame", window, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", addonListBG, "TOPLEFT", 0, -2)
	scrollFrame:SetWidth(addonListBG:GetWidth() - 25)
	scrollFrame:SetHeight(addonListBG:GetHeight() - 5)
	scrollFrame:SetFrameLevel(window:GetFrameLevel() + 1)

	scrollFrame.Anchor = CreateFrame("Frame", window:GetName().."ScrollAnchor", scrollFrame)
	scrollFrame.Anchor:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, -3)
	scrollFrame.Anchor:SetWidth(window:GetWidth() - 40)
	scrollFrame.Anchor:SetHeight(scrollFrame:GetHeight())
	scrollFrame.Anchor:SetFrameLevel(scrollFrame:GetFrameLevel() + 1)
	scrollFrame:SetScrollChild(scrollFrame.Anchor)

	-- Load addon information
	AddonManager.AllAddons = AddonManager:UpdateAddonList()
	AddonManager.FilteredAddons = AddonManager:UpdateAddonList()
	AddonManager.showEnabled = true
	AddonManager.showDisabled = true

	AddonManager.Buttons = {}

	-- Create initial list
	for i, addon in pairs(AddonManager.AllAddons) do
		local button = CreateFrame("Button", nil, scrollFrame.Anchor)
		button:SetFrameLevel(scrollFrame.Anchor:GetFrameLevel() + 1)
		button:SetSize(15.5, 15.5)
		button:SkinButton()
		button:SetHitRectInsets(0, -250, 0, 0)
		if addon.enabled then
			if button.overlay then
				button.overlay:SetVertexColor(1, 0.82, 0, 0.8)
			end
		end

		local highligh = button:CreateTexture(nil, nil, self)
		highligh:SetTexture(1, 1, 1, 0.3)
		highligh:SetPoint("TOPLEFT", button, 2, -2)
		highligh:SetPoint("BOTTOMRIGHT", button, -2, 2)
		button:SetHighlightTexture(highligh)

		if i == 1 then
			button:SetPoint("TOPLEFT", scrollFrame.Anchor, "TOPLEFT", 5, -5.5)
		else
			button:SetPoint("TOP", AddonManager.Buttons[i-1], "BOTTOM", 0, -3.5)
		end
		button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		button.text:SetJustifyH("LEFT")
		button.text:SetPoint("LEFT", button, "RIGHT", 8, 0)
		button.text:SetPoint("RIGHT", scrollFrame.Anchor, "RIGHT", 0, 0)
		button.text:SetText(addon.title)

		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, self:GetHeight())
			GameTooltip:ClearLines()
			if addon.version then
				GameTooltip:AddDoubleLine(addon.title, addon.version)
			else
				GameTooltip:AddLine(addon.title)
			end
			if addon.notes then
				GameTooltip:AddLine(addon.notes, nil, nil, nil, true)
			end
			if addon.dependencies then
				GameTooltip:AddLine(L_ALOAD_DEP..unpack(addon.dependencies), 1, 0.2, 0, true)
			end
			if addon.optionaldependencies then
				GameTooltip:AddLine(L_ALOAD_OP_DEP..unpack(addon.optionaldependencies), 1, 0.5, 0, true)
			end
			if addon.author then
				GameTooltip:AddLine(L_ALOAD_AUTHOR..addon.author, 1, 0.2, 0, true)
			end
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
		button:SetScript("OnMouseDown", function(self)
			if addon.enabled then
				if self.overlay then
					self.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
				DisableAddOn(addon.name)
				addon.enabled = false
			else
				if self.overlay then
					self.overlay:SetVertexColor(1, 0.82, 0, 0.8)
				end
				EnableAddOn(addon.name)
				addon.enabled = true
			end
		end)

		AddonManager.Buttons[i] = button
	end

	function AddonManager:UpdateList(AddonsTable)
		-- Start off by hiding all of the buttons
		for _, b in pairs(AddonManager.Buttons) do b:Hide() end
		local i = 1
		for _, addon in pairs(AddonsTable) do
			local button = AddonManager.Buttons[i]
			button:Show()
			if addon.enabled then
				if button.overlay then
					button.overlay:SetVertexColor(1, 0.82, 0, 0.8)
				end
			else
				if button.overlay then
					button.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
			end

			button:SetScript("OnMouseDown", function(self)
				if addon.enabled then
					if self.overlay then
						self.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
					end
					DisableAddOn(addon.name)
					addon.enabled = false
				else
					if self.overlay then
						self.overlay:SetVertexColor(1, 0.82, 0, 0.8)
					end
					EnableAddOn(addon.name)
					addon.enabled = true
				end
			end)

			button.text:SetText(addon.title)
			i = i + 1
		end
	end

	-- Search bar
	local searchBar = CreateFrame("EditBox", window:GetName().."SearchBar", window)
	searchBar:SetFrameLevel(window:GetFrameLevel() + 1)
	searchBar:SetPoint("BOTTOMLEFT", addonListBG, "TOPLEFT", 0, 5)
	searchBar:SetWidth(180)
	searchBar:SetHeight(20)
	searchBar:CreateBackdrop("Overlay")
	searchBar.backdrop:SetPoint("TOPLEFT", -2, 0)
	searchBar.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)
	searchBar:SetFont(C.media.normal_font, 13)
	searchBar:SetText(SEARCH)
	searchBar:SetAutoFocus(false)
	searchBar:SetTextInsets(1, 0, 0, 0)
	searchBar:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	searchBar:SetScript("OnEscapePressed", function(self) searchBar:SetText(SEARCH) AddonManager:UpdateList(AddonManager.AllAddons) searchBar:ClearFocus() end)
	searchBar:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
	searchBar:SetScript("OnTextChanged", function(self, input)
		if input then
			AddonManager.FilteredAddons = AddonManager:UpdateAddonList(self:GetText())
			AddonManager:UpdateList(AddonManager.FilteredAddons)
		end
	end)
	AddonManager.searchBar = searchBar

	local profileButton = CreateMenuButton(window, 70, 20, L_ALOAD_PROFILES, "BOTTOMRIGHT", addonListBG, "TOPRIGHT", 2, 5)
	profileButton:SetPoint("LEFT", searchBar, "RIGHT", 5, 0)
	profileButton:SetScript("OnClick", function(self)
		AddonManager:LoadProfileWindow()
	end)
	AddonManager.profileButton = profileButton

	local reloadButton = CreateMenuButton(window, 130, 20, L_ALOAD_RL, "TOP", addonListBG, "BOTTOM", 0, -5)
	reloadButton:SetScript("OnClick", function(self)
		if InCombatLockdown() then return end
		ReloadUI()
	end)
	AddonManager.reloadButton = reloadButton

	AddonManager.Loaded = true
end

-- Slash command
SlashCmdList.ADDONMANAGER = function()
	if AddonManager:IsShown() then
		AddonManager:Hide()
	else
		AddonManager:LoadWindow()
	end
end
SLASH_ADDONMANAGER1 = "/aload"
SLASH_ADDONMANAGER2 = "/фдщфв"

-- Game menu buttons
local gmbAddOns = CreateFrame("Button", "GameMenuButtonAddonManager", GameMenuFrame, "GameMenuButtonTemplate")
gmbAddOns:SetText(ADDONS)
gmbAddOns:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -1)

GameMenuFrame:HookScript("OnShow", function()
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + gmbAddOns:GetHeight())
	if IsMacClient() then
		GameMenuButtonMacOptions:SetPoint("TOP", gmbAddOns, "BOTTOM", 0, -1)
	else
		GameMenuButtonUIOptions:SetPoint("TOP", gmbAddOns, "BOTTOM", 0, -1)
	end
end)

gmbAddOns:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	AddonManager:LoadWindow()
end)

if not IsAddOnLoaded("ShestakUI_Config") then return end
local guib = CreateFrame("Button", "GameMenuButtonSettingsUI", GameMenuFrame, "GameMenuButtonTemplate")
guib:SetText("ShestakUI")
guib:SetPoint("TOP", "GameMenuButtonOptions", "BOTTOM", 0, -23)

GameMenuFrame:HookScript("OnShow", function()
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + guib:GetHeight())
	if IsMacClient() then
		GameMenuButtonMacOptions:SetPoint("TOP", guib, "BOTTOM", 0, -1)
	else
		GameMenuButtonUIOptions:SetPoint("TOP", guib, "BOTTOM", 0, -1)
	end
end)

guib:SetScript("OnClick", function()
	PlaySound("igMainMenuOption")
	HideUIPanel(GameMenuFrame)
	if not UIConfigMain or not UIConfigMain:IsShown() then
		CreateUIConfig()
	else
		UIConfigMain:Hide()
	end
end)