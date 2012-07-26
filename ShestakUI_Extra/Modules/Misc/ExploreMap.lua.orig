local T, C, L = unpack(ShestakUI)
if C.extra_general.explore_map ~= true then return end

----------------------------------------------------------------------------------------
--	Tracking completion of the Explorer and Lore Master achievements in WorldMap(ExpLoreMaster by CrusaderHeimdall)
----------------------------------------------------------------------------------------
FACTION = UnitFactionGroup("player")
local questCompletion, exploreCompletion, adjustedX, adjustedY

function GetInfo(mapName)
	if L_EXTRA_ZONEACHID[mapName] == nil then
		return nil, nil
	end
	local explore = L_EXTRA_ZONEACHID[mapName].X
	if FACTION == "Alliance" then
		quest = L_EXTRA_ZONEACHID[mapName].A
	else
		quest = L_EXTRA_ZONEACHID[mapName].H
	end
	if explore == -1 or explore == nil then
		-- World map stuff
		return nil, nil
	end
	-- Zone exploration info gathering
	local completed = 0
	local total = GetAchievementNumCriteria(explore)
	if explore == 0 then
		exploreCompletion = nil
	else
		if total == 0 then
			_, _, isComplete = GetAchievementInfo(explore)
			total = 1
			if isComplete then
				completed = 1
			end
		else
			for x = 1, total do
				_, _, isComplete = GetAchievementCriteriaInfo(explore, x)
				if isComplete then
					completed = completed + 1
				end
			end
		end
		percentage = string.format("%d", (completed / total * 100))
		exploreCompletion = L_EXTRA_EXPLORED..percentage.."%"
	end
	-- Zone quest info gathering
	if quest == 0 then
		questCompletion = nil
	else
		_, _, _, questsDone, questsNeeded = GetAchievementCriteriaInfo(quest, 1)
		percentage = string.format("%d", (questsDone / questsNeeded * 100))
		if mapName == L_ZONE_TOLBARAD or mapName == L_ZONE_TOLBARADPEN then
			qHeader = DAILY..": "
		else
			qHeader = QUESTS_LABEL..": "
		end
		if questsDone == questsNeeded then
			--questCompletion = qHeader..COMPLETE
			questCompletion = qHeader.."100%"
		else
			questCompletion = qHeader..questsDone.."/"..questsNeeded.." ("..percentage.."%)"
		end
	end
	return exploreCompletion, questCompletion
end

-- Hijack World Map Name Update
function WorldMapFrame_SetMapName()
	local mapName = WORLD_MAP
	if WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
		local zoneId = UIDropDownMenu_GetSelectedID(WorldMapZoneDropDown)
		-- zoneId is nil for instances, Azeroth, or the cosmic view, in which case we'll keep the "WorldMap" title
		if zoneId then
			if zoneId > 0 then
				mapName = UIDropDownMenu_GetText(WorldMapZoneDropDown)
			elseif UIDropDownMenu_GetSelectedID(WorldMapContinentDropDown) > 0 then
				mapName = UIDropDownMenu_GetText(WorldMapContinentDropDown)
			end
		end
	end
	exploreCompletion, questCompletion = GetInfo(mapName)
	if exploreCompletion ~= nil then
		mapName = mapName..": "..exploreCompletion
	end
	if questCompletion ~= nil then
		mapName = mapName..", "..questCompletion
	end
	WorldMapFrameTitle:SetText(mapName)
end

function XLM_UD(self, elapsed)
	local x, y = GetCursorPosition()
	x = x / WorldMapButton:GetEffectiveScale()
	y = y / WorldMapButton:GetEffectiveScale()

	local centerX, centerY = WorldMapButton:GetCenter()
	local width = WorldMapButton:GetWidth()
	local height = WorldMapButton:GetHeight()
	adjustedY = (centerY + (height / 2) - y) / height
	adjustedX = (x - (centerX - (width / 2))) / width

	local name, fileName
	if WorldMapButton:IsMouseOver() and WorldMapFrame:IsShown() then
		name, fileName = UpdateMapHighlight(adjustedX, adjustedY)
		if name ~= nil then
			local w, h
			w, h = GameTooltip:GetSize()
			GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			local x, y = GetCursorPosition()
			x = x / UIParent:GetEffectiveScale()
			y = y / UIParent:GetEffectiveScale()
			GameTooltip:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x + 20 , y - 20)
			GameTooltip:SetText(name)
			line1, line2 = GetInfo(name)
			GameTooltip:AddLine(line1)
			GameTooltip:AddLine(line2)
			GameTooltip:Show()
		else 
			GameTooltip:Hide()
		end
		GameTooltip:FadeOut()
	end

	if fileName then
		WorldMapHighlight:SetDesaturated(true)
		if line1 ~= nil then
			loc = tonumber(string.sub(line1, 10, (string.find(line1, "%%") - 1)))
			if loc == nil then
				return
			end
			if loc == 100 then
				WorldMapHighlight:SetVertexColor(0, 1, 0, 1)
			elseif loc == 0 then
				WorldMapHighlight:SetVertexColor(1, 0, 0, 1)
			else
				WorldMapHighlight:SetVertexColor(1, 1, 0, 1)
			end
		else
			WorldMapHighlight:SetVertexColor(1, 1, 1)
		end
	else
		WorldMapHighlight:Hide()
	end
end

local ExpLoreMasterFrame = CreateFrame("Frame")
ExpLoreMasterFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ExpLoreMasterFrame:SetScript("OnUpdate", function(self, event, elapsed)
	if event == "ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone()
	end
	XLM_UD(self, elapsed)
end)