local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Pixel perfect script of custom ui Scale
----------------------------------------------------------------------------------------
T.UIScale = function()
	if T.getscreenwidth <= 1440 then
		T.low_resolution = true
	else
		T.low_resolution = false
	end

	if C.general.auto_scale == true then
		C.general.uiscale = min(2, max(0.64, 768 / string.match(T.resolution, "%d+x(%d+)")))
	end
end
T.UIScale()

local mult = 768 / string.match(T.resolution, "%d+x(%d+)") / C.general.uiscale
local Scale = function(x)
	return mult * math.floor(x / mult + 0.5)
end

T.Scale = function(x) return Scale(x) end
T.mult = mult
T.noscalemult = T.mult * C.general.uiscale

----------------------------------------------------------------------------------------
--	Pixel perfect fonts function
----------------------------------------------------------------------------------------
if T.getscreenheight <= 1200 then return end
C.media.pixel_font_size = C.media.pixel_font_size * mult
C.font.chat_tabs_font_size = C.font.chat_tabs_font_size * mult
C.font.action_bars_font_size = C.font.action_bars_font_size * mult
C.font.threat_meter_font_size = C.font.threat_meter_font_size * mult
C.font.raid_cooldowns_font_size = C.font.raid_cooldowns_font_size * mult
C.font.unit_frames_font_size = C.font.unit_frames_font_size * mult
C.font.auras_font_size = C.font.auras_font_size * mult
C.font.filger_font_size = C.font.filger_font_size * mult
C.font.bags_font_size = C.font.bags_font_size * mult
C.font.loot_font_size = C.font.loot_font_size * mult
C.font.combat_text_font_size = C.font.combat_text_font_size * mult

C.font.stats_font_size = C.font.stats_font_size * mult
C.font.stylization_font_size = C.font.stylization_font_size * mult
C.font.cooldown_timers_font_size = C.font.cooldown_timers_font_size * mult