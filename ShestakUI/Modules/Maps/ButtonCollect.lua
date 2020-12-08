local T, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true or C.skins.minimap_buttons ~= true then return end

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
local collectFrame = CreateFrame("Frame", "ButtonCollectFrame", UIParent)
local line = math.ceil(C.minimap.size / 20)

local function SkinButton(f)
	f:SetPushedTexture(nil)
	f:SetHighlightTexture(nil)
	f:SetDisabledTexture(nil)
	f:SetSize(20, 20)

	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:IsVisible() and region:GetObjectType() == "Texture" then
			local tex = tostring(region:GetTexture())

			if tex and (tex:find("Border") or tex:find("Background") or tex:find("AlphaMask")) then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
				region:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				region:SetDrawLayer("ARTWORK")
				if f:GetName() == "PS_MinimapButton" then
					region.SetPoint = T.dummy
				end
			end
		end
	end

	f:SetTemplate("ClassColor")
end

local function PositionAndStyle()
	collectFrame:SetSize(20, 20)
	collectFrame:SetPoint(unpack(C.position.minimap_buttons))
	for i = 1, #buttons do
		local f = buttons[i]
		f:ClearAllPoints()
		if i == 1 then
			f:SetPoint("TOP", collectFrame, "TOP", 0, 0)
		elseif i == line then
			f:SetPoint("TOPRIGHT", buttons[1], "TOPLEFT", -1, 0)
		else
			f:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -1)
		end
		f.ClearAllPoints = T.dummy
		f.SetPoint = T.dummy
		if C.skins.minimap_buttons_mouseover then
			f:SetAlpha(0)
			f:HookScript("OnEnter", function()
				f:FadeIn()
			end)
			f:HookScript("OnLeave", function()
				f:FadeOut()
			end)
		end
		SkinButton(f)
	end
end

local collect = CreateFrame("Frame")
collect:RegisterEvent("PLAYER_ENTERING_WORLD")
collect:SetScript("OnEvent", function()
	for _, child in ipairs({Minimap:GetChildren()}) do
		if not BlackList[child:GetName()] then
			if child:GetObjectType() == "Button" and child:GetNumRegions() >= 3 and child:IsShown() then
				child:SetParent(collectFrame)
				tinsert(buttons, child)
			end
		end
	end
	if #buttons == 0 then
		collectFrame:Hide()
	end
	PositionAndStyle()

	if WIM3MinimapButton and WIM3MinimapButton:GetParent() == UIParent and WIM3MinimapButton:GetNumRegions() < 9 then
		SkinButton(WIM3MinimapButton)
		SkinButton(WIM3MinimapButton)
	end
	collect:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)