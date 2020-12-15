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

	hooksecurefunc(frame, "SetRewards", function(self)
		for reward in self.rewardsPool:EnumerateActive() do
			if not reward.backdrop then
				reward:CreateBackdrop("Overlay")
				reward.backdrop:SetPoint("TOPLEFT", reward, 2, -15)
				reward.backdrop:SetPoint("BOTTOMRIGHT", reward, -2, 15)

				reward.Toast:SetAlpha(0)
				reward.Highlight:SetAlpha(0)
				reward.CircleMask:Hide()
				reward.IconBorder:SetAlpha(0)

				reward.b = CreateFrame("Frame", nil, reward)
				reward.b:SetTemplate("Default")
				reward.b:SetPoint("TOPLEFT", reward.Icon, "TOPLEFT", -2, 2)
				reward.b:SetPoint("BOTTOMRIGHT", reward.Icon, "BOTTOMRIGHT", 2, -2)
				reward.Icon:SetParent(reward.b)
				reward.Icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
				reward.Check:SetParent(reward.b)
			end
		end
	end)
end

T.SkinFuncs["Blizzard_CovenantRenown"] = LoadSkin