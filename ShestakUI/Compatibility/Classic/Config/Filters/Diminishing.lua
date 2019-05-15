local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Sap -> http://www.wowhead.com/spell=6770
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = {
	-- Stuns
	[5211] = {"stun"},				-- Bash
	[9005] = {"stun"},				-- Pounce
	[24394] = {"stun"},				-- Intimidation
	[853] = {"stun"},				-- Hammer of Justice
	[1833] = {"stun"},				-- Cheap Shot
	[7922] = {"stun"},				-- Charge Stun
	[12809] = {"stun"},				-- Concussion Blow
	[20253] = {"stun"},				-- Intercept Stun
	[20549] = {"stun"},				-- War Stomp (Racial)

	--[[
	-- Stun Procs
	[16922] = {"stunproc"},			-- Celestial Focus
	[19410] = {"stunproc"},			-- Improved Concussive Shot
	[12355] = {"stunproc"},			-- Impact
	[15269] = {"stunproc"},			-- Blackout
	[20170] = {"stunproc"},			-- Seal of Justice
	-- [18093] = {"stunproc"},			-- Pyroclasm
	[5530] = {"stunproc"},			-- Mace Specialization
	--]]

	-- Disorients
	[22570] = {"disorient"},		-- Mangle
	[118] = {"disorient"},			-- Polymorph
	-- [28272] = {"disorient"},		-- Polymorph (Pig)
	-- [28271] = {"disorient"},		-- Polymorph (Turtle)
	[1776] = {"disorient"},			-- Gouge
	[6770] = {"disorient"},			-- Sap

	-- Sleeps
	[2637] = {"sleep"},				-- Hibernate
	[19386] = {"sleep"},			-- Wyvern Sting

	-- Charms
	[605] = {"charm"},				-- Mind Control

	-- Fears
	[8122] = {"fear"},				-- Psychic Scream
	[5782] = {"fear"},				-- Fear
	[5484] = {"fear"},				-- Howl of Terror
	[6358] = {"fear"},				-- Seduction (Succubus)
	[5246] = {"fear"},				-- Intimidating Shout

	-- Horrors
	[6789] = {"horror"},			-- Death Coil

	-- Roots
	-- [19675] = {"root"},				-- Feral Charge Effect
	[339] = {"root"},				-- Entangling Roots
	[19975] = {"root"},				-- Entangling Roots (Nature's Grasp)
	-- [19306] = {"root"},				-- Counterattack
	[19185] = {"root"},				-- Entrapment
	-- [19229] = {"root"},				-- Improved Wing Clip
	[122] = {"root"},				-- Frost Nova
	-- [12494] = {"root"},				-- Frostbite
	-- [23694] = {"root"},				-- Improved Hamstring

	--[[
	-- Disarms
	[14251] = {"disarm"},			-- Riposte
	[676] = {"disarm"},				-- Disarm
	--]]

	--[[
	-- Silences
	[18469] = {"silence"},			-- Counterspell - Silenced
	[15487] = {"silence"},			-- Silence
	[18425] = {"silence"},			-- Kick - Silenced
	[24259] = {"silence"},			-- Spell Lock (Felhunter)
	[18498] = {"silence"},			-- Shield Bash - Silenced
	--]]

	-- Blind
	[2094] = {"blind"},				-- Blind

	-- Freezing Trap
	[3355] = {"freezingtrap"},		-- Freezing Trap

	-- Scatter Shot
	[19503] = {"scattershot"},		-- Scatter Shot

	-- Repentence
	[20066] = {"repentance"},		-- Repentance

	--[[
	-- Turn Undead
	[2878] = {"turned"},			-- Turn Undead
	--]]

	--[[
	-- Shackle Undead
	[9484] = {"shackle"},			-- Shackle Undead
	--]]

	-- Kidney Shot
	[408] = {"kidneyshot"},			-- Kidney Shot
}

local function GetIcon(id)
	local _, _, icon = GetSpellInfo(id)
	return icon
end

T.DiminishingIcons = {
	["stun"] = GetIcon(853),
	-- ["stunproc"] = GetIcon(5530),
	["disorient"] = GetIcon(118),
	["sleep"] = GetIcon(19386),
	["charm"] = GetIcon(605),
	["fear"] = GetIcon(8122),
	["horror"] = GetIcon(5782),
	["root"] = GetIcon(339),
	-- ["disarm"] = GetIcon(676),
	-- ["silence"] = GetIcon(15487),
	["blind"] = GetIcon(2094),
	["freezingtrap"] = GetIcon(3355),
	["scattershot"] = GetIcon(19503),
	["repentance"] = GetIcon(20066),
	-- ["turned"] = GetIcon(2878),
	-- ["shackle"] = GetIcon(9484),
	["kidneyshot"] = GetIcon(408),
}