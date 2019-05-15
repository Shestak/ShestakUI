local T, C, L, _ = unpack(select(2, ...))
if C.misc.item_level ~= true then return end

----------------------------------------------------------------------------------------
--	Item level on slot buttons in Character/InspectFrame(iLevel by Sanex)
----------------------------------------------------------------------------------------
local _G = getfenv(0)
local equiped = {} -- Table to store equiped items

local f = CreateFrame("Frame", nil, _G.PaperDollFrame) -- iLvel number frame
local g -- iLvel number for Inspect frame
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
local S_ITEM_LEVEL = "^" .. gsub(ITEM_LEVEL, "%%d", "(%%d+)")

local scantip = CreateFrame("GameTooltip", "iLvlScanningTooltip", nil, "GameTooltipTemplate")
scantip:SetOwner(UIParent, "ANCHOR_NONE")

local function _getRealItemLevel(slotId, unit)
	local realItemLevel
	local hasItem = scantip:SetInventoryItem(unit, slotId)
	if not hasItem then return nil end -- With this we don't get ilvl for offhand if we equip 2h weapon

	for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
		local text = _G["iLvlScanningTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			realItemLevel = realItemLevel or strmatch(text, S_ITEM_LEVEL)

			if realItemLevel then
				return tonumber(realItemLevel)
			end
		end
	end

	return realItemLevel
end

local function _updateItems(unit, frame)
	for i = 1, 17 do -- Only check changed player items or items without ilvl text, skip the shirt (4) and always update Inspects
		local itemLink = GetInventoryItemLink(unit, i)
		if i ~= 4 and ((frame == f and (equiped[i] ~= itemLink or frame[i]:GetText() == nil or itemLink == nil and frame[i]:GetText() ~= "")) or frame == g) then
			if frame == f then
				equiped[i] = itemLink
			end

			local delay = false
			if itemLink then
				local _, _, quality = GetItemInfo(itemLink)

				if (quality == 6) and (i == 16 or i == 17) then
					local relics = {select(4, strsplit(":", itemLink))}
					for i = 1, 3 do
						local relicID = relics[i] ~= "" and relics[i]
						local relicLink = select(2, GetItemGem(itemLink, i))
						if relicID and not relicLink then
							delay = true
						end
					end
					if delay then
						C_Timer.After(0.1, function()
							local realItemLevel = _getRealItemLevel(i, unit)
							realItemLevel = realItemLevel or ""
							frame[i]:SetText("|cFFFFFF00"..realItemLevel)
						end)
					end
				end
			end

			local realItemLevel = _getRealItemLevel(i, unit)
			realItemLevel = realItemLevel or ""
			if realItemLevel and realItemLevel == 1 then
				realItemLevel = ""
			end
			frame[i]:SetText("|cFFFFFF00"..realItemLevel)
		end
	end
end

local function _createStrings()
	local function _stringFactory(parent)
		local s = f:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
		s:SetPoint("TOP", parent, "TOP", 0, -2)

		return s
	end

	f:SetFrameLevel(_G.CharacterHeadSlot:GetFrameLevel())

	f[1] = _stringFactory(_G.CharacterHeadSlot)
	f[2] = _stringFactory(_G.CharacterNeckSlot)
	f[3] = _stringFactory(_G.CharacterShoulderSlot)
	f[15] = _stringFactory(_G.CharacterBackSlot)
	f[5] = _stringFactory(_G.CharacterChestSlot)
	f[9] = _stringFactory(_G.CharacterWristSlot)

	f[10] = _stringFactory(_G.CharacterHandsSlot)
	f[6] = _stringFactory(_G.CharacterWaistSlot)
	f[7] = _stringFactory(_G.CharacterLegsSlot)
	f[8] = _stringFactory(_G.CharacterFeetSlot)
	f[11] = _stringFactory(_G.CharacterFinger0Slot)
	f[12] = _stringFactory(_G.CharacterFinger1Slot)
	f[13] = _stringFactory(_G.CharacterTrinket0Slot)
	f[14] = _stringFactory(_G.CharacterTrinket1Slot)

	f[16] = _stringFactory(_G.CharacterMainHandSlot)
	f[17] = _stringFactory(_G.CharacterSecondaryHandSlot)

	if T.classic then
		f[18] = _stringFactory(_G.CharacterRangedSlot)
		-- f[0] = _stringFactory(_G.CharacterAmmoSlot)
	end

	f:Hide()
end

local function _createGStrings()
	local function _stringFactory(parent)
		local s = g:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
		s:SetPoint("TOP", parent, "TOP", 0, -2)

		return s
	end

	g:SetFrameLevel(_G.InspectHeadSlot:GetFrameLevel())

	g[1] = _stringFactory(_G.InspectHeadSlot)
	g[2] = _stringFactory(_G.InspectNeckSlot)
	g[3] = _stringFactory(_G.InspectShoulderSlot)
	g[15] = _stringFactory(_G.InspectBackSlot)
	g[5] = _stringFactory(_G.InspectChestSlot)
	g[9] = _stringFactory(_G.InspectWristSlot)

	g[10] = _stringFactory(_G.InspectHandsSlot)
	g[6] = _stringFactory(_G.InspectWaistSlot)
	g[7] = _stringFactory(_G.InspectLegsSlot)
	g[8] = _stringFactory(_G.InspectFeetSlot)
	g[11] = _stringFactory(_G.InspectFinger0Slot)
	g[12] = _stringFactory(_G.InspectFinger1Slot)
	g[13] = _stringFactory(_G.InspectTrinket0Slot)
	g[14] = _stringFactory(_G.InspectTrinket1Slot)

	g[16] = _stringFactory(_G.InspectMainHandSlot)
	g[17] = _stringFactory(_G.InspectSecondaryHandSlot)

	if T.classic then
		g[18] = _stringFactory(_G.CharacterRangedSlot)
		-- g[0] = _stringFactory(_G.CharacterAmmoSlot)
	end

	g:Hide()
end

local function OnEvent(self, event, ...) -- Event handler
	if event == "ADDON_LOADED" and (...) == "Blizzard_InspectUI" then
		self:UnregisterEvent(event)

		g = CreateFrame("Frame", nil, _G.InspectPaperDollFrame) -- iLevel number frame for Inspect
		_createGStrings()
		_createGStrings = nil

		_G.InspectPaperDollFrame:HookScript("OnShow", function(self)
			g:SetFrameLevel(_G.InspectHeadSlot:GetFrameLevel())
			f:RegisterEvent("INSPECT_READY")
			f:RegisterEvent("UNIT_INVENTORY_CHANGED")
			_updateItems("target", g)
			g:Show()
		end)

		_G.InspectPaperDollFrame:HookScript("OnHide", function(self)
			f:UnregisterEvent("INSPECT_READY")
			f:UnregisterEvent("UNIT_INVENTORY_CHANGED")
			g:Hide()
		end)
	elseif event == "PLAYER_LOGIN" then
		self:UnregisterEvent(event)

		_createStrings()
		_createStrings = nil

		_G.PaperDollFrame:HookScript("OnShow", function(self)
			f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
			if not T.classic then
				f:RegisterEvent("ITEM_UPGRADE_MASTER_UPDATE")
				f:RegisterEvent("ARTIFACT_UPDATE")
				f:RegisterEvent("SOCKET_INFO_UPDATE")
			end
			f:RegisterEvent("COMBAT_RATING_UPDATE")
			_updateItems("player", f)
			f:Show()
		end)

		_G.PaperDollFrame:HookScript("OnHide", function(self)
			f:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
			if not T.classic then
				f:UnregisterEvent("ITEM_UPGRADE_MASTER_UPDATE")
				f:UnregisterEvent("ARTIFACT_UPDATE")
				f:UnregisterEvent("SOCKET_INFO_UPDATE")
			end
			f:UnregisterEvent("COMBAT_RATING_UPDATE")
			f:Hide()
		end)
	elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "ITEM_UPGRADE_MASTER_UPDATE"
	or event == "ARTIFACT_UPDATE" or event == "SOCKET_INFO_UPDATE" or event == "COMBAT_RATING_UPDATE" then
		if (...) == 16 then
			equiped[16] = nil
			equiped[17] = nil
		end
		_updateItems("player", f)
	elseif event == "INSPECT_READY" or event == "UNIT_INVENTORY_CHANGED" then
		_updateItems("target", g)
	end
end
f:SetScript("OnEvent", OnEvent)