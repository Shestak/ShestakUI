local T, C, L = unpack(ShestakUI)
if C.extra_general.map_boss_count ~= true then return end

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
	-- Hide boss icon
	--[[if event == "ZONE_CHANGED_NEW_AREA" then
		-- The EJ_X functions don't work until the Encounter Journal has been seen during that session
		local _, type = GetInstanceInfo()
		if type == "party" or type == "raid" then
			if not IsAddOnLoaded("Blizzard_EncounterJournal") then
				LoadAddOn("Blizzard_EncounterJournal")
			end
			EncounterJournal:Show()
			EncounterJournal:Hide()
		end
		return
	end]]

	if WorldMapFrame:IsShown() then
		PopulateEncounterInfo()

		local i = 1
		local button = _G["EJMapButton"..i]
		while button and button:IsShown() do
			--button:SetSize(25, 25) -- Hide boss icon

			if not button.label then
				button.label = button:CreateFontString(nil, "OVERLAY")
				button.label:SetFont(STANDARD_TEXT_FONT, 15)
				button.label:SetShadowOffset(1, -1)
				button.label:SetText(i)
				button.label:SetPoint("CENTER")
			end

			if deadBosses[(EJ_GetEncounterInfoByIndex(i))] then
				button.label:SetTextColor(1, 0, 0)
			else
				button.label:SetTextColor(0, 1, 0)
			end

			-- Hide boss icon
			--[[for _, region in pairs{button:GetRegions()} do
				if region:GetObjectType() ~= 'FontString' then
					region:Hide()
					region.Show = function() end
					if region.SetTexture then region:SetTexture() end
				end
			end]]

			i = i + 1
			button = _G["EJMapButton"..i]
		end
	end
end)