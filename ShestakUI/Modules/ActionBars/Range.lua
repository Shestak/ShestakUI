local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Out of range check(tullaRange by Tuller)
----------------------------------------------------------------------------------------
-- Locals and speed
local _G = _G
local next = next
local pairs = pairs

local UPDATE_DELAY = 0.15
local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME

local IsActionInRange = IsActionInRange
local IsUsableAction = IsUsableAction
local HasAction = HasAction

local function timer_Create(parent, interval)
	local updater = parent:CreateAnimationGroup()
	updater:SetLooping("NONE")
	updater:SetScript("OnFinished", function()
		if parent:Update() then
			parent:Start(interval)
		end
	end)

	local a = updater:CreateAnimation("Animation")
	a:SetOrder(1)

	parent.Start = function(self)
		self:Stop()
		a:SetDuration(interval)
		updater:Play()
		return self
	end

	parent.Stop = function(self)
		if updater:IsPlaying() then
			updater:Stop()
		end
		return self
	end

	parent.Active = function()
		return updater:IsPlaying()
	end

	return parent
end

-- Main thing
local tullaRange = timer_Create(CreateFrame("Frame", "tullaRange"), UPDATE_DELAY)

function tullaRange:Load()
	self:SetScript("OnEvent", self.OnEvent)
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_LOGOUT")
end

-- Frame Events
function tullaRange:OnEvent(event, ...)
	local action = self[event]
	if action then
		action(self, event, ...)
	end
end

-- Game Events
function tullaRange:PLAYER_LOGIN()
	if not TULLARANGE_COLORS then
		self:LoadDefaults()
	end
	self.colors = TULLARANGE_COLORS

	self.buttonsToUpdate = {}

	hooksecurefunc("ActionButton_OnUpdate", self.RegisterButton)
	hooksecurefunc("ActionButton_UpdateUsable", self.OnUpdateButtonUsable)
	hooksecurefunc("ActionButton_Update", self.OnButtonUpdate)
end

-- Actions
function tullaRange:Update()
	return self:UpdateButtons(UPDATE_DELAY)
end

function tullaRange:ForceColorUpdate()
	for button in pairs(self.buttonsToUpdate) do
		tullaRange.OnUpdateButtonUsable(button)
	end
end

function tullaRange:UpdateActive()
	if next(self.buttonsToUpdate) then
		if not self:Active() then
			self:Start()
		end
	else
		self:Stop()
	end
end

function tullaRange:UpdateButtons(elapsed)
	if next(self.buttonsToUpdate) then
		for button in pairs(self.buttonsToUpdate) do
			self:UpdateButton(button, elapsed)
		end
		return true
	end
	return false
end

function tullaRange:UpdateButton(button, elapsed)
	tullaRange.UpdateButtonUsable(button)
	tullaRange.UpdateButtonFlash(button, elapsed)
end

function tullaRange:UpdateButtonStatus(button)
	local action = button.action
	if action and button:IsVisible() and HasAction(action) then
		self.buttonsToUpdate[button] = true
	else
		self.buttonsToUpdate[button] = nil
	end
	self:UpdateActive()
end

-- Button Hooking
function tullaRange.RegisterButton(button)
	button:HookScript("OnShow", tullaRange.OnButtonUpdate)
	button:HookScript("OnHide", tullaRange.OnButtonUpdate)
	button:SetScript("OnUpdate", nil)

	tullaRange:UpdateButtonStatus(button)
end

function tullaRange.OnUpdateButtonUsable(button)
	button.tullaRangeColor = nil
	tullaRange.UpdateButtonUsable(button)
end

function tullaRange.OnButtonUpdate(button)
	tullaRange:UpdateButtonStatus(button)
end

-- Range Coloring
function tullaRange.UpdateButtonUsable(button)
	local action = button.action
	local isUsable, notEnoughMana = IsUsableAction(action)

	-- Usable
	if isUsable then
		-- Out of range
		if IsActionInRange(action) == false then
			tullaRange.SetButtonColor(button, "oor")
		-- In range
		else
			tullaRange.SetButtonColor(button, "normal")
		end
	-- Out of mana
	elseif notEnoughMana then
		tullaRange.SetButtonColor(button, "oom")
	-- Unusable
	else
		tullaRange.SetButtonColor(button, "unusable")
	end
end

function tullaRange.SetButtonColor(button, colorType)
	if button.tullaRangeColor ~= colorType then
		button.tullaRangeColor = colorType

		local r, g, b = tullaRange:GetColor(colorType)
		button.icon:SetVertexColor(r, g, b)
	end
end

function tullaRange.UpdateButtonFlash(button, elapsed)
	if button.flashing ~= 1 then return end

	local flashtime = button.flashtime - elapsed

	if flashtime <= 0 then
		local overtime = -flashtime
		if overtime >= ATTACK_BUTTON_FLASH_TIME then
			overtime = 0
		end
		flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

		local flashTexture = button.Flash
		if flashTexture:IsShown() then
			flashTexture:Hide()
		else
			flashTexture:Show()
		end
	end

	button.flashtime = flashtime
end

-- Configuration
function tullaRange:LoadDefaults()
	TULLARANGE_COLORS = {
		normal = {1, 1, 1},
		oor = {1, 0.3, 0.1},
		oom = {0.1, 0.3, 1},
		unusable = {0.4, 0.4, 0.4}
	}
end

function tullaRange:GetColor(index)
	local color = self.colors[index]
	return color[1], color[2], color[3]
end

-- Load The Thing
tullaRange:Load()