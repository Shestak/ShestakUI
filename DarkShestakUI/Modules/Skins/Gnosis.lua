local T, C, L, _ = unpack(select(2, ...))
if C.skins.gnosis ~= true then return end

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then

		if(_G.Gnosis.lsm) then
			_G.Gnosis.lsm:Register("statusbar", "Texture", "Interface\\Addons\\DarkShestakUI\\Media\\Textures\\Textures")
			_G.Gnosis.lsm:Register("font", "Pixel", "Interface\\Addons\\DarkShestakUI\\Media\\Fonts\\Pixel.ttf", 2)
		end

		GnosisCharConfig.cbconf = {
			["GnosisTarget"] = {
				["fSparkHeightMulti"] = 1.2,
				["rotatertext"] = 0,
				["bShowShield"] = false,
				["bMergeTrade"] = true,
				["fadeout"] = 0.4,
				["colBarBg"] = {C.skins.color_theme[1], C.skins.color_theme[2], C.skins.color_theme[3], 0.4},
				["colSuccess"] = {0.15, 0.25, 0.1, 0.7},
				["incombatsel"] = 1,
				["alignname"] = "LEFT",
				["bnwtypesel"] = 1,
				["colBarNI"] = {0.15, 0.35, 0.35, 0.7},
				["font"] = "Pixel",
				["colFailed"] = {0.7, 0.3, 0.2, 0.75},
				["colTextLag"] = {1, 0, 0, 1},
				["anchortype"] = 2,
				["bShowTicks"] = true,
				["rotatectext"] = 0,
				["strNameFormat"] = "namecol<1,0,0>txm< (>misctxm<)>col<pre>txts< (>tscurtxts</>tstottxts<)>",
				["colShadow"] = {0, 0, 0, 0.7},
				["anchor_y"] = 6,
				["rotatelattext"] = 0,
				["unit"] = "target",
				["scaleicon"] = 1,
				["fontsize"] = 0,
				["bordericon"] = 0,
				["bnwlistnew"] = "",
				["anchorto"] = 2,
				["bartexture"] = "Texture",
				["fontsize_timer"] = 0,
				["colBorderNI"] = {1, 0.8, 0, 0.85},
				["alpha"] = 1,
				["fSparkWidthMulti"] = 0.8,
				["bShowAsMinutes"] = true,
				["colBar"] = {C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 1},
				["rotateicon"] = 0,
				["bShowLat"] = true,
				["anchor"] = {
					["px"] = 0.5,
					["py"] = 0.5274962969621022,
				},
				["bEnShadowCol"] = true,
				["bInvDir"] = false,
				["anchorframe"] = "GnosisPlayer",
				["bEnShadowOffset"] = false,
				["colSpark"] = {1, 1, 1, 1},
				["anchorfrom"] = 8,
				["coord"] = {
					["casticon"] = {
						["y"] = 0,
						["x"] = 7,
					},
					["shadow"] = {
						["y"] = -3,
						["x"] = 3,
					},
					["castname"] = {
						["y"] = 0,
						["x"] = 9,
					},
					["casttime"] = {
						["y"] = 0,
						["x"] = -9,
					},
					["latency"] = {
						["y"] = 1,
						["x"] = -1,
					},
				},
				["cboptver"] = 3.25,
				["forcefreealign"] = false,
				["aligntime"] = "RIGHT",
				["height"] = 16,
				["fontsize_lat"] = 0,
				["colBorder"] = {0, 0, 0, 0.85},
				["spec"] = 0,
				["colText"] = {1, 1, 1, 1},
				["strata"] = "MEDIUM",
				["bEn"] = true,
				["colInterrupted"] = {1, 0.8, 0, 0.7},
				["colTextTime"] = {1, 1, 1, 1},
				["colLagBar"] = {0.9, 0.85, 0.7, 0.65},
				["border"] = 0,
				["bShowPlayerLatency"] = true,
				["bShowCBS"] = true,
				["latbarsize"] = 0.15,
				["bartype"] = "cb",
				["iconside"] = "RIGHT",
				["strGap"] = 15,
				["bExtChannels"] = true,
				["bUnlocked"] = true,
				["bResizeLongName"] = true,
				["fontoutline"] = "OUTLINE, MONOCHROME",
				["bShowWNC"] = false,
				["relationsel"] = 1,
				["ingroupsel"] = 1,
				["alignlat"] = "ADAPT",
				["anchor_x"] = -19,
				["strTimeFormat"] = "col<1,0,0>p<2s>col<pre> r<1m> / t<2m>",
				["width"] = 258,
				["latbarfixed"] = 0.03,
				["bColSuc"] = false,
				["alignment"] = "NAMETIME",
				["bFillup"] = false,
				["orient"] = 1,
				["bIconUnlocked"] = true,
				["bnwlist"] = {},
				["scale"] = 1,
			},
			["GnosisPlayer"] = {
				["fSparkHeightMulti"] = 1.2,
				["rotatertext"] = 0,
				["bShowShield"] = false,
				["bMergeTrade"] = true,
				["fadeout"] = 0.4,
				["colBarBg"] = {C.skins.color_theme[1], C.skins.color_theme[2], C.skins.color_theme[3], 0.4},
				["colSuccess"] = {0.15, 0.25, 0.1, 0.7},
				["incombatsel"] = 1,
				["alignname"] = "LEFT",
				["bnwtypesel"] = 1,
				["colBarNI"] = {0.15, 0.35, 0.35, 0.7},
				["font"] = "Pixel",
				["colFailed"] = {0.7, 0.3, 0.2, 0.75},
				["colTextLag"] = {1, 0, 0, 1},
				["anchortype"] = 2,
				["bShowTicks"] = true,
				["rotatectext"] = 0,
				["strNameFormat"] = "namecol<1,0,0>txm< (>misctxm<)>col<pre>txts< (>tscurtxts</>tstottxts<)>",
				["colShadow"] = {0, 0, 0, 0.7},
				["anchor_y"] = 152,
				["rotatelattext"] = 0,
				["unit"] = "player",
				["scaleicon"] = 1,
				["fontsize"] = 0,
				["bordericon"] = 0,
				["bnwlistnew"] = "",
				["anchorto"] = 2,
				["bartexture"] = "Texture",
				["fontsize_timer"] = 0,
				["colBorderNI"] = {1, 0.8, 0, 0.85},
				["alpha"] = 1,
				["fSparkWidthMulti"] = 0.8,
				["bShowAsMinutes"] = true,
				["colBar"] = {C.unitframe.uf_color[1], C.unitframe.uf_color[2], C.unitframe.uf_color[3], 1},
				["rotateicon"] = 0,
				["bShowLat"] = true,
				["anchor"] = {
					["px"] = 0.5,
					["py"] = 0.5824888908863067,
				},
				["bEnShadowCol"] = true,
				["bInvDir"] = false,
				["anchorframe"] = "ActionBarAnchor",
				["bEnShadowOffset"] = false,
				["colSpark"] = {1, 1, 1, 1},
				["anchorfrom"] = 8,
				["coord"] = {
					["casticon"] = {
						["y"] = 0,
						["x"] = -7,
					},
					["shadow"] = {
						["y"] = -3,
						["x"] = 3,
					},
					["castname"] = {
						["y"] = 0,
						["x"] = 9,
					},
					["casttime"] = {
						["y"] = 0,
						["x"] = -9,
					},
					["latency"] = {
						["y"] = 1,
						["x"] = -1,
					},
				},
				["cboptver"] = 3.25,
				["forcefreealign"] = false,
				["aligntime"] = "RIGHT",
				["height"] = 16,
				["fontsize_lat"] = 0,
				["colBorder"] = {0, 0, 0, 0.85},
				["spec"] = 0,
				["colText"] = {1, 1, 1, 1},
				["strata"] = "MEDIUM",
				["bEn"] = true,
				["colInterrupted"] = {1, 0.8, 0, 0.7},
				["colTextTime"] = {1, 1, 1, 1},
				["colLagBar"] = {0.9, 0.85, 0.7, 0.65},
				["border"] = 0,
				["bShowPlayerLatency"] = true,
				["bShowCBS"] = true,
				["latbarsize"] = 0.15,
				["bartype"] = "cb",
				["iconside"] = "LEFT",
				["strGap"] = 15,
				["bExtChannels"] = true,
				["bUnlocked"] = true,
				["bResizeLongName"] = true,
				["fontoutline"] = "OUTLINE, MONOCHROME",
				["bShowWNC"] = false,
				["relationsel"] = 1,
				["ingroupsel"] = 1,
				["alignlat"] = "ADAPT",
				["anchor_x"] = 9,
				["strTimeFormat"] = "col<1,0,0>p<2s>col<pre> r<1m> / t<2m>",
				["width"] = 258,
				["latbarfixed"] = 0.03,
				["bColSuc"] = false,
				["alignment"] = "NAMETIME",
				["bFillup"] = false,
				["orient"] = 1,
				["bIconUnlocked"] = true,
				["bnwlist"] = {},
				["scale"] = 1,
			},
		}

		oUF_Player_Castbar:Kill()
		oUF_Target_Castbar:Kill()

		GnosisPlayer.Overlay = CreateFrame("Frame", nil, GnosisPlayer)
		GnosisPlayer.Overlay:SetTemplate("Default", "Shadow")
		GnosisPlayer.Overlay:SetFrameLevel(1)
		GnosisPlayer.Overlay:SetFrameStrata("BACKGROUND")
		GnosisPlayer.Overlay:SetPoint("TOPLEFT", -2, 2)
		GnosisPlayer.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)

		GnosisPlayer.Button = CreateFrame("Frame", nil, GnosisPlayer)
		GnosisPlayer.Button:SetHeight(20)
		GnosisPlayer.Button:SetWidth(20)
		GnosisPlayer.Button:SetTemplate("Default", "Shadow")

		GnosisPlayer.Icon = GnosisPlayer.Button:CreateTexture(nil, "ARTWORK")
		GnosisPlayer.Icon:SetPoint("TOPLEFT", GnosisPlayer.Button, 2, -2)
		GnosisPlayer.Icon:SetPoint("BOTTOMRIGHT", GnosisPlayer.Button, -2, 2)
		GnosisPlayer.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		GnosisPlayer.Button:SetPoint("RIGHT", GnosisPlayer, "LEFT", -5, 0)
		-- Target
		GnosisTarget.Overlay = CreateFrame("Frame", nil, GnosisTarget)
		GnosisTarget.Overlay:SetTemplate("Default", "Shadow")
		GnosisTarget.Overlay:SetFrameLevel(1)
		GnosisTarget.Overlay:SetFrameStrata("BACKGROUND")
		GnosisTarget.Overlay:SetPoint("TOPLEFT", -2, 2)
		GnosisTarget.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)

		GnosisTarget.Button = CreateFrame("Frame", nil, GnosisTarget)
		GnosisTarget.Button:SetHeight(20)
		GnosisTarget.Button:SetWidth(20)
		GnosisTarget.Button:SetTemplate("Default", "Shadow")

		GnosisTarget.Icon = GnosisTarget.Button:CreateTexture(nil, "ARTWORK")
		GnosisTarget.Icon:SetPoint("TOPLEFT", GnosisTarget.Button, 2, -2)
		GnosisTarget.Icon:SetPoint("BOTTOMRIGHT", GnosisTarget.Button, -2, 2)
		GnosisTarget.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		GnosisTarget.Button:SetPoint("LEFT", GnosisTarget, "RIGHT", 5, 0)

		_G.Gnosis:SetBarParams("GnosisPlayer")
		_G.Gnosis:SetBarParams("GnosisTarget")

		frame:UnregisterEvent("PLAYER_LOGIN")

	end
end)
