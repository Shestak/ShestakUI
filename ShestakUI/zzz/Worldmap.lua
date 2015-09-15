local T, C, L, _ = unpack(select(2, ...))
if C.zzz.WorldMap ~= true then return end

----------------------------------------------------------------------------------------
--	地圖上標記隊友名稱縮寫並顯示是否戰鬥或死亡
----------------------------------------------------------------------------------------
local function colored(class) 
   local colorRGB = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR 
   return format("|CFF%2x%2x%2x", colorRGB.r*255, colorRGB.g*255, colorRGB.b*255) 
end 

local sub, GetRaidRosterInfo = string.sub, GetRaidRosterInfo 
hooksecurefunc("WorldMapUnit_Update", function(self) 
   if not self.group then 
      self.group = self:CreateFontString(nil, "OVERLAY") 
      self.group:SetFont(STANDARD_TEXT_FONT, 16, "THINOUTLINE") 
      self.group:SetPoint("LEFT", self, "RIGHT") 
   end 
   self.group:SetText("") 
   if self.unit then 
      if string.find(self.unit, "raid") then 
         local longName, _, _, _, _, class = GetRaidRosterInfo(sub(self.unit,5)) 
         if longName then 
            local _, _, shortName, server = string.find(longName, "([^%-]+)%-(.+)") 
            if not server then 
               shortName = longName 
            end 
            self.group:SetText(colored(class)..sub(shortName,1,6).."|r") 
         end 
      end 
      if UnitAffectingCombat(self.unit) then 
         self.icon:SetVertexColor(.8, 0, 0) -- 戰鬥中顏色 
         self:SetAlpha(1) 
      elseif UnitIsDeadOrGhost(self.unit) then 
         self.icon:SetVertexColor(0, 0, 0) -- 死亡顏色 
         self:SetAlpha(.7) 
      else 
         self:SetAlpha(.7) 
      end 
   end 
end) 

----------------------------------------------------------------------------------------
--	地图玩家圆点标志显示小组编号+鼠标提示彩色化
----------------------------------------------------------------------------------------
for i = 1, 40 do _G["WorldMapRaid"..i]:SetSize(32, 32) end

hooksecurefunc("WorldMapUnit_Update", function(self)
	if self.unit then
		if string.find(self:GetName(), "WorldMapRaid") then
			if not self.group then
				self.group = self:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
				self.group:SetPoint("CENTER", 1, 1)
			end
			self.group:SetText(select(3, GetRaidRosterInfo(string.sub(self.unit, 5))) or "")
		end
		if UnitAffectingCombat(self.unit) then
			self.icon:SetVertexColor(1, 0, 0)
		elseif UnitIsDeadOrGhost(self.unit) then
			self.icon:SetVertexColor(0.3, 0.3, 0.3)
		end
	end
end)


local function colorit(text, class)
	local colorStr = class and RAID_CLASS_COLORS[class].colorStr
	if not class or not colorStr then return NORMAL_FONT_COLOR_CODE..text.."|r" end
	return "|c"..colorStr..text.."|r"				--	return format(PLAYER_CLASS_NO_SPEC, colorStr, text)
end

local function MapUnit_OnEnter(self, motion, map)
	local x, y = self:GetCenter()
	local parentX, parentY = self:GetParent():GetCenter()
	if ( x > parentX ) then
		if map == "WorldMap" then
			WorldMapTooltip:SetOwner(self, "ANCHOR_LEFT")
		else
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		end
	else
		if map == "WorldMap" then
			WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT")
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		end
	end

	local unitButton, unit
	local newLineString = ""
	local tooltipText = ""
	local name, subgroup, class, fileName, nameText, server

	if ( map == "WorldMap" and WorldMapPlayerUpper:IsMouseOver() ) then
		name = UnitName(WorldMapPlayerUpper.unit)
		if ( PlayerIsPVPInactive(WorldMapPlayerUpper.unit) ) then
			tooltipText = format(PLAYER_IS_PVP_AFK, "---> "..name.." <---")
		else
			_, fileName = UnitClass(WorldMapPlayerUpper.unit)
			tooltipText = "---> "..colorit(name, fileName).." <---"
		end
		newLineString = "\n"
	end
	for i=1, MAX_PARTY_MEMBERS do
		unitButton = _G[map.."Party"..i]
		if ( unitButton:IsVisible() and unitButton:IsMouseOver() ) then
			name = UnitName(unitButton.unit)
			class, fileName = UnitClass(unitButton.unit)
			if ( PlayerIsPVPInactive(unitButton.unit) ) then
				tooltipText = tooltipText..newLineString..format(PLAYER_IS_PVP_AFK, class.." "..name)
			else
				tooltipText = tooltipText..newLineString..colorit(name, fileName)
			end
			newLineString = "\n"
		end
	end
	for i=1, MAX_RAID_MEMBERS do
		unitButton = _G[map.."Raid"..i]
		if ( unitButton:IsVisible() and unitButton:IsMouseOver() ) then
			if ( unitButton.name ) then
				if ( PlayerIsPVPInactive(unitButton.name) ) then
					tooltipText = tooltipText..newLineString..format(PLAYER_IS_PVP_AFK, unitButton.name)
				else
					tooltipText = tooltipText..newLineString..unitButton.name
				end
			else
				unit = unitButton.unit
				nameText, _, subgroup, _, class, fileName = GetRaidRosterInfo(string.sub(unit, 5))
				if PlayerIsPVPInactive(unit) then
					tooltipText = tooltipText..newLineString..format(PLAYER_IS_PVP_AFK, "["..subgroup.."] "..class.." "..nameText)
				else
					_, _, name, server = string.find(nameText, "([^%-]+)%-(.+)")
					if name and server then
						name = colorit(name, fileName).."|CFFFFFFFF-|r"..colorit(server)
					else
						name = colorit(nameText, fileName)
					end
					tooltipText = tooltipText..newLineString.."["..subgroup.."] "..name
				end
			end
			newLineString = "\n"
		end
	end
	if map == "WorldMap" then
		for _, v in pairs(MAP_VEHICLES) do
			if ( v:IsVisible() and v:IsMouseOver() ) then
				if ( v.name ) then
					tooltipText = tooltipText..newLineString..v.name
				end
				newLineString = "\n"
			end
		end
		for i = 1, NUM_WORLDMAP_DEBUG_OBJECTS do
			unitButton = _G["WorldMapDebugObject"..i]
			if ( unitButton:IsVisible() and unitButton:IsMouseOver() ) then
				tooltipText = tooltipText..newLineString..unitButton.name
				newLineString = "\n"
			end
		end
		WorldMapTooltip:SetText(tooltipText)
		WorldMapTooltip:Show()
	else
		GameTooltip:SetText(tooltipText)
		GameTooltip:Show()
	end
end

function WorldMapUnit_OnEnter(self, motion)
	MapUnit_OnEnter(self, motion, "WorldMap")
end

local loaded = false
hooksecurefunc("BattlefieldMinimap_LoadUI", function()
	if loaded then
		return
	else
		loaded = true
		function BattlefieldMinimapUnit_OnEnter(self, motion)
			MapUnit_OnEnter(self, motion, "BattlefieldMinimap")
		end
	end
end)