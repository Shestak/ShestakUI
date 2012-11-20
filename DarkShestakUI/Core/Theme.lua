local T, C, L, _ = unpack(select(2, ...))
if not IsAddOnLoaded("DarkShestakUI_Config") then return end

----------------------------------------------------------------------------------------
--	Dark ShetakUI color theme
----------------------------------------------------------------------------------------
if GUIConfigAll[T.realm][T.name] == true and not GUIConfig then return end
if GUIConfigAll[T.realm][T.name] == false and not GUIConfigSettings then return end


if GUIConfigAll[T.realm][T.name] == true then
	if GUIConfig["skins"] == nil then GUIConfig["skins"] = {} end	
else
	if GUIConfigSettings["skins"] == nil then GUIConfigSettings["skins"] = {} end
end

local function Color(r, g, b)
	if GUIConfigAll[T.realm][T.name] == true then
		GUIConfig["skins"]["color_theme"] = {r, g, b, 0.4}
	else
		GUIConfigSettings["skins"]["color_theme"] = {r, g, b, 0.4}
	end
end

StaticPopupDialogs.SWITCH_THEME = {
	text = L_POPUP_SWITCH_THEME,
	button1 = L_POPUP_SWITCH_THEME_RED,
	button2 = L_POPUP_SWITCH_THEME_BLUE,
	button3 = L_POPUP_SWITCH_THEME_GREEN,
	OnAccept = function() Color(0.9, 0.2, 0.2) ReloadUI() end,
	OnCancel = function() Color(0.1, 0.5, 0.9) ReloadUI() end,
	OnAlt = function() Color(0.3, 0.9, 0.3) ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}

if GUIConfigAll[T.realm][T.name] == true then
	if not GUIConfig["skins"]["color_theme"] then
		StaticPopup_Show("SWITCH_THEME")
	end
else
	if not GUIConfigSettings["skins"]["color_theme"] then
		StaticPopup_Show("SWITCH_THEME")
	end
end
