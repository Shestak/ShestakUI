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
--	FrameStackGlobalizer(by Gethe)
----------------------------------------------------------------------------------------
local FrameStackFix = CreateFrame("Frame")
FrameStackFix:RegisterEvent("ADDON_LOADED")
FrameStackFix:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_DebugTools" then
		local EnumerateFrames = _G.EnumerateFrames
		local tostring = _G.tostring

		local ignore = {}
		local frames = {}
		local function FindFrame(hash)
			if ignore[hash] then return end

			if frames[hash] then
				return frames[hash]
			else
				local frame = EnumerateFrames()
				while frame do
					local frameHash = tostring(frame)
					if frameHash:find(hash) then
						frames[hash] = frame
						return frame
					end
					frame = EnumerateFrames(frame)
				end
			end

			ignore[hash] = true
		end

		local matchPattern, subPattern = "%s%%.(%%x*)%%.?", "(%s%%.%%x*)"
		local function TransformText(text)
			local parent = text:match("%s+([%w_]+)%.")
			if parent then
				local hash = text:match(matchPattern:format(parent))
				if hash and #hash > 5 then
					local frame = FindFrame(hash:upper())
					if frame and frame:GetName() then
						text = text:gsub(subPattern:format(parent), frame:GetName())
						return TransformText(text)
					end
				end
			end

			return text
		end

		_G.hooksecurefunc(_G.FrameStackTooltip, "SetFrameStack", function(self)
			for i = 1, self:NumLines() do
				local line = _G["FrameStackTooltipTextLeft"..i]
				local text = line:GetText()
				if text and text:find("<%d+>") then
					line:SetText(TransformText(text))
				end
			end
		end)
	end
end)