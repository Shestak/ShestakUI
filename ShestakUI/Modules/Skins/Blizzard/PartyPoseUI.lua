local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	PartyPoseUI skin
----------------------------------------------------------------------------------------
local function SkinPartyPoseFrame(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetPoint("TOPLEFT", -2, UnitFactionGroup("player") == "Horde" and 11 or 15)
	frame.backdrop:SetPoint("BOTTOMRIGHT", 2, -3)
	frame.Border:Hide()

	frame.ModelScene:StripTextures()
	frame.ModelScene:CreateBackdrop("Transparent")

	local rewardFrame = frame.RewardAnimations.RewardFrame
	rewardFrame.NameFrame:SetAlpha(0)
	rewardFrame.IconBorder:SetAlpha(0)
	rewardFrame.Icon:SetPoint("TOPLEFT", -15, -2)
	rewardFrame.Icon:SkinIcon()

	frame.LeaveButton:SkinButton()
end

local function LoadSkin()
	SkinPartyPoseFrame(IslandsPartyPoseFrame)
end

T.SkinFuncs["Blizzard_IslandsPartyPoseUI"] = LoadSkin

local function LoadSecondarySkin()
	SkinPartyPoseFrame(WarfrontsPartyPoseFrame)
end

T.SkinFuncs["Blizzard_WarfrontsPartyPoseUI"] = LoadSecondarySkin