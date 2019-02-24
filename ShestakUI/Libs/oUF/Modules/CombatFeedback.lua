local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_combat_feedback ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_CombatFeedback(by Ammo)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local damage_format = "-%d"
local heal_format = "+%d"
local maxAlpha = 0.6
local updateFrame
local feedback = {}
local color
local colors = {
	STANDARD		= {1, 1, 1},
	-- Damage
	IMMUNE			= {1, 1, 1},
	DAMAGE			= {1, 0, 0},
	CRUSHING		= {1, 0, 0},
	CRITICAL		= {1, 0, 0},
	GLANCING		= {1, 0, 0},
	ABSORB			= {1, 1, 1},
	BLOCK			= {1, 1, 1},
	MISS			= {1, 1, 1},
	-- Heal
	HEAL			= {0, 1, 0},
	CRITHEAL		= {0, 1, 0},
	-- Energize
	ENERGIZE		= {0.41, 0.8, 0.94},
	CRITENERGIZE	= {0.41, 0.8, 0.94},
}

local function createUpdateFrame()
	if updateFrame then return end
	updateFrame = CreateFrame("Frame")
	updateFrame:Hide()
	updateFrame:SetScript("OnUpdate", function()
		if next(feedback) == nil then
			updateFrame:Hide()
			return
		end
		for object, startTime in pairs(feedback) do
			local maxalpha = object.CombatFeedbackText.maxAlpha
			local elapsedTime = GetTime() - startTime
			if elapsedTime < COMBATFEEDBACK_FADEINTIME then
				local alpha = maxalpha * (elapsedTime / COMBATFEEDBACK_FADEINTIME)
				object.CombatFeedbackText:SetAlpha(alpha)
			elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) then
				object.CombatFeedbackText:SetAlpha(maxalpha)
			elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) then
				local alpha = maxalpha - maxalpha * ((elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME)
				object.CombatFeedbackText:SetAlpha(alpha)
			else
				object.CombatFeedbackText:Hide()
				feedback[object] = nil
			end
		end
	end)
end

local function combat(self, event, unit, eventType, flags, amount)
	if unit ~= self.unit then return end
	if unit == "vehicle" then return end
	local FeedbackText = self.CombatFeedbackText
	local fColors = FeedbackText.colors
	local font, fontHeight, fontFlags = C.font.combat_text_font, C.font.combat_text_font_size, C.font.combat_text_font_style
	local text, arg
	color = fColors and fColors.STANDARD or colors.STANDARD
	if eventType == "IMMUNE" and not FeedbackText.ignoreImmune then
		color = fColors and fColors.IMMUNE or colors.IMMUNE
		fontHeight = fontHeight
		text = CombatFeedbackText[eventType]
	elseif eventType == "WOUND" and not FeedbackText.ignoreDamage then
		if amount ~= 0 then
			if flags == "CRITICAL" then
				color = fColors and fColors.CRITICAL or colors.CRITICAL
				fontHeight = fontHeight
			elseif flags == "CRUSHING" then
				color = fColors and fColors.CRUSING or colors.CRUSHING
				fontHeight = fontHeight
			elseif flags == "GLANCING" then
				color = fColors and fColors.GLANCING or colors.GLANCING
				fontHeight = fontHeight
			else
				color = fColors and fColors.DAMAGE or colors.DAMAGE
			end
			text = damage_format
			arg = amount
		elseif flags == "ABSORB" then
			color = fColors and fColors.ABSORB or colors.ABSORB
			fontHeight = fontHeight
			text = CombatFeedbackText["ABSORB"]
		elseif flags == "BLOCK" then
			color = fColors and fColors.BLOCK or colors.BLOCK
			fontHeight = fontHeight
			text = CombatFeedbackText["BLOCK"]
		else
			color = fColors and fColors.MISS or colors.MISS
			text = CombatFeedbackText["MISS"]
		end
	elseif eventType == "BLOCK" and not FeedbackText.ignoreDamage then
		color = fColors and fColors.BLOCK or colors.BLOCK
		fontHeight = fontHeight
		text = CombatFeedbackText[eventType]
	elseif eventType == "HEAL" and not FeedbackText.ignoreHeal then
		text = heal_format
		arg = amount
		if flags == "CRITICAL" then
			color = fColors and fColors.CRITHEAL or colors.CRITHEAL
			fontHeight = fontHeight
		else
			color = fColors and fColors.HEAL or colors.HEAL
		end
	elseif event == "ENERGIZE" and not FeedbackText.ignoreEnergize then
		text = amount
		if flags == "CRITICAL" then
			color = fColors and fColors.ENERGIZE or colors.ENERGIZE
			fontHeight = fontHeight
		else
			color = fColors and fColors.CRITENERGIZE or colors.CRITENERGIZE
		end
	elseif not FeedbackText.ignoreOther then
		text = CombatFeedbackText[eventType]
	end

	if text then
		FeedbackText:SetFont(font, fontHeight, fontFlags)
		FeedbackText:SetFormattedText(text, arg)
		FeedbackText:SetTextColor(unpack(color))
		FeedbackText:SetAlpha(0)
		FeedbackText:Show()
		feedback[self] = GetTime()
		updateFrame:Show()
	end
end

local function addCombat(object)
	if not object.CombatFeedbackText then return end

	local _, fontHeight = object.CombatFeedbackText:GetFont()
	object.CombatFeedbackText.origHeight = fontHeight
	object.CombatFeedbackText.maxAlpha = object.CombatFeedbackText.maxAlpha or maxAlpha
	createUpdateFrame()
	object:RegisterEvent("UNIT_COMBAT", combat)
end

for _, object in ipairs(oUF.objects) do addCombat(object) end
oUF:RegisterInitCallback(addCombat)