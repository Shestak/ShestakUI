local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Out of range check(tullaRange by Tuller)
----------------------------------------------------------------------------------------
-- Locals and speed
local _G = _G
local UPDATE_DELAY = 0.15
local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME
local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local ActionButton_GetPagedID = ActionButton_GetPagedID
local ActionButton_IsFlashing = ActionButton_IsFlashing
local ActionHasRange = ActionHasRange
local IsActionInRange = IsActionInRange
local IsUsableAction = IsUsableAction
local HasAction = HasAction

local function timer_Create(parent, interval)
	local updater = parent:CreateAnimationGroup()
	updater:SetLooping("NONE")
	updater:SetScript("OnFinished", function(self)
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

	parent.Active = function(self)
		return updater:IsPlaying()
	end

	return parent
end

-- Holy Power detection
local DIVINE_PURPOSE = GetSpellInfo(90174)
local isHolyPowerAbility
do
	local HOLY_POWER_SPELLS = {
		[85673] = GetSpellInfo(85673),		-- Word of Glory
		[114163] = GetSpellInfo(114163),	-- Eternal Flame
	}

	isHolyPowerAbility = function(actionId)
		local actionType, id = GetActionInfo(actionId)
		if actionType == "macro" then
			local macroSpell = GetMacroSpell(id)
			if macroSpell then
				for spellId, spellName in pairs(HOLY_POWER_SPELLS) do
					if macroSpell == spellName then
						return true
					end
				end
			end
		else
			return HOLY_POWER_SPELLS[id]
		end
		return false
	end
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
	tullaRange.UpdateFlash(button, elapsed)
end

function tullaRange:UpdateButtonStatus(button)
	local action = ActionButton_GetPagedID(button)
	if button:IsVisible() and action and HasAction(action) and ActionHasRange(action) then
		self.buttonsToUpdate[button] = true
	else
		self.buttonsToUpdate[button] = nil
	end
	self:UpdateActive()
end

-- Button Hooking
function tullaRange.RegisterButton(button)
	button:HookScript("OnShow", tullaRange.OnButtonShow)
	button:HookScript("OnHide", tullaRange.OnButtonHide)
	button:SetScript("OnUpdate", nil)

	tullaRange:UpdateButtonStatus(button)
end

function tullaRange.OnButtonShow(button)
	tullaRange:UpdateButtonStatus(button)
end

function tullaRange.OnButtonHide(button)
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
	local action = ActionButton_GetPagedID(button)
	local isUsable, notEnoughMana = IsUsableAction(action)

	-- Usable
	if isUsable then
		-- Out of range
		if IsActionInRange(action) == false then
			tullaRange.SetButtonColor(button, "oor")
		-- Holy Power
		elseif T.class == "PALADIN" and isHolyPowerAbility(action) and not (UnitPower("player", SPELL_POWER_HOLY_POWER) >= 3 or UnitBuff("player", DIVINE_PURPOSE)) then
			tullaRange.SetButtonColor(button, "ooh")
		-- In range
		else
			tullaRange.SetButtonColor(button, "normal")
		end
	-- Out of mana
	elseif notEnoughMana then
		tullaRange.SetButtonColor(button, "oom")
	-- Unusable
	else
		button.tullaRangeColor = "unusuable"
	end
end

function tullaRange.SetButtonColor(button, colorType)
	if button.tullaRangeColor ~= colorType then
		button.tullaRangeColor = colorType

		local r, g, b = tullaRange:GetColor(colorType)
		local icon = _G[button:GetName().."Icon"]
		icon:SetVertexColor(r, g, b)
	end
end

function tullaRange.UpdateFlash(button, elapsed)
	if ActionButton_IsFlashing(button) then
		local flashtime = button.flashtime - elapsed

		if flashtime <= 0 then
			local overtime = -flashtime
			if overtime >= ATTACK_BUTTON_FLASH_TIME then
				overtime = 0
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

			local flashTexture = _G[button:GetName().."Flash"]
			if flashTexture:IsShown() then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end

		button.flashtime = flashtime
	end
end

-- Configuration
function tullaRange:LoadDefaults()
	TULLARANGE_COLORS = {
		normal = {1, 1, 1},
		oor = {1, 0.1, 0.1},
		oom = {0.1, 0.3, 1},
		ooh = {0.45, 0.45, 1}
	}
end

function tullaRange:GetColor(index)
	local color = self.colors[index]
	return color[1], color[2], color[3]
end

-- Load The Thing
tullaRange:Load()