local T, C, L, _ = unpack(select(2, ...))
if C.skins.atlasloot ~= true then return end

----------------------------------------------------------------------------------------
--	AtlasLoot skin(by Max41479)
----------------------------------------------------------------------------------------
local function SkinDropDown(Frame)
	_G[Frame]:StripTextures()
	_G[Frame]:SetTemplate("Transparent", "Shadow")
	T.SkinNextPrevButton(_G[Frame..'-button'])
	local a, b, c, d = _G[Frame..'-button']:GetPoint()
	_G[Frame..'-button']:SetPoint(a, b, c, d - 4, 0)
	_G[Frame]:HookScript('OnUpdate', function()
		for i = 1, 3 do
			local CatFrame = _G['AtlasLoot-DropDown-CatFrame'..i]
			if CatFrame and not CatFrame.IsSkinned then
				local r, g, b = CatFrame:GetBackdropColor()
				CatFrame:StripTextures()
				CatFrame:SetTemplate("Transparent", "Shadow")
				CatFrame:SetBackdropColor(r, g, b)
				CatFrame:HookScript('OnShow', function(self)
					local a, f, c, d, e = self:GetPoint()
					self:SetPoint(a, f, c, d, e - 3)
				end)
				CatFrame:GetScript('OnShow')(CatFrame)
				CatFrame.IsSkinned = true
			end
			local DropdownTitle = _G[Frame..'-title']
			DropdownTitle:ClearAllPoints()
			DropdownTitle:SetPoint("BOTTOMLEFT", _G[Frame], "TOPLEFT", 0, 3)
		end
	end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	if not IsAddOnLoaded("AtlasLoot") then return end

	local AtlasLootFrame = _G["AtlasLoot_GUI-Frame"]
	local AtlasLootItemFrame = _G["AtlasLoot_GUI-ItemFrame"]
	AtlasLootFrame:SetScript("OnUpdate", AL_OnShow)
	AtlasLootItemFrame:CreateBackdrop("Transparent", "Shadow")
	AtlasLootItemFrame.clasFilterButton:CreateBackdrop("Default")

	local StripAllTextures = {
		AtlasLootFrame,
		AtlasLootFrame.titleFrame,
		AtlasLootItemFrame.itemsButton,
		AtlasLootItemFrame.modelButton,
		_G["AtlasLoot-Select-1"],
		_G["AtlasLoot-Select-2"],
		_G["AtlasLoot-Select-3"],
	}

	local SetTemplate = {
		AtlasLootFrame,
		_G["AtlasLoot-Select-1"],
		_G["AtlasLoot-Select-2"],
		_G["AtlasLoot-Select-3"],
	}

	local buttons = {
		AtlasLootItemFrame.itemsButton,
		AtlasLootItemFrame.modelButton,
	}

	for _, object in pairs(StripAllTextures) do
		object:StripTextures()
	end

	for k, object in pairs(SetTemplate) do
		if k < 4 then
			object:SetTemplate("Transparent", "Shadow")
		else
			object:SetTemplate("Transparent")
		end
	end

	for _, button in pairs(buttons) do
		button:SkinButton()
	end

	SkinDropDown('AtlasLoot-DropDown-1')
	SkinDropDown('AtlasLoot-DropDown-2')
	T.SkinCloseButton(AtlasLootFrame.CloseButton)
	T.SkinNextPrevButton(AtlasLootItemFrame.nextPageButton)
	T.SkinNextPrevButton(AtlasLootItemFrame.prevPageButton)
	AtlasLootItemFrame.prevPageButton:ClearAllPoints()
	AtlasLootItemFrame.prevPageButton:SetPoint("BOTTOMLEFT", AtlasLootItemFrame, "BOTTOMLEFT", 3, 3)
	AtlasLootItemFrame.nextPageButton:ClearAllPoints()
	AtlasLootItemFrame.nextPageButton:SetPoint("BOTTOMRIGHT", AtlasLootItemFrame, "BOTTOMRIGHT", -3, 3)
end)
