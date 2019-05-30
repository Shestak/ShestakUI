local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Based on LiteStats(by Katae)
----------------------------------------------------------------------------------------
local P = "player"
local realm, char, class, layout = GetRealmName(), UnitName(P), select(2, UnitClass(P)), {}

-- Tooltip text colors
local tthead = {r = 0.40, g = 0.78, b = 1}	-- Headers
local ttsubh = {r = 0.75, g = 0.90, b = 1}	-- Subheaders

-- Strata/Level for text objects
local strata, level = "MEDIUM", 20

-- Globals
local profiles = LPSTAT_PROFILES
local font = LPSTAT_FONT
local t_icon = LTIPICONSIZE or 20
local IsAltKeyDown = IsAltKeyDown
local UpdateMemUse = UpdateAddOnMemoryUsage
local format = string.format
local strmatch = string.match
local strfind = string.find
local strtrim = strtrim
local unpack = unpack
local pairs = pairs
local ipairs = ipairs
local floor = math.floor
local select = select
local gsub = gsub

-- Config
local modules = LPSTAT_CONFIG
local fps = modules.FPS
local latency = modules.Latency
local memory = modules.Memory
local durability = modules.Durability
local gold = modules.Gold
local clock = modules.Clock
local location = modules.Location
local coords = modules.Coords
local ping = modules.Ping
local guild = modules.Guild
local friends = modules.Friends
local bags = modules.Bags
local talents = modules.Talents
local stats = modules.Stats
local experience = modules.Experience
local loot = modules.Loot
local nameplates = modules.Nameplates

-- Events Reg
local function RegEvents(f, l) for _, e in ipairs{strsplit(" ", l)} do f:RegisterEvent(e) end end

------------------------------------------
-- Saved Vars Init / Coords
local ls, coordX, coordY, conf, Coords = CreateFrame("Frame"), 0, 0, {}
RegEvents(ls, "ADDON_LOADED PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED")
ls:SetScript("OnEvent", function(_, event, addon)
	if event == "ADDON_LOADED" and addon == "ShestakUI" then
		if not SavedStats then SavedStats = {} end
		if not SavedStats[realm] then SavedStats[realm] = {} end
		if not SavedStats[realm][char] then SavedStats[realm][char] = {} end
		conf = SavedStats[realm][char]

		-- true/false defaults for autosell and autorepair
		if conf.AutoSell == nil then conf.AutoSell = true end
		if conf.AutoRepair == nil then conf.AutoRepair = true end
		if conf.AutoGuildRepair == nil then conf.AutoGuildRepair = true end
	end
end)

-- Config missing?
if not modules then return end

if modules and ((coords and coords.enabled) or (location and location.enabled)) then
	ls:SetScript("OnUpdate", function(self, elapsed)
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.2 then
			local unitMap = C_Map.GetBestMapForUnit("player")

			if unitMap then
				local GetPlayerMapPosition = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player")

				if GetPlayerMapPosition then
					coordX, coordY = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player"):GetXY()
				end
			end

			self.elapsed = 0
		end
	end)

	function Coords() return format(coords and coords.fmt or "%d, %d", coordX * 100, coordY * 100) end
end

-- Set profile
if profiles then for _, p in ipairs{class,format("%s - %s", char, realm)} do
	if profiles[p] then for k, v in pairs(profiles[p]) do
		for _k, _v in pairs(v) do modules[k][_k] = _v end
	end end
end profiles = nil end


------------------------------------------
local function comma_value(n) -- credit http://richard.warburton.it
	local left, num, right = string.match(n,"^([^%d]*%d)(%d*)(.-)$")
	return left..(num:reverse():gsub("(%d%d%d)","%1,"):reverse())..right
end

local function formatgold(style, amount)
	local gold, silver, copper = floor(amount * 0.0001), floor(mod(amount * 0.01, 100)), floor(mod(amount, 100))
	if style == 1 then
		return (gold > 0 and format("%s|cffffd700%s|r ", comma_value(gold), GOLD_AMOUNT_SYMBOL) or "")
			.. (silver > 0 and format("%s|cffc7c7cf%s|r ", silver, SILVER_AMOUNT_SYMBOL) or "")
			.. ((copper > 0 or (gold == 0 and silver == 0)) and format("%s|cffeda55f%s|r", copper, COPPER_AMOUNT_SYMBOL) or "")
	elseif style == 2 or not style then
		return format("%.1f|cffffd700%s|r", amount * 0.0001, GOLD_AMOUNT_SYMBOL)
	elseif style == 3 then
		return format("|cffffd700%s|r.|cffc7c7cf%s|r.|cffeda55f%s|r", gold, silver, copper)
	elseif style == 4 then
		return (gold > 0 and format(GOLD_AMOUNT_TEXTURE, gold, 12, 12) or "") .. (silver > 0 and format(SILVER_AMOUNT_TEXTURE, silver, 12, 12) or "")
			.. ((copper > 0 or (gold == 0 and silver == 0)) and format(COPPER_AMOUNT_TEXTURE, copper, 12, 12) or "") .. " "
	elseif style == 5 then
		return (gold > 0 and format("%s|cffffd700%s|r ", comma_value(gold), GOLD_AMOUNT_SYMBOL) or "")
			.. (format("%.2d|cffc7c7cf%s|r ", silver, SILVER_AMOUNT_SYMBOL))
			.. (format("%.2d|cffeda55f%s|r", copper, COPPER_AMOUNT_SYMBOL))
	end
end

local function zsub(s, ...) local t = {...} for i = 1, #t, 2 do s = gsub(s, t[i], t[i + 1]) end return s end
local function abbr(t, s) return t[s] or zsub(_G[strupper(s).."_ONELETTER_ABBR"], "%%d", "", "^%s*", "") end
local function fmttime(sec, t)
	local t = t or {}
	local d, h, m, s = ChatFrame_TimeBreakDown(floor(sec))
	local string = zsub(format(" %dd %dh %dm "..((d == 0 and h == 0) and "%ds" or ""), d, h, m, s), " 0[dhms]", " ", "%s+", " ")
	string = strtrim(gsub(string, "([dhms])", {d = abbr(t, "day"), h = abbr(t, "hour"), m = abbr(t, "minute"), s = abbr(t, "second")}), " ")
	return strmatch(string, "^%s*$") and "0"..abbr(t, "second") or string
end

function gradient(perc)
	perc = perc > 1 and 1 or perc < 0 and 0 or perc -- Stay between 0-1
	local seg, relperc = math.modf(perc*2)
	local r1, g1, b1, r2, g2, b2 = select(seg * 3 + 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0) -- R -> Y -> G
	local r, g, b = r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255), r, g, b
end

local function HideTT(self) GameTooltip:Hide() self.hovered = false end

local pxpx = {height = 1, width = 1}
local function Inject(name, stat)
	if not name then return end
	if not stat then stat = pxpx end

	local m = modules[name]
	for k, v in pairs{ -- retrieving config variables from LPSTAT_CONFIG
		--name = name, anchor_frame = m.anchor_frame,
		name = name, parent = m.anchor_frame,
		anchor_to = m.anchor_to, anchor_from = m.anchor_from,
		x_off = m.x_off, y_off = m.y_off,
		height = m.height, width = m.width,
		strata = m.strata or strata, level = level
	} do if not stat[k] then stat[k] = v end end
	if not stat.text then stat.text = {} end

	-- retrieve font variables and insert them into text table
	for k,v in pairs(font) do
		if not stat.text[k] then
			stat.text[k] = m[k] or v
		end
	end

	if stat.OnEnter then if stat.OnLeave then hooksecurefunc(stat, "OnLeave", HideTT) else stat.OnLeave = HideTT end end
	tinsert(layout, stat)
end

-- Inject dummy frames for disabled modules
for name, conf in pairs(modules) do
	if not conf.enabled then Inject(name) end
end

local function AltUpdate(self)
	if not self.hovered then return end
	if IsAltKeyDown() and not self.altdown then self.altdown = true self:GetScript("OnEnter")(self)
	elseif not IsAltKeyDown() and self.altdown then self.altdown = false self:GetScript("OnEnter")(self) end
end

local menuFrame = CreateFrame("Frame", "ContactDropDownMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{text = OPTIONS_MENU, isTitle = true, notCheckable = true},
	{text = INVITE, hasArrow = true, notCheckable = true},
	{text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true}
}

SLASH_LSTATS1, SLASH_LSTATS2, SLASH_LSTATS3 = "/ls", "/lstats", "/litestats"
local function slprint(...)
	local m, l = "|cffbcee68", "|cffff9912 -|r"
	local t = {...} print(m, t[1])
	for i = 2, #t do print(l, t[i]) end
end
function SlashCmdList.LSTATS()
	print("Lite|cff66C6FFStats|r "..L_STATS_TIPS)
	if clock.enabled then
		slprint(TIMEMANAGER_TITLE, L_STATS_OPEN_CALENDAR, L_STATS_RC_TIME_MANAGER, L_STATS_TOGGLE_TIME)
	end
	if memory.enabled then
		slprint(L_STATS_MEMORY, L_STATS_RC_COLLECTS_GARBAGE)
	end
	if friends.enabled or guild.enabled then
		slprint(format("%s/%s", FRIENDS, GUILD), L_STATS_VIEW_NOTES, L_STATS_CHANGE_SORTING)
	end
	if durability.enabled then
		slprint(DURABILITY, L_STATS_OPEN_CHARACTER, L_STATS_RC_AUTO_REPAIRING1, L_STATS_RC_AUTO_REPAIRING2, L_STATS_EQUIPMENT_CHANGER)
	end
	if experience.enabled then
		slprint(format("%s/%s/%s", COMBAT_XP_GAIN, TIME_PLAYED_MSG, FACTION), L_STATS_RC_EXPERIENCE, L_STATS_WATCH_FACTIONS, L_STATS_TOOLTIP_EXPERIENCE, L_STATS_TOOLTIP_TIME_PLAYED)
	end
	if talents.enabled then
		slprint(TALENTS, L_STATS_OPEN_TALENT, L_STATS_RC_TALENT)
	end
	if location.enabled or coords.enabled then
		slprint(L_STATS_LOCATION, L_STATS_WORLD_MAP, L_STATS_INSERTS_COORDS)
	end
	if gold.enabled then
		slprint(strtrim(gsub(MONEY, "%%d", "")), L_STATS_OPEN_CURRENCY, L_STATS_RC_AUTO_SELLING, L_STATS_NEED_TO_SELL, L_STATS_WATCH_CURRENCY)
	end
	print("|cffBCEE68", format(L_STATS_OTHER_OPTIONS, "|cff66C6FFShestakUI\\Config\\DataText.lua").."|r")
end

CreateFrame("Frame", "LSMenus", UIParent, "UIDropDownMenuTemplate")

----------------------------------------------------------------------------------------
--	FPS
----------------------------------------------------------------------------------------
if fps.enabled then
	Inject("FPS", {
		text = {
			string = function()
				return format(fps.fmt, floor(GetFramerate()))
			end
		},
	})
end

----------------------------------------------------------------------------------------
--	Latency
----------------------------------------------------------------------------------------
if latency.enabled then
	Inject("Latency", {
		text = {
			string = function()
				local _, _, latencyHome, latencyWorld = GetNetStats()
				local lat = math.max(latencyHome, latencyWorld)
				return format(gsub(latency.fmt, "%[color%]", (gradient(1 - lat / 750))), lat)
			end
		},
		OnEnter = function(self)
			local _, _, latencyHome, latencyWorld = GetNetStats()
			local latency
			if not T.classic then -- For some reason formatting the localized string directly isn't working in Classic
				latency = format(MAINMENUBAR_LATENCY_LABEL, latencyHome, latencyWorld)
			else
				latency = format("Latency:\n%.0f ms (home)\n%.0f ms (world)", latencyHome, latencyWorld)
			end
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Latency.tip_anchor, modules.Latency.tip_frame, modules.Latency.tip_x, modules.Latency.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(latency, tthead.r, tthead.g, tthead.b)
			GameTooltip:Show()
		end,
	})
end

----------------------------------------------------------------------------------------
--	Memory
----------------------------------------------------------------------------------------
if memory.enabled then
	local function sortdesc(a, b) return a[2] > b[2] end
	local function formatmem(val, dec)
		return format(format("%%.%df %s", dec or 1, val > 1024 and "MB" or "KB"), val / (val > 1024 and 1024 or 1))
	end
	local memoryt = {}
	local isCPU = GetCVar("scriptProfile") == "1"
	Inject("Memory", {
		text = {
			string = function(self)
				self.total = 0
				UpdateMemUse()
				local parent = self:GetParent()
				for i = 1, GetNumAddOns() do self.total = self.total + GetAddOnMemoryUsage(i) end
				if parent.hovered then self:GetParent():GetScript("OnEnter")(parent) end
				return self.total >= 1024 and format(memory.fmt_mb, self.total / 1024) or format(memory.fmt_kb, self.total)
			end, update = 5,
		},
		OnEnter = function(self)
			collectgarbage()
			self.hovered = true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Memory.tip_anchor, modules.Memory.tip_frame, modules.Memory.tip_x, modules.Memory.tip_y)
			GameTooltip:ClearLines()
			local lat, r = select(4, GetNetStats()), 750
			GameTooltip:AddDoubleLine(
				format("|cffffffff%s|r %s, %s%s|r %s", floor(GetFramerate()), FPS_ABBR, gradient(1 - lat / r), lat, MILLISECONDS_ABBR),
				format("%s: |cffffffff%s", ADDONS, formatmem(self.text.total)), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			if memory.max_addons ~= 0 or IsAltKeyDown() then
				if isCPU and IsControlKeyDown() then
					self.timer = 5
				end
				if not self.timer or self.timer + 5 < time() then
					if isCPU and IsControlKeyDown() then
						UpdateAddOnCPUUsage()
						for i = 1, #memoryt do memoryt[i] = nil end
						for i = 1, GetNumAddOns() do
							local addon, name = GetAddOnInfo(i)
							if IsAddOnLoaded(i) then tinsert(memoryt, {name or addon, GetAddOnCPUUsage(i)}) end
						end
						table.sort(memoryt, sortdesc)
					else
						self.timer = time()
						UpdateMemUse()
						for i = 1, #memoryt do memoryt[i] = nil end
						for i = 1, GetNumAddOns() do
							local addon, name = GetAddOnInfo(i)
							if IsAddOnLoaded(i) then tinsert(memoryt, {name or addon, GetAddOnMemoryUsage(i)}) end
						end
						table.sort(memoryt, sortdesc)
					end
				end
				local exmem = 0
				for i,t in ipairs(memoryt) do
					if memory.max_addons and i > memory.max_addons and not IsAltKeyDown() then
						exmem = exmem + t[2]
					else
						local color = t[2] <= 102.4 and {0,1} -- 0 - 100
							or t[2] <= 512 and {0.5,1} -- 100 - 512
							or t[2] <= 1024 and {0.75,1} -- 512 - 1mb
							or t[2] <= 2560 and {1,1} -- 1mb - 2.5mb
							or t[2] <= 5120 and {1,0.75} -- 2.5mb - 5mb
							or t[2] <= 8192 and {1,0.5} -- 5mb - 8mb
							or {1,0.1} -- 8mb +
						if isCPU and IsControlKeyDown() then
							GameTooltip:AddDoubleLine(t[1], format("%d ms", t[2]), 1, 1, 1, color[1], color[2], 0)
						else
							GameTooltip:AddDoubleLine(t[1], formatmem(t[2]), 1, 1, 1, color[1], color[2], 0)
						end
					end
				end
				if exmem > 0 and not IsAltKeyDown() then
					local more = #memoryt - memory.max_addons
					GameTooltip:AddDoubleLine(format("%d %s (%s)", more, L_STATS_HIDDEN, ALT_KEY), formatmem(exmem), ttsubh.r, ttsubh.g, ttsubh.b, ttsubh.r, ttsubh.g, ttsubh.b)
				end
				GameTooltip:AddDoubleLine(" ", "--------------", 1, 1, 1, 0.5, 0.5, 0.5)
			end
			local bandwidth = GetAvailableBandwidth()
			if bandwidth ~= 0 then
				GameTooltip:AddDoubleLine(L_STATS_BANDWIDTH, format("%s ".."Mbps", T.Round(bandwidth, 2)), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_DOWNLOAD, format("%s%%", floor(GetDownloadedPercentage() * 100 + 0.5)), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddDoubleLine(L_STATS_MEMORY_USAGE, formatmem(gcinfo() - self.text.total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddDoubleLine(L_STATS_TOTAL_MEMORY_USAGE, formatmem(collectgarbage"count"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			if isCPU then
				self.totalCPU = 0
				UpdateAddOnCPUUsage()
				for i = 1, GetNumAddOns() do self.totalCPU = self.totalCPU + GetAddOnCPUUsage(i) end
				GameTooltip:AddDoubleLine(L_STATS_TOTAL_CPU_USAGE, format("%d ms", self.totalCPU), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			end
			GameTooltip:Show()
		end,
		--OnUpdate = AltUpdate,
		OnLeave = function(self) self.hovered = false end,
		OnClick = function(self, button)
			if button == "RightButton" then
				UpdateMemUse()
				local before = gcinfo()
				collectgarbage()
				UpdateMemUse()
				print(format("|cff66C6FF%s:|r %s", L_STATS_GARBAGE_COLLECTED, formatmem(before - gcinfo())))
				self.timer, self.text.elapsed = nil, 5
				self:GetScript("OnEnter")(self)
			elseif button == "LeftButton" then
				if AddonList:IsShown() then
					AddonList_OnCancel()
				else
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
					ShowUIPanel(AddonList)
				end
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Durability
----------------------------------------------------------------------------------------
if durability.enabled then
	Inject("Durability", {
		OnLoad = function(self)
			CreateFrame("GameTooltip", "LPDURA")
			LPDURA:SetOwner(WorldFrame, "ANCHOR_NONE")
			if durability.man then DurabilityFrame.Show = DurabilityFrame.Hide end
			RegEvents(self, "UPDATE_INVENTORY_DURABILITY MERCHANT_SHOW PLAYER_LOGIN")
		end,
		OnEvent = function(self, event)
			if event == "UPDATE_INVENTORY_DURABILITY" or event == "PLAYER_LOGIN" then
				local dmin = 100
				for id = 1, 18 do
					local dur, dmax = GetInventoryItemDurability(id)
					if dur ~= dmax then dmin = floor(min(dmin, dur / dmax * 100)) end
				end
				self.text:SetText(format(gsub(durability.fmt, "%[color%]", (gradient(dmin / 100))), dmin))
			elseif event == "MERCHANT_SHOW" and not (IsAltKeyDown() or IsShiftKeyDown()) then
				if conf.AutoRepair and CanMerchantRepair() then
					local cost, total = GetRepairAllCost(), 0
					if cost > 0 then
						if not T.classic then
							if conf.AutoGuildRepair and CanGuildBankRepair() then RepairAllItems(1) total = cost end
						end
						if GetRepairAllCost() > 0 then
							if not durability.ignore_inventory and GetRepairAllCost() <= GetMoney() then
								total = GetRepairAllCost(); RepairAllItems()
							else
								for id = 1, 18 do
									local cost = select(3, LPDURA:SetInventoryItem(P, id))
									if cost ~= 0 and cost <= GetMoney() then
										if not InRepairMode() then ShowRepairCursor() end
										PickupInventoryItem(id)
										total = total + cost
									end
								end
							end
							HideRepairCursor()
						end
						if total > 0 then print(format("|cff66C6FF%s |cffFFFFFF%s", REPAIR_COST, formatgold(1, total))) end
					end
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Durability.tip_anchor, modules.Durability.tip_frame, modules.Durability.tip_x, modules.Durability.tip_y)
			GameTooltip:ClearLines()
			if C.tooltip.average_lvl == true then
				local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
				avgItemLevel = floor(avgItemLevel)
				avgItemLevelEquipped = floor(avgItemLevelEquipped)
				if not T.classic then
					GameTooltip:AddDoubleLine(DURABILITY, STAT_AVERAGE_ITEM_LEVEL..": "..avgItemLevelEquipped.." / "..avgItemLevel, tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				else
					GameTooltip:AddDoubleLine(DURABILITY, STAT_AVERAGE_ITEM_LEVEL..": "..avgItemLevelEquipped, tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				end
			else
				GameTooltip:AddLine(DURABILITY, tthead.r, tthead.g, tthead.b)
			end
			GameTooltip:AddLine(" ")
			local nodur, totalcost = true, 0
			for slot, string in gmatch("1HEAD3SHOULDER5CHEST6WAIST7LEGS8FEET9WRIST10HANDS16MAINHAND17SECONDARYHAND", "(%d+)([^%d]+)") do
				local dur, dmax = GetInventoryItemDurability(slot)
				local string = _G[string.."SLOT"]
				if dur ~= dmax then
					local perc = dur ~= 0 and dur/dmax or 0
					local hex = gradient(perc)
					GameTooltip:AddDoubleLine(durability.gear_icons and format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t %s", GetInventoryItemTexture(P, slot), t_icon, string) or string,format("|cffaaaaaa%s/%s | %s%s%%", dur, dmax, hex, floor(perc * 100)), 1, 1, 1)
					totalcost, nodur = totalcost + select(3, LPDURA:SetInventoryItem(P, slot))
				end
			end
			if nodur then
				GameTooltip:AddLine("100%", 0.1, 1, 0.1)
			else
				GameTooltip:AddDoubleLine(" ", "--------------", 1, 1, 1, 0.5, 0.5, 0.5)
				GameTooltip:AddDoubleLine(REPAIR_COST, formatgold(1, totalcost), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(" ", L_STATS_AUTO_REPAIR..": "..(conf.AutoRepair and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			if not T.classic then
				GameTooltip:AddDoubleLine(" ", L_STATS_GUILD_REPAIR..": "..(conf.AutoGuildRepair and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			end
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if not T.classic then
				if button == "RightButton" then
					conf.AutoRepair = not conf.AutoRepair
					self:GetScript("OnEnter")(self)
				elseif button == "MiddleButton" then
					conf.AutoGuildRepair = not conf.AutoGuildRepair
					self:GetScript("OnEnter")(self)
				elseif C_EquipmentSet.GetNumEquipmentSets() > 0 and button == "LeftButton" and (IsAltKeyDown() or IsShiftKeyDown()) then
					local menulist = {{isTitle = true, notCheckable = 1, text = format(gsub(EQUIPMENT_SETS, ":", ""), "")}}
					if C_EquipmentSet.GetNumEquipmentSets() == 0 then
						tinsert(menulist, {text = NONE, notCheckable = 1, disabled = true})
					else
						for i = 1, C_EquipmentSet.GetNumEquipmentSets() do
							local name, icon, setID = C_EquipmentSet.GetEquipmentSetInfo(i-1)
							if not icon then icon = 134400 end
							tinsert(menulist, {text = format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t %s", icon, t_icon, name), notCheckable = 1, func = function() if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end EquipmentManager_EquipSet(setID) end})
						end
					end
					EasyMenu(menulist, LSMenus, "cursor", 0, 0, "MENU")
				elseif button == "LeftButton" then
					ToggleCharacter("PaperDollFrame")
				end
			else
				if button == "RightButton" then
					conf.AutoRepair = not conf.AutoRepair
					self:GetScript("OnEnter")(self)
				elseif button == "MiddleButton" then
					conf.AutoGuildRepair = not conf.AutoGuildRepair
					self:GetScript("OnEnter")(self)
				elseif button == "LeftButton" then
					ToggleCharacter("PaperDollFrame")
				end
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Gold
----------------------------------------------------------------------------------------
if gold.enabled then
	local IsSubTitle = 0
	local function Currency(id, weekly, capped)
		local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)
		if amount == 0 then return end
		if IsSubTitle == 1 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(PROFESSIONS_ARCHAEOLOGY, ttsubh.r, ttsubh.g, ttsubh.b)
		elseif IsSubTitle == 2 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(PROFESSIONS_COOKING, ttsubh.r, ttsubh.g, ttsubh.b)
		elseif IsSubTitle == 3 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(TRADE_SKILLS, ttsubh.r, ttsubh.g, ttsubh.b)
		elseif IsSubTitle == 4 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L_STATS_CURRENCY_RAID, ttsubh.r, ttsubh.g, ttsubh.b)
		elseif IsSubTitle == 5 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(EXPANSION_NAME7, ttsubh.r, ttsubh.g, ttsubh.b)
		end
		IsSubTitle = 0
		if weekly then
			if discovered then GameTooltip:AddDoubleLine(name, format("%s |T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t", REFORGE_CURRENT..": ".. amount.." - "..WEEKLY..": "..week.." / "..weekmax, tex, t_icon), 1, 1, 1, 1, 1, 1) end
		elseif capped then
			if id == 392 then maxed = 4000 end
			if discovered then GameTooltip:AddDoubleLine(name, format("%s |T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t", amount.." / "..maxed, tex, t_icon), 1, 1, 1, 1, 1, 1) end
		else
			if discovered then GameTooltip:AddDoubleLine(name, format("%s |T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t", amount, tex, t_icon), 1, 1, 1, 1, 1, 1) end
		end
	end
	Inject("Gold", {
		OnLoad = function(self)
			self.started = GetMoney()
			RegEvents(self, "PLAYER_LOGIN PLAYER_MONEY MERCHANT_SHOW")
			if not SavedStats.JunkIgnore then SavedStats.JunkIgnore = {} end
		end,
		OnEvent = function(self, event)
			conf.Gold = GetMoney()
			if event == "MERCHANT_SHOW" then
				if conf.AutoSell and not (IsAltKeyDown() or IsShiftKeyDown()) then
					local profit = 0
					for bag = 0, NUM_BAG_SLOTS do for slot = 0, GetContainerNumSlots(bag) do
						local link = GetContainerItemLink(bag, slot)
						if link then
							local itemstring, ignore = strmatch(link, "|Hitem:(%d-):"), false
							for _, exception in pairs(SavedStats.JunkIgnore) do
								if exception == itemstring then ignore = true break end
							end
							if (select(3, GetItemInfo(link)) == 0 and not ignore) or (ignore and select(3, GetItemInfo(link)) ~= 0) then
								profit = profit + select(11, GetItemInfo(link)) * select(2, GetContainerItemInfo(bag, slot))
								UseContainerItem(bag, slot)
							end
						end
					end end
					if profit > 0 then print(format("|cff66C6FF%s: |cffFFFFFF%s", L_STATS_JUNK_PROFIT, formatgold(1, profit))) end
				end
				return
			end
			self.text:SetText(formatgold(gold.style, conf.Gold))
		end,
		OnEnter = function(self)
			local curgold = GetMoney()
			local _, _, archaeology, _, cooking = GetProfessions()
			conf.Gold = curgold
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(gold.tip_anchor, gold.tip_frame, gold.tip_x, gold.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(CURRENCY, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			if self.started ~= curgold then
				local gained = curgold > self.started
				local color = gained and "|cff55ff55" or "|cffff5555"
				GameTooltip:AddDoubleLine(L_STATS_SESSION_GAIN, format("%s$|r %s %s$|r", color, formatgold(1, abs(self.started - curgold)), color), 1, 1, 1, 1, 1, 1)
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddLine(L_STATS_SERVER_GOLD, ttsubh.r, ttsubh.g, ttsubh.b)
			local total = 0
			local goldTable = {}
			local charIndex = 0
			wipe(goldTable)
			for char, conf in pairs(SavedStats[realm]) do
				if conf.Gold and conf.Gold > 99 then
					charIndex = charIndex + 1
					goldTable[charIndex] = {char, formatgold(5, conf.Gold), conf.Gold}
				end
			end
			table.sort(goldTable, function(a, b)
				if (a and b) then
					return a[3] > b[3]
				end
			end)
			for _, v in ipairs(goldTable) do
				GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
				total = total + v[3]
			end
			GameTooltip:AddDoubleLine(" ", "-----------------", 1, 1, 1, 0.5, 0.5, 0.5)
			GameTooltip:AddDoubleLine(TOTAL, formatgold(5, total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddLine(" ")

			if not T.classic then
				local currencies = 0
				for i = 1, GetCurrencyListSize() do
					local name, _, _, _, watched, count, icon = GetCurrencyListInfo(i)
					if watched then
						if currencies == 0 then GameTooltip:AddLine(TRACKING, ttsubh.r, ttsubh.g, ttsubh.b) end
						local r, g, b
						if count > 0 then r, g, b = 1, 1, 1 else r, g, b = 0.5, 0.5, 0.5 end
						GameTooltip:AddDoubleLine(name, format("%d |T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59:%d|t", count, icon, t_icon), r, g, b, r, g, b)
						currencies = currencies + 1
					end
				end

				if archaeology and C.stats.currency_archaeology then
					IsSubTitle = 1
					Currency(384)	-- Dwarf Archaeology Fragment
					Currency(385)	-- Troll Archaeology Fragment
					Currency(393)	-- Fossil Archaeology Fragment
					Currency(394)	-- Night Elf Archaeology Fragment
					Currency(397)	-- Orc Archaeology Fragment
					Currency(398)	-- Draenei Archaeology Fragment
					Currency(399)	-- Vrykul Archaeology Fragment
					Currency(400)	-- Nerubian Archaeology Fragment
					Currency(401)	-- Tol'vir Archaeology Fragment
					Currency(676)	-- Pandaren Archaeology Fragment
					Currency(677)	-- Mogu Archaeology Fragment
					Currency(754)	-- Mantid Archaeology Fragment
					Currency(821)	-- Draenor Clans Archaeology Fragment
					Currency(828)	-- Ogre Archaeology Fragment
					Currency(829)	-- Arakkoa Archaeology Fragment
					Currency(1172)	-- Highborne Archaeology Fragment
					Currency(1173)	-- Highmountain Tauren Archaeology Fragment
					Currency(1174)	-- Demonic Archaeology Fragment
				end

				if cooking and C.stats.currency_cooking then
					IsSubTitle = 2
					Currency(81)	-- Epicurean's Award
					Currency(402)	-- Ironpaw Token
				end

				if C.stats.currency_professions then
					IsSubTitle = 3
					Currency(910)	-- Secret of Draenor Alchemy
					Currency(999)	-- Secret of Draenor Tailoring
					Currency(1008)	-- Secret of Draenor Jewelcrafting
					Currency(1017)	-- Secret of Draenor Leatherworking
					Currency(1020)	-- Secret of Draenor Blacksmithing
				end

				if C.stats.currency_raid and T.level == MAX_PLAYER_LEVEL then
					IsSubTitle = 4
					Currency(1580, false, true)	-- Seal of Wartorn Fate
				end

				if C.stats.currency_misc then
					IsSubTitle = 5
					Currency(1716)	-- Honorbound Service Medal
					Currency(1717)	-- 7th Legion Service Medal
					Currency(1718)	-- Titan Residuum
					Currency(1560)	-- War Resources
					Currency(1710)	-- Seafarer's Dubloon
					Currency(515)	-- Darkmoon Prize Ticket
				end
			end

			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(" ", L_STATS_AUTO_SELL..": "..(conf.AutoSell and "|cff55ff55"..L_STATS_ON or "|cffff5555"..strupper(OFF)), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if button == "LeftButton" then
				ToggleCharacter("TokenFrame")
			elseif button == "RightButton" then
				conf.AutoSell = not conf.AutoSell
				self:GetScript("OnEnter")(self)
			end
		end
	})
	SLASH_KJUNK1 = "/junk"
	function SlashCmdList.KJUNK(s)
		local action = strsplit(" ", s)
		if action == "list" then
			print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_ADDITIONS, (#SavedStats.JunkIgnore == 0 and NONE or "")))
			for i, id in pairs(SavedStats.JunkIgnore) do
				local _, link = GetItemInfo(id)
				print("- ["..i.."]", link)
			end
		elseif action == "clear" then
			SavedStats.JunkIgnore = {}
			print("|cff66C6FF"..L_STATS_JUNK_CLEARED.."|r")
		elseif action == "add" or strfind(action, "^del") or strfind(action, "^rem") then
			local _, mouselink = GameTooltip:GetItem()
			for id in s:gmatch("|Hitem:(%d-):") do
				mouselink = nil
				local _, link = GetItemInfo(id)
				if action == "add" then
					if not tContains(SavedStats.JunkIgnore,id) then
						tinsert(SavedStats.JunkIgnore, id)
						print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_ADDED, link))
					else
						print(format("%s |cff66C6FF%s|r", link, L_STATS_JUNK_ALREADY_ADDITIONS))
					end
				elseif strfind(action, "^del") or strfind(action, "^rem") then
					tDeleteItem(SavedStats.JunkIgnore, id)
					print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_REMOVED, link))
				end
			end
			if mouselink then
				for id in mouselink:gmatch("|Hitem:(%d-):") do
					if action == "add" then
						if not tContains(SavedStats.JunkIgnore,id) then
							tinsert(SavedStats.JunkIgnore, id)
							print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_ADDED, mouselink))
						else
							print(format("%s |cff66C6FF%s|r", mouselink, L_STATS_JUNK_ALREADY_ADDITIONS))
						end
					elseif strfind(action, "^del") or strfind(action, "^rem") then
						tDeleteItem(SavedStats.JunkIgnore, id)
						print(format("|cff66C6FF%s:|r %s", L_STATS_JUNK_REMOVED, mouselink))
					end
				end
			end
		else
			print("Lite|cff66C6FFStats|r: "..L_STATS_JUNK_LIST)
			print(format("/junk <add||rem(ove)> [%s] - %s", L_STATS_JUNK_ITEMLINK, L_STATS_JUNK_ADD_ITEM))
			print("/junk list - "..L_STATS_JUNK_ITEMS_LIST)
			print("/junk clear - "..L_STATS_JUNK_CLEAR_ADDITIONS)
		end
	end
end

----------------------------------------------------------------------------------------
--	Clock
----------------------------------------------------------------------------------------
if clock.enabled then
	local CALENDAR_MONTH_NAMES = {
		MONTH_JANUARY,
		MONTH_FEBRUARY,
		MONTH_MARCH,
		MONTH_APRIL,
		MONTH_MAY,
		MONTH_JUNE,
		MONTH_JULY,
		MONTH_AUGUST,
		MONTH_SEPTEMBER,
		MONTH_OCTOBER,
		MONTH_NOVEMBER,
		MONTH_DECEMBER,
	}
	Inject("Clock", {
		text = {
			string = function()
				return zsub(GameTime_GetTime(true), "%s*AM", clock.AM, "%s*PM", clock.PM, ":", clock.colon)
			end
		},
		OnLoad = function(self) RequestRaidInfo() RegEvents(self, "UPDATE_INSTANCE_INFO") end,
		OnEvent = function(self) if self.hovered then self:GetScript("OnEnter")(self) end end,
		OnEnter = function(self)
			if not self.hovered then RequestRaidInfo() self.hovered = true end
			local currentCalendarTime, weekday, month, fullDate
			if not T.classic then
				currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
				weekday = CALENDAR_WEEKDAY_NAMES[currentCalendarTime.weekday]
				month = CALENDAR_MONTH_NAMES[currentCalendarTime.month]
				fullDate = format(FULLDATE, weekday, month, currentCalendarTime.monthDay, currentCalendarTime.year, currentCalendarTime.month)
			else
				currentCalendarTime = C_DateAndTime.GetTodaysDate()
				weekday = CALENDAR_WEEKDAY_NAMES[currentCalendarTime.weekDay]
				month = CALENDAR_MONTH_NAMES[currentCalendarTime.month]
				fullDate = format(FULLDATE, weekday, month, currentCalendarTime.day, currentCalendarTime.year, currentCalendarTime.month)
			end
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(clock.tip_anchor, clock.tip_frame, clock.tip_x, clock.tip_y)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(fullDate, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_LOCALTIME, ":", ""), zsub(GameTime_GetLocalTime(true), "%s*AM", "am", "%s*PM", "pm"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			GameTooltip:AddDoubleLine(gsub(TIMEMANAGER_TOOLTIP_REALMTIME, ":", ""), zsub(GameTime_GetGameTime(true), "%s*AM", "am", "%s*PM", "pm"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)

			local titleName
			for i = 1, GetNumSavedInstances() do
				local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers, _, numEncounters, encounterProgress = GetSavedInstanceInfo(i)
				if isRaid and (locked or extended) or maxPlayers == 5 and difficulty == 23 and (locked or extended) then
					local tr, tg, tb, diff
					if not titleName then
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(GROUP_FINDER, ttsubh.r, ttsubh.g, ttsubh.b)
						titleName = true
					end
					if extended then tr, tg, tb = 0.3, 1, 0.3 else tr, tg, tb = 1, 1, 1 end

					local _, _, isHeroic, _, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
					if displayMythic then
						diff = "M"
					elseif isHeroic or displayHeroic then
						diff = "H"
					end

					if (numEncounters and numEncounters > 0) and (encounterProgress and encounterProgress > 0) then
						GameTooltip:AddDoubleLine(format("%s |cffaaaaaa[%s%s] (%s/%s)", name, maxPlayers, diff or "", encounterProgress, numEncounters), fmttime(reset), 1, 1, 1, tr, tg, tb)
					else
						GameTooltip:AddDoubleLine(format("%s |cffaaaaaa[%s%s]", name, maxPlayers, diff or ""), fmttime(reset), 1, 1, 1, tr, tg, tb)
					end
				end
			end
			if not T.classic then
				local addedLine
				for i = 1, GetNumSavedWorldBosses() do
					local name, _, reset = GetSavedWorldBossInfo(i)
					if reset then
						if not addedLine then
							GameTooltip:AddLine(" ")
							GameTooltip:AddLine(RAID_INFO_WORLD_BOSS, ttsubh.r, ttsubh.g, ttsubh.b)
							addedLine = true
						end
						GameTooltip:AddDoubleLine(name, fmttime(reset), 1, 1, 1, 1, 1, 1)
					end
				end
				if T.level == MAX_PLAYER_LEVEL then
					local c = 0
					for _, q in ipairs({52834, 52835, 52837, 52838, 52839, 52840}) do
						if IsQuestFlaggedCompleted(q) then
							c = c + 1
						end
					end
					local max = 2
					local r, g, b = 1, 1, 1
					if c == 0 then
						r, g, b = 1, 0, 0
					elseif c == 1 then
						r, g, b = 1, 1, 0
					end
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(MISCELLANEOUS, ttsubh.r, ttsubh.g, ttsubh.b)
					GameTooltip:AddDoubleLine(L_STATS_SEALS, format("%s/%s", c, max), 1, 1, 1, r, g, b)
				end
			end
			GameTooltip:Show()
		end,
		OnClick = function(_, b)
			if not T.classic then
				(b == "RightButton" and ToggleTimeManager or ToggleCalendar)()
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Location
----------------------------------------------------------------------------------------
if location.enabled then
	Inject("Location", {
		OnLoad = function(self)
			RegEvents(self, "ZONE_CHANGED ZONE_CHANGED_INDOORS ZONE_CHANGED_NEW_AREA PLAYER_ENTERING_WORLD")
			self.sanctuary = {SANCTUARY_TERRITORY, {0.41, 0.8, 0.94}}
			self.arena = {FREE_FOR_ALL_TERRITORY, {1, 0.1, 0.1}}
			self.friendly = {FACTION_CONTROLLED_TERRITORY, {0.1, 1, 0.1}}
			self.hostile = {FACTION_CONTROLLED_TERRITORY, {1, 0.1, 0.1}}
			self.contested = {CONTESTED_TERRITORY, {1, 0.7, 0}}
			self.combat = {COMBAT_ZONE, {1, 0.1, 0.1}}
			self.neutral = {format(FACTION_CONTROLLED_TERRITORY, FACTION_STANDING_LABEL4), {1, 0.93, 0.76}}
		end,
		OnEvent = function(self)
			self.subzone, self.zone, self.pvp = GetSubZoneText(), GetZoneText(), {GetZonePVPInfo()}
			if not self.pvp[1] then self.pvp[1] = "neutral" end
			local label = (self.subzone ~= "" and location.subzone) and self.subzone or self.zone
			local r, g, b = unpack(self.pvp[1] and (self[self.pvp[1]][2] or self.other) or self.other)
			self.text:SetText(location.truncate == 0 and label or strtrim(strsub(label, 1, location.truncate)))
			self.text:SetTextColor(r, g, b, font.alpha)
		end,
		OnUpdate = function(self,u)
			if self.hovered then
				self.elapsed = self.elapsed + u
				if self.elapsed > 1 or self.init then
					GameTooltip:ClearLines()
					GameTooltip:AddLine(format("%s |cffffffff(%s)", self.zone, Coords()), tthead.r, tthead.g, tthead.b, 1, 1, 1)
					if self.pvp[1] and not IsInInstance() then
						local r, g, b = unpack(self[self.pvp[1]][2])
						if self.subzone and self.subzone ~= self.zone then GameTooltip:AddLine(self.subzone, r, g, b) end
						GameTooltip:AddLine(format(self[self.pvp[1]][1], self.pvp[3] or ""), r, g, b)
					end
					GameTooltip:Show()
					self.elapsed, self.init = 0, false
				end
			end
		end,
		OnEnter = function(self)
			self.hovered, self.init = true, true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Location.tip_anchor, modules.Location.tip_frame, modules.Location.tip_x, modules.Location.tip_y)
		end,
		OnClick = function(self)
			if IsShiftKeyDown() then
				ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
				ChatEdit_ChooseBoxForSend():Insert(format(" (%s: %s)", self.zone, Coords()))
			else
				ToggleFrame(WorldMapFrame)
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Coordinates
----------------------------------------------------------------------------------------
if coords.enabled then
	Inject("Coords", {
		text = {string = Coords},
		OnClick = function()
			if IsShiftKeyDown() then
				ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
				ChatEdit_ChooseBoxForSend():Insert(format(" (%s: %s)", GetZoneText(), Coords()))
			else
				ToggleFrame(WorldMapFrame)
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Ping
----------------------------------------------------------------------------------------
if ping.enabled then
	Inject("Ping", {
		OnLoad = function(self)
			self:RegisterEvent("MINIMAP_PING")
			self.animGroup = self.text:CreateAnimationGroup()
			self.anim = self.animGroup:CreateAnimation("Alpha")
			self.animGroup:SetScript("OnFinished", function() self.text:Hide() end)
			self.anim:SetFromAlpha(1)
			self.anim:SetToAlpha(0)
			self.anim:SetDuration(2.8)
			self.anim:SetStartDelay(5)
			end,
		OnEvent = function(self, _, unit)
			if unit == P and ping.hide_self then return end
				local class = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]
				self.text:SetText(format(ping.fmt, UnitName(unit)))
				if class then
					self.text:SetTextColor(class.r, class.g, class.b, 1)
				else
					self.text:SetTextColor(1, 1, 1, 1)
				end
				self.animGroup:Stop()
				self.text:Show()
				self.animGroup:Play()
			end
	})
end

----------------------------------------------------------------------------------------
--	Guild
----------------------------------------------------------------------------------------
if guild.enabled then
	local guildTable = {}
	local function BuildGuildTable()
		wipe(guildTable)
		for i = 1, GetNumGuildMembers() do
			local name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, mobile = GetGuildRosterInfo(i)
			name = Ambiguate(name, "none")
			guildTable[i] = {name, rank, level, zone, note, officernote, connected, status, class, mobile}
		end
		table.sort(guildTable, function(a, b)
			if (a and b) then
				return a[1] < b[1]
			end
		end)
	end
	hooksecurefunc("SortGuildRoster", function(type) CURRENT_GUILD_SORTING = type end)
	Inject("Guild", {
		text = {
			string = function()
				if IsInGuild() then
					local total, _, online = GetNumGuildMembers()
					return format(guild.fmt, online, total)
				else return not T.classic and LOOKINGFORGUILD or format("%s %s", NO, GUILD) end
			end, update = 5
		},
		OnLoad = function(self)
			GuildRoster()
			SortGuildRoster(guild.sorting == "note" and "rank" or "note")
			SortGuildRoster(guild.sorting)
			self:RegisterEvent("GROUP_ROSTER_UPDATE")
			self:RegisterEvent("GUILD_ROSTER_UPDATE")
		end,
		OnEvent = function(self)
			if self.hovered then
				self:GetScript("OnEnter")(self)
			end
			if IsInGuild() then
				BuildGuildTable()
			end
		end,
		OnUpdate = function(self, u)
			if IsInGuild() then
				AltUpdate(self)
				if not self.gmotd then
					if self.elapsed > 1 then GuildRoster(); self.elapsed = 0 end
					if GetGuildRosterMOTD() ~= "" then self.gmotd = true; if self.hovered then self:GetScript("OnEnter")(self) end end
					self.elapsed = self.elapsed + u
				end
			end
		end,
		OnClick = function(self, b)
			if b == "LeftButton" then
				ToggleGuildFrame()
			elseif b == "MiddleButton" and IsInGuild() then
				local s = CURRENT_GUILD_SORTING
				SortGuildRoster(IsShiftKeyDown() and s or (IsAltKeyDown() and (s == "rank" and "note" or "rank") or s == "class" and "name" or s == "name" and "level" or s == "level" and "zone" or "class"))
				self:GetScript("OnEnter")(self)
			elseif b == "RightButton" and IsInGuild() then
				HideTT(self)

				local grouped
				local menuCountWhispers = 0
				local menuCountInvites = 0

				menuList[2].menuList = {}
				menuList[3].menuList = {}

				for i = 1, #guildTable do
					if (guildTable[i][7] or guildTable[i][10]) and guildTable[i][1] ~= T.name then
						local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])
						if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
							grouped = "|cffaaaaaa*|r"
						else
							grouped = ""
							if not guildTable[i][10] then
								menuCountInvites = menuCountInvites + 1
								menuList[2].menuList[menuCountInvites] = {
									text = string.format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s", levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, Ambiguate(guildTable[i][1], "all"), ""),
									arg1 = guildTable[i][1],
									notCheckable = true,
									func = function(self, arg1)
										menuFrame:Hide()
										InviteUnit(arg1)
									end
								}
							end
						end
						menuCountWhispers = menuCountWhispers + 1
						menuList[3].menuList[menuCountWhispers] = {
							text = string.format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s", levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, Ambiguate(guildTable[i][1], "all"), grouped),
							arg1 = guildTable[i][1],
							notCheckable = true,
							func = function(self, arg1)
								menuFrame:Hide()
								SetItemRef("player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton")
							end
						}
					end
				end

				EasyMenu(menuList, menuFrame, self, 0, 0, "MENU")
			end
		end,
		OnEnter = function(self)
			if IsInGuild() then
				self.hovered = true
				GuildRoster()
				local name, rank, level, zone, note, officernote, connected, status, class, isMobile, zone_r, zone_g, zone_b, classc, levelc, grouped
				local total, _, online = GetNumGuildMembers()
				local gmotd = GetGuildRosterMOTD()

				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(modules.Guild.tip_anchor, modules.Guild.tip_frame, modules.Guild.tip_x, modules.Guild.tip_y)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(GetGuildInfo(P),format("%s: %d/%d", GUILD_ONLINE_LABEL, online, total), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				if gmotd ~= "" then GameTooltip:AddLine(format("%s |cffaaaaaa- |cffffffff%s", GUILD_MOTD, gmotd), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
				if guild.maxguild ~= 0 and online >= 1 then
					GameTooltip:AddLine(" ")
					for i = 1, total do
						if guild.maxguild and i > guild.maxguild then
							if online > 2 then GameTooltip:AddLine(format("%d %s (%s)", online - guild.maxguild, L_STATS_HIDDEN, ALT_KEY), ttsubh.r, ttsubh.g, ttsubh.b) end
							break
						end
						name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, isMobile = GetGuildRosterInfo(i)
						if (connected or isMobile) and level >= guild.threshold then
							name = Ambiguate(name, "all")
							if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1, 0.3 else zone_r, zone_g, zone_b = 1, 1, 1 end
							if isMobile then zone = "|cffa5a5a5"..REMOTE_CHAT.."|r" end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
							grouped = (UnitInParty(name) or UnitInRaid(name)) and (GetRealZoneText() == zone and " |cff7fff00*|r" or " |cffff7f00*|r") or ""
							if self.altdown then
								GameTooltip:AddDoubleLine(format("%s%s |cff999999- |cffffffff%s", grouped, name, rank), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
								if note ~= "" then GameTooltip:AddLine("   "..NOTE_COLON.." "..note, ttsubh.r, ttsubh.g, ttsubh.b, 1) end
								if officernote ~= "" and EPGP then
									local ep, gp = EPGP:GetEPGP(name)
									if ep then
										officernote = "   EP: "..ep.."  GP: "..gp.."  PR: "..string.format("%.3f", ep / gp)
									else
										officernote = "   O."..NOTE_COLON.." "..officernote
									end
								elseif officernote ~= "" then
									officernote = "   O."..NOTE_COLON.." "..officernote
								end
								if officernote ~= "" then GameTooltip:AddLine(officernote, 0.3, 1, 0.3, 1) end
							else
								if status == 1 then
									status = " |cffE7E716"..L_CHAT_AFK.."|r"
								elseif status == 2 then
									status = " |cffff0000"..L_CHAT_DND.."|r"
								else
									status = ""
								end
								GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, level, name, status, grouped), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
							end
						end
					end
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine(" ", format("%s %s", L_STATS_SORTING_BY, CURRENT_GUILD_SORTING), 1, 1, 1, ttsubh.r, ttsubh.g, ttsubh.b)
				end
				GameTooltip:Show()
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Friends
----------------------------------------------------------------------------------------
if friends.enabled then
	local totalFriendsOnline = 0
	local totalBattleNetOnline = 0
	local BNTable = {}
	local friendTable = {}
	local function BuildFriendTable(total)
		totalFriendsOnline = 0
		wipe(friendTable)

		for i = 1, total do
			local name, level, class, area, connected, status, note = GetFriendInfo(i)
			for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			if GetLocale() ~= "enUS" then
				for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
			end
			friendTable[i] = {name, level, class, area, connected, status, note}
			if connected then
				totalFriendsOnline = totalFriendsOnline + 1
			end
		end

		table.sort(friendTable, function(a, b)
			if a[1] and b[1] then
				return a[1] < b[1]
			end
		end)
	end
	local function BuildBNTable(total)
		totalBattleNetOnline = 0
		wipe(BNTable)

		for i = 1, total do
			local presenceID, presenceName, battleTag, _, toonName, toonID, client, isOnline, _, isAFK, isDND, _, noteText = BNGetFriendInfo(i)
			local _, _, _, realmName, _, faction, race, class, _, zoneName, level = BNGetGameAccountInfo(toonID or presenceID)
			for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			if GetLocale() ~= "enUS" then
				for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
			end
			BNTable[i] = {presenceID, presenceName, battleTag, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level}
			if isOnline then
				totalBattleNetOnline = totalBattleNetOnline + 1
			end
		end

		table.sort(BNTable, function(a, b)
			if a[2] and b[2] and a[3] and b[3] then
				if a[2] == b[2] then return a[3] < b[3] end
				return a[2] < b[2]
			end
		end)
	end
	local clientTags = {
		[BNET_CLIENT_D3] = "Diablo 3",
		[BNET_CLIENT_WTCG] = "Hearthstone",
		[BNET_CLIENT_HEROES] = "Heroes of the Storm",
		[BNET_CLIENT_OVERWATCH] = "Overwatch",
		[BNET_CLIENT_SC] = "StarCraft",
		[BNET_CLIENT_SC2] = "StarCraft 2",
		[BNET_CLIENT_DESTINY2] = "Destiny 2",
		[BNET_CLIENT_COD] = "Call of Duty: Black Ops 4"
	}
	Inject("Friends", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN PLAYER_ENTERING_WORLD GROUP_ROSTER_UPDATE FRIENDLIST_UPDATE BN_FRIEND_LIST_SIZE_CHANGED BN_FRIEND_ACCOUNT_ONLINE BN_FRIEND_ACCOUNT_OFFLINE BN_FRIEND_INFO_CHANGED BN_FRIEND_ACCOUNT_ONLINE BN_FRIEND_ACCOUNT_OFFLINE BN_FRIEND_INFO_CHANGED") end,
		OnEvent = function(self, event)
			if event ~= "GROUP_ROSTER_UPDATE" then
				local numBNetTotal, numBNetOnline = BNGetNumFriends()
				local online, total = 0, GetNumFriends()
				for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
				online = online + numBNetOnline
				total = total + numBNetTotal
				self.text:SetText(format(friends.fmt, online, total))
			end
			if self.hovered then self:GetScript("OnEnter")(self) end
		end,
		OnUpdate = AltUpdate,
		OnClick = function(self, b)
			if b == "MiddleButton" then
				ToggleIgnorePanel()
			elseif b == "LeftButton" then
				ToggleFriendsFrame()
			elseif b == "RightButton" then
				HideTT(self)

				local BNTotal = BNGetNumFriends()
				local total = GetNumFriends()
				BuildBNTable(BNTotal)
				BuildFriendTable(total)

				local classc, levelc, grouped
				local menuCountWhispers = 0
				local menuCountInvites = 0

				menuList[2].menuList = {}
				menuList[3].menuList = {}

				if totalFriendsOnline > 0 then
					for i = 1, #friendTable do
						if friendTable[i][5] then
							if UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1]) then
								grouped = " |cffaaaaaa*|r"
							else
								grouped = ""
							end

							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])
							if classc == nil then
								classc = GetQuestDifficultyColor(friendTable[i][2])
							end

							menuCountWhispers = menuCountWhispers + 1
							menuList[3].menuList[menuCountWhispers] = {
								text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, friendTable[i][2], classc.r * 255, classc.g * 255, classc.b * 255, friendTable[i][1], grouped),
								arg1 = friendTable[i][1],
								notCheckable = true,
								func = function(self, arg1)
									menuFrame:Hide()
									SetItemRef("player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton")
								end
							}

							if not (UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1])) then
								menuCountInvites = menuCountInvites + 1
								menuList[2].menuList[menuCountInvites] = {
									text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r", levelc.r * 255, levelc.g * 255, levelc.b * 255, friendTable[i][2], classc.r * 255, classc.g * 255, classc.b * 255, friendTable[i][1]),
									arg1 = friendTable[i][1],
									notCheckable = true,
									func = function(self, arg1)
										menuFrame:Hide()
										InviteUnit(arg1)
									end
								}
							end
						end
					end
				end

				if totalBattleNetOnline > 0 then
					for i = 1, #BNTable do
						if BNTable[i][7] then
							if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
								grouped = " |cffaaaaaa*|r"
							else
								grouped = ""
							end

							menuCountWhispers = menuCountWhispers + 1
							menuList[3].menuList[menuCountWhispers] = {
								text = BNTable[i][2]..grouped,
								arg1 = BNTable[i][2],
								notCheckable = true,
								func = function(self, arg1)
									menuFrame:Hide()
									ChatFrame_SendBNetTell(arg1)
								end
							}

							if BNTable[i][6] == BNET_CLIENT_WOW and UnitFactionGroup("player") == BNTable[i][12] then
								if not (UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4])) then
									classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])
									if classc == nil then
										classc = GetQuestDifficultyColor(BNTable[i][16])
									end
									menuCountInvites = menuCountInvites + 1
									menuList[2].menuList[menuCountInvites] = {
										text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r", levelc.r * 255, levelc.g * 255, levelc.b * 255, BNTable[i][16], classc.r * 255, classc.g * 255, classc.b * 255, BNTable[i][4]),
										arg1 = BNTable[i][5],
										notCheckable = true,
										func = function(self, arg1)
											menuFrame:Hide()
											BNInviteFriend(arg1)
										end
									}
								end
							end
						end
					end
				end

				EasyMenu(menuList, menuFrame, self, 0, 0, "MENU")
			end
		end,
		OnEnter = function(self)
			ShowFriends()
			self.hovered = true
			local online, total = 0, GetNumFriends()
			local name, level, class, zone, connected, status, note, classc, levelc, zone_r, zone_g, zone_b, grouped
			for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
			local BNonline, BNtotal = 0, BNGetNumFriends()
			local presenceName, toonName, toonID, client, isOnline
			if BNtotal > 0 then
				for i = 1, BNtotal do if select(8, BNGetFriendInfo(i)) then BNonline = BNonline + 1 end end
			end
			local totalonline = online + BNonline
			local totalfriends = total + BNtotal
			if online > 0 or BNonline > 0 then
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(modules.Friends.tip_anchor, modules.Friends.tip_frame, modules.Friends.tip_x, modules.Friends.tip_y)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(FRIENDS_LIST, format("%s: %s/%s", GUILD_ONLINE_LABEL, totalonline, totalfriends), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				if online > 0 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(WOW_FRIEND)
					for i = 1, total do
						name, level, class, zone, connected, status, note = GetFriendInfo(i)
						if not connected then break end
						if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
						for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
						if GetLocale() ~= "enUS" then
							for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
						end
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
						grouped = (UnitInParty(name) or UnitInRaid(name)) and (GetRealZoneText() == zone and " |cff7fff00*|r" or " |cffff7f00*|r") or ""
						GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s", levelc.r * 255, levelc.g * 255, levelc.b * 255, level, name, grouped, " "..status), zone, classc.r, classc.g, classc.b, zone_r, zone_g, zone_b)
						if self.altdown and note then GameTooltip:AddLine("  "..note, ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					end
				end
				if BNonline > 0 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(BATTLENET_FRIEND)
					for i = 1, BNtotal do
						_, presenceName, battleTag, _, toonName, toonID, client, isOnline, _, isAFK, isDND = BNGetFriendInfo(i)
						toonName = BNet_GetValidatedCharacterName(toonName, battleTag, client) or ""
						if not isOnline then break end
						if isAFK then
							status = "|cffE7E716"..L_CHAT_AFK.."|r"
						else
							if isDND then
								status = "|cffff0000"..L_CHAT_DND.."|r"
							else
								status = ""
							end
						end
						if client == BNET_CLIENT_WOW then
							local _, toonName, client, realmName, _, _, _, class, _, zoneName, level = BNGetGameAccountInfo(toonID)
							for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
							if GetLocale() ~= "enUS" then
								for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
							end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
							if UnitInParty(toonName) or UnitInRaid(toonName) then grouped = " |cffaaaaaa*|r" else grouped = "" end
							GameTooltip:AddDoubleLine(format("%s (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r", client, levelc.r * 255, levelc.g * 255, levelc.b * 255, level, classc.r * 255, classc.g * 255, classc.b * 255, toonName, grouped, 255, 0, 0, status), presenceName, 238, 238, 238, 238, 238, 238)
							if self.altdown then
								if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
								if GetRealmName() == realmName then realm_r, realm_g, realm_b = 0.3, 1.0, 0.3 else realm_r, realm_g, realm_b = 0.65, 0.65, 0.65 end
								GameTooltip:AddDoubleLine("  "..zoneName, realmName, zone_r, zone_g, zone_b, realm_r, realm_g, realm_b)
							end
						else
							local _, _, _, _, _, _, _, _, _, _, _, gameText, _, _, _, _, _, isGameAFK, isGameBusy = BNGetGameAccountInfo(toonID)
							if client == "BSAp" or client == "App" then
								client = gameText
							else
								client = clientTags[client]
							end
							if isGameAFK then
								status = "|cffE7E716"..L_CHAT_AFK.."|r"
							else
								if isGameBusy then
									status = "|cffff0000"..L_CHAT_DND.."|r"
								else
									status = ""
								end
							end
							GameTooltip:AddDoubleLine("|cffeeeeee "..presenceName.."|r".." "..status, "|cffeeeeee"..client.."|r")
						end
					end
				end
				GameTooltip:Show()
			else
				HideTT(self)
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Bags
----------------------------------------------------------------------------------------
if bags.enabled then
	Inject("Bags", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN BAG_UPDATE") end,
		OnEvent = function(self)
			local free, total = 0, 0
			for i = 0, NUM_BAG_SLOTS do
				free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
			end
			self.text:SetText(format(bags.fmt, free, total))
		end,
		OnClick = function() ToggleAllBags() end,
		OnEnter = function(self)
			local free, total = 0, 0
			for i = 0, NUM_BAG_SLOTS do
				free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
			end
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			if GetBindingKey("TOGGLEBACKPACK") then
				GameTooltip:AddLine(BACKPACK_TOOLTIP.." ("..GetBindingKey("TOGGLEBACKPACK")..")", tthead.r, tthead.g, tthead.b)
			else
				GameTooltip:AddLine(BACKPACK_TOOLTIP, tthead.r, tthead.g, tthead.b)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(format(NUM_FREE_SLOTS, free, total), 1, 1, 1)
			GameTooltip:Show()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Talents
----------------------------------------------------------------------------------------
if talents.enabled then
	local lootSpecName, specName
	local specList = {
		{text = SPECIALIZATION, isTitle = true, notCheckable = true},
		{notCheckable = true},
		{notCheckable = true},
		{notCheckable = true},
		{notCheckable = true}
	}
	local lootList = {
		{text = SELECT_LOOT_SPECIALIZATION, isTitle = true, notCheckable = true},
		{notCheckable = true, func = function() SetLootSpecialization(0) end},
		{notCheckable = true},
		{notCheckable = true},
		{notCheckable = true},
		{notCheckable = true}
	}
	Inject("Talents", {
		OnLoad = function(self)
			if not T.classic then
				RegEvents(self, "PLAYER_ENTERING_WORLD PLAYER_TALENT_UPDATE PLAYER_LOOT_SPEC_UPDATED")
			else
				RegEvents(self, "PLAYER_ENTERING_WORLD CHARACTER_POINTS_CHANGED UNIT_INVENTORY_CHANGED UPDATE_BONUS_ACTIONBAR")
			end
		end,
		OnEvent = function(self)
			if UnitLevel(P) < SHOW_SPEC_LEVEL then
				self.text:SetText(format("%s %s", NO, SPECIALIZATION))
				return
			end

			local lootSpec
			if not T.classic then
				lootSpec = GetLootSpecialization()
				lootSpecName = lootSpec and select(2, GetSpecializationInfoByID(lootSpec)) or NO
			end

			local spec = GetSpecialization()
			specName = spec and select(2, GetSpecializationInfo(spec)) or NO

			local specIcon, lootIcon = "", ""
			local lootText = LOOT

			local _, _, _, specTex = GetSpecializationInfo(spec)
			if specTex then
				specIcon = format("|T%s:14:14:0:0:64:64:5:59:5:59|t", specTex)
			end

			if not T.classic then
				if lootSpec == 0 then
					lootIcon = specIcon
					lootText = "|cff55ff55"..lootText.."|r"
					lootSpecName = "|cff55ff55"..specName.."|r"
				else
					local _, _, _, texture = GetSpecializationInfoByID(lootSpec)
					if texture then
						lootIcon = format("|T%s:14:14:0:0:64:64:5:59:5:59|t", texture)
					end
				end
			end

			if not T.classic then
				self.text:SetText(format("%s:%s  %s:%s", L_STATS_SPEC, specIcon, lootText, lootIcon))
			else
				self.text:SetText(format("%s:%s", L_STATS_SPEC, specIcon))
			end
			if specIcon and C.font.stats_font_size ~= 15 and C.font.stats_font_size ~= 17 then
				local point, relativeTo, relativePoint, xOfs = self.text:GetPoint()
				self.text:SetPoint(point, relativeTo, relativePoint, xOfs, -1)
			end
			if self.hovered then self:GetScript("OnEnter")(self) end
		end,
		OnEnter = function(self)
			self.hovered = true
			if UnitLevel(P) >= SHOW_SPEC_LEVEL then
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint(modules.Talents.tip_anchor, modules.Talents.tip_frame, modules.Talents.tip_x, modules.Talents.tip_y)
				GameTooltip:ClearLines()
				if not T.classic then
					GameTooltip:AddLine(SPECIALIZATION.."/"..LOOT, tthead.r, tthead.g, tthead.b)
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine(SPECIALIZATION, specName, ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
					GameTooltip:AddDoubleLine(LOOT, lootSpecName, ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				else
					GameTooltip:AddLine(SPECIALIZATION, tthead.r, tthead.g, tthead.b)
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine(SPECIALIZATION, specName, ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				end
				GameTooltip:Show()
			end
		end,
		OnLeave = function(self)
			self.hovered = false
		end,
		OnClick = function(self, b)
			if UnitLevel(P) < SHOW_SPEC_LEVEL then
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_SPEC_LEVEL).."|r")
				return
			end
			if not T.classic then
				if b == "LeftButton" then
					if not PlayerTalentFrame then
						LoadAddOn("Blizzard_TalentUI")
					end
					if IsShiftKeyDown() then
						PlayerTalentFrame_Toggle()
					else
						for index = 1, 4 do
							local id, name, _, texture = GetSpecializationInfo(index)
							if id then
								if GetSpecializationInfo(GetSpecialization()) == id then
									name = "|cff55ff55"..name.."|r"
								end
								specList[index + 1].text = format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59|t  %s", texture, name)
								specList[index + 1].func = function() SetSpecialization(index) end
							else
								specList[index + 1] = nil
							end
						end
						EasyMenu(specList, LSMenus, self, 0, 24, "MENU")
					end
				elseif b == "RightButton" and GetSpecialization() then
					local lootSpec = GetLootSpecialization()
					local _, specName = GetSpecializationInfo(GetSpecialization())
					local specDefault = format(LOOT_SPECIALIZATION_DEFAULT, specName)
					if lootSpec == 0 then
						specDefault = "|cff55ff55"..format(LOOT_SPECIALIZATION_DEFAULT, specName).."|r"
					end
					lootList[2].text = specDefault
					for index = 1, 4 do
						local id, name, _, texture = GetSpecializationInfo(index)
						if id then
							if lootSpec == id then
								name = "|cff55ff55"..name.."|r"
							end
							lootList[index + 2].text = format("|T%s:"..t_icon..":"..t_icon..":0:0:64:64:5:59:5:59|t  %s", texture, name)
							lootList[index + 2].func = function() SetLootSpecialization(id) end
						else
							lootList[index + 2] = nil
						end
					end
					EasyMenu(lootList, LSMenus, self, 0, 40, "MENU")
				end
			else
				if b == "LeftButton" then
					ToggleTalentFrame()
				end
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Character Stats
----------------------------------------------------------------------------------------
if stats.enabled then
	local function tags(sub)
		local percent, string = true
		if sub == "power" then
			local value, power
			local Base, PosBuff, NegBuff = UnitAttackPower("player")
			local Effective = Base + PosBuff + NegBuff
			local RangedBase, RangedPosBuff, RangedNegBuff = UnitRangedAttackPower("player")
			local range = RangedBase + RangedPosBuff + RangedNegBuff
			local heal = GetSpellBonusHealing()
			local spell
			if not T.classic then
				spell = GetSpellBonusDamage(7)
			else
				local current = {}
				local best = 1
				for i = 1, 7 do
					 current[i] = GetSpellBonusDamage(i)
					 if current[i] > current[best] then
						best = i
					end
				end
				spell = best
			end
			local attack = Effective
			if heal > spell then
				power = heal
			else
				power = spell
			end
			if attack > power and T.class ~= "HUNTER" then
				value = attack
			elseif T.class == "HUNTER" then
				value = range
			else
				value = power
			end
			string = value
		elseif not T.classic and sub == "mastery" then
			string = GetMasteryEffect()
		elseif sub == "haste" then
			string = GetHaste()
		elseif not T.classic and sub == "resilience" then
			string, percent = GetCombatRating(16)
		elseif sub == "crit" then
			string = GetCritChance()
		elseif sub == "dodge" then
			string = GetDodgeChance()
		elseif sub == "parry" then
			string = GetParryChance()
		elseif sub == "block" then
			string = GetBlockChance()
		elseif sub == "avoidance" then
			string = GetDodgeChance() + GetParryChance()
		elseif sub == "manaregen" then
			local I5SR = true
			if T.class == "ROGUE" or T.class == "WARRIOR" or T.class == "DEATHKNIGHT" then
				string, percent = "??"
			else
				local base, cast = GetManaRegen()
				string, percent = floor((I5SR and cast or base) * 5)
			end
		elseif sub == "armor" then
			local _, eff = UnitArmor(P)
			string, percent = eff
		elseif not T.classic and sub == "versatility" then
			string = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)
		elseif not T.classic and sub == "leech" then
			string = GetCombatRating(17)
		else
			string, percent = format("[%s]", sub)
		end
		if not percent then return string end
		return format("%.1f", string)
	end
	Inject("Stats", {
		OnLoad = function(self)
			RegEvents(self, "PLAYER_LOGIN UNIT_STATS UNIT_DAMAGE UNIT_RANGEDDAMAGE PLAYER_DAMAGE_DONE_MODS UNIT_ATTACK_SPEED UNIT_ATTACK_POWER UNIT_RANGED_ATTACK_POWER")
		end,
		OnEvent = function(self) self.fired = true end,
		OnUpdate = function(self, u)
			self.elapsed = self.elapsed + u
			if self.fired and self.elapsed > 2.5 then
				self.text:SetText(gsub(stats[format("spec%dfmt", GetSpecialization() and GetSpecialization() or 1)], "%[(%w-)%]", tags))
				self.elapsed, self.fired = 0, false
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Experience/Played/Rep
----------------------------------------------------------------------------------------
if experience.enabled then
	local logintime, playedtotal, playedlevel, playedmsg, gained, lastkill, lastquest = GetTime(), 0, 0, 0, 0
	local repname, repcolor, standingname, currep, minrep, maxrep
	local mobxp = gsub(COMBATLOG_XPGAIN_FIRSTPERSON, "%%[sd]", "(.*)")
	local questxp = gsub(COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED, "%%[sd]", "(.*)")
	local AzeritXP, AzeritTotalLevelXP, AzeritLevel = 0, 0, 0
	local function short(num, tt)
		if short or tt then
			num = tonumber(num)
			if num >= 1e11 then
				return ("%.0f%s"):format(num / 1e9, experience.billion or "b")
			elseif num >= 1e10 then
				return ("%.1f%s"):format(num / 1e9, experience.billion or "b"):gsub("%.?0+([km])$", "%1")
			elseif num >= 1e9 then
				return ("%.2f%s"):format(num / 1e9, experience.billion or "b"):gsub("%.?0+([km])$", "%1")
			elseif num >= 1e8 then
				return ("%.0f%s"):format(num / 1e6, experience.million or "m")
			elseif num >= 1e7 then
				return ("%.1f%s"):format(num / 1e6, experience.million or "m"):gsub("%.?0+([km])$", "%1")
			elseif num >= 1e6 then
				return ("%.2f%s"):format(num / 1e6, experience.million or "m"):gsub("%.?0+([km])$", "%1")
			elseif num >= 1e5 then
				return ("%.0f%s"):format(num / 1e3, experience.thousand or "k")
			elseif num >= 1e3 then
				return ("%.1f%s"):format(num / 1e3, experience.thousand or "k"):gsub("%.?0+([km])$", "%1")
			end
		end
		return floor(tonumber(num))
	end
	local function tags(sub,tt)
		local t = experience
			-- exp tags
		return sub == "level" and UnitLevel(P)
			or sub == "curxp" and short(UnitXP(P),tt)
			or sub == "remainingxp" and short(UnitXPMax(P) - UnitXP(P), tt)
			or sub == "totalxp" and short(UnitXPMax(P), tt)
			or sub == "cur%" and floor(UnitXP(P) / UnitXPMax(P) * 100)
			or sub == "remaining%" and 100 - floor(UnitXP(P) / UnitXPMax(P) * 100)
			or sub == "restxp" and short(GetXPExhaustion() or 0,tt)
			or sub == "rest%" and min(150, floor((GetXPExhaustion() or 0) / UnitXPMax(P) * 100))
			or sub == "sessiongained" and short(gained,tt)
			or sub == "sessionrate" and short(gained / (GetTime() - playedmsg) * 3600, tt)
			or sub == "levelrate" and short(UnitXP(P) / (playedlevel + GetTime() - playedmsg) * 3600, tt)
			or sub == "sessionttl" and (gained ~= 0 and fmttime((UnitXPMax(P) - UnitXP(P)) / (gained / (GetTime() - playedmsg)), t) or L_STATS_INF)
			or sub == "levelttl" and (UnitXP(P) ~= 0 and fmttime((UnitXPMax(P) - UnitXP(P)) / (UnitXP(P) / (playedlevel + GetTime() - playedmsg)), t) or L_STATS_INF)
			or sub == "questsleft" and (lastquest and ceil((UnitXPMax(P) - UnitXP(P)) / tonumber(lastquest)) or "??")
			or sub == "killsleft" and (lastkill and ceil((UnitXPMax(P) - UnitXP(P)) / tonumber(lastkill)) or "??")
			-- time played tags
			or sub == "playedtotal" and fmttime(playedtotal + GetTime() - playedmsg, t)
			or sub == "playedlevel" and fmttime(playedlevel + GetTime() - playedmsg, t)
			or sub == "playedsession" and fmttime(GetTime() - logintime,t)
			-- rep tags
			or sub == "repname" and (t.faction_subs[repname] or repname)
			or sub == "repcolor" and "|cff"..repcolor
			or sub == "standing" and standingname
			or sub == "currep" and (currep ~= maxrep and abs(currep - minrep) or currep > 0 and 1 or 0)
			or sub == "repleft" and abs(maxrep - currep)
			or sub == "maxrep" and (currep ~= maxrep and abs(maxrep - minrep) or maxrep > 0 and 1 or 0)
			or sub == "rep%" and (currep ~= 0 and floor(abs(currep - minrep) / abs(maxrep - minrep) * 100) or 0)
			-- artifact tags
			or sub == "curart" and short(AzeritXP, tt)
			or sub == "curart%" and floor(AzeritXP / AzeritTotalLevelXP * 100)
			or sub == "totalart" and short(AzeritTotalLevelXP, tt)
			or sub == "remainingart" and short(AzeritTotalLevelXP - AzeritXP, tt)
			or sub == "remainingart%" and 100 - floor(AzeritXP / AzeritTotalLevelXP * 100)
			or format("[%s]", sub)
	end
	Inject("Experience", {
		text = {
			string = function(self)
				if conf.ExpMode == "rep" then
					return self:GetText()
				elseif conf.ExpMode == "played" then
					return gsub(experience.played_fmt, "%[([%w%%]-)%]", tags)
				elseif conf.ExpMode == "xp" then
					return gsub(experience[format("xp_%s_fmt", (GetXPExhaustion() or 0) > 0 and "rested" or "normal")], "%[([%w%%]-)%]", tags) or " "
				elseif conf.ExpMode == "art" then
					return self:GetText()
				end
			end
		},
		OnLoad = function(self)
			if not T.classic then
				RegEvents(self, "TIME_PLAYED_MSG PLAYER_LOGOUT PLAYER_LOGIN UPDATE_FACTION CHAT_MSG_COMBAT_XP_GAIN PLAYER_LEVEL_UP AZERITE_ITEM_EXPERIENCE_CHANGED PLAYER_EQUIPMENT_CHANGED")
			else
				RegEvents(self, "TIME_PLAYED_MSG PLAYER_LOGOUT PLAYER_LOGIN UPDATE_FACTION CHAT_MSG_COMBAT_XP_GAIN PLAYER_LEVEL_UP")
			end
			-- Filter first time played message
			local ofunc = ChatFrame_DisplayTimePlayed
			function ChatFrame_DisplayTimePlayed() ChatFrame_DisplayTimePlayed = ofunc end
			RequestTimePlayed()
			if not conf.ExpMode or conf.ExpMode == "xp" then
				conf.ExpMode = UnitLevel(P) ~= MAX_PLAYER_LEVEL and "xp" or "played"
			end
		end,
		OnEvent = function(self, event, ...)
			if event == "CHAT_MSG_COMBAT_XP_GAIN" then
				local msg = ...
				if msg:find(mobxp) then
					_, lastkill = strmatch(msg, mobxp)
					lastkill = strmatch(lastkill, "%d+")
					gained = gained + lastkill
				elseif msg:find(questxp) then
					lastquest = strmatch(msg, questxp)
					lastquest = strmatch(lastquest, "%d+")
					gained = gained + lastquest
				end
			elseif event == "PLAYER_LEVEL_UP" then
				playedlevel, playedmsg = 0, GetTime()
			elseif event == "TIME_PLAYED_MSG" then
				playedtotal, playedlevel = ...
				playedmsg = GetTime()
			elseif (event == "UPDATE_FACTION" or event == "PLAYER_LOGIN") and conf.ExpMode == "rep" then
				local standing, factionID
				repname, standing, minrep, maxrep, currep, factionID = GetWatchedFactionInfo()
				if not T.classic then
					local friendID, _, _, _, _, _, standingText, _, nextThreshold = GetFriendshipReputation(factionID)
					if friendID then
						if not nextThreshold then
							minrep, maxrep, currep = 0, 1, 1
						end
						standing = 5
					else
						local value, nextThreshold = C_Reputation.GetFactionParagonInfo(factionID)
						if value then
							currep = value % nextThreshold
							minrep = 0
							maxrep = nextThreshold
							standing = 8
						end
					end
				end
				if not repname then repname = NONE end
				local color = {}
				if standing == 0 then
					color.r, color.g, color.b = GetItemQualityColor(0)
				elseif standing == 7 then
					color.r, color.g, color.b = GetItemQualityColor(3)
				elseif standing == 8 then
					color.r, color.g, color.b = GetItemQualityColor(4)
				else
					color = FACTION_BAR_COLORS[standing]
				end
				standingname = standingText or _G[format("FACTION_STANDING_LABEL%s%s", standing, UnitSex(P) == 3 and "_FEMALE" or "")]
				if not standingname then standingname = UNKNOWN end
				repcolor = format("%02x%02x%02x", min(color.r * 255 + 40, 255), min(color.g * 255 + 40, 255), min(color.b * 255 + 40, 255))
				self.text:SetText(gsub(experience.faction_fmt, "%[([%w%%]-)%]", tags))
			end
			if event == "PLAYER_LOGOUT" or event == "TIME_PLAYED_MSG" then
				conf.Played = floor(playedtotal + GetTime() - playedmsg)
			end
			if (event == "AZERITE_ITEM_EXPERIENCE_CHANGED" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_LOGIN") and conf.ExpMode == "art" then
				if event == "PLAYER_EQUIPMENT_CHANGED" then
					local slot = ...
					if slot ~= INVSLOT_MAINHAND then
						return
					end
				end
				local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
				if azeriteItemLocation then
					AzeritXP, AzeritTotalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
					AzeritLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
					self.text:SetText(gsub(experience.artifact_fmt, "%[([%w%%]-)%]", tags))
				else
					if event == "PLAYER_EQUIPMENT_CHANGED" then
						conf.ExpMode = "played"
					end
				end
			end
		end,
		OnEnter = function(self)
			self.hovered = true
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint(modules.Experience.tip_anchor, modules.Experience.tip_frame, modules.Experience.tip_x, modules.Experience.tip_y)
			GameTooltip:ClearLines()
			if conf.ExpMode == "played" then
				GameTooltip:AddLine(TIME_PLAYED_MSG, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_SESSION, tags("playedsession", 1), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_LEVEL, tags("playedlevel", 1), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L_STATS_ACC_PLAYED, ttsubh.r, ttsubh.g, ttsubh.b)
				local total = 0
				for realm, t in pairs(SavedStats) do
					for name, conf in pairs(t) do
						if conf.Played then
							local r, g, b, player = 1, 1, 1
							if name == UnitName(P) and realm == GetRealmName() then
								conf.Played, player, r, g, b = floor(playedtotal + GetTime() - playedmsg), true, 0.5, 1, 0.5
							end
							if conf.Played > 3600 or player then -- 1hr threshold displayed
								GameTooltip:AddDoubleLine(format("%s-%s", name, realm), fmttime(conf.Played), r, g, b, 1, 1, 1)
							end
							total = total + conf.Played
						end
					end
				end
				GameTooltip:AddDoubleLine(" ", "------------------", 1, 1, 1, 0.5, 0.5, 0.5)
				GameTooltip:AddDoubleLine(TOTAL, fmttime(total), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			elseif conf.ExpMode == "xp" then
				GameTooltip:AddDoubleLine(COMBAT_XP_GAIN, format(LEVEL_GAINED, UnitLevel(P)), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_CURRENT_XP, format("%s/%s (%s%%)", tags"curxp", tags"totalxp", tags"cur%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_REMAINING_XP, format("%s (%s%%)", tags"remainingxp", tags"remaining%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				if GetXPExhaustion() and GetXPExhaustion() ~= 0 then
					GameTooltip:AddDoubleLine(L_STATS_RESTED_XP, format("%s (%s%%)", tags"restxp", tags"rest%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				end
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_SESSION_XP, format("%s/%s (%s)", tags"sessionrate", L_STATS_HR, tags"sessionttl"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_XP_RATE, format("%s/%s (%s)", tags"levelrate", L_STATS_HR, tags"levelttl"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(format(L_STATS_QUESTS_TO, UnitLevel(P) + 1), format("%s:%s %s:%s", L_STATS_QUEST, tags"questsleft", L_STATS_KILLS, tags"killsleft"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_SESSION, tags"playedsession", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_LEVEL, tags"playedlevel", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				GameTooltip:AddDoubleLine(L_STATS_PLAYED_TOTAL, tags"playedtotal", ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
			elseif conf.ExpMode == "rep" then
				if repname == NONE then GameTooltip:Hide() return end
				local desc, war, watched
				for i = 1, GetNumFactions() do
					_, desc, _, _, _, _, war, _, _, _, _, watched = GetFactionInfo(i)
					if watched then break end
				end
				GameTooltip:AddLine(repname, tthead.r, tthead.g, tthead.b)
				GameTooltip:AddLine(desc, ttsubh.r, ttsubh.g, ttsubh.b, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(format("%s%s", tags"repcolor", tags"standing"), war and format("|cffff5555%s", AT_WAR))
				if currep ~= maxrep then
					GameTooltip:AddDoubleLine(format("%s%% | %s/%s", tags"rep%", tags"currep", tags"maxrep"), -tags"repleft", ttsubh.r, ttsubh.g, ttsubh.b, 1, 0.33, 0.33)
				end
			elseif conf.ExpMode == "art" then
				local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
				if azeriteItemLocation then
					AzeritXP, AzeritTotalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
					AzeritLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
					local azeriteName = Item:CreateFromItemLocation(azeriteItemLocation):GetItemName()
					GameTooltip:AddDoubleLine(azeriteName, format(LEVEL_GAINED, AzeritLevel), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine(L_STATS_CURRENT_XP, format("%s/%s (%s%%)", tags"curart", tags"totalart", tags"curart%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
					GameTooltip:AddDoubleLine(L_STATS_REMAINING_XP, format("%s (%s%%)", tags"remainingart", tags"remainingart%"), ttsubh.r, ttsubh.g, ttsubh.b, 1, 1, 1)
				end
			end
			GameTooltip:Show()
		end,
		OnClick = function(self, button)
			if button == "RightButton" then
				if not T.classic then
					conf.ExpMode = conf.ExpMode == "xp" and "played"
						or (conf.ExpMode == "played" and C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()) and "art"
						or conf.ExpMode == "played" and "rep"
						or conf.ExpMode == "art" and "rep"
						or (conf.ExpMode == "rep" and UnitLevel(P) ~= MAX_PLAYER_LEVEL) and "xp"
						or conf.ExpMode == "rep" and "played"
					if conf.ExpMode == "rep" then
						self:GetScript("OnEvent")(self,"UPDATE_FACTION")
					elseif conf.ExpMode == "art" then
						self:GetScript("OnEvent")(self,"AZERITE_ITEM_EXPERIENCE_CHANGED")
					else
						self:GetScript("OnUpdate")(self, 5)
					end
				else
					conf.ExpMode = conf.ExpMode == "xp" and "played"
						or conf.ExpMode == "played" and "rep"
						or (conf.ExpMode == "rep" and UnitLevel(P) ~= MAX_PLAYER_LEVEL) and "xp"
						or conf.ExpMode == "rep" and "played"
					if conf.ExpMode == "rep" then
						self:GetScript("OnEvent")(self,"UPDATE_FACTION")
					else
						self:GetScript("OnUpdate")(self, 5)
					end
				end
				self:GetScript("OnEnter")(self)
			elseif button == "LeftButton" and conf.ExpMode == "rep" then
				ToggleCharacter("ReputationFrame")
			end
		end
	})
end

----------------------------------------------------------------------------------------
--	Loot
----------------------------------------------------------------------------------------
if loot.enabled then
	Inject("Loot", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if GetCVarBool("AutoLootDefault") then
				self.text:SetText(format(loot.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(loot.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if GetCVarBool("AutoLootDefault") then
					SetCVar("AutoLootDefault", 0)
					self.text:SetText(format(loot.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					SetCVar("AutoLootDefault", 1)
					self.text:SetText(format(loot.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(AUTO_LOOT_DEFAULT_TEXT, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_AUTO_LOOT_DEFAULT, 1, 1, 1, 1)
			GameTooltip:Show()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Nameplates
----------------------------------------------------------------------------------------
if nameplates.enabled then
	Inject("Nameplates", {
		OnLoad = function(self) RegEvents(self, "PLAYER_LOGIN CVAR_UPDATE") end,
		OnEvent = function(self)
			if GetCVar("nameplateMotion") == "0" then
				self.text:SetText(format(nameplates.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
			else
				self.text:SetText(format(nameplates.fmt, "|cffff5555"..strupper(OFF).."|r"))
			end
		end,
		OnClick = function(self, button)
			if button == "RightButton" or button == "LeftButton" then
				if GetCVar("nameplateMotion") == "0" then
					SetCVar("nameplateMotion", "1")
					self.text:SetText(format(nameplates.fmt, "|cffff5555"..strupper(OFF).."|r"))
				else
					SetCVar("nameplateMotion", "0")
					self.text:SetText(format(nameplates.fmt, "|cff55ff55"..L_STATS_ON.."|r"))
				end
			end
		end,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -3, 26)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(UNIT_NAMEPLATES_ALLOW_OVERLAP, tthead.r, tthead.g, tthead.b)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(OPTION_TOOLTIP_UNIT_NAMEPLATES_ALLOW_OVERLAP, 1, 1, 1, 1)
			GameTooltip:Show()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(1)
			end
		end,
		OnLeave = function()
			if C.toppanel.enable == true and C.toppanel.mouseover == true then
				TopPanel:SetAlpha(0)
			end
		end,
	})
end

----------------------------------------------------------------------------------------
--	Applying modules
----------------------------------------------------------------------------------------
lpanels:CreateLayout("LiteStats", layout)
lpanels:ApplyLayout(nil, "LiteStats")

Inject = nil
