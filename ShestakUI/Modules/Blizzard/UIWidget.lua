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
local atlasColors = {
	["UI-Frame-Bar-Fill-Blue"] = {0.2, 0.6, 1},
	["UI-Frame-Bar-Fill-Red"] = {0.9, 0.2, 0.2},
	["UI-Frame-Bar-Fill-Yellow"] = {1, 0.6, 0},
	["objectivewidget-bar-fill-left"] = {0.2, 0.6, 1},
	["objectivewidget-bar-fill-right"] = {0.9, 0.2, 0.2}
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UPDATE_ALL_UI_WIDGETS")
frame:SetScript("OnEvent", function()
	for _, widgetFrame in pairs(UIWidgetTopCenterContainerFrame.widgetFrames) do
		if widgetFrame.widgetType == _G.Enum.UIWidgetVisualizationType.DoubleStatusBar then
			for _, bar in pairs({widgetFrame.LeftBar, widgetFrame.RightBar}) do
				hooksecurefunc(bar, "SetStatusBarAtlas", function(self, atlas)
					if atlasColors[atlas] then
						bar:SetStatusBarTexture(C.media.texture)
						bar:SetStatusBarColor(unpack(atlasColors[atlas]))
					end
				end)
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
end)

hooksecurefunc(UIWidgetTemplateStatusBarMixin, "Setup", function(widgetInfo)
	local bar = widgetInfo.Bar
	local atlas = bar:GetStatusBarAtlas()
	if atlasColors[atlas] then
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetStatusBarColor(unpack(atlasColors[atlas]))
	end
	if not bar.styled then
		bar.BGLeft:SetAlpha(0)
		bar.BGRight:SetAlpha(0)
		bar.BGCenter:SetAlpha(0)
		bar.BorderLeft:SetAlpha(0)
		bar.BorderRight:SetAlpha(0)
		bar.BorderCenter:SetAlpha(0)
		bar.Spark:SetAlpha(0)
		bar:CreateBackdrop("Overlay")
		bar.styled = true
	end
end)

hooksecurefunc(UIWidgetTemplateCaptureBarMixin, "Setup", function(widgetInfo)
	widgetInfo.LeftLine:SetAlpha(0)
	widgetInfo.RightLine:SetAlpha(0)
	widgetInfo.BarBackground:SetAlpha(0)
	widgetInfo.Glow1:SetAlpha(0)
	widgetInfo.Glow2:SetAlpha(0)
	widgetInfo.Glow3:SetAlpha(0)

	widgetInfo.LeftBar:SetTexture(C.media.texture)
	widgetInfo.NeutralBar:SetTexture(C.media.texture)
	widgetInfo.RightBar:SetTexture(C.media.texture)

	widgetInfo.LeftBar:SetVertexColor(0.2, 0.6, 1)
	widgetInfo.NeutralBar:SetVertexColor(0.8, 0.8, 0.8)
	widgetInfo.RightBar:SetVertexColor(0.9, 0.2, 0.2)

	if not widgetInfo.backdrop then
		widgetInfo:CreateBackdrop("Default")
		widgetInfo.backdrop:SetPoint("TOPLEFT", widgetInfo.LeftBar, -2, 2)
		widgetInfo.backdrop:SetPoint("BOTTOMRIGHT", widgetInfo.RightBar, 2, -2)
	end
end)

hooksecurefunc(UIWidgetTemplateScenarioHeaderCurrenciesAndBackgroundMixin, "Setup", function(widgetInfo)
	widgetInfo.Frame:SetAlpha(0)
end)