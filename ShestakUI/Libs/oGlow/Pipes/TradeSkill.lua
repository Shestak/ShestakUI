-- TODO:
--  - Write a description.

local hook

local pipe = function(id)
	if(oGlow:IsPipeEnabled'tradeskill') then
		local itemLink = GetTradeSkillItemLink(id)

		if(itemLink) then
			oGlow:CallFilters('tradeskill', TradeSkillSkillIcon, itemLink)
		end

		for i=1, GetTradeSkillNumReagents(id) do
			local reagentFrame = _G['TradeSkillReagent' .. i .. 'IconTexture']
			local reagentLink = GetTradeSkillReagentItemLink(id, i)

			oGlow:CallFilters('tradeskill', reagentFrame, reagentLink)
		end
	end
end

local function ADDON_LOADED(self, event, addon)
	if(addon == 'Blizzard_TradeSkillUI') then
		if(not hook) then
			hooksecurefunc('TradeSkillFrame_SetSelection', pipe)
			hook = true
		end
		self:UnregisterEvent(event, ADDON_LOADED)
	end
end

local update = function(self)
	local id = GetTradeSkillSelectionIndex()
	if(id and IsAddOnLoaded('Blizzard_TradeSkillUI')) then
		return pipe(id)
	end
end

local enable = function(self)
	if(IsAddOnLoaded("Blizzard_TradeSkillUI")) then
		if(not hook) then
			hooksecurefunc("TradeSkillFrame_SetSelection", pipe)
			hook = true
		end
	else
		self:RegisterEvent("ADDON_LOADED", ADDON_LOADED)
	end
end

local disable = function(self)
	self:UnregisterEvent('ADDON_LOADED', ADDON_LOADED)

	if(IsAddOnLoaded('Blizzard_TradeSkillUI')) then
		for i=1, MAX_TRADE_SKILL_REAGENTS or 8 do
			self:CallFilters('tradeskill', _G['TradeSkillReagent' .. i .. 'IconTexture'])
		end
		self:CallFilters('tradeskill', TradeSkillSkillIcon)
	end
end

oGlow:RegisterPipe('tradeskill', enable, disable, update, 'Profession frame', nil)
