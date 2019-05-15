local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MacClient panel skin(by Affli)
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsMacClient() then
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton9"])
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton10"])
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton11"])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)