local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.talents ~= true then return end

----------------------------------------------------------------------------------------
--	Target Talents(TipTacTalents by Aezay)
----------------------------------------------------------------------------------------
local gtt = GameTooltip
local GetSpecializationInfo = GetSpecializationInfo

-- Constants
local TALENTS_PREFIX = TALENTS..":|cffffffff "
local CACHE_SIZE = 25
local INSPECT_DELAY = 0.2
local INSPECT_FREQ = 2

-- Variables
local ttt = CreateFrame("Frame", "TipTacTalents")
local cache = {}
local current = {}

-- Time of the last inspect reuqest. Init this to zero, just to make sure. This is a global so other addons could use this variable as well
lastInspectRequest = 0

-- Allow these to be accessed through other addons
ttt.cache = cache
ttt.current = current
ttt:Hide()

----------------------------------------------------------------------------------------
--	Gather Talents
----------------------------------------------------------------------------------------
local function GatherTalents(isInspect)
	-- Inspect functions will always use the active spec when not inspecting
	local group = GetActiveSpecGroup(isInspect)
	-- Get points per tree, and set "primaryTree" to the tree with most points
	local primaryTree = 1
	for i = 1, 3 do
		local _, _, _, _, pointsSpent = GetSpecializationInfo(i, isInspect, nil, group)
		current[i] = pointsSpent
		if current[i] > current[primaryTree] then
			primaryTree = i
		end
	end
	local _, tabName = GetSpecializationInfo(primaryTree, isInspect, nil, group)
	current.tree = tabName
	-- Customise output. Use TipTac setting if it exists, otherwise just use formatting style one.
	if current[primaryTree] == 0 then
		current.format = L_TOOLTIP_NO_TALENT
	else
		current.format = current.tree.." ("..current[1].."/"..current[2].."/"..current[3]..")"
	end
	-- Set the tips line output, for inspect, only update if the tip is still showing a unit!
	if not isInspect then
		gtt:AddLine(TALENTS_PREFIX..current.format)
	elseif gtt:GetUnit() then
		for i = 2, gtt:NumLines() do
			if (_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s", TALENTS_PREFIX, current.format)
				if not gtt.fadeOut then
					gtt:Show()
				end
				break
			end
		end
	end
	-- Organise Cache
	local cacheSize = CACHE_SIZE
	for i = #cache, 1, -1 do
		if current.name == cache[i].name then
			tremove(cache, i)
			break;
		end
	end
	if #cache > cacheSize then
		tremove(cache, 1)
	end
	-- Cache the new entry
	if cacheSize > 0 then
		cache[#cache + 1] = CopyTable(current)
	end
end

----------------------------------------------------------------------------------------
--	Event Handling
----------------------------------------------------------------------------------------
-- OnEvent
ttt:SetScript("OnEvent", function(self, event, guid)
	self:UnregisterEvent(event)
	if guid == current.guid then
		GatherTalents(1)
	end
end)

-- OnUpdate
ttt:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate - elapsed)
	if self.nextUpdate <= 0 then
		self:Hide()
		-- Make sure the mouseover unit is still our unit
		if UnitGUID("mouseover") == current.guid then
			lastInspectRequest = GetTime()
			self:RegisterEvent("INSPECT_READY")
			-- Az: Fix the blizzard inspect copypasta code (Blizzard_InspectUI\InspectPaperDollFrame.lua @ line 23)
			if InspectFrame then
				InspectFrame.unit = "player"
			end
			NotifyInspect(current.unit)
		end
	end
end)

-- HOOK: OnTooltipSetUnit
gtt:HookScript("OnTooltipSetUnit", function(self, ...)
	-- Abort any delayed inspect in progress
	ttt:Hide()
	-- Get the unit -- Check the UnitFrame unit if this tip is from a concated unit, such as "targettarget".
	local _, unit = self:GetUnit()
	if not unit then
		local mFocus = GetMouseFocus()
		if mFocus and mFocus.unit then
			unit = mFocus.unit
		end
	end
	-- No Unit or not a Player
	if not unit or not UnitIsPlayer(unit) then
		return
	end
	-- Only bother for players over level 9
	local level = UnitLevel(unit)
	if level > 9 or level == -1 then
		-- Wipe Current Record
		wipe(current)
		current.unit = unit
		current.name = UnitName(unit)
		current.guid = UnitGUID(unit)
		-- No need for inspection on the player
		if UnitIsUnit(unit, "player") then
			GatherTalents()
			return
		end
		-- Show Cached Talents, If Available
		local cacheLoaded = false
		for _, entry in ipairs(cache) do
			if current.name == entry.name then
				self:AddLine(TALENTS_PREFIX..entry.format)
				current.tree = entry.tree
				current.format = entry.format
				current[1], current[2], current[3] = entry[1], entry[2], entry[3]
				cacheLoaded = true
				break
			end
		end
		-- Queue an inspect request
		local isInspectOpen = (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown())
		if CanInspect(unit) and not isInspectOpen then
			local lastInspectTime = GetTime() - lastInspectRequest
			ttt.nextUpdate = (lastInspectTime > INSPECT_FREQ) and INSPECT_DELAY or (INSPECT_FREQ - lastInspectTime + INSPECT_DELAY)
			ttt:Show()
			if not cacheLoaded then
				self:AddLine(TALENTS_PREFIX..L_TOOLTIP_LOADING)
			end
		end
	end
end)