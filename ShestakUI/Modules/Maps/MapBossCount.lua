local T, C, L, _ = unpack(select(2, ...))
if C.map.map_boss_count ~= true then return end

----------------------------------------------------------------------------------------
--	Show boss count in WorldMap(BetterMapPortraits by Magdain)
----------------------------------------------------------------------------------------
local deadBosses = {}
local PopulateEncounterInfo = function()
	wipe(deadBosses)

	for i = 1, GetNumSavedInstances() do
		local savedName, _, _, _, locked = GetSavedInstanceInfo(i)
		-- We're saved to the instance we're currently in
		if GetInstanceInfo() == savedName and locked then
			local index = 1
			local name, _, dead = GetSavedInstanceEncounterInfo(i, index)
			while name do
				if dead then
					deadBosses[name] = true
				end
				index = index + 1
				name, _, dead = GetSavedInstanceEncounterInfo(i, index)
			end
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("WORLD_MAP_UPDATE")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event)
	if WorldMapFrame:IsShown() then
		PopulateEncounterInfo()

		local i = 1
		local button = _G["EJMapButton"..i]
		while button and button:IsShown() do
			if not button.label then
				button.label = button:CreateFontString(nil, "OVERLAY", "QuestFont_Super_Huge")
				button.label:SetText(i)
				button.label:SetPoint("CENTER")
			end

			if deadBosses[(EJ_GetEncounterInfoByIndex(i))] then
				button.label:SetTextColor(1, 0, 0)
			else
				button.label:SetTextColor(0, 1, 0)
			end

			i = i + 1
			button = _G["EJMapButton"..i]
		end
	end
end)