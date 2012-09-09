local T, C, L, _ = unpack(select(2, ...))
if C.automation.chefs_hat ~= true then return end

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

local function BackInBag()
	if GetContainerNumFreeSlots(0) > 0 then
		PickupInventoryItem(1)
		PutItemInBackpack()
		return
	end
	local hatType = GetItemFamily(GetInventoryItemLink("player", 1))
	for bag = 1, NUM_BAG_SLOTS do
		local this = GetInventoryItemLink("player", ContainerIDToInventoryID(bag))
		if this then
			local bagType = GetItemFamily(this)
				if bagType == 0 or bagType == hatType then
				if GetContainerNumFreeSlots(bag) > 0 then
					PickupInventoryItem(1)
					PutItemInBag(bag + CONTAINER_BAG_OFFSET)
					return
				end
			end
		end
	end
end

local function WhereIsThisDamnedHat(ThisHat)
	local SearchThis = "item:"..ThisHat..":"
	for SearchHere = 0, 4 do
		for SearchThere = 1, GetContainerNumSlots(SearchHere) do
			local OhhhhIFoundSomething = GetContainerItemLink(SearchHere, SearchThere)
			if OhhhhIFoundSomething and OhhhhIFoundSomething:find(SearchThis) then
				return OhhhhIFoundSomething
			end
		end
	end
	local OhhhhhTheHatIsOnMyHead = GetInventoryItemLink("player", 1)
	if OhhhhhTheHatIsOnMyHead and OhhhhhTheHatIsOnMyHead:find(SearchThis) then
		return OhhhhhTheHatIsOnMyHead
	end
end

local function GiveMe_TheOldHat()
	TheChef_Is_InTheKitchen = false
	if IDoNotCookHere or IDoNotCookThere then return end
	if TheChefsHat_Is_OnMyHead then
		if TheOldHat then
			local ThisIs_TheOldHat = WhereIsThisDamnedHat(TheOldHat)
			if ThisIs_TheOldHat then
				ShowHelm(TheOldHat_Is_LookingGood)
				EquipItemByName(ThisIs_TheOldHat)
			else
				ShowHelm(TheOldHat_Is_LookingGood)
				BackInBag()
			end
		else
			ShowHelm(TheOldHat_Is_LookingGood)
			BackInBag()
		end
		TheChefsHat_Is_OnMyHead = false
	end
end

local function GiveMe_TheChefsHat()
	TheOldHat = GetInventoryItemLink("player", 1)
	if TheOldHat then
		TheOldHat = string.match(TheOldHat, "item:(%-?%d+):")
	end

	if ShowingHelm() then
		TheOldHat_Is_LookingGood = true
	else
		TheOldHat_Is_LookingGood = false
	end

	local ThisIs_TheChefsHat = WhereIsThisDamnedHat(TheChefsHat)

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