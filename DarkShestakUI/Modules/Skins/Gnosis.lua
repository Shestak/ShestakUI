local T, C, L, _ = unpack(select(2, ...))
--if C.skins.gnosis ~= true then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
-- Player
GnosisCharConfig.cbconf.GnosisPlayer.bordericon = 0
GnosisCharConfig.cbconf.GnosisPlayer.border = 0
GnosisCharConfig.cbconf.GnosisPlayer.height = 16
GnosisCharConfig.cbconf.GnosisPlayer.width = 258
-- Target
GnosisCharConfig.cbconf.GnosisTarget.bordericon = 0
GnosisCharConfig.cbconf.GnosisTarget.border = 0
GnosisCharConfig.cbconf.GnosisTarget.height = 16
GnosisCharConfig.cbconf.GnosisTarget.width = 258
-- Player
--GnosisPlayer:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
GnosisPlayer.Overlay = CreateFrame("Frame", nil, GnosisPlayer)
GnosisPlayer.Overlay:SetTemplate("Default", "Shadow")
GnosisPlayer.Overlay:SetFrameLevel(1)
GnosisPlayer.Overlay:SetFrameStrata("BACKGROUND")
GnosisPlayer.Overlay:SetPoint("TOPLEFT", -2, 2)
GnosisPlayer.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)
-- Target
GnosisTarget.Overlay = CreateFrame("Frame", nil, GnosisTarget)
GnosisTarget.Overlay:SetTemplate("Default", "Shadow")
GnosisTarget.Overlay:SetFrameLevel(1)
GnosisTarget.Overlay:SetFrameStrata("BACKGROUND")
GnosisTarget.Overlay:SetPoint("TOPLEFT", -2, 2)
GnosisTarget.Overlay:SetPoint("BOTTOMRIGHT", 2, -2)
end)

local Gnosis = _G["Gnosis"]
function _G.Gnosis:SetBarParams(name, cfgtab, bartab)
	local bar = bartab and self[bartab][name] or self.castbars[name];
	local tParams = cfgtab and self.s[cfgtab][name] or self.s.cbconf[name];
	bar.conf = tParams;

	-- clean up bar if multi-spell timer
	if (tParams.bartype == "ti") then
		self:CleanupCastbar(bar);
	end

	-- setup bar parameters
	bar:SetWidth(tParams.width);
	bar:SetHeight(tParams.height);

	-- status bar
	bar.barwidth = tParams.width;
	bar.barheight = tParams.height;
	bar.bar:SetHeight(tParams.height);
	bar.bar:SetWidth(1000);

	-- bar texture
	bar.bar:SetStatusBarTexture(self.lsm:Fetch("statusbar", tParams.bartexture), "BORDER");
	bar.bar:SetStatusBarColor(unpack(tParams.colBar));

	-- statusbar orienation
	if (tParams.orient == 2) then
		bar.bar:SetOrientation("VERTICAL", tParams.bInvDir);
	else
		bar.bar:SetOrientation("HORIZONTAL", tParams.bInvDir);
	end

	bar.bar:ClearAllPoints();
	bar.bar:SetAllPoints(bar);

	-- bar border
	local bsize, bnsize = tParams.border, -tParams.border;
	local bisize, binsize = tParams.bIconUnlocked and tParams.bordericon or bsize, tParams.bIconUnlocked and -tParams.bordericon or bnsize;
	self:SetBarBorder(bar, bsize);

	-- bar background
	bar.bbg:ClearAllPoints();
	bar.bbg:SetAllPoints(bar);

	-- icon
	bar.icon:ClearAllPoints();
	bar.bicon:ClearAllPoints();
	bar.bicon:ClearAllPoints();
	bar.icon:SetTexture(tParams.bUnlocked and self.toyIcon or nil);
	if (tParams.iconside ~= "NONE") then
		local iconside_ =
			(tParams.iconside == "LEFT" and "RIGHT") or
			(tParams.iconside == "RIGHT" and "LEFT") or
			(tParams.iconside == "TOP" and "BOTTOM") or
			(tParams.iconside == "BOTTOM" and "TOP");

		local bileft, biright, bitop, bibottom =
				tParams.iconside == "RIGHT" and 0.0 or 1.0,
				tParams.iconside == "LEFT" and 0.0 or 1.0,
				tParams.iconside == "BOTTOM" and 0.0 or 1.0,
				tParams.iconside == "TOP" and 0.0 or 1.0;

		if (not tParams.bIconUnlocked) then
			-- locked to barframe
			local iconsize_ = abs(bileft - biright) * tParams.height + abs(bitop - bibottom) * tParams.width;

			bar.icon:SetPoint(iconside_, bar, tParams.iconside, (biright - bileft) * bisize, (bitop - bibottom) * bisize);
			bar.icon:SetWidth(iconsize_);
			bar.icon:SetHeight(iconsize_);
			bar.sicon:SetWidth(1.85 * iconsize_);
			bar.sicon:SetHeight(3.275 * iconsize_);
			bar.bicon:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -bileft * bisize, bitop * bisize);
			bar.bicon:SetPoint("BOTTOMRIGHT", bar.icon, "BOTTOMRIGHT", biright * bisize, -bibottom * bisize);
		else
			-- unlocked
			local x_, y_ =
				tParams.bIconUnlocked and tParams.coord.casticon.x or 0,
				tParams.bIconUnlocked and tParams.coord.casticon.y or 0;
			local scale_ = tParams.scaleicon;
			local iconsize_ = min(tParams.height, tParams.width) * scale_;

			bar.icon:SetPoint(iconside_, bar, tParams.iconside, ((biright - bileft) * bisize + x_) * scale_, ((bitop - bibottom) * bisize + y_) * scale_);
			bar.icon:SetWidth(iconsize_);
			bar.icon:SetHeight(iconsize_);
			bar.sicon:SetWidth(1.85 * iconsize_);
			bar.sicon:SetHeight(3.275 * iconsize_);
			bar.bicon:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -bisize * scale_, bisize * scale_);
			bar.bicon:SetPoint("BOTTOMRIGHT", bar.icon, "BOTTOMRIGHT", bisize * scale_, -bisize * scale_);
		end

		bar.icon:Show();
		bar.bicon:Show();
	else
		bar.icon:Hide();
		bar.bicon:Hide();
	end

	-- icon rotate
	self:Rotate(bar.iag, bar.ian, tParams.bIconUnlocked and tParams.rotateicon or 0);
	self:Rotate(bar.biag, bar.bian, tParams.bIconUnlocked and tParams.rotateicon or 0);
	self:Rotate(bar.siag, bar.sian, tParams.bIconUnlocked and tParams.rotateicon or 0);

	-- text rotate
	self:Rotate(bar.ctag, bar.ctan, tParams.rotatectext);
	self:Rotate(bar.rtag, bar.rtan, tParams.rotatertext);
	self:Rotate(bar.bltag, bar.bltan, tParams.rotatelattext);
	self:Rotate(bar.brtag, bar.brtan, tParams.rotatelattext);

	local curFont = GameFontNormal:GetFont();
	if (tParams.font) then
		curFont = self.lsm:Fetch("font", tParams.font);
	end
	local fo = nil;
	if (tParams.fontoutline and self.fontoutlines[tParams.fontoutline] and self.fontoutlines[tParams.fontoutline] ~= "NONE") then
		fo = self.fontoutlines[tParams.fontoutline];
	end
	local fssizeparam = tParams.orient == 2 and tParams.width or tParams.height;
	local fs = fssizeparam <= 40 and fssizeparam or 40;
	if (tParams.fontsize and tParams.fontsize > 0) then
		bar.ctext:SetFont(curFont, tParams.fontsize, fo);
		bar.defFS = tParams.fontsize;
	else
		bar.ctext:SetFont(curFont, max(fs*0.65,1), fo);
		bar.defFS = fs * 0.65;
	end

	bar.defFont = curFont;
	bar.defFO = fo;

	fs = fssizeparam <= 40 and fssizeparam or 40;
	-- timer
	if (tParams.fontsize_timer and tParams.fontsize_timer > 0) then
		bar.rtext:SetFont(curFont, tParams.fontsize_timer, fo);
	else
		bar.rtext:SetFont(curFont, max(fs*0.55,1), fo);
	end
	-- latency
	if (tParams.fontsize_lat and tParams.fontsize_lat > 0) then
		bar.brtext:SetFont(curFont, tParams.fontsize_lat, fo);
		bar.bltext:SetFont(curFont, tParams.fontsize_lat, fo);
	else
		bar.brtext:SetFont(curFont, max(fs/2*0.85,1), fo);
		bar.bltext:SetFont(curFont, max(fs/2*0.85,1), fo);
	end

	for i = 1, 15 do
		if(tParams.orient == 2) then
			bar.lb[i]:SetWidth(tParams.width);
		else
			bar.lb[i]:SetHeight(tParams.height);
		end
		bar.lb[i]:SetTexture(unpack(tParams.colLagBar));
	end

	-- castbar spark
	if (tParams.orient == 2) then
		bar.cbs:SetWidth(tParams.fSparkHeightMulti * tParams.width * 0.3);	-- 0.3
		bar.cbs:SetHeight(tParams.fSparkWidthMulti * tParams.width *  1.6);	-- 1.6
		self:Rotate(bar.cbsag, bar.cbsan, 90);
	else
		bar.cbs:SetWidth(tParams.fSparkWidthMulti * tParams.height * 0.4);
		bar.cbs:SetHeight(tParams.fSparkHeightMulti * tParams.height * 1.5);
		self:Rotate(bar.cbsag, bar.cbsan, 0);
	end

	bar.cbs:SetVertexColor(unpack(tParams.colSpark));
	bar:SetScale(tParams.scale);

	if (not tParams.bShowCBS) then
		bar.cbs:Hide();
	end

	-- border texture
	bar.bdframe:Hide();
	bar.backdrop.edgeFile = self.lsm:Fetch("border", tParams.bordertexture);
	if (bar.backdrop.edgeFile) then
		bar.bdframe:ClearAllPoints();
		bar.bdframe:SetPoint("TOPLEFT", bar, -4, 4);
		bar.bdframe:SetPoint("BOTTOMRIGHT", bar, 4, -4);
		bar.bdframe:SetBackdrop(bar.backdrop);
		bar.bdframe:Show();
		bar.bdframe:SetFrameLevel(10);
	end

	-- set border color
	self:SetBorderColor(bar, tParams.colBorder, tParams.colBarBg, not tParams.bUnlocked and tParams.bShowWNC);

	-- text colors
	bar.ctext:SetTextColor(unpack(tParams.colText));
	bar.rtext:SetTextColor(unpack(tParams.colTextTime and tParams.colTextTime or tParams.colText));
	bar.brtext:SetTextColor(unpack(tParams.colTextLag and tParams.colTextLag or tParams.colText));
	bar.bltext:SetTextColor(unpack(tParams.colTextLag and tParams.colTextLag or tParams.colText));

	-- text shadow
	if (tParams.bEnShadowOffset) then
		bar.ctext:SetShadowOffset(tParams.coord.shadow.x, tParams.coord.shadow.y);
		bar.rtext:SetShadowOffset(tParams.coord.shadow.x, tParams.coord.shadow.y);
		bar.brtext:SetShadowOffset(tParams.coord.shadow.x, tParams.coord.shadow.y);
		bar.bltext:SetShadowOffset(tParams.coord.shadow.x, tParams.coord.shadow.y);
	end

	if (tParams.bEnShadowCol) then
		bar.ctext:SetShadowColor(unpack(tParams.colShadow));
		bar.rtext:SetShadowColor(unpack(tParams.colShadow));
		bar.brtext:SetShadowColor(unpack(tParams.colShadow));
		bar.bltext:SetShadowColor(unpack(tParams.colShadow));
	end

	-- anchor bar
	self:AnchorBar(name);

	-- bar alpha
	bar:SetAlpha(tParams.alpha);

	-- setup by bar type
	bar.ctext:ClearAllPoints();
	bar.rtext:ClearAllPoints();

	-- alignments
	tParams.forcefreealign = (tParams.rotatectext ~= 0 or tParams.rotatertext ~= 0);
	if (tParams.alignment == "FREE" or tParams.forcefree) then
		bar.rtext:SetPoint(tParams.aligntime, bar, tParams.coord["casttime"].x, tParams.coord["casttime"].y);
		bar.ctext:SetPoint(tParams.alignname, bar, tParams.coord["castname"].x, tParams.coord["castname"].y);
	elseif (tParams.alignment == "TIMENAME") then
		bar.rtext:SetPoint("LEFT", bar, "LEFT", tParams.coord["casttime"].x, tParams.coord["casttime"].y);
		bar.ctext:SetPoint("RIGHT", bar, "RIGHT", tParams.coord["castname"].x, tParams.coord["castname"].y);
		if (tParams.alignname == "LEFT" or tParams.alignname == "CENTER") then
			bar.ctext:SetPoint("LEFT", bar.rtext, "RIGHT", 0, 0);
		else
			bar.rtext:SetPoint("RIGHT", bar.ctext, "LEFT", 0, 0);
		end
	else
		bar.rtext:SetPoint("RIGHT", bar, "RIGHT", tParams.coord["casttime"].x, tParams.coord["casttime"].y);
		bar.ctext:SetPoint("LEFT", bar, "LEFT", tParams.coord["castname"].x, tParams.coord["castname"].y);
		if (tParams.alignname == "RIGHT" or tParams.alignname == "CENTER") then
			bar.ctext:SetPoint("RIGHT", bar.rtext, "LEFT", 0, 0);
		else
			bar.rtext:SetPoint("LEFT", bar.ctext, "RIGHT", 0, 0);
		end
	end

	bar.ctext:SetJustifyH(tParams.alignname);
	bar.rtext:SetJustifyH(tParams.aligntime);

	-- default center text
	bar.ctext:SetText(tParams.bUnlocked and bar.name or "");

	-- latency text blocks
	bar.brtext:SetPoint("BOTTOMRIGHT", bar, tParams.coord["latency"].x, tParams.coord["latency"].y);
	bar.bltext:SetPoint("BOTTOMLEFT", bar, -tParams.coord["latency"].x, tParams.coord["latency"].y);

	if (tParams.strata) then
		bar:SetFrameStrata(tParams.strata);
	end

	if (not tParams.bEn or (self.iCurSpec and tParams.spec > 0 and tParams.spec ~= self.iCurSpec)) then
		self:CleanupCastbar(bar);
		bar:Hide();		-- bar disabled
	else
		if (tParams.bUnlocked) then
			self:MakeBarMovable(name, true);
			bar:Show();
		elseif (tParams.bShowWNC) then
			self:MakeBarMovable(name, false);
			bar:Show();
		elseif (not bar.bIsActive) then
			self:MakeBarMovable(name, false);
			bar:Hide();
		end
	end

	-- default format strings
	bar.nfs = tParams.strNameFormat;
	bar.tfs = tParams.strTimeFormat;
	self:GenerateTimeTable(bar, true);

	-- castbar? if not set bnIsCB to true
	if (tParams.unit == "gcd" or tParams.unit == "gcd2" or
		tParams.unit == "sm" or tParams.unit == "sr" or tParams.unit == "smr") then
		bar.bnIsCB = true;
	else
		bar.bnIsCB = nil;
	end
	
	-- stop any sounds of current bar
	Gnosis:StopBarSounds(name);
end
