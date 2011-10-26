local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or T.class == "ROGUE" or T.class == "WARRIOR" or T.class == "HUNTER" or T.class == "MAGE" then return end

----------------------------------------------------------------------------------------
--	Based on FreebAutoRez(by Freebaser)
----------------------------------------------------------------------------------------
local parent, ns = ...
local oUF = ns.oUF

local classList = {
	["DEATHKNIGHT"] = {
		combat = GetSpellInfo(61999),	-- Raise Ally
	},

	["WARLOCK"] = {
		combat = GetSpellInfo(6203),	-- Soulstone
		ooc = GetSpellInfo(6203),		-- Soulstone
	},

	["DRUID"] = {
		combat = GetSpellInfo(20484),	-- Rebirth
		ooc = GetSpellInfo(50769),		-- Revive
	},

	["PRIEST"] = {
		ooc = GetSpellInfo(2006),		-- Resurrection
	},

	["PALADIN"] = {
		ooc = GetSpellInfo(7328),		-- Redemption
	},

	["SHAMAN"] = {
		ooc = GetSpellInfo(2008),		-- Ancestral Spirit
	},
}

local body = ""
local function macroBody(class, unit)
	local combatspell = classList[class].combat
	local oocspell = classList[class].ooc

	body = "#showtooltip\n/tar [@"..unit.."]\n/stopmacro [nodead,@mouseover]\n"
	if combatspell then
		body = body.."/cast [combat,help,dead,@mouseover] "..combatspell.."; "

		if oocspell then
			body = body.."[help,dead,@mouseover] "..oocspell.."; "
		end

		if T.class == "WARLOCK" then
			body = body.."\n/cast Create Soulstone\n "
		end
	elseif oocspell then
		body = body.."/cast [help,dead,@mouseover] "..oocspell.."; "
	end

	body = body.."\n/targetlasttarget [combat]"

	return body
end

local Enable = function(self)
	local _, class = UnitClass("player")
	if not class then return end

	if classList[class] then
		if not IsAddOnLoaded("Clique") then
			self:SetAttribute("type1", "macro")
			self:SetScript("PreClick", function(self, button)
				local unit = self.unit or "mouseover"
				self:SetAttribute("macrotext1", macroBody(class, unit))
			end
		end
	end
end

local Disable = function(self)
	self:SetAttribute("type1", nil)
	self:SetAttribute("macrotext1", nil)
end

oUF:AddElement("AutoResurrect", nil, Enable, Disable)