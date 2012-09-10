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
	button:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 3, 2)
	for i =1, #buttons do
		buttons[i]:ClearAllPoints()
		buttons[i]:SetPoint("TOP", button, "TOP", 0, -((i - 1) * 21))
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

-- edit by Oz of shestak. org --
