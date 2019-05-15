local T, C, L, _ = unpack(select(2, ...))
if T.classic or IsAddOnLoaded("DBM-Core") or IsAddOnLoaded("BigWigs") then return end

----------------------------------------------------------------------------------------
--	Queue timer on LFGDungeonReadyDialog
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", nil, LFGDungeonReadyDialog)
if C.skins.blizzard_frames == true then
	frame:SetPoint("BOTTOM", LFGDungeonReadyDialog, "BOTTOM", 0, 8)
	frame:CreateBackdrop("Overlay")
	frame:SetSize(240, 10)
else
	frame:SetPoint("TOP", LFGDungeonReadyDialog, "BOTTOM", 0, -10)
	frame:SetSize(280, 10)
	frame.t = frame:CreateTexture(nil, "OVERLAY")
	frame.t:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border")
	frame.t:SetSize(375, 64)
	frame.t:SetPoint("TOP", 0, 28)
end

frame.bar = CreateFrame("StatusBar", nil, frame)
frame.bar:SetStatusBarTexture(C.media.texture)
frame.bar:SetAllPoints()
frame.bar:SetFrameLevel(LFGDungeonReadyDialog:GetFrameLevel() + 1)
frame.bar:SetStatusBarColor(1, 0.7, 0)

LFGDungeonReadyDialog.nextUpdate = 0

local function UpdateBar()
	local obj = LFGDungeonReadyDialog
	local oldTime = GetTime()
	local flag = 0
	local duration = 40
	local interval = 0.1
	obj:SetScript("OnUpdate", function(self, elapsed)
		obj.nextUpdate = obj.nextUpdate + elapsed
		if obj.nextUpdate > interval then
			local newTime = GetTime()
			if (newTime - oldTime) < duration then
				local width = frame:GetWidth() * (newTime - oldTime) / duration
				frame.bar:SetPoint("BOTTOMRIGHT", frame, 0 - width, 0)
				flag = flag + 1
				if flag >= 10 then
					flag = 0
				end
			else
				obj:SetScript("OnUpdate", nil)
			end
			obj.nextUpdate = 0
		end
	end)
end

frame:RegisterEvent("LFG_PROPOSAL_SHOW")
frame:SetScript("OnEvent", function(self)
	if LFGDungeonReadyDialog:IsShown() then
		UpdateBar()
	end
end)