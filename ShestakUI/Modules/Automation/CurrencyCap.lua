local T, C, L, _ = unpack(select(2, ...))
if C.automation.currency_cap ~= true then return end

----------------------------------------------------------------------------------------
--	Auto popup for currency cap(EnoughPoints by gi2k15)
----------------------------------------------------------------------------------------
StaticPopupDialogs.EnoughPoints = {
	button1 = OKAY,
	hideOnEscape = true,
	whileDead = false,
	timeout = 0,
	preferredIndex = 5,
}

local badge = {
	["justice"] = JUSTICE_CURRENCY,
	["valor"] = VALOR_CURRENCY,
	["honor"] = HONOR_CURRENCY,
}

local hasShown = false
local isValor = false
local logging = true

local defaults = {
	["justice"] = {
		max = 4000,
		queueing = true,
		logging = true,
	},
	["valor"] = {
		max = 5000,
		queueing = true,
		logging = true,
	},
	["honor"] = {
		max = 4000,
		logging = true,
	},
}

local frame = CreateFrame("Frame", "EnoughPoints", UIParent)
frame:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
frame:RegisterEvent("ADDON_LOADED")

function frame:ADDON_LOADED(event, name)
	if name == "ShestakUI" then
		self:RegisterEvent("PLAYER_LOGIN")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("LFG_UPDATE")
		self:RegisterEvent("LFG_PROPOSAL_SHOW")
	end
end

function frame:CheckBadges(kind)
	if isValor then
		isValor = false
		StaticPopupDialogs.EnoughPoints.OnHide = nil
	end
	local name, currentAmount = GetCurrencyInfo(badge[kind])
	if currentAmount >= defaults[kind].max then
		StaticPopupDialogs.EnoughPoints.text = L_POPUP_CURRENCY_CAP..":\n |cffffff00"..tostring(currentAmount).."|r |cff00aa00["..name.."]|r."
		StaticPopup_Show("EnoughPoints")
	end
end

function frame:PLAYER_ENTERING_WORLD()
	local _, instanceType = IsInInstance()
	if instanceType == "raid" then
		self:CheckBadges("valor")
	elseif instanceType == "party" then
		self:CheckBadges("justice")
	end
end

function frame:PLAYER_LOGIN()
	if defaults.honor.logging then
		self:CheckBadges("honor")
	end
	if defaults.justice.logging then
		StaticPopupDialogs.EnoughPoints.OnHide = function() self:CheckBadges("valor") end
		self:CheckBadges("justice")
		isValor = true
		return
	end
	if defaults.valor.logging then
		self:CheckBadges("valor")
	end
end

function frame:LFG_UPDATE()
	if hasShown == false and logging == false then
		if defaults.justice.queueing then
			StaticPopupDialogs.EnoughPoints.OnHide = function() self:CheckBadges("valor") end
			self:CheckBadges("justice")
			isValor = true
			hasShown = true
			return
		end
		if defaults.valor.queueing then
			self:CheckBadges("valor")
			hasShown = true
		end
	elseif logging and hasShown == false then
		logging = false
	end
end

function frame:LFG_PROPOSAL_SHOW()
	hasShown = false
end