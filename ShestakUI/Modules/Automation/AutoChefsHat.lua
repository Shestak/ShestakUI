local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Auto equip Chef's Hat(ChefsHat by Kunda)
----------------------------------------------------------------------------------------
local ChefsHat = CreateFrame("Frame")
local ChefsKitchen = GetSpellInfo(33359)

local TheChefsHat = "46349"
local TheChefsHat_Is_OnMyHead

local TheOldHat
local TheOldHat_Is_LookingGood

local TheChef_Is_InTheKitchen
local IDoNotCookHere
local IDoNotCookThere

local function WhereIsThisDamnedHat()
	for SearchHere = 0, 4 do
		for SearchThere = 1, GetContainerNumSlots(SearchHere) do
			local OhhhhIFoundSomething = GetContainerItemLink(SearchHere, SearchThere)
			if OhhhhIFoundSomething and OhhhhIFoundSomething:find(TheChefsHat) then
				return OhhhhIFoundSomething
			end
		end
	end
	local OhhhhhTheHatIsOnMyHead = GetInventoryItemLink("player", 1)
	if OhhhhhTheHatIsOnMyHead and OhhhhhTheHatIsOnMyHead:find(TheChefsHat) then
		return OhhhhhTheHatIsOnMyHead
	end
end

local function GiveMe_TheOldHat()
	TheChef_Is_InTheKitchen = false
	if IDoNotCookHere or IDoNotCookThere then return end
	if TheChefsHat_Is_OnMyHead then
		ShowHelm(TheOldHat_Is_LookingGood)
		EquipItemByName(TheOldHat)
		TheChefsHat_Is_OnMyHead = false
	end
end

local function GiveMe_TheChefsHat()
	TheOldHat = GetInventoryItemLink("player", 1)
	if ShowingHelm() then
		TheOldHat_Is_LookingGood = true
	else
		TheOldHat_Is_LookingGood = false
	end

	local ThisIs_TheChefsHat = WhereIsThisDamnedHat()

	if ThisIs_TheChefsHat then
		EquipItemByName(ThisIs_TheChefsHat)
		ShowHelm(true)
		TheChefsHat_Is_OnMyHead = true
	else
		TheChefsHat_Is_OnMyHead = false
	end
end

local function DoINeed_TheChefsHat()
	if IsTradeSkillLinked() then
		GiveMe_TheOldHat()
		return
	end
	if GetTradeSkillLine() == ChefsKitchen then
		TheChef_Is_InTheKitchen = true
		if IDoNotCookHere or IDoNotCookThere then return end
		GiveMe_TheChefsHat()
	else
		TheChef_Is_InTheKitchen = false
		if IDoNotCookHere or IDoNotCookThere then return end
		GiveMe_TheOldHat()
	end
end

local function ToBeOrNotToBe()
	if IDoNotCookHere or IDoNotCookThere then return end
	if TheChef_Is_InTheKitchen then
		if not TheChefsHat_Is_OnMyHead then
			GiveMe_TheChefsHat()
		end
	else
		if TheChefsHat_Is_OnMyHead then
			GiveMe_TheOldHat()
		end
	end
end

local function HmmmmCooking(self, Campfire, Chef)
	if Campfire == "PLAYER_REGEN_DISABLED" then
		IDoNotCookHere = true
	elseif Campfire == "PLAYER_REGEN_ENABLED" then
		IDoNotCookHere = false
		ToBeOrNotToBe()
	elseif Campfire == "UNIT_SPELLCAST_CHANNEL_START" then
		if Chef ~= "player" then return end
		IDoNotCookThere = true
	elseif Campfire == "UNIT_SPELLCAST_CHANNEL_STOP" then
		if Chef ~= "player" then return end
		IDoNotCookThere = false
		ToBeOrNotToBe()
	elseif Campfire == "TRADE_SKILL_SHOW" then
		DoINeed_TheChefsHat()
	elseif Campfire == "TRADE_SKILL_CLOSE" then
		GiveMe_TheOldHat()
	end
end

ChefsHat:RegisterEvent("PLAYER_REGEN_DISABLED")
ChefsHat:RegisterEvent("PLAYER_REGEN_ENABLED")
ChefsHat:RegisterEvent("TRADE_SKILL_SHOW")
ChefsHat:RegisterEvent("TRADE_SKILL_CLOSE")
ChefsHat:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
ChefsHat:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
ChefsHat:SetScript("OnEvent", HmmmmCooking)