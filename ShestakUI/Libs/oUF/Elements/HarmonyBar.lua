if select(2, UnitClass('player')) ~= 'MONK' then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_LIGHT_FORCE = SPELL_POWER_LIGHT_FORCE

local Colors = {
	[1] = {.57, .63, .35, 1},
	[2] = {.47, .63, .35, 1},
	[3] = {.37, .63, .35, 1},
	[4] = {.27, .63, .33, 1},
	[5] = {.17, .63, .33, 1},
}

local function UpdateBar(self, event, unit, numPoints)
	local hb = self.HarmonyBar

	if UnitHasVehicleUI("player") then
		hb:Hide()
	else
		hb:Show()
	end

	if hb.numPoints ~= numPoints then
		if numPoints == 4 then
			local spacing = select(4, hb[4]:GetPoint())
			hb[5]:Hide()
			hb[4]:SetWidth(hb[4].W + hb[5].W + spacing)
		else
			hb[5]:Show()
			hb[4]:SetWidth(hb[4].W)
		end

		hb.numPoints = numPoints
	end
end

local function Update(self, event, unit)
	local hb = self.HarmonyBar
	local light = UnitPower("player", SPELL_POWER_LIGHT_FORCE)

	-- if max light changed, show/hide the 5th and update anchors
	local numPoints = UnitPowerMax("player", SPELL_POWER_LIGHT_FORCE)

	for i = 1, numPoints do
		if i <= light then
			hb[i]:SetAlpha(1)
		else
			hb[i]:SetAlpha(.2)
		end
	end

	UpdateBar(self, event, unit, numPoints)
end

local function Enable(self, unit)
	local hb = self.HarmonyBar
	if hb and unit == "player" then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:RegisterEvent("UNIT_POWER", Update)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Update)
		self:RegisterEvent("PLAYER_LEVEL_UP", Update)

		for i = 1, 5 do
			local Point = hb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetStatusBarColor(unpack(Colors[i]))
			Point:SetFrameLevel(hb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			Point.W = Point:GetWidth()
		end

		hb.numPoints = 5

		return true
	end
end

local function Disable(self)
	if self.HarmonyBar then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:UnregisterEvent("UNIT_POWER", Update)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Update)
		self:UnregisterEvent("PLAYER_LEVEL_UP", Update)
	end
end

oUF:AddElement('HarmonyBar', Update, Enable, Disable)
