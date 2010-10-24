----------------------------------------------------------------------------------------
--	Based on aTooltip
----------------------------------------------------------------------------------------
if not SettingsCF.tooltip.enable == true then return end

local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	WorldMapTooltip,
}

for _, tt in pairs(tooltips) do
	SettingsDB.SkinFadedPanel(tt)
	tt:HookScript("OnShow", function(self)
		self:SetBackdropColor(unpack(SettingsCF.media.overlay_color))
		self:SetBackdropBorderColor(unpack(SettingsCF.media.border_color))
	end)
end

LFDSearchStatus:SetFrameStrata("TOOLTIP")

----------------------------------------------------------------------------------------
--	Hide PVP text
----------------------------------------------------------------------------------------
PVP_ENABLED = ""

----------------------------------------------------------------------------------------
--	Statusbar
----------------------------------------------------------------------------------------
GameTooltipStatusBar:SetStatusBarTexture(SettingsCF.media.texture)
GameTooltipStatusBar:SetHeight(4)
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 2, 6)
GameTooltipStatusBar:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -2, 6)

-- Short-display HP value on StatusBar
local function ShortValue(value)
	if value >= 1e7 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e6 then
		return ("%.2fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e5 then
		return ("%.0fk"):format(value / 1e3)
	elseif value >= 1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

----------------------------------------------------------------------------------------
--	Unit tooltip styling
----------------------------------------------------------------------------------------
aTooltip = CreateFrame("Frame", "aTooltip", UIParent)
aTooltip:RegisterEvent("ADDON_LOADED")
aTooltip:SetScript("OnEvent", function(self, event, addon)
    if addon == "QuestHelper" then self.QH_found = true end
    if addon ~= "ShestakUI" then return end

	local function GameTooltipDefault(tooltip, parent)
		if SettingsCF["tooltip"].cursor == true then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR")
		else
			tooltip:SetOwner(parent, "ANCHOR_NONE")
			tooltip:ClearAllPoints()
			tooltip:SetPoint(unpack(SettingsCF["position"].tooltip))
			tooltip.default = 1;
		end
	end
	hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)
	
	if SettingsCF["tooltip"].shift_modifer == true then
		local ShiftShow = function()
			if IsShiftKeyDown() then
				GameTooltip:Show()
				GameTooltip:SetBackdropColor(unpack(SettingsCF["media"].overlay_color)) 
				GameTooltip:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
			else
				GameTooltip:Hide()
			end
		end
	GameTooltip:SetScript("OnShow", ShiftShow)
	local EventShow = function()
		if arg1 == "LSHIFT" and arg2 == 1 then
			GameTooltip:Show()
			GameTooltip:SetBackdropColor(unpack(SettingsCF["media"].overlay_color)) 
			GameTooltip:SetBackdropBorderColor(unpack(SettingsCF["media"].border_color))
		elseif arg1 == "LSHIFT" and arg2 == 0 then
			GameTooltip:Hide()
		end
	end
	local sh = CreateFrame("Frame")
	sh:RegisterEvent("MODIFIER_STATE_CHANGED")
	sh:SetScript("OnEvent", EventShow)
	else
		if SettingsCF["tooltip"].cursor == true then
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function (GameTooltip, parent)
			GameTooltip:SetOwner(parent,"ANCHOR_CURSOR")
			end)
		else
			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self)
			self:SetPoint(unpack(SettingsCF["position"].tooltip))
			end)
		end
	end

	if SettingsCF["tooltip"].health_value == true then
		GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
		if not value then
			return
		end
		local min, max = self:GetMinMaxValues()
		if (value < min) or (value > max) then
			return
		end
		self:SetStatusBarColor(0, 1, 0)
		local unit  = select(2, GameTooltip:GetUnit())
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			if not self.text then
				self.text = self:CreateFontString(nil, "OVERLAY")
				self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 1.5)
				self.text:SetFont(SettingsCF["media"].normal_font, 11)
				self.text:SetShadowColor(0, 0, 0, 1)
				self.text:SetShadowOffset(1, -1)
			end
			self.text:Show()
			local hp = ShortValue(min).." / "..ShortValue(max)
			self.text:SetText(hp)
		end
		end)
	end	
		
    local OnTooltipSetUnit = function(self)
        local lines = self:NumLines()
        local name, unit = self:GetUnit()

        if not unit then return end

        local race = UnitRace(unit)
        local level = UnitLevel(unit)
		local levelColor = GetQuestDifficultyColor(level)
		local classification = UnitClassification(unit)
		local creatureType = UnitCreatureType(unit)

        if level and level == -1 then
            if classification == "worldboss" then
                level = "|cffff0000|r"..BOSS
            else
                level = "|cffff0000??|r"
            end
        end
        
		if classification == "rareelite" then classification = " R+"
		elseif classification == "rare"  then classification = " R"
		elseif classification == "elite" then classification = "+"
		else classification = "" end
		
        if not SettingsCF["tooltip"].title then _G["GameTooltipTextLeft1"]:SetText(name) end

        if(UnitIsPlayer(unit)) then
            if(GetGuildInfo(unit)) then
                _G["GameTooltipTextLeft2"]:SetFormattedText("%s", GetGuildInfo(unit))
                _G["GameTooltipTextLeft2"]:SetTextColor(0, 1, 1)
            end

            local n = GetGuildInfo(unit) and 3 or 2
			--  thx TipTac for the fix above with color blind enabled
			if GetCVar("colorblindMode") == "1" then n = n + 1 end
			_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s", levelColor.r*255, levelColor.g*255, levelColor.b*255, level, race)
        else
            for i = 2, lines do
                local line = _G["GameTooltipTextLeft"..i]
                if not line or not line:GetText() then return end -- damn QuestHelper!
                if (level and line:GetText():find("^"..LEVEL)) or (creatureType and line:GetText():find("^"..creatureType)) then
					local r, g, b = GameTooltip_UnitColor(unit)
					line:SetFormattedText("|cff%02x%02x%02x%s%s|r %s", levelColor.r*255, levelColor.g*255, levelColor.b*255, level, classification, creatureType or "")
					break
                end
            end
        end

        if SettingsCF["tooltip"].target == true and UnitExists(unit.."target") then
            local r, g, b = GameTooltip_UnitColor(unit.."target")
            local text = ""

            if UnitIsEnemy("player", unit.."target") then
                r, g, b = 1, 0, 0
            elseif not UnitIsFriend("player", unit.."target") then
                r, g, b = 1, 1, 0
            end

            if UnitName(unit.."target") == UnitName("player") then
                text = "|cfffed100"..STATUS_TEXT_TARGET..":|r ".."|cffff0000> "..UNIT_YOU.." <|r"
            else
                text = "|cfffed100"..STATUS_TEXT_TARGET..":|r "..UnitName(unit.."target")
            end

            self:AddLine(text, r, g, b)
        end
    end

    GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
end)

function GameTooltip_UnitColor(unit)
    local r, g, b

    if UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
    elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or UnitIsDead(unit) then
        r, g, b = 0.6, 0.6, 0.6
    else
        local reaction = UnitReaction(unit, "player")
		if reaction then
			r, g, b = FACTION_BAR_COLORS[reaction].r, FACTION_BAR_COLORS[reaction].g, FACTION_BAR_COLORS[reaction].b
		else
			r, g, b = 1, 1, 1
		end
    end

    return r, g, b
end

----------------------------------------------------------------------------------------
--	Target Talents(TipTacTalents by Aezay)
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].talents == true then
	local gtt = GameTooltip;
	local GetTalentTabInfo = GetTalentTabInfo;

	-- Constants
	local TALENTS_PREFIX = TALENTS..":|cffffffff ";
	local CACHE_SIZE = 25;		-- Change cache size here (Default 25)
	local MIN_INSPECT_DELAY = 0.2;
	local MIN_INSPECT_FREQ = 2;
	
	-- Variables
	local ttt = CreateFrame("Frame", "TipTacTalents");
	local cache = {};
	local current = {};
	local lastInspectRequest = 0;

	-- Allow these to be accessed through other addons
	ttt.cache = cache;
	ttt.current = current;
	ttt:Hide();

	--------------------------------------------------------------------------------------------------------
	--                                           Gather Talents                                           --
	--------------------------------------------------------------------------------------------------------

	local function GatherTalents(isInspect)
		-- Inspect functions will always use the active spec when not inspecting
		local group = GetActiveTalentGroup(isInspect);
		-- Get points per tree, and set "maxTree" to the tree with most points
		local maxTree, _ = 1;
		for i = 1, 3 do
			local _, _, _, _, pointsSpent = GetTalentTabInfo(i,isInspect,nil,group);
			current[i] = pointsSpent;
			if (current[i] > current[maxTree]) then
				maxTree = i;
			end
		end
		local _, tabName = GetTalentTabInfo(maxTree,isInspect,nil,group);
		current.tree = tabName;
		-- Az: Clear Inspect, as we are done using it
		if (isInspect) then
			ClearInspectPlayer();
		end
		-- Customise output. Use TipTac setting if it exists, otherwise just use formatting style one.
		local talentFormat = (1);
		if (current[maxTree] == 0) then
			current.format = L_TOOLTIP_NO_TALENT;
		elseif (talentFormat == 1) then
			current.format = current.tree.." ("..current[1].."/"..current[2].."/"..current[3]..")";
		elseif (talentFormat == 2) then
			current.format = current.tree;
		elseif (talentFormat == 3) then
			current.format = current[1].."/"..current[2].."/"..current[3];
		end
		-- Set the tips line output, for inspect, only update if the tip is still showing a unit!
		if (not isInspect) then
			gtt:AddLine(TALENTS_PREFIX..current.format);
		elseif (gtt:GetUnit()) then
			for i = 2, gtt:NumLines() do
				if ((_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX)) then
					_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s",TALENTS_PREFIX,current.format);
					-- Do not call Show() if the tip is fading out, this only works with TipTac, if TipTacTalents are used alone, it might still bug the fadeout
					if (not gtt.fadeOut) then
						gtt:Show();
					end
					break;
				end
			end
		end
		-- Organise Cache
		local cacheSize = (CACHE_SIZE);
		for i = #cache, 1, -1 do
			if (current.name == cache[i].name) then
				tremove(cache,i);
				break;
			end
		end
		if (#cache > cacheSize) then
			tremove(cache,1);
		end
		-- Cache the new entry
		if (cacheSize > 0) then
			cache[#cache + 1] = CopyTable(current);
		end
	end

	--------------------------------------------------------------------------------------------------------
	--                                           Event Handling                                           --
	--------------------------------------------------------------------------------------------------------

	-- OnEvent
	ttt:SetScript("OnEvent",function(self,event,guid)
		self:UnregisterEvent(event);
		if (guid == current.guid) then
			GatherTalents(1);
		end
	end);

	-- OnUpdate
	ttt:SetScript("OnUpdate",function(self,elapsed)
		self.nextUpdate = (self.nextUpdate - elapsed);
		if (self.nextUpdate <= 0) then
			self:Hide();
			-- Make sure the mouseover unit is still our unit
			if (UnitGUID("mouseover") == current.guid) then
				lastInspectRequest = GetTime();
				self:RegisterEvent("INSPECT_READY");
				-- Az: Fix the blizzard inspect copypasta code (Blizzard_InspectUI\InspectPaperDollFrame.lua @ line 23)
				if (InspectFrame) then
					InspectFrame.unit = unit;
				end
				NotifyInspect(current.unit);
			end
		end
	end);

	-- HOOK: OnTooltipSetUnit
	gtt:HookScript("OnTooltipSetUnit",function(self,...)
		-- Abort any delayed inspect in progress
		ttt:Hide();
		-- Get the unit -- Check the UnitFrame unit if this tip is from a concated unit, such as "targettarget".
		local _, unit = self:GetUnit();
		if (not unit) then
			local mFocus = GetMouseFocus();
			if (mFocus) and (mFocus.unit) then
				unit = mFocus.unit;
			end
		end
		-- No Unit or not a Player
		if (not unit) or (not UnitIsPlayer(unit)) then
			return;
		end
		-- Only bother for players over level 9
		local level = UnitLevel(unit);
		if (level > 9 or level == -1) then
			-- Wipe Current Record
			wipe(current);
			current.unit = unit;
			current.name = UnitName(unit);
			current.guid = UnitGUID(unit)
			-- No need for inspection on the player
			if (UnitIsUnit(unit,"player")) then
				GatherTalents();
				return;
			end
			-- Show Cached Talents, If Available
			local cacheLoaded = false;
			for _, entry in ipairs(cache) do
				if (current.name == entry.name) then
					self:AddLine(TALENTS_PREFIX..entry.format);
					current.tree = entry.tree;
					current.format = entry.format;
					current[1], current[2], current[3] = entry[1], entry[2], entry[3];
					cacheLoaded = true;
					break;
				end
			end
			-- Queue an inspect request
			local isInspectOpen = (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown());
			if (CanInspect(unit)) and (not isInspectOpen) then
				local lastInspectTime = (GetTime() - lastInspectRequest);
				ttt.nextUpdate = (lastInspectTime > MIN_INSPECT_FREQ) and MIN_INSPECT_DELAY or (MIN_INSPECT_FREQ - lastInspectTime + MIN_INSPECT_DELAY);
				ttt:Show();
				if (not cacheLoaded) then
					self:AddLine(TALENTS_PREFIX..L_TOOLTIP_LOADING);
				end
			end
		end
	end);
end

----------------------------------------------------------------------------------------
--	Your achievement status in tooltip(Enhanced Achievements by Syzgyn)
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].achievements == true then
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
		_,_,_,completed, month, day, year = GetAchievementInfo(achievementID)

		if completed then
			if year < 10 then year = "0" .. year end
		
			tooltip:AddLine(L_TOOLTIP_ACH_COMPLETE .. month .. "/" .. day .. "/" .. year, 0,1,0)
		elseif numCriteria == 0 then
			tooltip:AddLine(L_TOOLTIP_ACH_INCOMPLETE)
		else
			tooltip:AddLine(L_TOOLTIP_ACH_STATUS)
			for i=1, numCriteria, 2 do
				for a=0, 1 do
					output[a].text = nil
					output[a].color = nil
					if i+a <= numCriteria then
						name,_,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achievementID, i+a)
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

	hooksecurefunc(ItemRefTooltip, "SetHyperlink", hookSetHyperlink)
end

----------------------------------------------------------------------------------------
--	Adds item icons to tooltips()
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].item_icon == true then
	local function AddIcon(self, icon)
		if icon then
			local title = _G[self:GetName() .. "TextLeft1"]
			if title and not title:GetText():find("|T" .. icon) then
				title:SetFormattedText("|T%s:%d|t %s", icon, 20, title:GetText())
			end
		end
	end

	local function hookItem(tip)
		tip:HookScript("OnTooltipSetItem", function(self, ...)
			local name, link = self:GetItem()
			local icon = link and GetItemIcon(link)
			AddIcon(self, icon)
		end)
	end
	hookItem(_G["GameTooltip"])
	hookItem(_G["ItemRefTooltip"])

	local function hookSpell(tip)
		tip:HookScript("OnTooltipSetSpell", function(self, ...)
			local name, rank, icon = GetSpellInfo(self:GetSpell())
			AddIcon(self, icon)
		end)
	end
	hookSpell(_G["GameTooltip"])
	hookSpell(_G["ItemRefTooltip"])
end

----------------------------------------------------------------------------------------
--	Adds guild rank to tooltips(GuildRank by Meurtcriss)
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].rank == true then
	local GTT = GameTooltip
	-- HOOK: OnTooltipSetUnit
	GTT:HookScript("OnTooltipSetUnit",function(self,...)
		-- Get the unit
		local _, unit = self:GetUnit()
		if not unit then
			local mFocus = GetMouseFocus()
			if mFocus and mFocus.unit then
				unit = mFocus.unit
			end
		end
		-- Get and display guild rank
		if UnitIsPlayer(unit) then
			local guildName, guildRank = GetGuildInfo(unit)
			if guildName then
				self:AddLine(RANK..": |cFFFFFFFF"..guildRank.."|r")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Clean ruRU tooltip(snt_rufix by Don Kaban, edited by ALZA)
----------------------------------------------------------------------------------------
ITEM_CREATED_BY = "" -- No creator name
ITEM_SOCKETABLE = "" -- No gem info line
if SettingsDB.client == "ruRU" then
	EMPTY_SOCKET_RED = "|cffFF4040красное гнездо|r"
	EMPTY_SOCKET_YELLOW = "|cffffff40желтое гнездо|r"
	EMPTY_SOCKET_BLUE = "|cff6060ffсинее гнездо|r"

	local replace =  {
		["красного цвета"] = "|cffFF4040красного цвета|r",
		["синего цвета"] = "|cff6060ffсинего цвета|r",
		["желтого цвета"] = "|cffffff40желтого цвета|r",
		["Требуется хотя бы"] = "Требуется",
		["Чернокнижник"] = "|cff9482C9Чернокнижник|r",
		["Воин"] = "|cffC79C6EВоин|r",
		["Шаман"] = "|cff0070DEШаман|r",
		["Разбойник"] = "|cffFFF569Разбойник|r",
		["Жрец"] = "|cffFFFFFFЖрец|r",
		["Паладин"] = "|cffF58CBAПаладин|r",
		["Маг"] = "|cff69CCF0Маг|r",
		["Охотник"] = "|cffABD473Охотник|r",
		["Друид"] = "|cffFF7D0AДруид|r",
		["Рыцарь смерти"] = "|cffC41F3BРыцарь смерти|r",
	}

	local _G = getfenv(0)
	local ttext

	local function Translate(text)
		if(text) then
			for rus, replace in next, replace do
				text = text:gsub(rus, replace)
			end
			return text
		end
	end

	local function UpdateTooltip(self)
		if(not self:GetItem()) then return end
		local tname = self:GetName()
		for i=1, self:NumLines() do
			ttext = _G[tname.."TextLeft"..i]
			if ttext then ttext:SetText(Translate(ttext:GetText())) end
			ttext = _G[tname.."TextRight"..i]
			if ttext then ttext:SetText(Translate(ttext:GetText())) end
		end
		ttext = nil
	end

	GameTooltip:HookScript("OnTooltipSetItem", UpdateTooltip)
	ItemRefTooltip:HookScript("OnTooltipSetItem", UpdateTooltip)
	ShoppingTooltip1:HookScript("OnTooltipSetItem", UpdateTooltip)
	ShoppingTooltip2:HookScript("OnTooltipSetItem", UpdateTooltip)
end

----------------------------------------------------------------------------------------
-- Hide tooltips in combat for action bars, pet bar and shapeshift bar
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].hidebuttons == true then
	local CombatHideActionButtonsTooltip = function(self)
		if not IsShiftKeyDown() then
			self:Hide()
		end
	end
 
	hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
end

----------------------------------------------------------------------------------------
--	Arena function(ArenaExp by Fernir)
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].arena_experience == true then
	local isGTTActive = false
	local GTT = _G["GameTooltip"]
	-- Settings start 
	local needStatistic = {
		370, -- Highest 2 man personal rating
		595, -- Highest 3 man personal rating
		596, -- Highest 5 man personal rating
	}
	local needAchievements = {
		1161,  -- 2200 arena rating in 5x5
		1159,  -- 2200 arena rating in 2x2
		1160,  -- 2200 arena rating in 3x3
		2091,  -- gladiator
	}
	-- Settings end 

	strGradient = function(val, low, high)
		local percent, r, g
		if (high > low) then 
			percent = val/(high-low)
		else 
			percent = 1-val/(low-high) 
		end
		if (percent > 1) then percent = 1 end
		if (percent < 0) then percent = 0 end
		if (percent < 0.5) then 
			r, g = 1, 2*percent
		else
			r, g = (1-percent)*2, 1
		end
		return format("|cff%02x%02x%02x%s|r", r*255, g*255, 0, val) 
	end 

	local skillf = CreateFrame("frame")
	skillf:RegisterEvent("ADDON_LOADED")
	skillf:SetScript("OnEvent",function(self,event,...)
		if event == "ADDON_LOADED" then
			if arg1 == ... then
				skillf:UnregisterEvent("ADDON_LOADED")
				GTT:HookScript("OnTooltipSetUnit", function()
					if InCombatLockdown() and InCombatLockdown() == 1 then return end
					if AchievementFrame and AchievementFrame:IsShown() then return end

					self.unit = select(2, GTT:GetUnit())
					if not UnitIsPlayer(self.unit) then return end

					if _G.GearScore then
						_G.GearScore:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
					end
					ClearAchievementComparisonUnit()
					skillf:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
					SetAchievementComparisonUnit(self.unit)
				end)
				GTT:HookScript("OnTooltipCleared", function()
					if skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") and skillf:IsEventRegistered("INSPECT_ACHIEVEMENT_READY") then
						skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
						ClearAchievementComparisonUnit()
					end
					isGTTActive = false
				end)
			end
		elseif event == "INSPECT_ACHIEVEMENT_READY" then
			if not GetComparisonAchievementPoints() then return end
			
			isGTTActive = false
			
			for indx, Achievement in pairs(needAchievements) do
				local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(Achievement)
				if GetAchievementComparisonInfo(Achievement) then
					GTT:AddLine("|T"..Image..":16:16:0:0:64:64:4:60:4:60|t "..Name)
					isGTTActive = true
				end
			end
			
			for indx, Achievement in pairs(needStatistic) do
				if GetComparisonStatistic(Achievement) ~= "--" then
					GTT:AddDoubleLine(select(2,GetAchievementInfo(Achievement)), strGradient(tonumber(GetComparisonStatistic(Achievement)), 0, 100))
					isGTTActive = true
				end
			end
			
			if isGTTActive then GTT:Show() end

			if _G.GearScore then
				_G.GearScore:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
			end

			skillf:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
			ClearAchievementComparisonUnit()
		end
	end)
end

----------------------------------------------------------------------------------------
--	Only for test(SpellID by silverwind)
----------------------------------------------------------------------------------------
if SettingsCF["tooltip"].spell_id == true then
	hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
		local id = select(11,UnitBuff(...))
		if id then
			self:AddDoubleLine(L_TOOLTIP_SPELL_ID,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
		local id = select(11,UnitDebuff(...))
		if id then
			self:AddDoubleLine(L_TOOLTIP_SPELL_ID,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
		local id = select(11,UnitAura(...))
		if id then
			self:AddDoubleLine(L_TOOLTIP_SPELL_ID,id)
			self:Show()
		end
	end)

	hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
		if string.find(link,"^spell:") then
			local id = string.sub(link,7)
			ItemRefTooltip:AddDoubleLine(L_TOOLTIP_SPELL_ID,id)
			ItemRefTooltip:Show()
		end
	end)

	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local id = select(3,self:GetSpell())
		if id then
			self:AddDoubleLine(L_TOOLTIP_SPELL_ID,id)
			self:Show()
		end
	end)
end