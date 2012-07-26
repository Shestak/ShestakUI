local T, C, L = unpack(ShestakUI)
if C.extra_skins.blood_shield_tracker ~= true or T.class ~= "DEATHKNIGHT" then return end

----------------------------------------------------------------------------------------
--	BloodShieldTracker skin
----------------------------------------------------------------------------------------
local BSTSkin = CreateFrame("Frame")
BSTSkin:RegisterEvent("PLAYER_LOGIN")
BSTSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("BloodShieldTracker") then return end

	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["PWSBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["ShieldBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["HealthBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["IllumBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["EstimateBar"] = {} end
	if not BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"] then BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"] = {} end

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
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["border"] = false
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["texture"] = "Smooth"
	BloodShieldTrackerDB["profiles"]["Default"]["bars"]["TotalAbsorbsBar"]["scale"] = 1

	local frames = {
		"BloodShieldTracker_PWSBar",
		"BloodShieldTracker_EstimateBar",
		"BloodShieldTracker_ShieldBar",
		"BloodShieldTracker_TotalAbsorbsBar",
		"BloodShieldTracker_IllumBar",
		"BloodShieldTracker_HealthBar"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			frame:CreateBackdrop("Default")
			frame.backdrop:Point("TOPLEFT", -2, 2)
			frame.backdrop:Point("BOTTOMRIGHT", 2, -2)

			frame.value:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			frame.value:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

			if frame.time then
				frame.time:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
				frame.time:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
			end
		end
	end
end)