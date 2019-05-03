local T, C, L, _ = unpack(select(2, ...))
if C.skins.blood_shield_tracker ~= true or T.class ~= "DEATHKNIGHT" then return end

----------------------------------------------------------------------------------------
--	BloodShieldTracker skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("BloodShieldTracker") then return end

	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["AMSBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["AMSBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PurgatoryBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PurgatoryBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["BloodChargeBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["BloodChargeBar"] = {} end

	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["AMSBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["AMSBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["AMSBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PurgatoryBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PurgatoryBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PurgatoryBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["scale"] = 1
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["BloodChargeBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["BloodChargeBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["BloodChargeBar"]["scale"] = 1

	local bars = {
		"BloodShieldTracker_AMSBar",
		"BloodShieldTracker_PWSBar",
		"BloodShieldTracker_EstimateBar",
		"BloodShieldTracker_ShieldBar",
		"BloodShieldTracker_TotalAbsorbsBar",
		"BloodShieldTracker_IllumBar",
		"BloodShieldTracker_HealthBar",
		"BloodShieldTracker_PurgatoryBar",
		"BloodShieldTracker_BloodChargeBar"
	}

	for i = 1, getn(bars) do
		local bar = _G[bars[i]]
		if bar then
			bar:CreateBackdrop("Default")

			bar.value:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			bar.value:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

			if bar.stacks then
				bar.stacks:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
				bar.stacks:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			end

			if bar.time then
				bar.time:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
				bar.time:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			end
		end
	end
end)