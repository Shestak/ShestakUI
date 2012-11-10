local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.tool_bar ~= true then return end

----------------------------------------------------------------------------------------
--	ToolBar(by m2jest1c for Dark ShestakUI)
----------------------------------------------------------------------------------------
local damagemeter = false

local tbar = CreateFrame("Frame", "ToolBar", UIParent)
tbar:CreatePanel("Invisible", 16, C.chat.background and C.chat.height + 5 or C.chat.height + 1, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -2, C.chat.background and 25 or 20)
if C.chat.tool_bar_mouseover == true then
	tbar:SetAlpha(0)
	tbar:SetScript("OnEnter", function()
		tbar:FadeIn()
	end)
	tbar:SetScript("OnLeave", function()
		tbar:FadeOut()
	end)
end

local lb = CreateFrame("Button", nil, tbar)
lb:CreatePanel("Transparent", 16, 16, "BOTTOM", tbar, "BOTTOM", 0, 0)
lb:SetBackdropBorderColor(0.3, 0.3, 0.9)
lb.t = lb:CreateTexture(nil, "ARTWORK")
lb.t:SetTexture(C.media.blank)
lb.t:SetVertexColor(1, 0.82, 0, 1)
lb.t:SetPoint("TOPLEFT", lb, "TOPLEFT", 2, -2)
lb.t:SetPoint("BOTTOMRIGHT", lb, "BOTTOMRIGHT", -2, 2)

local db = CreateFrame("Button", nil, tbar)
db:CreatePanel("Transparent", 16, 16, "BOTTOM", lb, "TOP", 0, C.chat.background and 4 or 3)
db:SetBackdropBorderColor(0.9, 0.1, 0.1)
db.t = db:CreateTexture(nil, "ARTWORK")
db.t:SetTexture(C.media.blank)
db.t:SetVertexColor(1, 0.82, 0, 1)
db.t:SetPoint("TOPLEFT", db, "TOPLEFT", 2, -2)
db.t:SetPoint("BOTTOMRIGHT", db, "BOTTOMRIGHT", -2, 2)

local cb = CreateFrame("Button", nil, tbar)
cb:CreatePanel("Transparent", 16, 16, "BOTTOM", db, "TOP", 0, C.chat.background and 4 or 3)
cb:SetBackdropBorderColor(0.3, 0.9, 0.3)
cb.t = cb:CreateTexture(nil, "ARTWORK")
cb.t:SetTexture(C.media.blank)
cb.t:SetVertexColor(1, 0.82, 0, 1)
cb.t:SetPoint("TOPLEFT", cb, "TOPLEFT", 2, -2)
cb.t:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", -2, 2)

local LootShow = function()
	ChatFrame3:ClearAllPoints()
	if C.chat.background == true then
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5] + 4)
		TooltipAnchor:SetPoint("BOTTOMRIGHT", ChatTabsPanelRight, "TOPRIGHT", 0, 3)
	else
		ChatFrame3:SetPoint("BOTTOMRIGHT", C.position.chat[2], "BOTTOMRIGHT", -C.position.chat[4] - 1, C.position.chat[5])
		TooltipAnchor:SetPoint("BOTTOMRIGHT", RightPanel, "TOPRIGHT", 0, 3)
		RightPanel:Show()
	end
	lb.t:SetAlpha(1)
	SavedOptionsPerChar.LootFrame = true
end

local LootHide = function()
	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 20, 0)
	if C.chat.background ~= true then RightPanel:Hide() end
	lb.t:SetAlpha(0)
	SavedOptionsPerChar.LootFrame = false
end

local DamageShow = function()
	if damagemeter == "Recount" then
		Recount_MainWindow:Show()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", Recount_MainWindow, "TOPRIGHT", 2, 5)
	elseif damagemeter == "alDamageMeter" then
		alDamageMeterFrame:ClearAllPoints()
		alDamageMeterFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -23, 26)
		TooltipAnchor:SetPoint("BOTTOMRIGHT", alDamageMeterFrame, "TOPRIGHT", 2, 5)
	end
	db.t:SetAlpha(1)
	SavedOptionsPerChar.DamageMeter = true
end

local DamageHide = function()
	if damagemeter == "Recount" then
		Recount_MainWindow:Hide()
	elseif damagemeter == "alDamageMeter" then
		alDamageMeterFrame:ClearAllPoints()
		alDamageMeterFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 23, 26)
	end
	db.t:SetAlpha(0)
	SavedOptionsPerChar.DamageMeter = false
end

local CombatLog = function()
	if LoggingCombat() then
		cb.t:SetAlpha(0)
	else
		cb.t:SetAlpha(1)
	end
	SlashCmdList.COMBATLOG()
end

lb:SetScript("OnMouseUp", function(_, button)
	if button == "RightButton" then
		ToggleLootHistoryFrame()
	else
		if damagemeter ~= nil then
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
end)

db:SetScript("OnMouseUp", function()
	if SavedOptionsPerChar.DamageMeter == true and SavedOptionsPerChar.LootFrame == false then
		DamageHide()
		TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
	elseif SavedOptionsPerChar.DamageMeter == false and SavedOptionsPerChar.LootFrame == true then
		DamageShow()
		LootHide()
	else
		DamageShow()
	end
end)

cb:SetScript("OnMouseUp", function()
	CombatLog()
end)

tbar:RegisterEvent("PLAYER_ENTERING_WORLD")
tbar:HookScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
		CombatLog()
		if IsAddOnLoaded("alDamageMeter") then
			damagemeter = "alDamageMeter"
		elseif IsAddOnLoaded("Recount") then
			damagemeter = "Recount"
			Recount_MainWindow:ClearAllPoints()
			Recount_MainWindow:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 18)
		else
			damagemeter = false
		end
		if SavedOptionsPerChar.LootFrame == nil then SavedOptionsPerChar.LootFrame = true end
		if SavedOptionsPerChar.DamageMeter == nil then SavedOptionsPerChar.DamageMeter = false end
		if SavedOptionsPerChar.LootFrame == true and damagemeter ~= false then
			LootShow()
			DamageHide()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == true and damagemeter ~= false then
			LootHide()
			DamageShow()
		elseif SavedOptionsPerChar.LootFrame == false and SavedOptionsPerChar.DamageMeter == false and damagemeter ~= false then
			LootHide()
			DamageHide()
			TooltipAnchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 24)
		elseif SavedOptionsPerChar.LootFrame == false then
			LootHide()
			db:Hide()
			cb:SetPoint("BOTTOM", lb, "TOP", 0, C.chat.background and 4 or 3)
		else
			LootShow()
			db:Hide()
			cb:SetPoint("BOTTOM", lb, "TOP", 0, C.chat.background and 4 or 3)
		end
	end
end)
