local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.tool_bar ~= true then return end

----------------------------------------------------------------------------------------
--	ToolBar(by m2jest1c for Dark ShestakUI)
----------------------------------------------------------------------------------------
local tbar = CreateFrame("Frame", "ToolBar", UIParent)
tbar:CreatePanel("Invisible", 16, C.chat.background and C.chat.height + 5 or C.chat.height + 1, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -2, C.chat.background and 25 or 20)
if C.chat.tool_bar_mouseover == true then
	cbar:SetAlpha(0)
	cbar:SetScript("OnEnter", function()
		cbar:FadeIn()
	end)
	cbar:SetScript("OnLeave", function()
		cbar:FadeOut()
	end)
end

local LootShow = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetSize(C.chat.width, C.chat.height)
	if C.chat.background == true then
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5] + 4)
		TooltipAnchor:SetPoint("BOTTOMRIGHT", ChatTabsPanelRight, "TOPRIGHT", 0, 3)
	else
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5])
		TooltipAnchor:SetPoint("BOTTOMRIGHT", RightPanel, "TOPRIGHT", 0, 3)
		RightPanel:Show()
	end
	FCF_SavePositionAndDimensions(ChatFrame3)
	LB.t:SetAlpha(1)
	SavedOptionsPerChar.LootFrame = true
end

local LootHide = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 200, 0)
	if C.chat.background ~= true then RightPanel:Hide() end
	FCF_SavePositionAndDimensions(ChatFrame3)
	LB.t:SetAlpha(0)
	SavedOptionsPerChar.LootFrame = false
end

local DamageShow = function()
	alDamageMeterFrame:ClearAllPoints()
	alDamageMeterFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26)
	TooltipAnchor:SetPoint("BOTTOMRIGHT", alDamageMeterFrame, "TOPRIGHT", 2, 5)
	DB.t:SetAlpha(1)
	SavedOptionsPerChar.DamageMeter = true
end

local DamageHide = function()
	alDamageMeterFrame:ClearAllPoints()
	alDamageMeterFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 23, 26)
	DB.t:SetAlpha(0)
	SavedOptionsPerChar.DamageMeter = false
end

function tbar:LB(button)
	if button == "RightButton" then
		ToggleLootHistoryFrame()
	else
		if alDamageMeterEnabled ~= nil then
			if SavedOptionsPerChar.LootFrame == true and SavedOptionsPerChar.DamageMeter == false then
				LootHide()
				TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
			elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true then
				LootShow()
				DamageHide()
			else
				LootShow()
			end
		else
			if SavedOptionsPerChar.LootFrame == true then
				LootHide()
				TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
			else
				LootShow()
			end
		end
	end
end

function tbar:DB(button)
	if SavedOptionsPerChar.DamageMeter == true and SavedOptionsPerChar.LootFrame == false then
		DamageHide()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
	elseif SavedOptionsPerChar.DamageMeter == false and SavedOptionsPerChar.LootFrame == true then
		DamageShow()
		LootHide()
	else
		DamageShow()
	end
end

local function CreateButton(b, f)
	b:SetWidth(16)
	b:SetHeight(16)
	b:SetTemplate()
	b:RegisterForClicks("AnyUp")
	b:SetScript("OnClick", f)
	if C.chat.tool_bar_mouseover == true then
		b:SetScript("OnEnter", function()
			cbar:FadeIn()
		end)
		b:SetScript("OnLeave", function()
			cbar:FadeOut()
		end)
	end

	b.t = b:CreateTexture(nil, "ARTWORK")
	b.t:SetTexture(C.media.blank)
	b.t:SetVertexColor(1, 0.82, 0, 1)
	b.t:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	b.t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
end

local lb = CreateFrame("Button", "LB", tbar)
CreateButton(lb, tbar.LB)
lb:SetPoint("BOTTOM", tbar, "BOTTOM", 0, 0)
lb:SetBackdropColor(unpack(C.media.overlay_color))
lb:SetBackdropBorderColor(0.3, 0.3, 0.9, 1)

local db = CreateFrame("Button", "DB", tbar)
CreateButton(db, tbar.DB)
db:SetPoint("BOTTOM", lb, "TOP", 0, C.chat.background and 4 or 3)
db:SetBackdropColor(unpack(C.media.overlay_color))
db:SetBackdropBorderColor(0.9, 0.1, 0.1, 1)

tbar:RegisterEvent("PLAYER_LOGIN")
tbar:HookScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		self:UnregisterEvent(event)
		_, _, _, alDamageMeterEnabled = GetAddOnInfo("alDamageMeter")
		if SavedOptionsPerChar.LootFrame == nil then SavedOptionsPerChar.LootFrame = true end
		if SavedOptionsPerChar.DamageMeter == nil then SavedOptionsPerChar.DamageMeter = false end
		if SavedOptionsPerChar.LootFrame == true and alDamageMeterEnabled ~= nil then
			LootShow()
			DamageHide()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true and alDamageMeterEnabled ~= nil then
			LootHide()
			DamageShow()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == false and alDamageMeterEnabled ~= nil then
			LootHide()
			DamageHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		else
			LootShow()
			DB:Hide()
		end
	end
end)
