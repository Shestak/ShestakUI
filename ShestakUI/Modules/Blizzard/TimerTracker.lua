local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

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

	bar:CreateBackdrop("Default")
	bar:SetStatusBarTexture(C.media.texture)
	bar:SetStatusBarColor(0.7, 0, 0)

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(C.media.texture)
	bar.bg:SetVertexColor(0.7, 0, 0, 0.3)
end

local function SkinBlizzTimer()
	for _, b in pairs(TimerTracker.timerList) do
		if b["bar"] and not b["bar"].skinned then
			SkinIt(b["bar"])
			b["bar"].skinned = true
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("START_TIMER")
frame:SetScript("OnEvent", SkinBlizzTimer)