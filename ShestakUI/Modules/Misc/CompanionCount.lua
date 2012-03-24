local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Display number of companions on pet/mount tab(CompanionCount by chrippa)
----------------------------------------------------------------------------------------
local MAX_COMPANIONS = {
	CRITTER = 207,
	MOUNT = 227
}

local progress = CreateFrame("StatusBar", "CompanionCountProgress", SpellBookCompanionsFrame, "ProfessionStatusBarTemplate")
progress:SetPoint("CENTER", 0, -220)
if C.skins.blizzard_frames == true then
	progress:StripTextures()
	progress:SetStatusBarTexture(C.media.texture)
	progress:SetStatusBarColor(0, 0.8, 0)
	progress:CreateBackdrop("Overlay")
end

hooksecurefunc("SpellBookFrame_UpdatePages", function()
	local mode = SpellBookCompanionsFrame.mode

	if mode then
		local cur, max = GetNumCompanions(mode), MAX_COMPANIONS[mode]
		progress:SetMinMaxValues(1, max)
		progress:SetValue(cur)
		progress.rankText:SetFormattedText("%d/%d", cur, max)
	end
end)