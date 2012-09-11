local T, C, L, _ = unpack(select(2, ...))
if C.skins.minimap_buttons ~= true or C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Collect minimap buttons in one line
----------------------------------------------------------------------------------------
local BlackList = {
	["QueueStatusMinimapButton"] = true,
	["MiniMapTracking"] = true,
	["MiniMapMailFrame"] = true,
	["HelpOpenTicketButton"] = true,
	["GameTimeFrame"] = true,
}

local buttons = {}
local button = CreateFrame("Frame", "ButtonCollectFrame", UIParent)

local function PositionAndStyle()
	button:Size(20)
	button:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMRIGHT", 3, -2)
	for i = 1, #buttons do
		buttons[i]:ClearAllPoints()
		if i == 1 then
			buttons[i]:SetPoint("TOP", button, "TOP", 0, 0)
		else
			buttons[i]:SetPoint("BOTTOM", buttons[i-1], "TOP", 0, 1)
		end
		buttons[i]:SetBackdropBorderColor(unpack(C.media.border_color))
		buttons[i].ClearAllPoints = T.dummy
		buttons[i].SetPoint = T.dummy
	end
end

local collect = CreateFrame("Frame")
collect:RegisterEvent("PLAYER_ENTERING_WORLD")
collect:SetScript("OnEvent", function(self)
	for i, child in ipairs({Minimap:GetChildren()}) do
		if not BlackList[child:GetName()] then
			if child:GetObjectType() == "Button" and child:GetNumRegions() >= 3 and child:IsShown() then
				child:SetParent(button)
				tinsert(buttons, child)
			end
		end
	end
	if #buttons == 0 then
		button:Hide()
	end
	PositionAndStyle()
end)