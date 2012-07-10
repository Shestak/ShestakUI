local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MissingLoot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	_G["MissingLootFrame"]:SetTemplate("Transparent")
	_G["MissingLootFrameCorner"]:Kill()

	T.SkinCloseButton(_G["MissingLootFramePassButton"])

	local function SkinButton()
		local number = GetNumMissingLootItems()
		for i = 1, number do
			local slot = _G["MissingLootFrameItem"..i]
			local icon = slot.icon

			if not slot.isSkinned then
				slot:StripTextures()
				slot:SetTemplate("Default")
				slot:StyleButton()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				icon:SetDrawLayer("ARTWORK")

				slot.isSkinned = true
			end
		end
	end
	hooksecurefunc("MissingLootFrame_Show", SkinButton)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)