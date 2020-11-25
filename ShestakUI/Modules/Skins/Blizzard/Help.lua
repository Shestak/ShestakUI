local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Help skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.HelpFrame
	frame:StripTextures()
	frame:CreateBackdrop('Transparent')
	T.SkinCloseButton(_G.HelpFrameCloseButton, frame.backdrop)

	local browser = _G.HelpBrowser
	browser.BrowserInset:StripTextures()
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)