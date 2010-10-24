if SettingsCF.unitframe.enable ~= true or SettingsCF.unitframe.plugins_talents ~= true then return end
if not oUF then return end

local spells =  {
	-- WARRIOR
	[GetSpellInfo(12294)] = L_PLANNER_WARRIOR_1,		-- Mortal Strike
	[GetSpellInfo(46924)] = L_PLANNER_WARRIOR_1,		-- Bladestorm
	[GetSpellInfo(23881)] = L_PLANNER_WARRIOR_2,		-- Bloodthirst
	[GetSpellInfo(12809)] = L_PLANNER_WARRIOR_3,		-- Concussion Blow
	[GetSpellInfo(20243)] = L_PLANNER_WARRIOR_3,		-- Devastate
	-- PALADIN
	[GetSpellInfo(31935)] = L_PLANNER_PALADIN_2,		-- Avenger's Shield
	[GetSpellInfo(20473)] = L_PLANNER_PALADIN_1,		-- Holy Shock
	[GetSpellInfo(35395)] = L_PLANNER_PALADIN_3,		-- Crusader Strike
	[GetSpellInfo(53385)] = L_PLANNER_PALADIN_3,		-- Divine Storm
	[GetSpellInfo(20066)] = L_PLANNER_PALADIN_3,		-- Repentance
	-- ROGUE
	[GetSpellInfo(1329)] = L_PLANNER_ROGUE_1,			-- Mutilate
	[GetSpellInfo(51690)] = L_PLANNER_ROGUE_2,			-- Killing Spree
	[GetSpellInfo(13877)] = L_PLANNER_ROGUE_2,			-- Blade Flurry
	[GetSpellInfo(13750)] = L_PLANNER_ROGUE_2,			-- Adrenaline Rush
	[GetSpellInfo(16511)] = L_PLANNER_ROGUE_3,			-- Hemorrhage
	-- PRIEST
	[GetSpellInfo(47540)] = L_PLANNER_PRIEST_1,			-- Penance
	[GetSpellInfo(10060)] = L_PLANNER_PRIEST_1,			-- Power Infusion
	[GetSpellInfo(33206)] = L_PLANNER_PRIEST_1,			-- Pain Suppression
	[GetSpellInfo(34861)] = L_PLANNER_PRIEST_2,			-- Circle of Healing
	[GetSpellInfo(15487)] = L_PLANNER_PRIEST_3,			-- Silence
	[GetSpellInfo(34914)] = L_PLANNER_PRIEST_3,			-- Vampiric Touch
	-- DEATHKNIGHT
	[GetSpellInfo(55050)] = L_PLANNER_DEATHKNIGHT_1,	-- Heart Strike
	[GetSpellInfo(49203)] = L_PLANNER_DEATHKNIGHT_2,	-- Hungering Cold
	[GetSpellInfo(49143)] = L_PLANNER_DEATHKNIGHT_2,	-- Frost Strike
	[GetSpellInfo(49184)] = L_PLANNER_DEATHKNIGHT_2,	-- Howling Blast
	[GetSpellInfo(55090)] = L_PLANNER_DEATHKNIGHT_3,	-- Scourge Strike
	-- MAGE
	[GetSpellInfo(44425)] = L_PLANNER_MAGE_1,			-- Arcane Barrage
	[GetSpellInfo(44457)] = L_PLANNER_MAGE_2,			-- Living Bomb
	[GetSpellInfo(31661)] = L_PLANNER_MAGE_2,			-- Dragon's Breath
	[GetSpellInfo(11113)] = L_PLANNER_MAGE_2,			-- Blast Wave
	[GetSpellInfo(44572)] = L_PLANNER_MAGE_3,			-- Deep Freeze
	-- WARLOCK
	[GetSpellInfo(48181)] = L_PLANNER_WARLOCK_1,		-- Haunt
	[GetSpellInfo(30108)] = L_PLANNER_WARLOCK_1,		-- Unstable Affliction
	[GetSpellInfo(59672)] = L_PLANNER_WARLOCK_2,		-- Metamorphosis
	[GetSpellInfo(50796)] = L_PLANNER_WARLOCK_3,		-- Chaos Bolt
	[GetSpellInfo(30283)] = L_PLANNER_WARLOCK_3,		-- Shadowfury
	-- SHAMAN
	[GetSpellInfo(51490)] = L_PLANNER_SHAMAN_1,			-- Thunderstorm
	[GetSpellInfo(16166)] = L_PLANNER_SHAMAN_1,			-- Elemental Mastery
	[GetSpellInfo(51533)] = L_PLANNER_SHAMAN_2,			-- Feral Spirit
	[GetSpellInfo(30823)] = L_PLANNER_SHAMAN_2,			-- Shamanistic Rage
	[GetSpellInfo(17364)] = L_PLANNER_SHAMAN_2,			-- Stormstrike
	[GetSpellInfo(61295)] = L_PLANNER_SHAMAN_3,			-- Riptide
	[GetSpellInfo(51886)] = L_PLANNER_SHAMAN_3,			-- Cleanse Spirit
	-- HUNTER
	[GetSpellInfo(19577)] = L_PLANNER_HUNTER_1,			-- Intimidation
	[GetSpellInfo(34490)] = L_PLANNER_HUNTER_2,			-- Silencing Shot
	[GetSpellInfo(53209)] = L_PLANNER_HUNTER_2,			-- Chimera Shot
	[GetSpellInfo(53301)] = L_PLANNER_HUNTER_3,			-- Explosive Shot
	[GetSpellInfo(19386)] = L_PLANNER_HUNTER_3,			-- Wyvern Sting
	-- DRUID
	[GetSpellInfo(48505)] = L_PLANNER_DRUID_1,			-- Starfall
	[GetSpellInfo(50516)] = L_PLANNER_DRUID_1,			-- Typhoon
	[GetSpellInfo(33876)] = L_PLANNER_DRUID_2,			-- Mangle (Cat)
	[GetSpellInfo(33878)] = L_PLANNER_DRUID_2,			-- Mangle (Bear)
	[GetSpellInfo(18562)] = L_PLANNER_DRUID_3,			-- Swiftmend
}

local buffs = { -- Credits: Proditor, Rinu
	-- WARRIOR
	[GetSpellInfo(56638)] = L_PLANNER_WARRIOR_1,		-- Taste for Blood
	[GetSpellInfo(64976)] = L_PLANNER_WARRIOR_1,		-- Juggernaut
	[GetSpellInfo(29801)] = L_PLANNER_WARRIOR_2,		-- Rampage
	[GetSpellInfo(50227)] = L_PLANNER_WARRIOR_3,		-- Sword and Board
	-- PALADIN
	[GetSpellInfo(85126)] = L_PLANNER_PALADIN_3,		-- Seals of Command
	--[GetSpellInfo(31836)] = L_PLANNER_PALADIN_1,		-- Light's Grace
	-- ROGUE
	[GetSpellInfo(36554)] = L_PLANNER_ROGUE_3,			-- Shadowstep
	[GetSpellInfo(31223)] = L_PLANNER_ROGUE_3,			-- Master of Subtlety
	-- PRIEST
	[GetSpellInfo(47788)] = L_PLANNER_PRIEST_2,			-- Guardian Spirit
	[GetSpellInfo(52797)] = L_PLANNER_PRIEST_1,			-- Borrowed Time
	[GetSpellInfo(15473)] = L_PLANNER_PRIEST_3,			-- Shadowform
	[GetSpellInfo(15286)] = L_PLANNER_PRIEST_3,			-- Vampiric Embrace
	-- DEATHKNIGHT
	[GetSpellInfo(49222)] = L_PLANNER_DEATHKNIGHT_3,	-- Bone Shield
	[GetSpellInfo(49016)] = L_PLANNER_DEATHKNIGHT_1,	-- Hysteria
	[GetSpellInfo(53138)] = L_PLANNER_DEATHKNIGHT_1,	-- Abomination's Might
	[GetSpellInfo(55610)] = L_PLANNER_DEATHKNIGHT_2,	-- Improved Icy Talons
	-- MAGE
	[GetSpellInfo(11426)] = L_PLANNER_MAGE_3,			-- Ice Barrier
	[GetSpellInfo(11129)] = L_PLANNER_MAGE_2,			-- Combustion
	[GetSpellInfo(82930)] = L_PLANNER_MAGE_1,			-- Arcane Tactics
	-- WARLOCK
	[GetSpellInfo(30301)] = L_PLANNER_WARLOCK_3,		-- Nether Protection
	-- SHAMAN
	[GetSpellInfo(77746)] = L_PLANNER_SHAMAN_1,			-- Totem of Wrath
	[GetSpellInfo(974)] = L_PLANNER_SHAMAN_3,			-- Earth Shield
	[GetSpellInfo(51470)] = L_PLANNER_SHAMAN_1,			-- Elemental Oath
	[GetSpellInfo(30808)] = L_PLANNER_SHAMAN_2,			-- Unleashed Rage
	-- HUNTER
	[GetSpellInfo(20895)] = L_PLANNER_HUNTER_1,			-- Spirit Bond
	[GetSpellInfo(19506)] = L_PLANNER_HUNTER_2,			-- Trueshot Aura
	-- DRUID
	[GetSpellInfo(17007)] = L_PLANNER_DRUID_2,			-- Leader of the Pack
	[GetSpellInfo(33891)] = L_PLANNER_DRUID_3,			-- Tree of Life
	[GetSpellInfo(24907)] = L_PLANNER_DRUID_1,			-- Moonkin Aura
	[GetSpellInfo(24858)] = L_PLANNER_DRUID_1,			-- Moonkin Form
	[GetSpellInfo(48438)] = L_PLANNER_DRUID_3,			-- Wild Growth
}

local function Update(object, event, unit)
	if object.unit ~= unit or unit == "player" or unit:find("pet") then return end
	object.Talents:SetText("")
	for index = 1, 40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, "HELPFUL")
		if name ~= nil and unitCaster == unit then
			if buffs[name] then
				object.Talents:SetText(buffs[name])
				return
			end
		end
	end
	local spell = select(1, UnitCastingInfo(unit))
	if spell then
		if spells[spell] then
			object.Talents:SetText(spells[spell])
			return
		end
	end
end

local function Enable(object)
	if not object.Talents then return end
	object:RegisterEvent("UNIT_AURA", Update)
	object:RegisterEvent("UNIT_SPELLCAST_START", Update)
	return true
end

local function Disable(object)
	if object.Talents then
		object:UnregisterEvent("UNIT_AURA", Update)
		object:UnregisterEvent("UNIT_SPELLCAST_START", Update)
	end
end

oUF:AddElement("Talents", Update, Enable, Disable)
for i, frame in ipairs(oUF.objects) do Enable(frame) end