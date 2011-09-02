local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin same ShestakUI frames if loaded Aurora
----------------------------------------------------------------------------------------
local AuroraSkin = CreateFrame("Frame")
AuroraSkin:RegisterEvent("PLAYER_LOGIN")
AuroraSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("Aurora") then return end
	local F = unpack(Aurora)

	local buttons = {
		"AddonSet1",
		"AddonSet2",
		"AddonSet3",
		"AddonSet4",
		"AddonSet5",
		"AddonSet6",
		"aLoadReload",
		"GameMenuButtonAddonManager",
		"GameMenuButtonSettingsGUI",
		"BaudErrorFrameClearButton",
		"BaudErrorFrameCloseButton",
	}

	for i = 1, getn(buttons) do
		local button = _G[buttons[i]]
		if button then
			F.Reskin(button)
		end
	end

	local frames = {
		"aLoadFrame",
		"AddonSets",
		"BaudErrorFrame",
		"aLoadScroll",
		"BaudErrorFrameListScrollBox",
		"BaudErrorFrameDetailScrollBox",
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			F.CreateBD(frame)
			F.CreateSD(frame)
		end
	end

	F.ReskinClose(_G["aLoadCloseButton"])
	F.ReskinScroll(_G["aLoadScrollScrollBar"])
	F.CreateTab(_G["FriendsFrameTab5"])
end)