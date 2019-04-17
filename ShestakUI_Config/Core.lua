-- local F, C
local _, ns = ...

----------------------------------------------------------------------------------------
--	GUI for ShestakUI(by Haleth, Solor)
----------------------------------------------------------------------------------------
local realm = GetRealmName()
local name = UnitName("player")

local pysWidth, pysHeight = _G.GetPhysicalScreenSize()
local fixedHeight = 768 / pysHeight
local scale = tonumber(floor(fixedHeight*100 + .5)/100)
mult = fixedHeight / scale

-- [[ Variables ]]

ns.localization = {}
ns.buttons = {}

local checkboxes = {}
local radiobuttons = {}
local sliders = {}
local editboxes = {}
local dropdowns = {}
local colourpickers = {}
local panels = {}

-- cache old values to check whether UI needs to be reloaded
local old = {}
local oldRadioValues = {}
local oldColours = {}

-- local overrideReload = false
local userChangedSlider = true -- to use SetValue without triggering OnValueChanged
local baseName = "ShestakUIOptionsPanel"

local r, g, b

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

-- check if a reload is needed
local function checkIsReloadNeeded()
	-- if not overrideReload then -- can't check sliders for old value, always flag for reload when they change
		for frame, value in pairs(old) do
			if C[frame.group][frame.option] ~= value then
				setReloadNeeded(true)
				return
			end
		end

		for radioOptionGroup, radioOptionValues in pairs(oldRadioValues) do
			for option, value in pairs(radioOptionValues) do
				if C[radioOptionGroup][option] ~= value then
					setReloadNeeded(true)
					return
				end
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
	-- end
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
		if child.radioHeader then -- radio button group
			child.radioHeader:SetTextColor(tR, tG, tB)

			for _, radioButton in pairs(child.buttons) do
				radioButton:SetEnabled(checked)
				radioButton.text:SetTextColor(tR, tG, tB)
			end
		else
			child:SetEnabled(checked)
			child.Text:SetTextColor(tR, tG, tB)
		end
	end
end

local function toggle(self)
	local checked = self:GetChecked()

	if checked then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
	end
	if self.group == "error" then
		if self.option == "white" and checked then
			local black = ShestakUIOptionsPanelerror.black
			if black:GetChecked() then
				black:SetChecked(false)
				SaveValue(black, false)
				if old[black] == nil then
					old[black] = not black:GetChecked()
				end
			end
		end

		if self.option == "black" and checked then
			local white = ShestakUIOptionsPanelerror.white
			if white:GetChecked() then
				white:SetChecked(false)
				SaveValue(white, false)

				if old[white] == nil then
					old[white] = not white:GetChecked()
				end
			end
		end
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

ns.CreateCheckBox = function(parent, option, text, tooltipText)
	local f = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")

	f.group = parent.tag
	f.option = option

	f.Text:SetSize(520, 20)
	if text then
		f.Text:SetText(text)
	else
		f.Text:SetText(ns[parent.tag.."_"..option])
	end

	if tooltipText then
		f.tooltipText = tooltipText
	elseif ns[parent.tag.."_"..option.."_desc"] then
		f.tooltipText = ns[parent.tag.."_"..option.."_desc"]
	else
		f.tooltipText = text
	end

	f.needsReload = true

	f:SetScript("OnClick", toggle)
	parent[option] = f

	tinsert(checkboxes, f)

	return f
end

local function toggleRadio(self)
	local previousValue

	local index = 1
	local radioButton = self.parent[self.option..index]
	while radioButton do
		if radioButton.isChecked then
			previousValue = index

			if radioButton ~= self then
				radioButton.isChecked = false
				radioButton:SetChecked(false)
			end
		end

		index = index + 1
		radioButton = self.parent[self.option..index]
	end

	self:SetChecked(true) -- don't allow deselecting
	self.isChecked = true

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)

	SaveValue(self, self.index)

	if self.needsReload then
		if oldRadioValues[self.group] == nil then
			oldRadioValues[self.group] = {}

			if oldRadioValues[self.group][self.option] == nil then
				oldRadioValues[self.group][self.option] = previousValue
			end
		end

		checkIsReloadNeeded()
	end
end

local function radioOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
end

local function radioOnLeave(self)
	GameTooltip:Hide()
end

ns.CreateRadioButtonGroup = function(parent, option, numValues, tooltipText, needsReload)
	local group = {}
	group.buttons = {}

	for i = 1, numValues do
		local f = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")

		f.parent = parent
		f.group = parent.tag
		f.option = option
		f.index = i

		f.text:SetFontObject(GameFontHighlight)
		f.text:SetText(ns.localization[parent.tag..option..i])
		if tooltipText then
			f.tooltipText = ns.localization[parent.tag..option..i.."Tooltip"]
		end

		if needsReload then
			f.tooltipText = f.tooltipText and format("%s\n\n%s", f.tooltipText, ns.localization.requiresReload) or ns.localization.requiresReload
		end

		if f.tooltipText then
			f:HookScript("OnEnter", radioOnEnter)
			f:HookScript("OnLeave", radioOnLeave)
		end

		f.needsReload = needsReload

		f:SetScript("OnClick", toggleRadio)
		parent[option..i] = f

		-- return value
		tinsert(group.buttons, f)

		-- handling input, style, ...
		tinsert(radiobuttons, f)

		if i > 1 then
			f:SetPoint("TOP", parent[option..i-1], "BOTTOM", 0, -8)
		end
	end

	local firstOption = parent[option..1]

	-- add header
	local header = firstOption:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	header:SetPoint("BOTTOMLEFT", firstOption, "TOPLEFT", 2, 5)
	header:SetText(ns.localization[parent.tag..option])
	group.radioHeader = header

	return group
end

-- Sliders

local function onValueChanged(self, value)
	if self.step < 1 then
		value = string.format("%.2f", value)
	else
		value = floor(value + 0.5)
	end

	if self.textInput then
		self.textInput:SetText(value)
	end

	if userChangedSlider then
		SaveValue(self, value)

		if self.needsReload then
			-- if not true, don't set to false - something else might have changed it
			if self.step < 1 then
				self.oldValue = string.format("%.2f", self.oldValue)
			end
			old[self] = self.oldValue
			checkIsReloadNeeded()
			-- setReloadNeeded(true)
		end

		-- overrideReload = true
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

	if textDesc then
		f.tooltipText = textDesc
	elseif ns[parent.tag.."_"..option.."_desc"] then
		f.tooltipText = ns[parent.tag.."_"..option.."_desc"]
	else
		f.tooltipText = text
	end

	f.needsReload = needsReload
	f.step = step

	f:SetScript("OnValueChanged", onValueChanged)
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
	f:SetWidth(60)
	f:SetHeight(20)
	f:SetMaxLetters(8)
	f:SetFontObject(GameFontHighlight)

	f:SetPoint("LEFT", slider, "RIGHT", 20, 0)

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
	f:SetWidth(55)
	f:SetHeight(20)
	f:SetMaxLetters(8)
	f:SetFontObject(GameFontHighlight)

	f:SetPoint("LEFT", 40, 0)

	f.value = ""
	f.valueNumber = number and true or false

	f:SetScript("OnEscapePressed", onSliderEscapePressed)
	f:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText(f.value) end)
	f:SetScript("OnEnterPressed", onEnterPressed)
	f:SetScript("OnEditFocusGained", function(self) f.value = f:GetText() end)
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

	if ns[parent.tag.."_"..option.."_desc"] then
		f.tooltipText = ns[parent.tag.."_"..option.."_desc"]
	else
		f.tooltipText = text
	end

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

local function onColourSwatchClicked(self)
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

	-- local tex = f:CreateTexture(nil, "OVERLAY")
	-- tex:SetAllPoints()
	-- f.tex = tex

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

	f:SetScript("OnClick", onColourSwatchClicked)
	parent[option] = f

	tinsert(colourpickers, f)

	return f
end

-- DropDown

ns.CreateDropDown = function(parent, option, needsReload, text, tableValue)
	local f = CreateFrame("Frame", parent:GetName()..option.."DropDown", parent, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(f, 110)

	UIDropDownMenu_Initialize(f, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		for _, value in pairs(tableValue) do
			info.text = value
			info.arg1 = value
			info.checked = value == f.selectedValue
			UIDropDownMenu_AddButton(info)
		end
	end)

	function f:SetValue(newValue)
		f.selectedValue = newValue
		UIDropDownMenu_SetText(f, newValue)
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
	label:SetWidth(440)
	label:SetHeight(20)
	label:SetJustifyH("LEFT")
	label:SetPoint("LEFT", 160, 4)

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

	-- activeTab:SetBackdropColor(r, g, b, .6)
	activeTab.panel.tab.Text:SetTextColor(1, 1, 1)

	activeTab.panel:Show()
	if activeTab.panel.second then
		activeTab.panel.general:Show()
		-- activeTab.panel.optional:Show()
	end

	if activeTab.panel_2 then
		activeTab.panel_2:Hide()
	end
end

local onTabClick = function(tab)
	activeTab.panel:Hide()

	-- activeTab:SetBackdropColor(0, 0, 0, 0)
	activeTab.panel.tab.Text:SetTextColor(1, 0.82, 0)

	if activeTab.panel.second then
		activeTab.panel.general:Hide()
		activeTab.panel_2:Hide()

		activeTab.panel.general.Text:SetTextColor(1, 1, 1)
		activeTab.panel.optional.Text:SetTextColor(1, 0.82, 0)
	end

	if activeTab.panel.third then
		activeTab.panel_3:Hide()
		activeTab.panel.general.Text:SetTextColor(1, 1, 1)
		activeTab.panel.optional.Text:SetTextColor(1, 0.82, 0)
		activeTab.panel.more.Text:SetTextColor(1, 0.82, 0)
	end

	setActiveTab(tab)
end

ns.addCategory = function(name, text, subText, second, third)
	local tag = strlower(name)

	local panel = CreateFrame("Frame", baseName..name, ShestakUIOptionsPanel)
	panel:SetSize(600 * mult, 670 * mult)
	panel:SetPoint("RIGHT", 0, 10)
	panel:EnableMouseWheel(true)
	panel:Hide()

	local panel_2, panel_3
	if second then
		local name2 = name.."2"
		local tag2 = strlower(name2)
		panel_2 = CreateFrame("Frame", baseName..name2, ShestakUIOptionsPanel)
		panel_2:SetSize(600 * mult, 670 * mult)
		panel_2:SetPoint("RIGHT", 0, 10)
		panel_2:EnableMouseWheel(true)
		panel_2:Hide()

		local general = CreateFrame("Button", nil, ShestakUIOptionsPanel, "UIPanelButtonTemplate")
		general:SetPoint("TOPRIGHT", -190, -44)
		general:SetSize(128, 25)
		general:SetText(GENERAL_LABEL)
		general:SetWidth(general.Text:GetWidth() + 15)
		general.Text:SetTextColor(1, 1, 1)
		general:Hide()

		local optional = CreateFrame("Button", nil, general, "UIPanelButtonTemplate")
		optional:SetPoint("LEFT", general, "RIGHT", 5, 0)
		optional:SetSize(128, 25)
		optional:SetText(ADVANCED_LABEL)
		optional:SetWidth(optional.Text:GetWidth() + 15)

		general:SetScript("OnClick", function()
			panel:Show()
			panel_2:Hide()
			general.Text:SetTextColor(1, 1, 1)
			optional.Text:SetTextColor(1, 0.82, 0)
		end)

		optional:SetScript("OnClick", function()
			panel:Hide()
			panel_2:Show()
			general.Text:SetTextColor(1, 0.82, 0)
			optional.Text:SetTextColor(1, 1, 1)
		end)

		tinsert(panels, panel_2)
		tinsert(ns.buttons, general)
		tinsert(ns.buttons, optional)

		panel.second = true
		panel.general = general
		panel.optional = optional

		if name == "general" then
			panel_2.tag = "media"
		else
			panel_2.tag = tag
		end

		ShestakUIOptionsPanel[tag2] = panel_2

		panel_2.Title = panel_2:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		panel_2.Title:SetPoint("TOPLEFT", 8, -16)
		panel_2.Title:SetText(text)

		panel_2.subText = panel_2:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		panel_2.subText:SetPoint("TOPLEFT", panel_2.Title, "BOTTOMLEFT", 0, -8)
		panel_2.subText:SetJustifyH("LEFT")
		panel_2.subText:SetJustifyV("TOP")
		panel_2.subText:SetSize(570 * mult, 30 * mult)
		panel_2.subText:SetText(subText)

		panel:SetScript("OnMouseWheel", function(self, delta)
			if delta < 0 then
				optional:Click()
			end
		end)

		panel_2:SetScript("OnMouseWheel", function(self, delta)
			if delta > 0 then
				general:Click()
			end
		end)

		if third then
			local name3 = name.."3"
			local tag3 = strlower(name3)
			panel_3 = CreateFrame("Frame", baseName..name3, ShestakUIOptionsPanel)
			panel_3:SetSize(600 * mult, 670 * mult)
			panel_3:SetPoint("RIGHT", 0, 10)
			panel_3:EnableMouseWheel(true)
			panel_3:Hide()

			local general = CreateFrame("Button", nil, ShestakUIOptionsPanel, "UIPanelButtonTemplate")
			general:SetPoint("TOPRIGHT", -195, -44)
			general:SetSize(128, 25)
			general:SetText(GENERAL_LABEL)
			general:SetWidth(general.Text:GetWidth() + 15)
			general.Text:SetTextColor(1, 1, 1)
			general:Hide()

			local optional = CreateFrame("Button", nil, general, "UIPanelButtonTemplate")
			optional:SetPoint("LEFT", general, "RIGHT", 5, 0)
			optional:SetSize(128, 25)
			optional:SetText(ADVANCED_LABEL)
			optional:SetWidth(optional.Text:GetWidth() + 15)

			local more = CreateFrame("Button", nil, general, "UIPanelButtonTemplate")
			more:SetPoint("LEFT", optional, "RIGHT", 5, 0)
			more:SetSize(128, 25)
			more:SetText(LFG_LIST_MORE)
			more:SetWidth(more.Text:GetWidth() + 15)

			general:SetScript("OnClick", function()
				panel:Show()
				panel_2:Hide()
				panel_3:Hide()
				general.Text:SetTextColor(1, 1, 1)
				optional.Text:SetTextColor(1, 0.82, 0)
				more.Text:SetTextColor(1, 0.82, 0)
			end)

			optional:SetScript("OnClick", function()
				panel:Hide()
				panel_2:Show()
				panel_3:Hide()
				general.Text:SetTextColor(1, 0.82, 0)
				optional.Text:SetTextColor(1, 1, 1)
				more.Text:SetTextColor(1, 0.82, 0)
			end)

			more:SetScript("OnClick", function()
				panel:Hide()
				panel_2:Hide()
				panel_3:Show()
				general.Text:SetTextColor(1, 0.82, 0)
				optional.Text:SetTextColor(1, 0.82, 0)
				more.Text:SetTextColor(1, 1, 1)
			end)

			tinsert(panels, panel_3)
			tinsert(ns.buttons, general)
			tinsert(ns.buttons, optional)
			tinsert(ns.buttons, more)

			panel.third = true
			panel.general = general
			panel.optional = optional
			panel.more = more

			panel_3.tag = tag
			ShestakUIOptionsPanel[tag3] = panel_3

			panel_3.Title = panel_3:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			panel_3.Title:SetPoint("TOPLEFT", 8, -16)
			panel_3.Title:SetText(text)

			panel_3.subText = panel_3:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
			panel_3.subText:SetPoint("TOPLEFT", panel_3.Title, "BOTTOMLEFT", 0, -8)
			panel_3.subText:SetJustifyH("LEFT")
			panel_3.subText:SetJustifyV("TOP")
			panel_3.subText:SetSize(570 * mult, 30 * mult)
			panel_3.subText:SetText(subText)

			panel:SetScript("OnMouseWheel", function(self, delta)
				if delta < 0 then
					optional:Click()
				end
			end)

			panel_2:SetScript("OnMouseWheel", function(self, delta)
				if delta > 0 then
					general:Click()
				elseif delta < 0 then
					more:Click()
				end
			end)

			panel_3:SetScript("OnMouseWheel", function(self, delta)
				if delta > 0 then
					optional:Click()
				end
			end)
		end
	end

	panel.Title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	panel.Title:SetPoint("TOPLEFT", 8, -16)
	panel.Title:SetText(text)

	panel.subText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	panel.subText:SetPoint("TOPLEFT", panel.Title, "BOTTOMLEFT", 0, -8)
	panel.subText:SetJustifyH("LEFT")
	panel.subText:SetJustifyV("TOP")
	panel.subText:SetSize(570 * mult, 30 * mult)
	panel.subText:SetText(subText)

	local tab = CreateFrame("Button", nil, ShestakUIOptionsPanel)
	tab:SetPoint("TOPLEFT", 11, -offset)
	tab:SetSize(168 * mult, 22 * mult)

	tab.Text = tab:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	tab.Text:SetPoint("LEFT", tab, 8, 0)
	tab.Text:SetText(text)
	tab.Text:SetSize(160, 20)
	tab.Text:SetJustifyH("LEFT")

	tab:SetScript("OnMouseUp", onTabClick)

	tab.panel = panel
	tab.panel_2 = panel_2
	tab.panel_3 = panel_3
	panel.tab = tab
	panel.tag = tag

	ShestakUIOptionsPanel[tag] = panel

	tinsert(panels, panel)

	offset = (offset + 24) * mult
end

ns.addSubCategory = function(category, name)
	local header = category:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	header:SetText(name)
	header:SetTextColor(179/255, 211/255, 243/255)

	local line = category:CreateTexture(nil, "ARTWORK")
	line:SetSize(500 * mult, 1 * mult)
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
				if C[group][option] == nil or (group == "unitframes" and (tonumber(profile[group][option]) or type(profile[group][option]) == "table")) then
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

	for _, radio in pairs(radiobuttons) do
		local isChecked = C[radio.group][radio.option] == radio.index

		radio:SetChecked(isChecked)
		radio.isChecked = isChecked -- need this for storing the previous value when user changes setting
	end

	userChangedSlider = false

	for _, slider in pairs(sliders) do
		slider:SetValue(C[slider.group][slider.option])
		slider.textInput:SetText(floor(C[slider.group][slider.option]*1000)/1000)
		slider.textInput:SetCursorPosition(0)
		slider.oldValue = C[slider.group][slider.option]
	end

	userChangedSlider = true

	for _, picker in pairs(colourpickers) do
		-- local colourTable = C[picker.group][picker.option]
		-- picker.tex:SetVertexColor(unpack(colourTable))
	end

	for _, editbox in pairs(editboxes) do
		editbox:SetText(C[editbox.group][editbox.option])
		editbox:SetCursorPosition(0)
		editbox.oldValue = C[editbox.group][editbox.option]
	end

	for _, dropdown in pairs(dropdowns) do
		UIDropDownMenu_SetText(dropdown, C[dropdown.group][dropdown.option])
		dropdown.selectedValue = C[dropdown.group][dropdown.option]
		dropdown.oldValue = C[dropdown.group][dropdown.option]
	end
end

local init = CreateFrame("Frame")
init:RegisterEvent("PLAYER_LOGIN")
init:SetScript("OnEvent", function()
	if not ShestakUI then return end

	T, C, L = unpack(ShestakUI)

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

	-- F.CreateBD(ShestakUIOptionsPanel)
	-- F.CreateSD(ShestakUIOptionsPanel)

	ShestakUIOptionsPanel:SetTemplate("Transparent")

	local sunFrame = CreateFrame("Frame", nil, ShestakUIOptionsPanel)
	sunFrame:SetPoint("LEFT", 10, 9)
	sunFrame:SetSize(175, 670 * mult)
	sunFrame:CreateBackdrop("Overlay")
	sunFrame.backdrop:SetPoint("TOPLEFT", 0, 3)
	sunFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, -4)

	T.SkinCheckBox(ShestakUIOptionsPanel.ProfileBox)

	for _, panel in pairs(panels) do
		panel:CreateBackdrop("Overlay")
		panel.backdrop:SetPoint("TOPLEFT", -10, 2)
		panel.backdrop:SetPoint("BOTTOMRIGHT", -10, -5)
		-- local bg = F.CreateBDFrame(panel.tab.Icon)
		-- F.Reskin(panel.tab)
		-- panel.tab:SkinButton()
	end

	setActiveTab(ShestakUIOptionsPanel.general.tab)

	for _, button in pairs(ns.buttons) do
		button:SkinButton()
	end

	for _, box in pairs(checkboxes) do
		T.SkinCheckBox(box)
	end

	-- for _, radio in pairs(radiobuttons) do
		-- F.ReskinRadio(radio)
	-- end

	for _, slider in pairs(sliders) do
		T.SkinSlider(slider)
		-- slider.textInput:SetTemplate("Overlay")
		T.SkinEditBox(slider.textInput, nil, 18)
		-- F.ReskinSlider(slider)
		-- F.ReskinInput(slider.textInput)
		-- F.SetFS(slider.textInput)
		-- F.SetFS(slider.text)
	end

	for _, picker in pairs(colourpickers) do
		-- picker.tex:SetTexture(C.media.backdrop)
		-- F.CreateBG(picker)
		local value = C[picker.group][picker.option]
		picker:SetTemplate("Transparent")
		picker:SetBackdropBorderColor(unpack(value))
		picker:SetBackdropColor(value[1], value[2], value[3], 0.3)
	end

	for _, editbox in pairs(editboxes) do
		T.SkinEditBox(editbox, nil, 18)
	end

	for _, dropdown in pairs(dropdowns) do
		T.SkinDropDownBox(dropdown)
	end

	local title = ShestakUIOptionsPanel:CreateFontString("UIConfigTitleVer", "OVERLAY", "GameFontNormal")
	title:SetPoint("TOP", 0, -10)
	title:SetText("ShestakUI "..T.version)

	displaySettings()
end)