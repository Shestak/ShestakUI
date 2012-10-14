local T, C, L, _ = unpack(select(2, ...))
if C.misc.chars_currency ~= true then return end

----------------------------------------------------------------------------------------
--	Tracks your currency tokens across multiple characters(Exonumist by Phanx)
----------------------------------------------------------------------------------------
local realmDB, charDB
local playerList = {}
local classColor = {}

local function UpdateData()
	for i = 1, GetCurrencyListSize() do
		local tokenID
		local name, isHeader, _, _, _, count = GetCurrencyListInfo(i)
		if name and not isHeader then
			if count > 0 then
				charDB[name] = count
			else
				charDB[name] = nil
			end
		end
	end
end
hooksecurefunc("BackpackTokenFrame_Update", UpdateData)

local function CurrencyButton_OnEnter(self)
	local i = self:GetParent().index
	local currency, isHeader, _, _, _, count = GetCurrencyListInfo(i)
	if isHeader then return end

	local spaced
	for _, name in ipairs(playerList) do
		local n = realmDB[name][currency]
		if n then
			if not spaced then
				GameTooltip:AddLine(" ")
				spaced = true
			end
			local r, g, b
			local class = realmDB[name].class
			if class then
				r, g, b = unpack(classColor[class])
			else
				r, g, b = 0, 1, 1
			end
			GameTooltip:AddLine(name..": "..n, r, g, b)
		end
	end
	if spaced then
		GameTooltip:Show()
	end
end

hooksecurefunc("TokenFrame_Update", function()
	local i = 1
	while true do
		local button = _G["TokenFrameContainerButton"..i]
		if not button then return end

		if not button.hookedOnEnter then
			button.LinkButton:HookScript("OnEnter", CurrencyButton_OnEnter)
			button.hookedOnEnter = true
		end

		i = i + 1
	end
	UpdateData()
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "ShestakUI" then return end

		if not SavedCurrency then SavedCurrency = {} end
		if not SavedCurrency[T.realm] then SavedCurrency[T.realm] = {} end
		if not SavedCurrency[T.realm][T.name] then SavedCurrency[T.realm][T.name] = {} end

		local now = time()

		SavedCurrency[T.realm][T.name].class = T.class
		SavedCurrency[T.realm][T.name].lastSeen = now

		charDB = SavedCurrency[T.realm][T.name]
		realmDB = SavedCurrency[T.realm]

		for k, v in pairs(charDB) do
			if type(k) == "number" then
				charDB[k] = nil
			end
		end

		local cutoff = now - (60 * 60 * 24 * 30)
		for name, data in pairs(realmDB) do
			if (data.lastSeen or now) > cutoff and name ~= T.name then
				tinsert(playerList, name)
			end
		end
		sort(playerList)

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