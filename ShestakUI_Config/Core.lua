local T, C
local _, ns = ...
local L = ns

----------------------------------------------------------------------------------------
--	GUI for ShestakUI(by Haleth, Solor)
----------------------------------------------------------------------------------------
local realm = GetRealmName()
local name = UnitName("player")

-- [[ Variables ]]

ns.buttons = {}
ns.NextPrevButtons = {}

local checkboxes = {}
local sliders = {}
local editboxes = {}
local dropdowns = {}
local colourpickers = {}
local panels = {}

-- cache old values to check whether UI needs to be reloaded
local old = {}
local oldColours = {}

local userChangedSlider = true -- to use SetValue without triggering OnValueChanged
local baseName = "ShestakUIOptionsPanel"

-- [[ Functions ]]

-- when an option needs a reload
local function setReloadNeeded(isNeeded)
	ShestakUIOptionsPanel.reloadText:SetShown(isNeeded)
	ns.needReload = isNeeded -- for the popup when clicking okay
	if isNeeded then
		ShestakUIOptionsPanelOkayButton:Enable()
	else
		ShestakUIOptionsPanelOkayButton:Disable()
	end
end
ns.setReloadNeeded = setReloadNeeded

-- check if a reload is needed
local function checkIsReloadNeeded()
	for frame, value in pairs(old) do
		if C[frame.group][frame.option] ~= value then
			setReloadNeeded(true)
			return
		end
	end

	for colourOption, oldTable in pairs(oldColours) do
		local savedTable = C[colourOption.group][colourOption.option]
		if savedTable[1] ~= oldTable[1] or savedTable[2] ~= oldTable[2] or savedTable[3] ~= oldTable[3] then
			setReloadNeeded(true)
			return
		end
	end

	-- if the tables were empty, or all of the old values match their current ones
	setReloadNeeded(false)
end

-- Called by every widget to save a value
local function SaveValue(f, value)
	if not C.options[f.group] then C.options[f.group] = {} end
	if not C.options[f.group][f.option] then C.options[f.group][f.option] = {} end

	C.options[f.group][f.option] = value -- these are the saved variables
	C[f.group][f.option] = value -- and this is from the lua options
end

-- [[ Widgets ]]

-- Check boxes

local function toggleChildren(self, checked)
	local tR, tG, tB
	if checked then
		tR, tG, tB = 1, 1, 1
	else
		tR, tG, tB = .3, .3, .3
	end

	for _, child in next, self.children do
		child:SetEnabled(checked)
		child.Text:SetTextColor(tR, tG, tB)
	end
end

local function toggle(self)
	local checked = self:GetChecked()

	if checked then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
	end

	SaveValue(self, checked)
	if self.children then toggleChildren(self, checked) end

	if self.needsReload then
		if old[self] == nil then
			old[self] = not checked
		end

		checkIsReloadNeeded()
	end
end

ns.CreateCheckBox = function(parent, option, text, textDesc)
	local f = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")

	f.group = parent.tag
	f.option = option

	if text then
		f.Text:SetText(text)
	else
		f.Text:SetText(ns[parent.tag.."_"..option])
	end

	f.tooltipText = ns[parent.tag.."_"..option.."_desc"] or textDesc or ns[parent.tag.."_"..option] or text

	f.needsReload = true

	f:SetScript("OnClick", toggle)
	parent[option] = f

	tinsert(checkboxes, f)

	return f
end

-- Sliders

local function onValueChanged(self, value)
	if self.step < 1 then
		if self.option == "uiscale" then
			value = tonumber(string.format("%.3f", value))
		else
			value = tonumber(string.format("%.2f", value))
		end
	else
		value = floor(value + 0.5)
	end

	if self.textInput then
		self.textInput:SetText(value)
	end

	if userChangedSlider then
		SaveValue(self, value)

		if self.needsReload then
			if self.step < 1 then
				self.oldValue = tonumber(string.format("%.2f", self.oldValue))
			end
			old[self] = self.oldValue
			checkIsReloadNeeded()
		end
	end
end

local function onMouseWheel(self, delta)
	if not IsControlKeyDown() and not IsShiftKeyDown() then
		local script = self.parent:GetScript("OnMouseWheel")
		if script then
			script(self.parent, delta)
		end
		return
	end

	value = self.textInput:GetText()

	local step = self.step
	if IsControlKeyDown() then
		step = self.step * 5
	elseif IsShiftKeyDown() then
		step = self.step
	end

	if delta < 0 then
		value = value + step
	else
		value = value - step
	end

	if self.step < 1 then
		if self.option == "uiscale" then
			value = tonumber(string.format("%.3f", value))
		else
			value = tonumber(string.format("%.2f", value))
		end
	else
		value = floor(value + 0.5)
	end

	if value < self.min then
		value = self.min
	elseif value > self.max then
		value = self.max
	end

	if self.textInput then
		self.textInput:SetText(value)
	end

	self:SetValue(value)

	if userChangedSlider then
		SaveValue(self, value)

		if self.needsReload then
			if self.step < 1 then
				self.oldValue = tonumber(string.format("%.2f", self.oldValue))
			end
			old[self] = self.oldValue
			checkIsReloadNeeded()
		end
	end
end

local function createSlider(parent, option, lowText, highText, low, high, step, needsReload, text, textDesc)
	local sliderName = parent:GetName()..option
	local f = CreateFrame("Slider", sliderName, parent, "OptionsSliderTemplate")

	BlizzardOptionsPanel_Slider_Enable(f)

	f.group = parent.tag
	f.option = option

	_G[sliderName.."Text"]:SetFontObject(GameFontHighlightSmall)
	_G[sliderName.."Text"]:SetSize(150, 20)

	if text then
		_G[sliderName.."Text"]:SetText(text)
	else
		_G[sliderName.."Text"]:SetText(ns[parent.tag.."_"..option])
	end

	_G[sliderName.."Low"]:SetText(lowText)
	_G[sliderName.."High"]:SetText(highText)

	f:SetMinMaxValues(low, high)
	f:SetObeyStepOnDrag(true)
	f:SetValueStep(step)
	f:SetWidth(150)

	f.tooltipText = ns[parent.tag.."_"..option.."_desc"] or textDesc or ns[parent.tag.."_"..option] or text

	f.needsReload = needsReload
	f.step = step
	f.min = low
	f.max = high
	f.parent = parent

	f:SetScript("OnValueChanged", onValueChanged)
	f:SetScript("OnMouseWheel", onMouseWheel)
	parent[option] = f

	tinsert(sliders, f)

	return f
end

local function onSliderEscapePressed(self)
	self:ClearFocus()
end

local function onSliderEnterPressed(self)
	local slider = self:GetParent()
	local min, max = slider:GetMinMaxValues()

	local value = tonumber(self:GetText())
	if value and value >= floor(min) and value <= floor(max) then
		if slider.option == "uiscale" then
			slider:SetValueStep(0.001)
		end
		slider:SetValue(value)
	else
		self:SetText(floor(slider:GetValue()*1000)/1000)
	end

	self:ClearFocus()
end

ns.CreateNumberSlider = function(parent, option, lowText, highText, low, high, step, needsReload, text, textDesc)
	local slider = createSlider(parent, option, lowText, highText, low, high, step, needsReload, text, textDesc)

	local f = CreateFrame("EditBox", parent:GetName()..option.."TextInput", slider, "InputBoxTemplate")
	f:SetAutoFocus(false)
	f:SetWidth(50)
	f:SetHeight(18)
	f:SetMaxLetters(8)
	f:SetFontObject(GameFontHighlight)

	f:SetPoint("LEFT", slider, "RIGHT", 10, 0)

	f:SetScript("OnEscapePressed", onSliderEscapePressed)
	f:SetScript("OnEnterPressed", onSliderEnterPressed)
	f:SetScript("OnEditFocusGained", nil)
	f:SetScript("OnEditFocusLost", onSliderEnterPressed)

	slider.textInput = f

	return slider
end

-- EditBox

local function onEnterPressed(self)
	local value = self.valueNumber and tonumber(self:GetText()) or tostring(self:GetText())
	SaveValue(self, value)
	self:ClearFocus()
	old[self] = self.oldValue
	checkIsReloadNeeded()
end

ns.CreateEditBox = function(parent, option, needsReload, text, number)
	local f = CreateFrame("EditBox", parent:GetName()..option.."TextInput", parent, "InputBoxTemplate")
	f:SetAutoFocus(false)
	f:SetWidth(60)
	f:SetHeight(18)
	f:SetMaxLetters(8)
	f:SetFontObject(GameFontHighlight)

	f:SetPoint("LEFT", 40, 0)

	f.value = ""
	f.valueNumber = number and true or false

	f:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText(f.value) end)
	f:SetScript("OnEnterPressed", onEnterPressed)
	f:SetScript("OnEditFocusGained", function() f.value = f:GetText() end)
	f:SetScript("OnEditFocusLost", onEnterPressed)

	local label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	label:SetWidth(440)
	label:SetHeight(20)
	label:SetJustifyH("LEFT")
	label:SetPoint("LEFT", f, "RIGHT", 10, 0)

	if text then
		label:SetText(text)
	else
		label:SetText(ns[parent.tag.."_"..option])
	end

	f.label = label
	f.tooltipText = ns[parent.tag.."_"..option.."_desc"] or text

	f:SetScript("OnEnter", function()
		GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 5, 5)
		GameTooltip:SetText(f.tooltipText, nil, nil, nil, nil, true)
	end)

	f:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	f.group = parent.tag
	f.option = option

	f.needsReload = needsReload
	parent[option] = f

	tinsert(editboxes, f)

	return f
end

-- Colour pickers

-- we update this in onColourSwatchClicked, need it for setColour / resetColour
-- because it can't be passed as parameter
local currentColourOption

local function round(x)
	return floor((x * 100) + .5) / 100
end

local function setColour()
	local newR, newG, newB = ColorPickerFrame:GetColorRGB()
	newR, newG, newB = round(newR), round(newG), round(newB)

	currentColourOption:SetBackdropBorderColor(newR, newG, newB)
	currentColourOption:SetBackdropColor(newR, newG, newB, 0.3)
	SaveValue(currentColourOption, {newR, newG, newB})

	checkIsReloadNeeded()
end

local function resetColour(previousValues)
	local oldR, oldG, oldB = unpack(previousValues)

	currentColourOption:SetBackdropBorderColor(oldR, oldG, oldB)
	currentColourOption:SetBackdropColor(oldR, oldG, oldB, 0.3)
	SaveValue(currentColourOption, {oldR, oldG, oldB})

	checkIsReloadNeeded()
end

local function onColourSwatchClicked(self, button)
	if button == "RightButton" then
		C.options[self.group][self.option] = nil
		setReloadNeeded(true)
		return
	end

	local colourTable = C[self.group][self.option]
	local r, g, b = unpack(colourTable)
	r, g, b = round(r), round(g), round(b)
	local originalR, originalG, originalB = r, g, b

	currentColourOption = self

	if self.needsReload and oldColours[self] == nil then
		oldColours[self] = {r, g, b}
	end

	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorPickerFrame.previousValues = {originalR, originalG, originalB}
	ColorPickerFrame.func = setColour
	ColorPickerFrame.cancelFunc = resetColour
	ColorPickerFrame:Hide()
	ColorPickerFrame:Show()
end

ns.CreateColourPicker = function(parent, option, needsReload, text)
	local f = CreateFrame("Button", nil, parent)
	f:SetSize(40, 20)

	local colortext = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	colortext:SetText(COLOR)
	colortext:SetPoint("CENTER")
	colortext:SetJustifyH("CENTER")
	f:SetWidth(colortext:GetWidth() + 5)

	local label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	if text then
		label:SetText(text)
	else
		label:SetText(ns[parent.tag.."_"..option])
	end
	label:SetWidth(440)
	label:SetHeight(20)
	label:SetJustifyH("LEFT")
	label:SetPoint("LEFT", 50, 0)

	f.group = parent.tag
	f.option = option

	f.needsReload = needsReload

	f:SetScript("OnMouseUp", onColourSwatchClicked)
	parent[option] = f

	tinsert(colourpickers, f)

	return f
end

-- DropDown
local DropDownText = {
	["Interface\\AddOns\\ShestakUI\\Media\\Textures\\Texture.tga"] = "Normal texture",
	["Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Normal.ttf"] = "Normal font",
	["Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf"] = "Pixel Font",
	[STANDARD_TEXT_FONT] = "Blizzard font",
	["BLACKLIST"] = L.general_error_blacklist,
	["WHITELIST"] = L.general_error_whitelist,
	["COMBAT"] = L.general_error_combat,
	["NONE"] = L.general_error_none,
	["RAID"] = L.automation_auto_collapse_raid,
	["RELOAD"] = L.automation_auto_collapse_reload,
	["DYNAMIC"] = L.raidframe_auto_position_dynamic,
	["STATIC"] = L.raidframe_auto_position_static,
}

ns.CreateDropDown = function(parent, option, needsReload, text, tableValue, LSM, isFont)
	local f = CreateFrame("Frame", parent:GetName()..option.."DropDown", parent, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(f, 110)

	UIDropDownMenu_Initialize(f, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for key, value in pairs(tableValue) do
			info.text = LSM and (DropDownText[value] or key) or DropDownText[value] or value
			info.arg1 = value
			info.arg2 = key
			info.checked = value == f.selectedValue

			if isFont then
				local fObject = CreateFont(info.text)
				fObject:SetFont(value, 12)
				info.fontObject = fObject
			end

			UIDropDownMenu_AddButton(info)
		end
	end)

	function f:SetValue(newValue, newkey)
		f.selectedValue = newValue
		local text = LSM and (DropDownText[newValue] or newkey) or DropDownText[newValue] or newValue
		UIDropDownMenu_SetText(f, text)
		SaveValue(f, newValue)
		old[f] = f.oldValue
		checkIsReloadNeeded()
		CloseDropDownMenus()
	end

	local label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	if text then
		label:SetText(text)
	else
		label:SetText(ns[parent.tag.."_"..option])
	end
	-- label:SetWidth(440)
	label:SetHeight(20)
	label:SetJustifyH("LEFT")
	label:SetPoint("LEFT", 160, 4)
	f.label = label

	f.tooltipText = ns[parent.tag.."_"..option.."_desc"]
	if f.tooltipText then
		f:SetScript("OnEnter", function()
			GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 0, 0)
			GameTooltip:SetText(f.tooltipText, nil, nil, nil, nil, true)
		end)

		f:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	end

	f.group = parent.tag
	f.option = option

	f.needsReload = needsReload

	parent[option] = f

	tinsert(dropdowns, f)

	return f
end

-- [[ Categories and tabs ]]

local offset = 50
local activeTab = nil

local function setActiveTab(tab)
	activeTab = tab

	activeTab.panel.tab.Text:SetTextColor(1, 1, 1)

	activeTab.panel:Show()

	if activeTab.panel_2 then
		activeTab.panel.PrevPageButton:Show()
		activeTab.panel.PrevPageButton:Disable()
		activeTab.panel.NextPageButton:Enable()
		activeTab.panel.pageText:SetFormattedText(COLLECTION_PAGE_NUMBER, 1, activeTab.panel.maxPages)
		activeTab.panel.currentPage = 1
		activeTab.panel_2:Hide()
	end

	C.category = tab.panel.tag
end

local onTabClick = function(tab)
	activeTab.panel:Hide()

	activeTab.panel.tab.Text:SetTextColor(1, 0.82, 0)

	if activeTab.panel_2 then
		activeTab.panel.PrevPageButton:Hide()
		activeTab.panel_2:Hide()
	end

	if activeTab.panel_3 then
		activeTab.panel_3:Hide()
	end

	if activeTab.panel_4 then
		activeTab.panel_4:Hide()
	end

	setActiveTab(tab)

	ns.HideSpellList()
end

local function CreateOptionPanel(name, text, subText)
	local panel = CreateFrame("Frame", name, ShestakUIOptionsPanel)
	panel:SetSize(600, 670)
	panel:SetPoint("RIGHT", 0, 10)
	panel:EnableMouseWheel(true)
	panel:Hide()

	panel.Title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	panel.Title:SetPoint("TOPLEFT", 8, -16)
	panel.Title:SetText(text)

	panel.subText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	panel.subText:SetPoint("TOPLEFT", panel.Title, "BOTTOMLEFT", 0, -8)
	panel.subText:SetJustifyH("LEFT")
	panel.subText:SetJustifyV("TOP")
	panel.subText:SetSize(570, 30)
	panel.subText:SetText(subText)

	return panel
end

ns.addCategory = function(name, text, subText, num)
	local tab = CreateFrame("Button", nil, ShestakUIOptionsPanel)
	tab:SetPoint("TOPLEFT", 11, -offset)
	tab:SetSize(168, 22)

	tab.Text = tab:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	tab.Text:SetPoint("LEFT", tab, 8, 0)
	tab.Text:SetText(text)
	tab.Text:SetSize(160, 20)
	tab.Text:SetJustifyH("LEFT")

	tab:SetScript("OnMouseUp", onTabClick)
	offset = (offset + 24)

	local tag = strlower(name)
	local panel = CreateOptionPanel(baseName..name, text, subText)
	panel[1] = panel
	tinsert(panels, panel)

	tab.panel = panel
	panel.tab = tab
	panel.tag = tag
	ShestakUIOptionsPanel[tag] = panel

	local numPages = num or 1
	if numPages > 1 then
		local name2 = name.."2"
		local tag2 = strlower(name2)
		local panel_2 = CreateOptionPanel(baseName..name2, text, subText)
		panel[2] = panel_2
		tinsert(panels, panel_2)

		if name == "general" then
			panel_2.tag = "media"
		else
			panel_2.tag = tag
		end

		ShestakUIOptionsPanel[tag2] = panel_2
		tab.panel_2 = panel_2

		local PrevPageButton = CreateFrame("Button", baseName..name.."PrevButton", ShestakUIOptionsPanel)
		PrevPageButton:SetPoint("TOPRIGHT", -45, -44)
		PrevPageButton:SetSize(28, 28)
		PrevPageButton:SetHighlightTexture("Interface\Buttons\UI-Common-MouseHilight")
		PrevPageButton:Hide()
		PrevPageButton:Disable()

		local pageText = PrevPageButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		pageText:SetPoint("RIGHT", PrevPageButton, "LEFT", -5, 0)
		panel.pageText = pageText

		local NextPageButton = CreateFrame("Button", baseName..name.."NextButton", PrevPageButton)
		NextPageButton:SetPoint("LEFT", PrevPageButton, "RIGHT", 5, 0)
		NextPageButton:SetSize(28, 28)
		NextPageButton:SetHighlightTexture("Interface\Buttons\UI-Common-MouseHilight")

		panel.currentPage = 1
		panel.maxPages = numPages
		local function SetPage(prev)
			panel.currentPage = panel.currentPage + (prev and - 1 or 1)
			pageText:SetFormattedText(COLLECTION_PAGE_NUMBER, panel.currentPage, panel.maxPages)

			for i = 1, numPages do
				panel[i]:Hide()
			end

			if panel.currentPage == 1 then
				PrevPageButton:Disable()
				NextPageButton:Enable()
				panel[1]:Show()
			elseif panel.currentPage == 2 then
				PrevPageButton:Enable()
				if numPages > 2 then
					NextPageButton:Enable()
				else
					NextPageButton:Disable()
				end
				panel[2]:Show()
			elseif panel.currentPage == 3 then
				PrevPageButton:Enable()
				if numPages > 3 then
					NextPageButton:Enable()
				else
					NextPageButton:Disable()
				end
				panel[3]:Show()
			elseif panel.currentPage == 4 then
				PrevPageButton:Enable()
				NextPageButton:Disable()
				panel[4]:Show()
			end
		end

		PrevPageButton:SetScript("OnClick", function()
			SetPage(true)
		end)

		NextPageButton:SetScript("OnClick", function()
			SetPage(false)
		end)

		tinsert(ns.NextPrevButtons, PrevPageButton)
		tinsert(ns.NextPrevButtons, NextPageButton)

		panel.PrevPageButton = PrevPageButton
		panel.NextPageButton = NextPageButton

		panel:SetScript("OnMouseWheel", function(_, delta)
			if delta < 0 then
				NextPageButton:Click()
			end
		end)

		panel_2:SetScript("OnMouseWheel", function(_, delta)
			if delta > 0 then
				PrevPageButton:Click()
			end
		end)

		if numPages > 2 then
			local name3 = name.."3"
			local tag3 = strlower(name3)
			local panel_3 = CreateOptionPanel(baseName..name3, text, subText)
			panel[3] = panel_3
			tinsert(panels, panel_3)

			tab.panel_3 = panel_3
			panel_3.tag = tag
			ShestakUIOptionsPanel[tag3] = panel_3

			panel_2:SetScript("OnMouseWheel", function(_, delta)
				if delta > 0 then
					PrevPageButton:Click()
				elseif delta < 0 then
					NextPageButton:Click()
				end
			end)

			panel_3:SetScript("OnMouseWheel", function(_, delta)
				if delta > 0 then
					PrevPageButton:Click()
				end
			end)

			if numPages > 3 then
				local name4 = name.."4"
				local tag4 = strlower(name4)
				local panel_4 = CreateOptionPanel(baseName..name4, text, subText)
				panel[4] = panel_4
				tinsert(panels, panel_4)

				tab.panel_4 = panel_4
				panel_4.tag = tag
				ShestakUIOptionsPanel[tag4] = panel_4

				panel_3:SetScript("OnMouseWheel", function(_, delta)
					if delta > 0 then
						PrevPageButton:Click()
					elseif delta < 0 then
						NextPageButton:Click()
					end
				end)

				panel_4:SetScript("OnMouseWheel", function(_, delta)
					if delta > 0 then
						PrevPageButton:Click()
					end
				end)
			end
		end
	end
end

ns.addSubCategory = function(category, name)
	local header = category:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	header:SetText(name)
	header:SetTextColor(179/255, 211/255, 243/255)

	local line = category:CreateTexture(nil, "ARTWORK")
	line:SetSize(500, 1)
	line:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
	line:SetColorTexture(0.37, 0.3, 0.3, 1)

	return header, line
end

-- [[ Init ]]

local function changeProfile()
	local profile
	if ShestakUIOptionsGlobal[realm][name] == true then
		if ShestakUIOptionsPerChar == nil then
			ShestakUIOptionsPerChar = {}
		end
		profile = ShestakUIOptionsPerChar
	else
		profile = ShestakUIOptions
	end

	for group, options in pairs(profile) do
		if C[group] then
			for option, value in pairs(options) do
				if C[group][option] == nil or C[group][option] == value then
					profile[group][option] = nil
				else
					C[group][option] = value
				end
			end
		else
			profile[group] = nil
		end
	end

	C.options = profile
end

local function displaySettings()
	for _, box in pairs(checkboxes) do
		box:SetChecked(C[box.group][box.option])
		if box.children then toggleChildren(box, box:GetChecked()) end
	end

	userChangedSlider = false

	for _, slider in pairs(sliders) do
		local value = C[slider.group][slider.option]
		if T.screenHeight > 1200 and slider.group == "font" and slider.option ~= "nameplates_font_size" then
			value = value / T.mult
		end
		slider:SetValue(value)
		slider.textInput:SetText(floor(value * 1000) / 1000)
		slider.textInput:SetCursorPosition(0)
		slider.oldValue = value
	end

	userChangedSlider = true

	for _, editbox in pairs(editboxes) do
		editbox:SetText(C[editbox.group][editbox.option])
		editbox:SetCursorPosition(0)
		editbox.oldValue = C[editbox.group][editbox.option]
	end

	for _, dropdown in pairs(dropdowns) do
		local text = DropDownText[C[dropdown.group][dropdown.option]] or C[dropdown.group][dropdown.option]
		UIDropDownMenu_SetText(dropdown, text)
		dropdown.selectedValue = C[dropdown.group][dropdown.option]
		dropdown.oldValue = C[dropdown.group][dropdown.option]
	end
end

local init = CreateFrame("Frame")
init:RegisterEvent("PLAYER_LOGIN")
init:SetScript("OnEvent", function()
	if not ShestakUI then return end

	T, C = unpack(ShestakUI)

	local ShestakUIOptionsPanel = ShestakUIOptionsPanel

	StaticPopupDialogs.PERCHAR = {
		text = L_GUI_PER_CHAR,
		OnAccept = function()
			if ShestakUIOptionsPanel.ProfileBox:GetChecked() then
				ShestakUIOptionsGlobal[realm][name] = true
			else
				ShestakUIOptionsGlobal[realm][name] = false
			end
			changeProfile()
			ReloadUI()
		end,
		OnCancel = function()
			if ShestakUIOptionsPanel.ProfileBox:GetChecked() then
				ShestakUIOptionsPanel.ProfileBox:SetChecked(false)
			else
				ShestakUIOptionsPanel.ProfileBox:SetChecked(true)
			end
		end,
		button1 = ACCEPT,
		button2 = CANCEL,
		timeout = 0,
		whileDead = 1,
		preferredIndex = 5,
	}

	ShestakUIOptionsPanel.ProfileBox:SetChecked(ShestakUIOptionsGlobal[realm][name])
	ShestakUIOptionsPanel.ProfileBox:SetScript("OnClick", function()
		StaticPopup_Show("PERCHAR")
	end)

	ShestakUIOptionsPanel:SetTemplate("Transparent")

	local sunFrame = CreateFrame("Frame", nil, ShestakUIOptionsPanel)
	sunFrame:SetPoint("LEFT", 10, 9)
	sunFrame:SetSize(175, 670)
	sunFrame:CreateBackdrop("Overlay")
	sunFrame.backdrop:SetPoint("TOPLEFT", 0, 3)
	sunFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, -4)

	T.SkinCheckBox(ShestakUIOptionsPanel.ProfileBox)

	for _, panel in pairs(panels) do
		panel:CreateBackdrop("Overlay")
		panel.backdrop:SetPoint("TOPLEFT", -10, 2)
		panel.backdrop:SetPoint("BOTTOMRIGHT", -10, -5)
	end

	for _, button in pairs(ns.buttons) do
		button:SkinButton()
	end

	for _, button in pairs(ns.NextPrevButtons) do
		T.SkinNextPrevButton(button, nil, "Any")
	end

	for _, box in pairs(checkboxes) do
		T.SkinCheckBox(box)
	end

	for _, slider in pairs(sliders) do
		T.SkinSlider(slider)
		T.SkinEditBox(slider.textInput)
	end

	for _, picker in pairs(colourpickers) do
		local value = C[picker.group][picker.option]
		picker:SetTemplate("Transparent")
		picker:SetBackdropBorderColor(unpack(value))
		picker:SetBackdropColor(value[1], value[2], value[3], 0.3)
	end

	for _, editbox in pairs(editboxes) do
		T.SkinEditBox(editbox)
	end

	for _, dropdown in pairs(dropdowns) do
		T.SkinDropDownBox(dropdown)
	end

	local title = ShestakUIOptionsPanel:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	title:SetPoint("TOP", 0, -10)
	title:SetText("ShestakUI "..T.version)

	setActiveTab(ShestakUIOptionsPanel.general.tab)

	displaySettings()
end)