local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	UIWidget position
----------------------------------------------------------------------------------------
local top, below = _G["UIWidgetTopCenterContainerFrame"], _G["UIWidgetBelowMinimapContainerFrame"]
local topAnchor = CreateFrame("Frame", "UIWidgetTopAnchor", UIParent)
topAnchor:SetSize(200, 30)
topAnchor:SetPoint(unpack(C.position.uiwidget_top))

_G["UIWidgetTopCenterContainerFrame"]:ClearAllPoints()
_G["UIWidgetTopCenterContainerFrame"]:SetPoint("TOP", topAnchor)

local belowAnchor = CreateFrame("Frame", "UIWidgetBelowAnchor", UIParent)
belowAnchor:SetSize(150, 30)
belowAnchor:SetPoint(unpack(C.position.uiwidget_below))

hooksecurefunc(below, "SetPoint", function(self, _, anchor)
	if anchor and anchor ~= belowAnchor then
		self:ClearAllPoints()
		self:SetPoint("TOP", belowAnchor)
	end
end)

for _, frame in pairs({top, below}) do
	local anchor = frame == top and topAnchor or belowAnchor
	anchor:EnableMouse(true)
	anchor:SetMovable(true)
	anchor:SetUserPlaced(true)
	anchor:SetClampedToScreen(true)
	frame:SetClampedToScreen(true)
	frame:SetScript("OnMouseDown", function(_, button)
		if IsAltKeyDown() or IsShiftKeyDown() then
			anchor:ClearAllPoints()
			anchor:StartMoving()
		elseif IsControlKeyDown() and button == "RightButton" then
			anchor:ClearAllPoints()
			if frame == top then
				anchor:SetPoint(unpack(C.position.uiwidget_top))
			else
				anchor:SetPoint(unpack(C.position.uiwidget_below))
			end
		end
	end)
	frame:SetScript("OnMouseUp", function()
		anchor:StopMovingOrSizing()
	end)
end

----------------------------------------------------------------------------------------
--	UIWidget skin
----------------------------------------------------------------------------------------
do
	local function SkinUIWidgets()
		for _, frame in pairs({UIWidgetTopCenterContainerFrame, UIWidgetBelowMinimapContainerFrame}) do
			for _, widgetFrame in pairs(frame.widgetFrames) do
				if widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.CaptureBar then
					-- TODO: find way to skin capture bar
					-- if not widgetFrame.backdrop then
						-- widgetFrame.LeftLine:SetAlpha(0)
						-- widgetFrame.RightLine:SetAlpha(0)
						-- -- select(4, widgetFrame:GetRegions()):Hide()

						-- widgetFrame.LeftBar:SetTexture(C.media.texture)
						-- widgetFrame.NeutralBar:SetTexture(C.media.texture)
						-- widgetFrame.RightBar:SetTexture(C.media.texture)

						-- widgetFrame.LeftBar:SetVertexColor(0.2, 0.6, 1)
						-- widgetFrame.NeutralBar:SetVertexColor(0.8, 0.8, 0.8)
						-- widgetFrame.RightBar:SetVertexColor(0.9, 0.2, 0.2)

						-- widgetFrame:CreateBackdrop("Default")
						-- widgetFrame.backdrop:SetPoint("TOPLEFT", widgetFrame.LeftBar, -2, 2)
						-- widgetFrame.backdrop:SetPoint("BOTTOMRIGHT", widgetFrame.RightBar, 2, -2)
					-- end
				elseif widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.StatusBar then
					T.SkinStatusBarWidget(widgetFrame)
				elseif widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.DoubleStatusBar then
					for _, bar in pairs({widgetFrame.LeftBar, widgetFrame.RightBar}) do
						local atlas = bar:GetStatusBarAtlas()
						if not atlas then
							bar:SetStatusBarTexture(C.media.texture)
						end
						if not bar.styled then
							bar.BG:SetAlpha(0)
							bar.BorderLeft:SetAlpha(0)
							bar.BorderRight:SetAlpha(0)
							bar.BorderCenter:SetAlpha(0)
							bar.Spark:SetAlpha(0)
							bar.SparkGlow:SetAlpha(0)
							bar:CreateBackdrop("Overlay")
							bar.styled = true
						end
					end
				end
			end
		end
	end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("UPDATE_ALL_UI_WIDGETS")
	frame:SetScript("OnEvent", function()
		SkinUIWidgets()
	end)
end