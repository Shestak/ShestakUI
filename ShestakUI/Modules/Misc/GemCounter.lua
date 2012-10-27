local T, C, L, _ = unpack(select(2, ...))
if C.misc.gem_counter ~= true or T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	Displays how many red/blue/yellow gems you have(GemCounter by Killakhan)
----------------------------------------------------------------------------------------
local GemCounter = {}
local addon = GemCounter
local RedGems, BlueGems, YellowGems, GreenGems, PurpleGems, OrangeGems, PrismaticGems
local Red_localized, Blue_localized, Yellow_localized, Green_localized, Purple_localized, Orange_localized
local BlueTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_blue"
local RedTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_red"
local YellowTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_yellow"
local GreenTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_green"
local PurpleTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_purple"
local OrangeTexture = "Interface\\Icons\\inv_misc_gem_x4_rare_cut_orange"
local PrismaticTexture = "Interface\\Icons\\INV_Jewelcrafting_DragonsEye02"

addon.f = CreateFrame("Frame", "GCmain", CharacterFrame)
addon.f:SetScript("OnShow", function(self) addon.GetGems() end)
addon.f:SetScript("OnEvent", function(self, event, ...) if addon[event] then return addon[event](addon, event, ...) end end)
addon.f:RegisterEvent("UNIT_INVENTORY_CHANGED")
addon.f:RegisterEvent("PLAYER_LOGIN")

function addon:PLAYER_LOGIN(event, ...)
	Red_localized = select(7, GetItemInfo(52255))
	Blue_localized = select(7, GetItemInfo(52235))
	Yellow_localized = select(7, GetItemInfo(52267))
	Green_localized = select(7, GetItemInfo(52245))
	Purple_localized = select(7, GetItemInfo(52213))
	Orange_localized = select(7, GetItemInfo(52222))
	addon.GetGems()
end

function addon:UNIT_INVENTORY_CHANGED(event, unit)
	if not unit == "player" then return end
	self:PLAYER_LOGIN()
end

for i = 1, 7 do
	addon["button"..i] = PaperDollItemsFrame:CreateTexture("GCbutton"..i, "OVERLAY")
	local frame = addon["button"..i]
	frame:SetHeight(15)
	frame:SetWidth(15)
	frame:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	frame.text = PaperDollItemsFrame:CreateFontString("GCtext"..i, "OVERLAY", "NumberFontNormal")
	frame.text:SetPoint("LEFT", frame, "RIGHT", 5, -1)
	frame.text:SetText("")
	if i == 1 then
		frame:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 53, 41)
	else
		frame:SetPoint("BOTTOM", addon["button"..(i-1)], "TOP", 0, 5)
	end
end
addon.button1:SetTexture(BlueTexture)
addon.button1.text:SetTextColor(0, 0.6, 1)
addon.button2:SetTexture(RedTexture)
addon.button2.text:SetTextColor(1, 0.4, 0.4)
addon.button3:SetTexture(YellowTexture)
addon.button3.text:SetTextColor(1, 1, 0)
addon.button4:SetTexture(GreenTexture)
addon.button4.text:SetTextColor(0, 1, 0)
addon.button5:SetTexture(PurpleTexture)
addon.button5.text:SetTextColor(0.6, 0.1, 0.9)
addon.button6:SetTexture(OrangeTexture)
addon.button6.text:SetTextColor(1, 0.6, 0)
addon.button7:SetTexture(PrismaticTexture)
addon.button7.text:SetTextColor(1, 1, 1)

function addon.GetGems()
	RedGems, BlueGems, YellowGems, GreenGems, PurpleGems, OrangeGems, PrismaticGems = 0, 0, 0, 0, 0, 0, 0
	for i = 1, 18 do
		local gem1, gem2, gem3, gem4, gem5, gem6 = GetInventoryItemGems(i)
		if gem1 then
			addon.GetGemColors(gem1)
			addon.GetPrismatic(gem1)
		end
		if gem2 then
			addon.GetGemColors(gem2)
			addon.GetPrismatic(gem2)
		end
		if gem3 then
			addon.GetGemColors(gem3)
			addon.GetPrismatic(gem3)
		end
		if gem4 then
			addon.GetGemColors(gem4)
			addon.GetPrismatic(gem4)
		end
		if gem5 then
			addon.GetGemColors(gem5)
			addon.GetPrismatic(gem5)
		end
		if gem6 then
			addon.GetGemColors(gem6)
			addon.GetPrismatic(gem6)
		end
	end
	addon.button1.text:SetText(BlueGems)
	addon.button2.text:SetText(RedGems)
	addon.button3.text:SetText(YellowGems)
	addon.button4.text:SetText(GreenGems)
	addon.button5.text:SetText(PurpleGems)
	addon.button6.text:SetText(OrangeGems)
	if PrismaticGems == 0 then
		addon.button7:Hide()
		addon.button7.text:SetText("")
	else
		addon.button7:Show()
		addon.button7.text:SetText(PrismaticGems)
	end
end

function addon.GetPrismatic(gem)
	local item = select(10, GetItemInfo(gem))
	if item then
		if item:find("dragonseye") then
			PrismaticGems = PrismaticGems + 1
		end
	end
end

function addon.GetGemColors(gem)
	local item = select(7, GetItemInfo(gem))
	if item == Red_localized then
		RedGems = RedGems + 1
	elseif item == Blue_localized then
		BlueGems = BlueGems + 1
	elseif item == Yellow_localized then
		YellowGems = YellowGems + 1
	elseif item == Green_localized then
		GreenGems = GreenGems + 1
	elseif item == Purple_localized then
		PurpleGems = PurpleGems + 1
	elseif item == Orange_localized then
		OrangeGems = OrangeGems + 1
	else
		return
	end
end