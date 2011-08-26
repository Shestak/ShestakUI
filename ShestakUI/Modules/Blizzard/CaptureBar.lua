local T, C, L = unpack(select(2, ...))

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
				bar:Point(unpack(C.position.capture_bar))
			else
				bar:Point("TOPLEFT", _G["WorldStateCaptureBar"..i-1], "BOTTOMLEFT", 0, -7)
			end
			if not bar.skinned then
				local left = _G[barname.."LeftBar"]
				local right = _G[barname.."RightBar"]
				local middle = _G[barname.."MiddleBar"]
				select(4, bar:GetRegions()):Hide()
				_G[barname.."LeftLine"]:SetAlpha(0)
				_G[barname.."RightLine"]:SetAlpha(0)
				_G[barname.."LeftIconHighlight"]:SetAlpha(0)
				_G[barname.."RightIconHighlight"]:SetAlpha(0)

				left:SetTexture(C.media.texture)
				right:SetTexture(C.media.texture)
				middle:SetTexture(C.media.texture)

				left:SetVertexColor(0.2, 0.6, 1)
				right:SetVertexColor(0.9, 0.2, 0.2)
				middle:SetVertexColor(0.8, 0.8, 0.8)

				bar:CreateBackdrop("Default")
				bar.backdrop:Point("TOPLEFT", left, -2, 2)
				bar.backdrop:Point("BOTTOMRIGHT", right, 2, -2)

				bar.skinned = true
			end
		end
	end
end
hooksecurefunc("UIParent_ManageFramePositions", CaptureUpdate)

----------------------------------------------------------------------------------------
--	Battlefield score frame
----------------------------------------------------------------------------------------
local function StateUpdate()
	if not NUM_ALWAYS_UP_UI_FRAMES then return end
	for i = 1, NUM_ALWAYS_UP_UI_FRAMES do
		local f = _G["AlwaysUpFrame"..i]

		if f then
			f:ClearAllPoints()
			f:SetFrameStrata("BACKGROUND")
			if i == 1 then
				f:Point(unpack(C.position.attempt))
			else
				f:Point("TOPLEFT", _G["AlwaysUpFrame"..i-1], "BOTTOMLEFT", 0, 0)
			end
		end
	end
end
hooksecurefunc("WorldStateAlwaysUpFrame_Update", StateUpdate)