----------------------------------------------------------------------------------------
--	Reposition Capture Bar
----------------------------------------------------------------------------------------
local function CaptureUpdate()
	if NUM_EXTENDED_UI_FRAMES then
		local captureBar
		for i = 1, NUM_EXTENDED_UI_FRAMES do
			captureBar = getglobal("WorldStateCaptureBar" .. i)

			if captureBar and captureBar:IsVisible() then
				captureBar:ClearAllPoints()
				if i == 1 then
					captureBar:SetPoint(unpack(SettingsCF.position.capture_bar))
				else
					captureBar:SetPoint("TOPLEFT", getglobal("WorldStateCaptureBar" .. i - 1 ), "TOPLEFT", 0, SettingsDB.Scale(-25))
				end
			end	
		end	
	end
end
hooksecurefunc("UIParent_ManageFramePositions", CaptureUpdate)

----------------------------------------------------------------------------------------
--	Battlefield score frame
----------------------------------------------------------------------------------------
if WorldStateAlwaysUpFrame then
	WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
	WorldStateAlwaysUpFrame:SetFrameLevel(0)
	WorldStateAlwaysUpFrame:ClearAllPoints()
	WorldStateAlwaysUpFrame:SetPoint(unpack(SettingsCF["position"].attempt))
	WorldStateAlwaysUpFrame.SetPoint = SettingsDB.dummy
end