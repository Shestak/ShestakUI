local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Reposition Capture Bar
----------------------------------------------------------------------------------------
local function CaptureUpdate()
	if not NUM_EXTENDED_UI_FRAMES then return end
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local barname = "WorldStateCaptureBar"..i
		local bar = _G[barname]

		if bar and bar:IsVisible() then
			bar:ClearAllPoints()
			if i == 1 then
				bar:SetPoint(unpack(C.position.capture_bar))
			else
				bar:SetPoint("TOPLEFT", _G["WorldStateCaptureBar"..i-1], "BOTTOMLEFT", 0, -7)
			end
			if not bar.skinned then
				local left = bar.LeftBar
				local right = bar.RightBar
				local middle = bar.MiddleBar
				select(4, bar:GetRegions()):Hide()
				bar.LeftLine:SetAlpha(0)
				bar.RightLine:SetAlpha(0)
				bar.LeftIconHighlight:SetAlpha(0)
				bar.RightIconHighlight:SetAlpha(0)

				left:SetTexture(C.media.texture)
				right:SetTexture(C.media.texture)
				middle:SetTexture(C.media.texture)

				left:SetVertexColor(0.2, 0.6, 1)
				right:SetVertexColor(0.9, 0.2, 0.2)
				middle:SetVertexColor(0.8, 0.8, 0.8)

				bar:CreateBackdrop("Default")
				bar.backdrop:SetPoint("TOPLEFT", left, -2, 2)
				bar.backdrop:SetPoint("BOTTOMRIGHT", right, 2, -2)

				bar.skinned = true
			end
		end
	end
end
hooksecurefunc("UIParent_ManageFramePositions", CaptureUpdate)

----------------------------------------------------------------------------------------
--	Battlefield score frame
----------------------------------------------------------------------------------------
do
	local f = _G["UIWidgetTopCenterContainerFrame"]
	f:ClearAllPoints()
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(unpack(C.position.attempt))
end