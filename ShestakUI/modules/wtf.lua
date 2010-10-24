----------------------------------------------------------------------------------------
--	MSBT settings
----------------------------------------------------------------------------------------
local UploadMSBT = function()
	if(MSBTProfiles_SavedVars) then table.wipe(MSBTProfiles_SavedVars) end
	if(MSBT_SavedMedia) then table.wipe(MSBT_SavedMedia) end
	MSBTProfiles_SavedVars = {
		["profiles"] = {
			["Default"] = {
				["powerThrottleDuration"] = 5,
				["normalOutlineIndex"] = 2,
				["partialColoringDisabled"] = true,
				["alwaysShowQuestItems"] = false,
				["hideFullOverheals"] = true,
				["normalFontSize"] = 16,
				["scrollAreas"] = {
					["Incoming"] = {
						["scrollHeight"] = 250,
						["offsetX"] = -215,
						["animationStyle"] = "Straight",
						["behavior"] = "MSBT_NORMAL",
						["offsetY"] = 151,
						["skillIconsDisabled"] = true,
						["direction"] = "Up",
					},
					["Outgoing"] = {
						["scrollHeight"] = 250,
						["offsetX"] = 174,
						["animationStyle"] = "Straight",
						["behavior"] = "MSBT_NORMAL",
						["offsetY"] = 151,
						["skillIconsDisabled"] = true,
						["direction"] = "Up",
					},
					["Notification"] = {
						["offsetX"] = -176,
						["offsetY"] = 201,
					},
					["Static"] = {
						["offsetX"] = -7,
						["offsetY"] = -33,
					},
				},
				["soundsDisabled"] = true,
				["hideMergeTrailer"] = true,
				["triggers"] = {
					["MSBT_TRIGGER_RIPOSTE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_KILL_SHOT"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_DECIMATION"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_BACKLASH"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_OVERPOWER"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_RAMPAGE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_RIME"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_RUNE_STRIKE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_PREDATORS_SWIFTNESS"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_ECLIPSE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_LOW_HEALTH"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_TIDAL_WAVES"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_VIPER_STING"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_NIGHTFALL"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_HOT_STREAK"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_LOW_MANA"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_SUDDEN_DEATH"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_IMPACT"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_OWLKIN_FRENZY"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_BRAIN_FREEZE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_ERADICATION"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_KILLING_MACHINE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_PVP_TRINKET"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_MISSILE_BARRAGE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_VICTORY_RUSH"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_BLOODSURGE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_CLEARCASTING"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_MOLTEN_CORE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_FINGERS_OF_FROST"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_COUNTER_ATTACK"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_HAMMER_OF_WRATH"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_REVENGE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_EXECUTE"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["MSBT_TRIGGER_FROSTBITE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
						["disabled"] = true,
					},
				},
				["regenAbilitiesDisabled"] = true,
				["critFontName"] = "ShestakUI",
				["hotThrottleDuration"] = 5,
				["critOutlineIndex"] = 2,
				["animationSpeed"] = 140,
				["skillIconsDisabled"] = true,
				["dotThrottleDuration"] = 5,
				["creationVersion"] = "5.4.75",
				["critFontSize"] = 16,
				["hideSkills"] = true,
				["events"] = {
					["NOTIFICATION_COMBAT_ENTER"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_PC_KILLING_BLOW"] = {
						["disabled"] = true,
						["fontSize"] = false,
					},
					["NOTIFICATION_MONEY"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_REP_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_DEBUFF_FADE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_REP_LOSS"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_BUFF"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_LOOT"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_SOUL_SHARD_CREATED"] = {
						["disabled"] = true,
						["fontSize"] = false,
					},
					["OUTGOING_EVADE"] = {
						["fontSize"] = 16,
					},
					["NOTIFICATION_SKILL_GAIN"] = {
						["disabled"] = true,
					},
					["INCOMING_HEAL_CRIT"] = {
						["fontSize"] = false,
					},
					["NOTIFICATION_POWER_LOSS"] = {
						["disabled"] = true,
					},
					["OUTGOING_HEAL_CRIT"] = {
						["fontSize"] = false,
					},
					["NOTIFICATION_DEBUFF_STACK"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_ITEM_BUFF_FADE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_EXPERIENCE_GAIN"] = {
						["fontSize"] = false,
					},
					["NOTIFICATION_BUFF_FADE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_MONSTER_EMOTE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_COMBAT_LEAVE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_POWER_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_CP_FULL"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["NOTIFICATION_ENEMY_BUFF"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_BUFF_STACK"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_EXTRA_ATTACK"] = {
						["disabled"] = true,
						["fontSize"] = false,
					},
					["NOTIFICATION_COOLDOWN"] = {
						["disabled"] = true,
						["fontSize"] = 16,
					},
					["NOTIFICATION_ITEM_BUFF"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_CP_GAIN"] = {
						["disabled"] = true,
					},
					["PET_OUTGOING_EVADE"] = {
						["fontSize"] = false,
					},
					["NOTIFICATION_HONOR_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_DEBUFF"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_NPC_KILLING_BLOW"] = {
						["fontSize"] = false,
					},
				},
				["cooldownThreshold"] = 60,
				["hideNames"] = true,
				["normalFontName"] = "ShestakUI",
				["healThreshold"] = 1000,
				["qualityExclusions"] = {
					true, -- [1]
				},
			},
		},
	}
	MSBT_SavedMedia = {
		["fonts"] = {
			["ShestakUI"] = "Interface\\AddOns\\ShestakUI\\media\\pixel.ttf",
		},
		["sounds"] = {
		},
	}
end

----------------------------------------------------------------------------------------
--	Skada settings
----------------------------------------------------------------------------------------
local UploadSkada = function()
	if(SkadaDB) then table.wipe(SkadaDB) end
	SkadaDB = {
		["profiles"] = {
			["Default"] = {
				["modules"] = {
					["notankwarnings"] = true,
				},
				["hidepvp"] = true,
				["windows"] = {
					{
						["point"] = "BOTTOMRIGHT",
						["barmax"] = 7,
						["scale"] = 1,
						["barfontsize"] = 8,
						["y"] = 147,
						["x"] = -247,
						["title"] = {
							["fontsize"] = 8,
							["borderthickness"] = 0,
							["texture"] = "Blizzard",
						},
						["barheight"] = 12,
						["spark"] = false,
						["enabletitle"] = false,
						["barwidth"] = 217,
						["bartexture"] = "Blizzard",
					}, -- [1]
				},
				["tooltippos"] = "topleft",
				["icon"] = {
					["hide"] = true,
				},
				["showranks"] = false,
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	Recount settings
----------------------------------------------------------------------------------------
local UploadRecount = function()
	if(RecountDB) then table.wipe(RecountDB) end
	RecountDB = {
		["profiles"] = {
			["Default"] = {
				["GraphWindowY"] = 0,
				["MainWindow"] = {
					["Position"] = {
						["y"] = -305,
						["x"] = 284,
						["w"] = 221,
						["h"] = 178,
					},
					["RowSpacing"] = 7,
					["Buttons"] = {
						["FileButton"] = false,
						["ReportButton"] = false,
					},
					["BarText"] = {
						["NumFormat"] = 3,
					},
				},
				["Colors"] = {
					["Window"] = {
						["Background"] = {
							["a"] = 0,
						},
						["Title"] = {
							["a"] = 0,
						},
					},
					["Bar"] = {
						["Bar Text"] = {
							["a"] = 1,
						},
						["Total Bar"] = {
							["a"] = 1,
						},
					},
				},
				["DetailWindowY"] = 0,
				["DetailWindowX"] = 0,
				["CurDataSet"] = "OverallData",
				["BarTexture"] = "Flat",
				["GraphWindowX"] = 0,
				["MainWindowWidth"] = 221,
				["MainWindowHeight"] = 178,
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	DXE settings
----------------------------------------------------------------------------------------
local UploadDXE = function()
	if(DXEDB) then table.wipe(DXEDB) end
	if(DXEIconDB) then table.wipe(DXEIconDB) end
	DXEDB = {
		["profiles"] = {
			["Default"] = {
				["Positions"] = {
					["DXEPane"] = {
						["yOfs"] = -20,
						["xOfs"] = 20,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["DXEAlertsTopStackAnchor"] = {
						["point"] = "BOTTOMLEFT",
						["relativePoint"] = "BOTTOMLEFT",
						["yOfs"] = 185,
						["xOfs"] = 21,
					},
					["DXEArrowsAnchor2"] = {
						["yOfs"] = -34,
						["xOfs"] = -111,
					},
					["DXEAlertsCenterStackAnchor"] = {
						["yOfs"] = 25,
						["xOfs"] = 3,
					},
					["DXEArrowsAnchor1"] = {
						["yOfs"] = -34,
						["xOfs"] = -4,
					},
					["DXEArrowsAnchor3"] = {
						["yOfs"] = -34,
						["xOfs"] = 98,
					},
				},
				["Pane"] = {
					["Show"] = false,
				},
			},
		},
	}
	DXEIconDB = {
		["hide"] = true,
	}
end

StaticPopupDialogs["SETTINGS_ALL"] = {
	text = L_POPUP_SETTINGS_ALL,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = function() SettingsDB.UploadDBM() UploadMSBT() UploadSkada() UploadRecount() UploadDXE() ReloadUI() end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}

local pr = function(msg)
    print(tostring(msg))
end

SLASH_SETTINGS1 = "/settings"
SlashCmdList["SETTINGS"] = function(msg)
    if(msg == "dbm") then
		SettingsDB.UploadDBM()
		ReloadUI()
	elseif(msg == "msbt") then
		UploadMSBT()
		ReloadUI()
	elseif(msg == "skada") then
		UploadSkada()
		ReloadUI()
	elseif(msg == "recount") then
		UploadRecount()
		ReloadUI()
	elseif(msg == "dxe") then
		UploadDXE()
		ReloadUI()
	elseif(msg == "all") then
		StaticPopup_Show("SETTINGS_ALL")
	else
		pr("|cffffff00"..L_INFO_SETTINGS_DBM.."|r")
		pr("|cffffff00"..L_INFO_SETTINGS_MSBT.."|r")
		pr("|cffffff00"..L_INFO_SETTINGS_SKADA.."|r")
		pr("|cffffff00"..L_INFO_SETTINGS_RECOUNT.."|r")
		pr("|cffffff00"..L_INFO_SETTINGS_DXE.."|r")
		pr("|cffffff00"..L_INFO_SETTINGS_ALL.."|r")
	end
end