local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin TimerTracker(by Tukz)
----------------------------------------------------------------------------------------
local function SkinIt(bar)
	for i = 1, bar:GetNumRegions() do
		local region = select(i, bar:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		elseif region:GetObjectType() == "FontString" then
			region:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
			region:SetShadowOffset(0, 0)
		end
	end

	bar:SetStatusBarTexture(C.media.texture)
	bar:SetStatusBarColor(0.7, 0, 0)

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(C.media.texture)
	bar.bg:SetVertexColor(0.7, 0, 0, 0.3)

	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:SetFrameLevel(0)
	bar.backdrop:SetTemplate("Default")
	bar.backdrop:Point("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bar.backdrop:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
end

local function SkinBlizzTimer(self, event, timerType, timeSeconds, totalTime)
	for _, b in pairs(TimerTracker.timerList) do
		if b["bar"] and not b["bar"].skinned then
			SkinIt(b["bar"])
			b["bar"].skinned = true
		end
	end
end

local load = CreateFrame("Frame")
load:RegisterEvent("START_TIMER")
load:SetScript("OnEvent", SkinBlizzTimer)