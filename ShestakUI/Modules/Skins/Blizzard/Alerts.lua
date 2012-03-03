local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Tutorial skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local function SkinAchievePopUp()
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["AchievementAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
					frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
				else
					frame.backdrop:SetBackdropColor(unpack(C.media.overlay_color))
				end

				frame:HookScript("OnShow", function()
					frame.backdrop:SetBackdropColor(unpack(C.media.overlay_color))
				end)

				-- Background
				_G["AchievementAlertFrame"..i.."Background"]:SetTexture(nil)
				_G["AchievementAlertFrame"..i.."Glow"]:Kill()
				_G["AchievementAlertFrame"..i.."Shine"]:Kill()

				-- Text
				_G["AchievementAlertFrame"..i.."Name"]:SetTextColor(1, 0.8, 0)
				_G["AchievementAlertFrame"..i.."Name"]:SetFont(C.media.normal_font, 11)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetFont(C.media.normal_font, 11)

				-- Icon
				_G["AchievementAlertFrame"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["AchievementAlertFrame"..i.."IconOverlay"]:Kill()
				_G["AchievementAlertFrame"..i.."IconTexture"]:ClearAllPoints()
				_G["AchievementAlertFrame"..i.."IconTexture"]:Point("LEFT", frame, 7, 0)

				if not _G["AchievementAlertFrame"..i.."IconTexture"].b then
					_G["AchievementAlertFrame"..i.."IconTexture"].b = CreateFrame("Frame", nil, _G["AchievementAlertFrame"..i])
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetFrameLevel(0)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetTemplate("Default")
					_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("TOPLEFT", _G["AchievementAlertFrame"..i.."IconTexture"], "TOPLEFT", -2, 2)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("BOTTOMRIGHT", _G["AchievementAlertFrame"..i.."IconTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AchievementAlertFrame_FixAnchors", SkinAchievePopUp)

	function SkinDungeonPopUp()
		for i = 1, DUNGEON_COMPLETION_MAX_REWARDS do
			local frame = _G["DungeonCompletionAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Transparent")
					frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", 16, -6)
					frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 6)
				end

				-- Background
				for i = 1, frame:GetNumRegions() do
					local region = select(i, frame:GetRegions())
					if region:GetObjectType() == "Texture" then
						if region:GetTexture() == "Interface\\LFGFrame\\UI-LFG-DUNGEONTOAST" or region:GetTexture() == "Interface\\LFGFrame\\LFR-Texture" then
							region:Kill()
						end
					end
				end

				_G["DungeonCompletionAlertFrame"..i.."Shine"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"].glow:Kill()
				_G["DungeonCompletionAlertFrame"..i].raidArt:Kill()

				-- Icon
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				if not _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b then
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b = CreateFrame("Frame", nil, _G["DungeonCompletionAlertFrame"..i])
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetFrameLevel(0)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetTemplate("Default")
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("TOPLEFT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "TOPLEFT", -2, 2)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("BOTTOMRIGHT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("DungeonCompletionAlertFrame_FixAnchors", SkinDungeonPopUp)

	function SkinChallengePopUp()
		local frame = _G["GuildChallengeAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Transparent")
				frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
				frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
			end

			-- Background
			local region = select(2, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\GuildFrame\\GuildChallenges" then
					region:Kill()
				end
			end

			_G["GuildChallengeAlertFrameGlow"]:Kill()
			_G["GuildChallengeAlertFrameShine"]:Kill()
			_G["GuildChallengeAlertFrameEmblemBorder"]:Kill()

			-- Icon border
			if not _G["GuildChallengeAlertFrameEmblemIcon"].b then
				_G["GuildChallengeAlertFrameEmblemIcon"].b = CreateFrame("Frame", nil, _G["GuildChallengeAlertFrame"])
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetFrameLevel(0)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetTemplate("Default")
				_G["GuildChallengeAlertFrameEmblemIcon"].b:Point("TOPLEFT", _G["GuildChallengeAlertFrameEmblemIcon"], "TOPLEFT", -3, 3)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:Point("BOTTOMRIGHT", _G["GuildChallengeAlertFrameEmblemIcon"], "BOTTOMRIGHT", 3, -2)
			end

			SetLargeGuildTabardTextures("player", GuildChallengeAlertFrameEmblemIcon, nil, nil)
		end
	end
	hooksecurefunc("GuildChallengeAlertFrame_FixAnchors", SkinChallengePopUp)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)