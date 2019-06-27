local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldStateScore skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Macro to show the PVPMatchScoreboard: /run PVPMatchScoreboard:Show()
	local PVPMatchScoreboard = _G.PVPMatchScoreboard
	PVPMatchScoreboard:StripTextures()
	PVPMatchScoreboard:DisableDrawLayer("BORDER")
	PVPMatchScoreboard:SetTemplate("Transparent")

	PVPMatchScoreboard.Content:StripTextures()

	T.SkinScrollBar(PVPMatchScoreboard.Content.ScrollFrame.ScrollBar)
	T.SkinCloseButton(PVPMatchScoreboard.CloseButton)

	for i = 1, 3 do
		T.SkinTab(_G.PVPMatchScoreboard.Content.TabContainer.TabGroup["Tab"..i])
	end

	-- Macro to show the PVPMatchResults: /run PVPMatchResults:Show()
	local PVPMatchResults = _G.PVPMatchResults
	PVPMatchResults:StripTextures()
	PVPMatchResults:DisableDrawLayer("BORDER")
	PVPMatchResults:SetTemplate("Transparent")

	PVPMatchResults.content:StripTextures()
	PVPMatchResults.content.tabContainer:StripTextures()

	T.SkinScrollBar(PVPMatchResults.content.scrollFrame.scrollBar)
	T.SkinCloseButton(PVPMatchResults.CloseButton)
	PVPMatchResults.buttonContainer.leaveButton:SkinButton()
	PVPMatchResults.buttonContainer.requeueButton:SkinButton()

	for i = 1, 3 do
		T.SkinTab(_G.PVPMatchResults.content.tabContainer.tabGroup["tab"..i])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)