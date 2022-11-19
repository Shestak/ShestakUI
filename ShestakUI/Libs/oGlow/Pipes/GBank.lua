local _E
local hook

local pipe = function()
	local tab = GetCurrentGuildBankTab()
	for i = 1, 98 do
		local index = math.fmod(i, 14)
		if index == 0 then
			index = 14
		end
		local column = math.ceil((i - 0.5) / 14)

		local slotLink = GetGuildBankItemLink(tab, i)
		local slotFrame = GuildBankFrame.Columns[column].Buttons[index]

		oGlow:CallFilters("gbank", slotFrame, _E and slotLink)
	end
end

local doHook = function()
	if(not hook) then
		hook = function(...)
			if(_E) then return pipe(...) end
		end

		hooksecurefunc(GuildBankFrame, "Update", hook)
	end
end

local function ADDON_LOADED(self, event, addon)
	if(addon == "Blizzard_GuildBankUI") then
		doHook()
		self:UnregisterEvent(event, ADDON_LOADED)
	end
end

local update = function(self)
	if(IsAddOnLoaded("Blizzard_GuildBankUI")) then
		return pipe()
	end
end

local enable = function(self)
	_E = true

	if(IsAddOnLoaded("Blizzard_GuildBankUI")) then
		doHook()
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
end

oGlow:RegisterPipe("gbank", enable, disable, update, "Guild bank frame", nil)