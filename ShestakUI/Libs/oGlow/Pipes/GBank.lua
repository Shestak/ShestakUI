-- TODO:
--  - Clean up the dupe code.
--  - Write a description.

local update = function(self)
	-- We shouldn't really do this. The correct solution would be to delay the
	-- event registration until Blizzard_GuildBankUI is loaded, but we use this
	-- solution for now.
	if(not IsAddOnLoaded"Blizzard_GuildBankUI") then return end

	local tab = GetCurrentGuildBankTab()
	for i=1, MAX_GUILDBANK_SLOTS_PER_TAB or 98 do
		local index = math.fmod(i, 14)
		if(index == 0) then
			index = 14
		end
		local column = math.ceil((i-0.5)/14)

		local slotLink = GetGuildBankItemLink(tab, i)
		local slotFrame = _G["GuildBankColumn"..column.."Button"..index]

		self:CallFilters('gbank', slotFrame, slotLink)
	end
end

local enable = function(self)
	self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED', update)
	self:RegisterEvent('GUILDBANKFRAME_OPENED', update)
end

local disable = function(self)
	self:UnregisterEvent('GUILDBANKBAGSLOTS_CHANGED', update)
	self:UnregisterEvent('GUILDBANKFRAME_OPENED', update)
	
	if(not IsAddOnLoaded'Blizzard_GuildBankUI') then return end

	for i=1, MAX_GUILDBANK_SLOTS_PER_TAB or 98 do
		local index = math.fmod(i, 14)
		if(index == 0) then
			index = 14
		end
		local column = math.ceil((i-0.5)/14)

		self:CallFilters('gbank', _G["GuildBankColumn"..column.."Button"..index])
	end

end

oGlow:RegisterPipe('gbank', enable, disable, update, 'Guild bank frame', nil)
