local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Professions skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = ProfessionsFrame
	T.SkinFrame(frame)


	-- Guild
	ProfessionsFrame.CraftingPage.ViewGuildCraftersButton:SkinButton()
	local GuildFrame = ProfessionsFrame.CraftingPage.GuildFrame
	GuildFrame:StripTextures()
	GuildFrame:CreateBackdrop("Transparent")
	GuildFrame.Container:StripTextures()
	GuildFrame.Container:CreateBackdrop("Overlay")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)