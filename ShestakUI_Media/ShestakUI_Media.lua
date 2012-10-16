local LSM = LibStub("LibSharedMedia-3.0")

if LSM == nil then return end

local LOCALE_MASK = 0
if GetLocale() == "koKR" then
	LOCALE_MASK = 1
elseif GetLocale() == "ruRU" then
	LOCALE_MASK = 2
elseif GetLocale() == "zhCN" then
	LOCALE_MASK = 4
elseif GetLocale() == "zhTW" then
	LOCALE_MASK = 8
else
	LOCALE_MASK = 128
end

-- Borders
LSM:Register("border", "Normal", "Interface\\AddOns\\ShestakUI_Media\\Media\\Borders\\Normal.tga")
LSM:Register("border", "Shadow", "Interface\\AddOns\\ShestakUI_Media\\Media\\Borders\\Shadow.tga")
LSM:Register("border", "Slim", "Interface\\AddOns\\ShestakUI_Media\\Media\\Borders\\Slim.tga")
LSM:Register("border", "Thin", "Interface\\AddOns\\ShestakUI_Media\\Media\\Borders\\Thin.tga")

-- Fonts
LSM:Register("font", "Calibri", "Interface\\AddOns\\ShestakUI_Media\\Media\\Fonts\\Calibri.ttf", LOCALE_MASK)
LSM:Register("font", "Empty", "Interface\\AddOns\\ShestakUI_Media\\Media\\Fonts\\Empty.ttf", LOCALE_MASK)
LSM:Register("font", "Expressway", "Interface\\AddOns\\ShestakUI_Media\\Media\\Fonts\\Expressway.ttf", LOCALE_MASK)
LSM:Register("font", "Hooge", "Interface\\AddOns\\ShestakUI_Media\\Media\\Fonts\\Hooge.ttf", LOCALE_MASK)
LSM:Register("font", "Visitor", "Interface\\AddOns\\ShestakUI_Media\\Media\\Fonts\\Visitor.ttf", LOCALE_MASK)

-- Sounds
LSM:Register("sound", "Proc", "Interface\\AddOns\\ShestakUI_Media\\Media\\Sounds\\Proc.mp3")
LSM:Register("sound", "Warning", "Interface\\AddOns\\ShestakUI_Media\\Media\\Sounds\\Warning.mp3")
LSM:Register("sound", "Whisper", "Interface\\AddOns\\ShestakUI_Media\\Media\\Sounds\\Whisper.mp3")

-- Statusbars
LSM:Register("statusbar", "BantoBar", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\BantoBar.tga")
LSM:Register("statusbar", "Bars", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Bars.tga")
LSM:Register("statusbar", "Bright", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Bright.tga")
LSM:Register("statusbar", "DarkBottom", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\DarkBottom.tga")
LSM:Register("statusbar", "Empty", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Empty.tga")
LSM:Register("statusbar", "Flat", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Flat.tga")
LSM:Register("statusbar", "Frost", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Frost.tga")
LSM:Register("statusbar", "HalU", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\HalU.tga")
LSM:Register("statusbar", "Hatched", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Hatched.tga")
LSM:Register("statusbar", "Minimalist", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Minimalist.tga")
LSM:Register("statusbar", "Rain", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Rain.tga")
LSM:Register("statusbar", "Ruben", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Ruben.tga")
LSM:Register("statusbar", "Smooth", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Smooth.tga")
LSM:Register("statusbar", "Striped", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Striped.tga")
LSM:Register("statusbar", "Tukz", "Interface\\AddOns\\ShestakUI_Media\\Media\\Statusbars\\Tukz.tga")