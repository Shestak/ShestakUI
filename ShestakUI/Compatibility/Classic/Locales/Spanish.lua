local T, C, L, _ = unpack(select(2, ...))
if (T.client ~= "esES" and T.client ~= "esMX") or not T.classic then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client
--	Translation: eXecrate, Seal
----------------------------------------------------------------------------------------
-- Misc
L_MISC_UI_OUTDATED = "Tu versión de ShestakUI no está actualizada. Puedes descargar la última versión de https://github.com/EsreverWoW/ShestakUI_Classic"

-- Welcome message
L_WELCOME_LINE_1 = "Bienvenido a ShestakUI (Classic) "
L_WELCOME_LINE_2_1 = "Escribe /cfg para configurar la interfaz, o visita https://github.com/EsreverWoW/ShestakUI_Classic"
L_WELCOME_LINE_2_2 = "para más información."
