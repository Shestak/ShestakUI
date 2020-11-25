local T, C, L, _ = unpack(select(2, ...))
if C.misc.chars_currency ~= true then return end

----------------------------------------------------------------------------------------
--	Tracks your currency tokens across multiple characters(Exonumist by Phanx)
----------------------------------------------------------------------------------------
local realmDB, charDB
local faction = UnitFactionGroup("player")
local playerList = {}
local classColor = {}
local nameToID = {}
local collapsed = {}

local function UpdateData()
	if TokenFrame:IsVisible() then
		return
	end
	local i, limit = 1, C_CurrencyInfo.GetCurrencyListSize()
	while i <= limit do
		local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		local name, isHeader, isExpanded, count = info.name, info.isHeader, info.isHeaderExpanded, info.quantity
		if isHeader then
			if not isExpanded then
				collapsed[name] = true
				C_CurrencyInfo.ExpandCurrencyList(i, 1)
				limit = C_CurrencyInfo.GetCurrencyListSize()
			end
		else
			local link = C_CurrencyInfo.GetCurrencyListLink(i)
			local id = tonumber(strmatch(link, "currency:(%d+)"))
			nameToID[name] = id
			if count > 0 then
				charDB[id] = count
			else
				charDB[id] = nil
			end
		end
		i = i + 1
	end
	while i > 0 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		if info then
			local name, isHeader, isExpanded = info.name, info.isHeader, info.isHeaderExpanded
			if isHeader and isExpanded and collapsed[name] then
				C_CurrencyInfo.ExpandCurrencyList(i, 0)
			end
		end
		i = i - 1
	end
	wipe(collapsed)
end
hooksecurefunc("BackpackTokenFrame_Update", UpdateData)
hooksecurefunc("TokenFrame_Update", UpdateData)

local function AddTooltipInfo(tooltip, currency, includePlayer)
	local spaced
	for i = (includePlayer and 1 or 2), #playerList do
		local name = playerList[i]
		local n = realmDB[name][currency]
		if n then
			if not spaced then
				tooltip:AddLine(" ")
				spaced = true
			end
			local r, g, b
			local class = realmDB[name].class
			if class then
				r, g, b = unpack(classColor[class])
			else
				r, g, b = 1, 1, 1
			end
			tooltip:AddLine(name..": "..n, r, g, b)
		end
	end
	if spaced then
		tooltip:Show()
	end
end

hooksecurefunc(GameTooltip, "SetCurrencyByID", function(tooltip, id)
	AddTooltipInfo(tooltip, id, not MerchantMoneyInset:IsMouseOver())
end)

hooksecurefunc(GameTooltip, "SetCurrencyToken", function(_, i)
	local info = C_CurrencyInfo.GetCurrencyListInfo(i)
	if info.name then
		AddTooltipInfo(GameTooltip, nameToID[info.name], not TokenFrame:IsMouseOver())
	end
end)

hooksecurefunc(GameTooltip, "SetHyperlink", function(tooltip, link)
	local id = strmatch(link, "currency:(%d+)")
	if id then
		AddTooltipInfo(tooltip, tonumber(id), true)
	end
end)

hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(tooltip, link)
	local id = strmatch(link, "currency:(%d+)")
	if id then
		AddTooltipInfo(tooltip, tonumber(id), true)
	end
end)

hooksecurefunc(GameTooltip, "SetMerchantCostItem", function(tooltip, item, currency)
	local _, _, _, name = GetMerchantItemCostItem(item, currency)
	if name then
		AddTooltipInfo(tooltip, nameToID[name], true)
	end
end)

hooksecurefunc(GameTooltip, "SetLFGDungeonReward", function(tooltip, dungeonID, rewardIndex)
	local name = GetLFGDungeonRewardInfo(dungeonID, rewardIndex)
	if name then
		AddTooltipInfo(tooltip, nameToID[name], true)
	end
end)

hooksecurefunc(GameTooltip, "SetLFGDungeonShortageReward", function(tooltip, dungeonID, shortageIndex, rewardIndex)
	local name = GetLFGDungeonShortageRewardInfo(dungeonID, shortageIndex, rewardIndex)
	if name then
		AddTooltipInfo(tooltip, nameToID[name], true)
	end
end)

hooksecurefunc(GameTooltip, "SetQuestCurrency", function(tooltip, type, id)
	local name = GetQuestCurrencyInfo(type, id)
	if name then
		AddTooltipInfo(tooltip, nameToID[name], true)
	end
end)

hooksecurefunc(GameTooltip, "SetQuestLogCurrency", function(tooltip, type, id)
	local name = GetQuestCurrencyInfo(type, id)
	if name then
		AddTooltipInfo(tooltip, nameToID[name], true)
	end
end)

if xMerchantFrame then
	local function xMerchantTooltip(self)
		if self.pointType == "Beta" then
			local id = nameToID[self.itemLink]
			if id then
				self.UpdateTooltip = nil
				return GameTooltip:SetCurrencyByID(id)
			end
		end
		self.UpdateTooltip = self.origUpdateTooltip
	end

	for i = 1, 10 do
		for j = 1, MAX_ITEM_COST do
			local item = _G["xMerchantFrame"..i.."Item"..j]
			item:HookScript("OnEnter", xMerchantTooltip)
			item.origUpdateTooltip = item.UpdateTooltip
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon ~= "ShestakUI" then return end

		if faction ~= "Alliance" and faction ~= "Horde" then return end

		ShestakUICurrency = ShestakUICurrency or {}
		ShestakUICurrency[T.realm] = ShestakUICurrency[T.realm] or {}
		ShestakUICurrency[T.realm][faction] = ShestakUICurrency[T.realm][faction] or {}
		ShestakUICurrency[T.realm][faction][T.name] = ShestakUICurrency[T.realm][faction][T.name] or {}

		realmDB = ShestakUICurrency[T.realm][faction]
		if not realmDB then return end

		charDB = realmDB[T.name]

		local now = time()
		charDB.class = select(2, UnitClass("player"))
		charDB.lastSeen = now

		local cutoff = now - (60 * 60 * 24 * 30)
		for name, data in pairs(realmDB) do
			if data.lastSeen and data.lastSeen < cutoff then
				realmDB[name] = nil
			elseif name ~= T.name then
				tinsert(playerList, name)
			end
		end
		sort(playerList)
		tinsert(playerList, 1, T.name)

		self:UnregisterEvent("ADDON_LOADED")

		if IsLoggedIn() then
			self:GetScript("OnEvent")(self, "PLAYER_LOGIN")
		else
			self:RegisterEvent("PLAYER_LOGIN")
		end
	elseif event == "PLAYER_LOGIN" then
		for k, v in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
			classColor[k] = {v.r, v.g, v.b}
		end
		if CUSTOM_CLASS_COLORS then
			CUSTOM_CLASS_COLORS:RegisterCallback(function()
				for k, v in pairs(CUSTOM_CLASS_COLORS) do
					classColor[k][1] = v.r
					classColor[k][2] = v.g
					classColor[k][3] = v.b
				end
			end)
		end
		self:UnregisterEvent("PLAYER_LOGIN")
	end
end)