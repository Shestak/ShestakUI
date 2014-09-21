local T, C, L, _ = unpack(select(2, ...))
if not IsAddOnLoaded("CLCProt") or C.skins.clcprot ~= true or T.class ~= "PALADIN" then return end

----------------------------------------------------------------------------------------
--	CLCProt skin(by Elv22)
----------------------------------------------------------------------------------------
if not LibStub then return end
local clcprot = LibStub("AceAddon-3.0"):GetAddon("clcprot")

function clcprot:CreateButton(name, size, point, parent, pointParent, offsetx, offsety, bfGroup, isChecked)
	local db = self.db.profile
	clcprotFrame:SetScale(1)
	clcprotFrame.SetScale = T.dummy

	name = "clcprot"..name
	local button
	if isChecked then
		button = CreateFrame("CheckButton", name, parent)
		button:SetTemplate("Default")
		button:StyleButton()
	else
		button = CreateFrame("Button", name, parent)
		button:SetTemplate("Default")
	end
	button:EnableMouse(false)
	button:SetSize(size, size)

	button.texture = button:CreateTexture("$parentIcon", "OVERLAY")
	button.texture:SetPoint("TOPLEFT", 2, -2)
	button.texture:SetPoint("BOTTOMRIGHT", -2, 2)
	button.texture:SetTexture(BGTEX)
	button.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.texture.SetTexCoord = T.dummy

	button.border = button:CreateTexture(nil, "BORDER")
	button.border:Kill()

	button.cooldown = CreateFrame("Cooldown", "$parentCooldown", button, "CooldownFrameTemplate")
	button.cooldown:SetPoint("TOPLEFT", 2, -2)
	button.cooldown:SetPoint("BOTTOMRIGHT", -2, 2)

	button.stack = button:CreateFontString("$parentCount", "OVERLAY", "TextStatusBarText")

	local fontFace, _, fontFlags = button.stack:GetFont()
	button.stack:SetFont(fontFace, 30, fontFlags)
	button.stack:SetJustifyH("RIGHT")
	button.stack:ClearAllPoints()
	button.stack:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 4, 0)

	button.defaultSize = button:GetWidth()

	button.SetScale = T.dummy
	button:ClearAllPoints()
	button:SetPoint(point, parent, pointParent, offsetx, offsety)

	if self.LBF then
		self.LBF:Group("clcprot", bfGroup):AddButton(button)
	end

	button:Hide()
	return button
end

function clcprot:UpdateButtonLayout(button, opt)
	button:SetSize(opt.size, opt.size)
	button:ClearAllPoints()
	button:SetPoint(opt.point, clcprotFrame, opt.pointParent, opt.x, opt.y)
	button:SetAlpha(opt.alpha)

	button.stack:ClearAllPoints()
	button.stack:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 4, 0)
end