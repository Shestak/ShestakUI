local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Anima Diversion skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = AnimaDiversionFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:CreateBackdrop("Transparent")

	frame.AnimaDiversionCurrencyFrame.Background:SetAlpha(0)
	frame.ReinforceInfoFrame.AnimaNodeReinforceButton:SkinButton()

	hooksecurefunc(AnimaDiversionFrame, "SetupCurrencyFrame", function()
		local cur = AnimaDiversionFrame.AnimaDiversionCurrencyFrame.CurrencyFrame.Quantity

		local text = cur and cur:GetText()
		if not text or text == '' then return end
		local new, count = gsub(text, "|T([^:]-):[%d+:]+|t", "|T%1:14:14:0:0:64:64:5:59:5:59|t")
		if count > 0 then cur:SetFormattedText("%s", new) end
	end)
end

T.SkinFuncs["Blizzard_AnimaDiversionUI"] = LoadSkin