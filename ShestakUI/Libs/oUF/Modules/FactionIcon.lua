local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_PVPSpecIcons
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local Update = function(self, event, unit)
	if event == "ARENA_OPPONENT_UPDATE" and unit ~= self.unit then return end
	local element = self.FactionIcon

	local _, instanceType = IsInInstance()
	if instanceType ~= "pvp" then
		element:Hide()
		return
	else
		element:Show()
	end

	if element.PreUpdate then element:PreUpdate(event) end

	if UnitIsEnemy(self.unit, "player") and UnitIsPlayer(self.unit) then
		element:Show()
	else
		element:Hide()
	end

	if element.PostUpdate then element:PostUpdate(event) end
end

local Enable = function(self)
	local element = self.FactionIcon
	if element then
		self:RegisterEvent("ARENA_OPPONENT_UPDATE", Update, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update, true)

		if UnitFactionGroup("player") == "Horde" then
			element:SetAtlas("nameplates-icon-bounty-alliance")
		else
			element:SetAtlas("nameplates-icon-bounty-horde")
		end

		return true
	end
end

local Disable = function(self)
	local element = self.FactionIcon
	if element then
		self:UnregisterEvent("ARENA_OPPONENT_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		element:Hide()
	end
end

oUF:AddElement("FactionIcon", Update, Enable, Disable)