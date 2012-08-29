local T, C, L = unpack(ShestakUI)
if C.extra_general.move_blizzard ~= true then return end

----------------------------------------------------------------------------------------
--	Move Blizzard frames
----------------------------------------------------------------------------------------
local frames = {
	"CharacterFrame", "SpellBookFrame", "PVPFrame", "TaxiFrame", "QuestFrame", "PVEFrame",
	"QuestLogFrame", "QuestLogDetailFrame", "MerchantFrame", "TradeFrame", "MailFrame",
	"FriendsFrame", "CinematicFrame", "TabardFrame", "PVPBannerFrame", "PetStableFrame",
	"GuildRegistrarFrame", "PetitionFrame", "HelpFrame", "GossipFrame", "DressUpFrame",
	"WorldStateScoreFrame", "LFDParentFrame", "LFRParentFrame", "ChatConfigFrame",
	"GameMenuFrame", "InterfaceOptionsFrame", "VideoOptionsFrame", "GuildInviteFrame",
	"OpenMailFrame", "LootFrame", "StackSplitFrame", "MacOptionsFrame", "ItemTextFrame",
	"StaticPopup1", "TutorialFrame", "MissingLootFrame", "PVPBannerFrame", "BankFrame"
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