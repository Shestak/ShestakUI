local T, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("MoveAnything") then return end

----------------------------------------------------------------------------------------
--	AlertFrameMove(by Gethe)
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:SetWidth(230)
AchievementAnchor:SetHeight(50)
AchievementAnchor:SetPoint(unpack(C.position.achievement))

local alertBlacklist = {
	GroupLootContainer = C.loot.rolllootframe,
	TalkingHeadFrame = true
}

local POSITION, ANCHOR_POINT, YOFFSET = "BOTTOM", "TOP", -9

local function CheckGrow()
	local point = AchievementAnchor:GetPoint()

	if string.find(point, "TOP") or point == "CENTER" or point == "LEFT" or point == "RIGHT" then
		POSITION = "TOP"
		ANCHOR_POINT = "BOTTOM"
		YOFFSET = 9
		FIRST_YOFFSET = YOFFSET - 2
	else
		POSITION = "BOTTOM"
		ANCHOR_POINT = "TOP"
		YOFFSET = -9
		FIRST_YOFFSET = YOFFSET + 2
	end
end

local ReplaceAnchors do
	local function QueueAdjustAnchors(self, relativeAlert)
		CheckGrow()

		for alertFrame in self.alertFramePool:EnumerateActive() do
			alertFrame:ClearAllPoints()
			alertFrame:SetPoint(POSITION, relativeAlert, ANCHOR_POINT, 0, YOFFSET)
			relativeAlert = alertFrame
		end

		-- if C.loot.rolllootframe then
			-- GroupLootContainer:ClearAllPoints()
			-- GroupLootContainer:SetPoint(POSITION, relativeAlert, ANCHOR_POINT, 0, YOFFSET)
		-- else
			-- GroupLootContainer:ClearAllPoints()
			-- GroupLootContainer:SetPoint(POSITION, AchievementAnchor, POSITION, 2, FIRST_YOFFSET)
		-- end

		return relativeAlert
	end

	local function SimpleAdjustAnchors(self, relativeAlert)
		CheckGrow()

		if self.alertFrame:IsShown() then
			self.alertFrame:ClearAllPoints()
			self.alertFrame:SetPoint(POSITION, relativeAlert, ANCHOR_POINT, 0, YOFFSET)
			return self.alertFrame
		end
		return relativeAlert
	end

	local function AnchorAdjustAnchors(self, relativeAlert)
		if self.anchorFrame:IsShown() then
			return self.anchorFrame
		end
		return relativeAlert
	end

	function ReplaceAnchors(alertFrameSubSystem)
		if alertFrameSubSystem.alertFramePool then
			if alertBlacklist[alertFrameSubSystem.alertFramePool.frameTemplate] then
				return alertFrameSubSystem.alertFramePool.frameTemplate, true
			else
				alertFrameSubSystem.AdjustAnchors = QueueAdjustAnchors
			end
		elseif alertFrameSubSystem.alertFrame then
			local frame = alertFrameSubSystem.alertFrame
			if alertBlacklist[frame:GetName()] then
				return frame:GetName(), true
			else
				alertFrameSubSystem.AdjustAnchors = SimpleAdjustAnchors
			end
		elseif alertFrameSubSystem.anchorFrame then
			local frame = alertFrameSubSystem.anchorFrame
			if alertBlacklist[frame:GetName()] then
				return frame:GetName(), true
			else
				alertFrameSubSystem.AdjustAnchors = AnchorAdjustAnchors
			end
		end
	end
end

local function SetUpAlert()
	hooksecurefunc(AlertFrame, "UpdateAnchors", function(self)
		CheckGrow()
		self:ClearAllPoints()
		self:SetPoint(POSITION, AchievementAnchor, POSITION, 2, FIRST_YOFFSET)
	end)

	hooksecurefunc(AlertFrame, "AddAlertFrameSubSystem", function(self, alertFrameSubSystem)
		local _, isBlacklisted = ReplaceAnchors(alertFrameSubSystem)
		if isBlacklisted then
			for i, alertSubSystem in ipairs(AlertFrame.alertFrameSubSystems) do
				if alertFrameSubSystem == alertSubSystem then
					return table.remove(AlertFrame.alertFrameSubSystems, i)
				end
			end
		end
	end)

	local remove = {}
	for i, alertFrameSubSystem in ipairs(AlertFrame.alertFrameSubSystems) do
		local name, isBlacklisted = ReplaceAnchors(alertFrameSubSystem)
		if isBlacklisted then
			remove[i] = name
		end
	end

	for i in next, remove do
		table.remove(AlertFrame.alertFrameSubSystems, i)
	end
end

SetUpAlert()