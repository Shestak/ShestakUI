local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Fix blank tooltip
----------------------------------------------------------------------------------------
local bug = nil
local FixTooltip = CreateFrame("Frame")
FixTooltip:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
FixTooltip:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
FixTooltip:SetScript("OnEvent", function()
	if GameTooltip:IsShown() then
		bug = true
	end
end)

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		if GameTooltip:IsShown() then
			bug = true
		end
	end
end)

GameTooltip:HookScript("OnTooltipCleared", function(self)
	if self:IsForbidden() then return end
	if bug and self:NumLines() == 0 then
		self:Hide()
		bug = false
	end
end)

----------------------------------------------------------------------------------------
--	Fix RemoveTalent() taint
----------------------------------------------------------------------------------------
FCF_StartAlertFlash = T.dummy

----------------------------------------------------------------------------------------
--	Fix DeclensionFrame strata
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

----------------------------------------------------------------------------------------
--	Fix SearchLFGLeave() taint
----------------------------------------------------------------------------------------
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function()
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)


----------------------------------------------------------------------------------------
--	FrameStackGlobalizer
----------------------------------------------------------------------------------------
local FrameStackFix = CreateFrame("Frame")
FrameStackFix:RegisterEvent("ADDON_LOADED")
FrameStackFix:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_DebugTools" then
		local frames = {}
		local EnumerateFrames = _G.EnumerateFrames
		local tostring = _G.tostring
		local function FindFrame(hash)
			if frames[hash] then
				return frames[hash]
			else
				local frame = EnumerateFrames()
				while frame do
					if frame:IsVisible() and frame:IsMouseOver() then
						if tostring(frame):find(hash) then
							frames[hash] = frame
							return frame
						end
					end
					frame = EnumerateFrames(frame)
				end
			end
		end

		local next = _G.next
		_G.hooksecurefunc(_G.FrameStackTooltip, "SetFrameStack", function(self, showHidden, showRegions, highlightIndexChanged)
			local regions = {self:GetRegions()}
			for _, region in next, regions do
				if region:GetObjectType() == "FontString" then
					local text = region:GetText()
					if text and text:find("<%d+>") then
						local hash = text:match("UIParent%.(%x*)%.?")
						if hash then
							local frame = FindFrame(hash:upper())
							if frame then
								local name = frame:GetName() or frame:GetDebugName()
								region:SetText(text:gsub("(UIParent%.%x*)", name))
							end
						end
					end
				end
			end
		end)
	end
end)

----------------------------------------------------------------------------------------
--	Collect garbage
----------------------------------------------------------------------------------------
local eventcount = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1

	if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)