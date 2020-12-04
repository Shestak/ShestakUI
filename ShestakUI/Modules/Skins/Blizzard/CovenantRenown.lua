local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Covenant Renown skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = CovenantRenownFrame
	frame:CreateBackdrop("Transparent")
	T.SkinCloseButton(frame.CloseButton)

	hooksecurefunc(frame, "SetUpCovenantData", function(self)
		self.CloseButton.Border:Hide()
		self:StripTextures()
	end)
end

T.SkinFuncs["Blizzard_CovenantRenown"] = LoadSkin