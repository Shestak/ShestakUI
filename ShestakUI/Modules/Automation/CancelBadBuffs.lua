local T, C, L, _ = unpack(select(2, ...))
if C.automation.cancel_bad_buffs ~= true then return end

----------------------------------------------------------------------------------------
--	Auto cancel various buffs(by Unknown)
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = select(1, GetSpellInfo(id))
	return name
end

local blacklist = {
	[SpellName(58493)] = true,	-- Mohawked!
	[SpellName(44212)] = true,	-- Jack-o'-Lanterned!
	[SpellName(61716)] = true,	-- Rabbit Costume
	[SpellName(24724)] = true,	-- Skeleton Costume
	[SpellName(24732)] = true,	-- Bat Costume
	[SpellName(24741)] = true,	-- Wisp Costume
	[SpellName(24737)] = true,	-- Ghost Costume
	[SpellName(24711)] = true,	-- Pirate Costume
	[SpellName(61781)] = true,	-- Turkey Feathers
	[SpellName(61734)] = true,	-- Noblegarden Bunny
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, unit)
	if unit ~= "player" then return end

	if event == "UNIT_AURA" then
		for buff, enabled in next, blacklist do
			if UnitAura(unit, buff) and enabled and not InCombatLockdown() then
				CancelUnitBuff(unit, buff)
				print("|cffffff00"..ACTION_SPELL_AURA_REMOVED.."|r "..(GetSpellLink(buff) or ("|cffffff00["..buff.."]|r")).."|cffffff00.|r")
			end
		end
	end
end)