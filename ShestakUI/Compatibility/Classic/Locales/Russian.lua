local T, C, L, _ = unpack(select(2, ...))
if T.client ~= "ruRU" or not T.classic then return end

----------------------------------------------------------------------------------------
--	Localization for ruRU client
--	Translation: Shestak, Wetxius
----------------------------------------------------------------------------------------
-- Misc
L_MISC_UI_OUTDATED = "Ваша версия ShestakUI устарела. Вы можете скачать последнюю версию с https://github.com/EsreverWoW/ShestakUI_Classic"

-- Welcome message
L_WELCOME_LINE_1 = "Добро пожаловать в ShestakUI (Classic) "
L_WELCOME_LINE_2_1 = "Введите /cfg для входа в настройки интерфейса, или посетите страницу https://github.com/EsreverWoW/ShestakUI_Classic"
L_WELCOME_LINE_2_2 = "для получения дополнительной информации."