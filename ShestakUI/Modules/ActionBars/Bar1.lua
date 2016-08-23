local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	ActionBar(by Tukz)
----------------------------------------------------------------------------------------
local bar = CreateFrame("Frame", "Bar1Holder", ActionBarAnchor, "SecureHandlerStateTemplate")
bar:SetAllPoints(ActionBarAnchor)

for i = 1, 12 do
	local button = _G["ActionButton"..i]
	button:SetSize(C.actionbar.button_size, C.actionbar.button_size)
	button:ClearAllPoints()
	button:SetParent(Bar1Holder)
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", Bar1Holder, 0, 0)
	else
		local previous = _G["ActionButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", C.actionbar.button_space, 0)
	end
end

local Page = {
	["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
	["ROGUE"] = "[bonusbar:1] 7;",
	["DEFAULT"] = "[vehicleui][possessbar] 12; [shapeshift] 13; [overridebar] 14; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
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
bar:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			local button = _G["ActionButton"..i]
			self:SetFrameRef("ActionButton"..i, button)
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
		if not InCombatLockdown() and (HasVehicleActionBar() or HasOverrideActionBar()) then
			for i = 1, NUM_ACTIONBAR_BUTTONS do
				local button = _G["ActionButton"..i]
				ActionButton_Update(button)
			end
		end
	else
		MainMenuBar_OnEvent(self, event, ...)
	end
end)