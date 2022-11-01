local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	ActionBar(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar1Holder", ActionBarAnchor, "SecureHandlerStateTemplate")
if C.actionbar.editor then
	local NumRow = ceil(C.actionbar.bar1_num / C.actionbar.bar1_row)
	bar:SetWidth((C.actionbar.bar1_size * C.actionbar.bar1_row) + (C.actionbar.button_space * (C.actionbar.bar1_row - 1)))
	bar:SetHeight((C.actionbar.bar1_size * NumRow) + (C.actionbar.button_space * (NumRow - 1)))
	bar:SetPoint("BOTTOMLEFT", ActionBarAnchor, 0, 0)
else
	bar:SetAllPoints(ActionBarAnchor)
end

local NumPerRows = C.actionbar.bar1_row
local NextRowButtonAnchor = _G["ActionButton1"]
for i = 1, 12 do
	local b = _G["ActionButton"..i]
	b:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	b:ClearAllPoints()
	-- b:SetParent(Bar1Holder)
	if C.actionbar.editor then
		if i <= C.actionbar.bar1_num then
			if i == 1 then
				b:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
			elseif i == NumPerRows + 1 then
				b:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -C.actionbar.button_space)

				NumPerRows = NumPerRows + C.actionbar.bar1_row
				NextRowButtonAnchor = _G["ActionButton"..i]
			else
				b:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", T.Scale(C.actionbar.button_space), 0)
			end
		else
			b:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
	else
		if i == 1 then
			b:SetPoint("BOTTOMLEFT", Bar1Holder, 0, 0)
		else
			local previous = _G["ActionButton"..i-1]
			b:SetPoint("LEFT", previous, "RIGHT", T.Scale(C.actionbar.button_space), 0)
		end
	end
end

local Page = {
	["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
	["ROGUE"] = "[bonusbar:1] 7;",
	["DEFAULT"] = "[possessbar] 16; [shapeshift] 17; [overridebar] 18; [vehicleui] 16; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
}

local function GetBar()
	local condition = Page["DEFAULT"]
	local class = T.class
	local page = Page[class]
	if page then
		condition = condition.." "..page
	end
	condition = condition.." 1"
	return condition
end

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
bar:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR")
bar:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			local button = _G["ActionButton"..i]
			self:SetFrameRef("ActionButton"..i, button)
			button:SetParent(Bar1Holder)
		end

		self:Execute([[
			buttons = table.new()
			for i = 1, 12 do
				table.insert(buttons, self:GetFrameRef("ActionButton"..i))
			end
		]])

		self:SetAttribute("_onstate-page", [[
			for i, button in ipairs(buttons) do
				button:SetAttribute("actionpage", tonumber(newstate))
			end
		]])

		RegisterStateDriver(self, "page", GetBar())
	elseif event == "UPDATE_VEHICLE_ACTIONBAR" or event == "UPDATE_OVERRIDE_ACTIONBAR" then
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			local button = _G["ActionButton"..i]
			local action = button.action
			local icon = button.icon

			if action >= 120 then
				local texture = GetActionTexture(action)

				if texture then
					icon:SetTexture(texture)
					icon:Show()
				else
					if icon:IsShown() then
						icon:Hide()
					end
				end
			end
		end
	end
end)

if C.actionbar.bottombars_mouseover then
	for i = 1, 12 do
		local b = _G["ActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() BottomBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then BottomBarMouseOver(0) end end)
	end
end

if C.actionbar.editor and C.actionbar.bar1_mouseover then
	for i = 1, 12 do
		local b = _G["ActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() Bar1MouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then Bar1MouseOver(0) end end)
	end

	bar:SetScript("OnEnter", function() Bar1MouseOver(1) end)
	bar:SetScript("OnLeave", function() if not HoverBind.enabled then Bar1MouseOver(0) end end)
end