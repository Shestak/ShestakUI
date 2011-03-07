local T, C, L = unpack(select(2, ...))

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
					captureBar:Point(unpack(C.position.capture_bar))
				else
					captureBar:Point("TOPLEFT", getglobal("WorldStateCaptureBar" .. i - 1 ), "TOPLEFT", 0, -25)
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
	WorldStateAlwaysUpFrame:Point(unpack(C.position.attempt))
	WorldStateAlwaysUpFrame.SetPoint = T.dummy
end