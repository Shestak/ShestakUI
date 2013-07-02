local T, C, L, _ = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.symbiosis ~= true then return end

----------------------------------------------------------------------------------------
--	Symbiosis info(module from bTooltip by Fernir)
----------------------------------------------------------------------------------------
local symbiosis = {
	gain = {
		["DEATHKNIGHT"] = {["DK_BLOOD"] = 113072, ["DK_FROST"] = 113516, ["DK_UNHOLY"] = 113516},
		["HUNTER"] = {["HUNTER_BM"] = 113073, ["HUNTER_MM"] = 113073, ["HUNTER_SV"] = 113073},
		["MAGE"] = {["MAGE_ARCANE"] = 113074, ["MAGE_FIRE"] = 113074, ["MAGE_FROST"] = 113074},
		["MONK"] = {["MONK_BREW"] = 113306, ["MONK_MIST"] = 127361, ["MONK_WIND"] = 113275},
		["PALADIN"] = {["PALADIN_HOLY"] = 113269, ["PALADIN_PROT"] = 113075, ["PALADIN_RET"] = 122287},
		["PRIEST"] = {["PRIEST_DISC"] = 113506, ["PRIEST_HOLY"] = 113506, ["PRIEST_SHADOW"] = 113277},
		["ROGUE"] = {["ROGUE_ASS"] = 113613, ["ROGUE_COMBAT"] = 113613, ["ROGUE_SUB"] = 113613},
		["SHAMAN"] = {["SHAMAN_ELE"] = 113286, ["SHAMAN_ENHANCE"] = 113286, ["SHAMAN_RESTO"] = 113289},
		["WARLOCK"] = {["WARLOCK_AFFLICTION"] = 113295, ["WARLOCK_DEMO"] = 113295, ["WARLOCK_DESTRO"] = 113295},
		["WARRIOR"] = {["WARRIOR_ARMS"] = 122294, ["WARRIOR_FURY"] = 122294, ["WARRIOR_PROT"] = 122286}
	},
	grant = {
		["DEATHKNIGHT"] = {["DRUID_BALANCE"] = 110570, ["DRUID_FERAL"] = 122282, ["DRUID_GUARDIAN"] = 122285, ["DRUID_RESTO"] = 110575},
		["HUNTER"] = {["DRUID_BALANCE"] = 110588, ["DRUID_FERAL"] = 110597, ["DRUID_GUARDIAN"] = 110600, ["DRUID_RESTO"] = 19263},
		["MAGE"] = {["DRUID_BALANCE"] = 110621, ["DRUID_FERAL"] = 110693, ["DRUID_GUARDIAN"] = 110694, ["DRUID_RESTO"] = 110696},
		["MONK"] = {["DRUID_BALANCE"] = 126458, ["DRUID_FERAL"] = 128844, ["DRUID_GUARDIAN"] = 126453, ["DRUID_RESTO"] = 126456},
		["PALADIN"] = {["DRUID_BALANCE"] = 110698, ["DRUID_FERAL"] = 110700, ["DRUID_GUARDIAN"] = 110701, ["DRUID_RESTO"] = 122288},
		["PRIEST"] = {["DRUID_BALANCE"] = 110707, ["DRUID_FERAL"] = 110715, ["DRUID_GUARDIAN"] = 110717, ["DRUID_RESTO"] = 110718},
		["ROGUE"] = {["DRUID_BALANCE"] = 110788, ["DRUID_FERAL"] = 110730, ["DRUID_GUARDIAN"] = 122289, ["DRUID_RESTO"] = 110791},
		["SHAMAN"] = {["DRUID_BALANCE"] = 110802, ["DRUID_FERAL"] = 110807, ["DRUID_GUARDIAN"] = 110803, ["DRUID_RESTO"] = 110806},
		["WARLOCK"] = {["DRUID_BALANCE"] = 122291, ["DRUID_FERAL"] = 110810, ["DRUID_GUARDIAN"] = 122290, ["DRUID_RESTO"] = 112970},
		["WARRIOR"] = {["DRUID_BALANCE"] = 122292, ["DRUID_FERAL"] = 112997, ["DRUID_GUARDIAN"] = 113002, ["DRUID_RESTO"] = 113004}
	}
}

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local unit = (select(2, self:GetUnit())) or (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover") or nil
	if unit then
		if UnitIsPlayer(unit) and not UnitIsEnemy(unit, "player") then
			for i = 1, 40 do
				if select(11, UnitAura(unit, i, "HELPFUL")) == 110309 then return end
			end
			local _, uclass = UnitClass(unit)
			local ulevel = UnitLevel(unit)
			local uspec = GetSpecialization()
			if not uspec then return end
			local spec = SPEC_CORE_ABILITY_TEXT[GetSpecializationInfo(uspec)]
			local spellID
			if T.class == "DRUID" and T.level >= 87 and uclass ~= "DRUID" then
				spellID = symbiosis.grant[uclass][spec]
			elseif T.class ~= "DRUID" and (uclass == "DRUID" and ulevel >= 87) then
				spellID = symbiosis.gain[T.class][spec]
			end
			local name = GetSpellInfo(spellID)
			if name then
				GameTooltip:AddLine(GetSpellInfo(110309)..": |cffffffff"..name.."|r")
			end
		end
	end
end)