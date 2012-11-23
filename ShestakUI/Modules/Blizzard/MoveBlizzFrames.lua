local T, C, L, _ = unpack(select(2, ...))
if C.misc.move_blizzard ~= true then return end

----------------------------------------------------------------------------------------
--	Move some Blizzard frames
----------------------------------------------------------------------------------------
local frames = {
	"CharacterFrame", "SpellBookFrame", "PVPFrame", "TaxiFrame", "QuestFrame", "PVEFrame",
	"QuestLogFrame", "QuestLogDetailFrame", "MerchantFrame", "TradeFrame", "MailFrame",
	"FriendsFrame", "CinematicFrame", "TabardFrame", "PVPBannerFrame", "PetStableFrame",
	"GuildRegistrarFrame", "PetitionFrame", "HelpFrame", "GossipFrame", "DressUpFrame",
	"WorldStateScoreFrame", "ChatConfigFrame", "RaidBrowserFrame", "InterfaceOptionsFrame",
	"GameMenuFrame", "VideoOptionsFrame", "GuildInviteFrame", "ItemTextFrame", "BankFrame",
	"OpenMailFrame", "LootFrame", "StackSplitFrame", "MacOptionsFrame", "TutorialFrame",
	"StaticPopup1", "StaticPopup2", "MissingLootFrame", "ScrollOfResurrectionSelectionFrame"
}

for i, v in pairs(frames) do
	if _G[v] then
		_G[v]:EnableMouse(true)
		_G[v]:SetMovable(true)
		_G[v]:SetClampedToScreen(true)
		_G[v]:RegisterForDrag("LeftButton")
		_G[v]:SetScript("OnDragStart", function(self) self:StartMoving() end)
		_G[v]:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	end
end