local T, C, L = unpack(select(2, ...))
if C.nameplate.enable ~= true or C.nameplate.quests ~= true then return end

----------------------------------------------------------------------------------------
--	Show quest icon on nameplates (based on code from ElvUI)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "oUF not loaded")

local QuestIcon = {
	indexByID = {}, --[questID] = questIndex
	activeQuests = {} --[questTitle] = questID
}

local ScanTooltip = CreateFrame("GameTooltip", "oUF_QuestIconTooltip", UIParent, "GameTooltipTemplate")
local ThreatTooltip = THREAT_TOOLTIP:gsub("%%d", "%%d-")

local function CheckTextForQuest(text)
	local x, y = strmatch(text, "(%d+)/(%d+)")
	if x and y then
		return floor(y - x)
	elseif not strmatch(text, ThreatTooltip) then
		local progress = tonumber(strmatch(text, "([%d%.]+)%%"))
		if progress and progress <= 100 then
			return ceil(100 - progress), true
		end
	end
end

local function GetQuests(unitID)
	local _, instanceType = IsInInstance()
	if instanceType == "arena" or instanceType == "pvp" or instanceType == "raid" or C_ChallengeMode.IsChallengeModeActive() then return end

	ScanTooltip:SetOwner(_G.UIParent, "ANCHOR_NONE")
	ScanTooltip:SetUnit(unitID)
	ScanTooltip:Show()

	local QuestList, notMyQuest, activeID
	for i = 3, ScanTooltip:NumLines() do
		local str = _G["oUF_QuestIconTooltipTextLeft" .. i]
		local text = str and str:GetText()
		if not text or text == "" then return end

		if UnitIsPlayer(text) then
			notMyQuest = text ~= T.name
		elseif text and not notMyQuest then
			local count, percent = CheckTextForQuest(text)

			-- this line comes from one line up in the tooltip
			local activeQuest = QuestIcon.activeQuests[text]
			if activeQuest then activeID = activeQuest end

			if count then
				local type, index, texture, _
				if activeID then
					index = QuestIcon.indexByID[activeID]
					_, texture = GetQuestLogSpecialItemInfo(index)
					for i = 1, GetNumQuestLeaderBoards(index) or 0 do
						local text, objectiveType, finished = GetQuestObjectiveInfo(activeID, i, false)
						if text and not finished and (objectiveType == "item" or objectiveType == "object") then
							type = "LOOT_ITEM"
						end
					end
				end

				if texture then
					type = "QUEST_ITEM"
				end

				if not QuestList then QuestList = {} end
				QuestList[#QuestList + 1] = {
					isPercent = percent,
					itemTexture = texture,
					objectiveCount = count,
					questType = type or "DEFAULT",
					-- below keys are currently unused
					questLogIndex = index,
					questID = activeID
				}
			end
		end
	end

	ScanTooltip:Hide()
	return QuestList
end

local function hideIcons(element)
	element:Hide()
	element.Item:Hide()
	element.Text:SetText("")
end

local function Update(self, event, arg1)
	local element = self.QuestIcon
	if not element then return end

	local unit = (event == "UNIT_NAME_UPDATE" and arg1) or self.unit
	if unit ~= self.unit then return end

	if element.PreUpdate then
		element:PreUpdate()
	end

	hideIcons(element)

	local QuestList = GetQuests(unit)
	if not QuestList then return end

	for i = 1, #QuestList do
		local quest = QuestList[i]
		local objectiveCount = quest.objectiveCount
		local questType = quest.questType
		local isPercent = quest.isPercent

		if isPercent or objectiveCount > 0 then
			element:Show()
			if element.Text and (isPercent or objectiveCount > 0) then
				element.Text:SetText(objectiveCount)
				if isPercent then
					element.Text:SetTextColor(0.2, 1, 1)
				else
					element.Text:SetTextColor(1, 0.82, 0)
				end
			end

			if questType == "QUEST_ITEM" then
				element.Item:Show()
				element.Item:SetTexture(quest.itemTexture)
			elseif questType == "LOOT_ITEM" then
				element.Item:Show()
				element.Item:SetTexture(133639)
			end
		end
	end

	if element.PostUpdate then
		return element:PostUpdate()
	end
end

local function Path(self, ...)
	return (self.QuestIcon.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
	local element = self.QuestIcon
	if element then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		if element:IsObjectType("Texture") and not element:GetAtlas() then
			-- element:SetAtlas("SmallQuestBang")
			-- element:SetAtlas("adventureguide-microbutton-alert")
			element:SetAtlas("worldquest-tracker-questmarker")
			-- element:SetTexture([[Interface\TargetingFrame\PortraitQuestBadge]])
		end

		self:RegisterEvent("QUEST_LOG_UPDATE", Path, true)
		self:RegisterEvent("UNIT_NAME_UPDATE", Path, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Path, true)

		SetCVar("showQuestTrackingTooltips", 1)

		return true
	end
end

local function Disable(self)
	local element = self.QuestIcon
	if element then
		element:Hide()
		hideIcons(element)

		self:UnregisterEvent("QUEST_LOG_UPDATE", Path)
		self:UnregisterEvent("UNIT_NAME_UPDATE", Path)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Path)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("QUEST_REMOVED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	wipe(QuestIcon.indexByID)
	wipe(QuestIcon.activeQuests)

	for i = 1, C_QuestLog.GetNumQuestLogEntries() do
		local id = C_QuestLog.GetQuestIDForLogIndex(i)
		if id and id > 0 then
			QuestIcon.indexByID[id] = i

			local title = C_QuestLog.GetTitleForLogIndex(i)
			if title then QuestIcon.activeQuests[title] = id end
		end
	end

	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
	end
end)

oUF:AddElement("QuestIcon", Path, Enable, Disable)