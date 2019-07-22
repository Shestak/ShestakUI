local T, C, L, _ = unpack(select(2, ...))
if C.misc.move_blizzard ~= true then return end

----------------------------------------------------------------------------------------
--	Move some Blizzard frames
----------------------------------------------------------------------------------------
local frames = {
	"CharacterFrame", "SpellBookFrame", "TaxiFrame", "QuestFrame", "PVEFrame", "AddonList",
	"QuestLogPopupDetailFrame", "MerchantFrame", "TradeFrame", "MailFrame", "LootFrame",
	"FriendsFrame", "CinematicFrame", "TabardFrame", "PetStableFrame", "BankFrame",
	"PetitionFrame", "HelpFrame", "GossipFrame", "DressUpFrame", "GuildRegistrarFrame",
	"ChatConfigFrame", "RaidBrowserFrame", "InterfaceOptionsFrame", "WorldMapFrame",
	"GameMenuFrame", "VideoOptionsFrame", "GuildInviteFrame", "ItemTextFrame",
	"OpenMailFrame", "StackSplitFrame", "TutorialFrame", "StaticPopup1",
	"StaticPopup2", "ScrollOfResurrectionSelectionFrame"
}

for _, v in pairs(frames) do
	if _G[v] then
		_G[v]:EnableMouse(true)
		_G[v]:SetMovable(true)
		_G[v]:SetClampedToScreen(true)
		_G[v]:RegisterForDrag("LeftButton")
		_G[v]:SetScript("OnDragStart", function(self) self:StartMoving() end)
		_G[v]:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	end
end

local AddOnFrames = {
	["Blizzard_AchievementUI"] = {"AchievementFrame"},
	["Blizzard_ArchaeologyUI"] = {"ArchaeologyFrame"},
	["Blizzard_ArtifactUI"] = {"ArtifactRelicForgeFrame"},
	["Blizzard_AuctionUI"] = {"AuctionFrame"},
	["Blizzard_BarberShopUI"] = {"BarberShopFrame"},
	["Blizzard_BindingUI"] = {"KeyBindingFrame"},
	["Blizzard_BlackMarketUI"] = {"BlackMarketFrame"},
	["Blizzard_Calendar"] = {"CalendarCreateEventFrame", "CalendarFrame", "CalendarViewEventFrame", "CalendarViewHolidayFrame"},
	["Blizzard_ChallengesUI"] = {"ChallengesLeaderboardFrame"},
	["Blizzard_Collections"] = {"CollectionsJournal", "WardrobeFrame"},
	["Blizzard_Communities"] = {"CommunitiesFrame"},
	["Blizzard_EncounterJournal"] = {"EncounterJournal"},
	["Blizzard_GMChatUI"] = {"GMChatStatusFrame"},
	["Blizzard_GMSurveyUI"] = {"GMSurveyFrame"},
	["Blizzard_GarrisonUI"] = {"GarrisonLandingPage", "GarrisonMissionFrame", "GarrisonCapacitiveDisplayFrame", "GarrisonBuildingFrame", "GarrisonRecruiterFrame", "GarrisonRecruitSelectFrame", "GarrisonShipyardFrame"},
	["Blizzard_GuildBankUI"] = {"GuildBankFrame"},
	["Blizzard_GuildControlUI"] = {"GuildControlUI"},
	["Blizzard_InspectUI"] = {"InspectFrame"},
	["Blizzard_ItemAlterationUI"] = {"TransmogrifyFrame"},
	["Blizzard_ItemSocketingUI"] = {"ItemSocketingFrame"},
	["Blizzard_ItemUpgradeUI"] = {"ItemUpgradeFrame"},
	["Blizzard_LookingForGuildUI"] = {"LookingForGuildFrame"},
	["Blizzard_MacroUI"] = {"MacroFrame"},
	["Blizzard_OrderHallUI"] = {"OrderHallMissionFrame"},
	["Blizzard_QuestChoice"] = {"QuestChoiceFrame"},
	["Blizzard_ReforgingUI"] = {"ReforgingFrame"},
	["Blizzard_TalentUI"] = {"PlayerTalentFrame"},
	["Blizzard_TalkingHeadUI"] = {"TalkingHeadFrame"},
	["Blizzard_TradeSkillUI"] = {"TradeSkillFrame"},
	["Blizzard_TrainerUI"] = {"ClassTrainerFrame"},
	["Blizzard_VoidStorageUI"] = {"VoidStorageFrame"}
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if AddOnFrames[addon] then
		for _, v in pairs(AddOnFrames[addon]) do
			if _G[v] then
				_G[v]:EnableMouse(true)
				_G[v]:SetMovable(true)
				_G[v]:SetClampedToScreen(true)
				_G[v]:RegisterForDrag("LeftButton")
				_G[v]:SetScript("OnDragStart", function(self) self:StartMoving() end)
				_G[v]:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
			end
		end
	end
end)
