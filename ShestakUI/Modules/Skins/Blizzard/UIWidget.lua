local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	UIWidget skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local function SkinUIWidgets()
		for _, widgetFrame in UIWidgetManager:EnumerateWidgetsByWidgetTag("") do
			-- print(widgetFrame.widgetType) -- debug finder
			if widgetFrame.widgetType == 2 then -- StatusBar
				local bar = widgetFrame.Bar
				local atlas = bar:GetStatusBarAtlas()
				if not atlas then
					bar:SetStatusBarTexture(C.media.texture)
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
			elseif widgetFrame.widgetType == 3 then -- DoubleStatusBar
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

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("UPDATE_ALL_UI_WIDGETS")
	frame:SetScript("OnEvent", function()
		SkinUIWidgets()
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)