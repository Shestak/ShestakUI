--	任务追踪列表职业染色

local T, C, L, _ = unpack(select(2, ...))
if C.zzz.ObjectiveTracker ~= true then return end

local move = false
local LeftItems = false
local fade = false

local vmwidth = 250
local vm = ObjectiveTrackerFrame

--移动框体--------------------------------------------------------------
if move then
	vm:SetClampedToScreen(true)
	vm.ClearAllPoints = function() end
	vm:SetPoint("TOPRIGHT", MultiBarLeftButton1, "TOPLEFT", -16, 0) 
	vm.SetPoint = function() end
	vm:SetMovable(true)
	vm:SetUserPlaced(true)
	vm:SetWidth(vmwidth)
	if fade then
		vm:SetScript('OnEnter', function(self) UIFrameFadeOut(ObjectiveTrackerFrame, 0.3, ObjectiveTrackerFrame:GetAlpha(), 1)   end) 
		vm:SetScript('OnLeave', function(self) UIFrameFadeOut(ObjectiveTrackerFrame, 3.0, ObjectiveTrackerFrame:GetAlpha(), 0.3)   end) 
	end
	
	local vmmove = CreateFrame("FRAME", nil, vm)  
	vmmove:SetHeight(16)
	vmmove:SetPoint("TOPLEFT", vm, 0, 0)
	vmmove:SetPoint("TOPRIGHT", vm)
	vmmove:EnableMouse(true)
	vmmove:RegisterForDrag("LeftButton")
	vmmove:SetHitRectInsets(-5, -5, -5, -5)
	vmmove:SetScript("OnDragStart", function(self, button)
		if  button=="LeftButton" then
			local f = self:GetParent()
			f:StartMoving()
		end
	end)

	vmmove:SetScript("OnDragStop", function(self, button)
		local f = self:GetParent()
		f:StopMovingOrSizing()
	end)
end

--任务物品放左面 ----------------------------------------------------------
if LeftItems then
	local function moveQuestObjectiveItems(self)
		local a = {self:GetPoint()}
			
		self:ClearAllPoints()
		self:SetPoint("TOPRIGHT", a[2], "TOPLEFT", -30, 0)
		self:SetFrameLevel(0)
	end

	local qitime = 0
	local qiinterval = 1

	hooksecurefunc("QuestObjectiveItem_OnUpdate", function(self, elapsed)
		qitime = qitime + elapsed
		
		if qitime > qiinterval then
			moveQuestObjectiveItems(self)
			qitime = 0
		end
	end)
end

-- 标题样式&职业染色 -------------------------------------------------------
local r, g, b = 103/255, 103/255, 103/255
local class = select(2, UnitClass("player"))
local colour = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]	

if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
	hooksecurefunc("ObjectiveTracker_Update", function(reason, id)
		if vm.MODULES and #vm.MODULES > 0 then
			for i = 1, #vm.MODULES do
				local module = vm.MODULES[i]
					module.Header.Background:SetAtlas(nil)
					module.Header.Text:SetFont(STANDARD_TEXT_FONT, 16,"OUTLINE")				
					module.Header.Text:ClearAllPoints()
					module.Header.Text:SetPoint("Left", module.Header, 5, 0)
					module.Header.Text:SetJustifyH("Left")	
				for _, block in pairs(module.usedBlocks) do
					if block.HeaderText then
						block.HeaderText:SetFont(DAMAGE_TEXT_FONT, 13,"OUTLINE")
						block.HeaderText:SetShadowOffset(-0.1, -0.1)
						block.HeaderText:SetShadowColor(0, 0, 0, 1)
						block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
						block.HeaderText:SetJustifyH("LEFT")
						block.HeaderText:SetWidth(vmwidth)
						block.HeaderText:SetWordWrap(true)
						
						-- fix overlap from double-lined headers
						local heightcheck = block.HeaderText:GetNumLines()
						local height = block:GetHeight()
						if heightcheck == 2 then
							block:SetHeight(height + 16)
						else
							block:SetHeight(height)	--(height + 5)
						end
					end
					for _, line in pairs(block.lines) do
						line.Text:SetFont(DAMAGE_TEXT_FONT, 13,"OUTLINE")
						line.Text:SetWidth(vmwidth)
						if line.Dash then
							line.Dash:SetText("▪ ")
							line.Dash:SetTextColor(colour.r, colour.g, colour.b)
						end
					end
				end
			end
		end
	end)
end

--------渐隐效果----------------------------
if fade then
	local f = CreateFrame("Frame") 
	f:RegisterEvent("PLAYER_ENTERING_WORLD") 
	f:RegisterEvent("PLAYER_REGEN_DISABLED") 
	f:RegisterEvent("PLAYER_REGEN_ENABLED") 
	f:SetScript("OnEvent", function(self, event) 
		if event == "PLAYER_ENTERING_WORLD" then 
			UIFrameFadeOut(ObjectiveTrackerFrame, 3.0, ObjectiveTrackerFrame:GetAlpha(), 0.3)  
		end 
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(ObjectiveTrackerFrame, 1.0, ObjectiveTrackerFrame:GetAlpha(), 0) 	
		elseif event == "PLAYER_REGEN_ENABLED" then 
			UIFrameFadeOut(ObjectiveTrackerFrame, 3.0, ObjectiveTrackerFrame:GetAlpha(), 0.3) 
		end 
	end)
end

-- 任务追踪自动开启/关闭 --------------------------------------------
local vmboss = CreateFrame("Frame", nil)
vmboss:RegisterEvent("PLAYER_ENTERING_WORLD")
vmboss:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
vmboss:RegisterEvent("UNIT_TARGETABLE_CHANGED")
vmboss:RegisterEvent("PLAYER_REGEN_ENABLED")
vmboss:RegisterEvent("UPDATE_WORLD_STATES")

local function bossexists()
	for i = 1, MAX_BOSS_FRAMES do
		if UnitExists("boss"..i) then
			return true
		end
	end
end

vmboss:SetScript("OnEvent", function(self, event)
	local _, instanceType = IsInInstance()
	local bar = _G["WorldStateCaptureBar1"]
	local mapcheck = GetMapInfo(mapFileName)
	
	if bossexists() then															-- boss战自动关闭
		if not vm.collapsed then
			ObjectiveTracker_Collapse()
		end
	elseif instanceType=="arena" or instanceType=="pvp" then						-- PVP自动关闭
		if not vm.collapsed then
			ObjectiveTracker_Collapse()
		end
	elseif bar and bar:IsVisible() then												-- 获得追踪栏关闭
		if not vm.collapsed then
			ObjectiveTracker_Collapse()
		end
	elseif vm.collapsed and instanceType=="raid" and not InCombatLockdown() then	-- 团队副本且不在战斗状态打开
		ObjectiveTracker_Expand()
	elseif vm.collapsed and mapcheck=="Ashran" and not InCombatLockdown() then		-- 在阿什兰且不在战斗中打开
		ObjectiveTracker_Expand()
	else 
		ObjectiveTracker_Expand()
	end
end)
    
-- 在追踪栏中显示任务等级-------------------------
local QuestLevelPatch = {}	
function SetBlockHeader_hook()
	for i = 1, GetNumQuestWatches() do
		local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
		if ( not questID ) then
			break
		end
		local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if oldBlock then
			local oldHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, title, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			local newTitle = title.." ["..select(2, GetQuestLogTitle(questLogIndex)).."]"
			local newHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
		end
	end
end
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", SetBlockHeader_hook)

-- 任务详细信息显示任务等级-------------------------
function QuestInfo_hook(template, parentFrame, acceptButton, material, mapView)
	local elementsTable = template.elements
	for i = 1, #elementsTable, 3 do
		if elementsTable[i] == QuestInfo_ShowTitle then
			if QuestInfoFrame.questLog then
				local questLogIndex = GetQuestLogSelection()
				local level = select(2, GetQuestLogTitle(questLogIndex))
				local newTitle = QuestInfoTitleHeader:GetText().." ["..level.."]"
				QuestInfoTitleHeader:SetText(newTitle)
			end
		end
	end
end
hooksecurefunc("QuestInfo_Display", QuestInfo_hook)

local function hoverquest(_, block)
		block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
end
hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", hoverquest)  
hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", hoverquest)
   
local function hoverachieve(_, block)
		block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
	end
hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", hoverachieve)
hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", hoverachieve)
	
-- 最小化按钮美化-------------------------
local button = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
button:SetSize(11, 11)
button:StripTextures()
button:SetTemplate("Overlay")

button.minus = button:CreateTexture(nil, "OVERLAY")
button.minus:SetSize(5, 1)
button.minus:SetPoint("CENTER")
button.minus:SetTexture(C.media.blank)

button.plus = button:CreateTexture(nil, "OVERLAY")
button.plus:SetSize(1, 5)
button.plus:SetPoint("CENTER")
button.plus:SetTexture(C.media.blank)

--button:HookScript("OnEnter")--, T.SetModifiedBackdrop)
--button:HookScript("OnLeave")--, T.SetOriginalBackdrop)

button.plus:Hide()
hooksecurefunc("ObjectiveTracker_Collapse", function()
	button.plus:Show()
end)

hooksecurefunc("ObjectiveTracker_Expand", function()
	button.plus:Hide()
end)