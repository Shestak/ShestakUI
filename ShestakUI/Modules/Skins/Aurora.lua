local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Skin some ShestakUI frames if loaded Aurora
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
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			F.CreateBD(frame)
			F.CreateSD(frame)
		end
	end

	local bd = {
		"aLoadScroll",
		"BaudErrorFrameListScrollBox",
		"BaudErrorFrameDetailScrollBox",
	}

	for i = 1, getn(bd) do
		local frame = _G[bd[i]]
		if frame then
			F.CreateBD(frame)
		end
	end

	F.CreateTab(_G["FriendsFrameTab5"])
	F.ReskinClose(_G["aLoadCloseButton"])
	F.ReskinScroll(_G["aLoadScrollScrollBar"])
	if IsAddOnLoaded("!BaudErrorFrame") then
		F.ReskinScroll(_G["BaudErrorFrameListScrollBoxScrollBarScrollBar"])
		F.ReskinScroll(_G["BaudErrorFrameDetailScrollFrameScrollBar"])
	end
end)