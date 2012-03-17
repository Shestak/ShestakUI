local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.achievements ~= true then return end

----------------------------------------------------------------------------------------
--	Your achievement status in tooltip(Enhanced Achievements by Syzgyn)
----------------------------------------------------------------------------------------
local colors = {
	["GREEN"] = {
		["r"] = 0.25,
		["g"] = 0.75,
		["b"] = 0.25,
	},
	["GRAY"] = {
		["r"] = 0.5,
		["g"] = 0.5,
		["b"] = 0.5,
	},
}

local function hookSetHyperlink(tooltip, refString)
	local achievementID, numCriteria, GUID, name, completed, quantity, reqQuantity, month, day, year
	local output = {[0] = {}, [1] = {}}
	if select(3, string.find(refString, "(%a-):")) ~= "achievement" then return end

	achievementID = select(3, string.find(refString, ":(%d+):"))
	numCriteria = GetAchievementNumCriteria(achievementID)
	GUID = select(3, string.find(refString, ":%d+:(.-):"))

	if GUID == string.sub(UnitGUID("player"), 3) then 
		tooltip:Show()
		return 
	end

	tooltip:AddLine(" ")
	_, _, _, completed, month, day, year = GetAchievementInfo(achievementID)

	if completed then
		if year < 10 then year = "0" .. year end

		tooltip:AddLine(L_TOOLTIP_ACH_COMPLETE .. month .. "/" .. day .. "/" .. year, 0, 1, 0)
	elseif numCriteria == 0 then
		tooltip:AddLine(L_TOOLTIP_ACH_INCOMPLETE)
	else
		tooltip:AddLine(L_TOOLTIP_ACH_STATUS)
		for i = 1, numCriteria, 2 do
			for a = 0, 1 do
				output[a].text = nil
				output[a].color = nil
				if i + a <= numCriteria then
					name, _, completed, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i + a)
					if completed then
						output[a].text = name
						output[a].color = "GREEN"
					else
						if quantity < reqQuantity and reqQuantity > 1 then
							output[a].text = name .. " (" .. quantity .. "/" .. reqQuantity .. ")"
							output[a].color = "GRAY"
						else
							output[a].text = name
							output[a].color = "GRAY"
						end
					end
				else
					output[a].text = nil
				end
			end
			if output[1].text == nil then
				tooltip:AddLine(output[0].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b)
			else
				tooltip:AddDoubleLine(output[0].text, output[1].text, colors[output[0].color].r, colors[output[0].color].g, colors[output[0].color].b, colors[output[1].color].r, colors[output[1].color].g, colors[output[1].color].b)
			end
			output = {[0] = {}, [1] = {}}
		end
	end
	tooltip:Show()
end

hooksecurefunc(GameTooltip, "SetHyperlink", hookSetHyperlink)
hooksecurefunc(ItemRefTooltip, "SetHyperlink", hookSetHyperlink)