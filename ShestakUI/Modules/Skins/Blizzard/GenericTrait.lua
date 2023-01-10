local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Generic Trait skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = _G.GenericTraitFrame
	T.SkinFrame(frame)

	local function ReplaceIconString(frame, text)
		if not text then text = frame:GetText() end
		if not text or text == "" then return end

		local newText, count = gsub(text, "|T(%d+):24:24[^|]*|t", " |T%1:16:16:0:0:64:64:5:59:5:59|t")
		if count > 0 then frame:SetFormattedText("%s", newText) end
	end

	ReplaceIconString(frame.Currency.UnspentPointsCount)
	hooksecurefunc(frame.Currency.UnspentPointsCount, "SetText", ReplaceIconString)
end

T.SkinFuncs["Blizzard_GenericTraitUI"] = LoadSkin