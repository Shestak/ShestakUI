local T, C, L, _ = unpack(select(2, ...))
if C.trade.enchantment_scroll ~= true or IsAddOnLoaded("OneClickEnchantScroll") then return end

----------------------------------------------------------------------------------------
--	Enchantment scroll on TradeSkill frame(OneClickEnchantScroll by Sara.Festung)
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "TradeSkillCreateScrollButton", ProfessionsFrame, "MagicButtonTemplate")
if C.skins.blizzard_frames == true then
	button:SkinButton(true)
	button:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.CreateButton, "TOPLEFT", -1, 0)
else
	button:SetPoint("TOPRIGHT", ProfessionsFrame.CraftingPage.CreateButton, "TOPLEFT")
end
button:SetScript("OnClick", function()
	local currentRecipeInfo = ProfessionsFrame.CraftingPage.SchematicForm:GetRecipeInfo()
	if currentRecipeInfo then
		C_TradeSkillUI.CraftRecipe(currentRecipeInfo.recipeID)
		UseItemByName(38682)
	end
end)

hooksecurefunc(ProfessionsFrame.CraftingPage, "ValidateControls", function(self)
	if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
		button:Hide()
	else
		local currentRecipeInfo = ProfessionsFrame.CraftingPage.SchematicForm:GetRecipeInfo()
		if currentRecipeInfo and currentRecipeInfo.alternateVerb then
			local professionInfo = ProfessionsFrame:GetProfessionInfo()
			if professionInfo and professionInfo.parentProfessionID == 333 then
				button:Show()
				local isEnchantingRecipe = currentRecipeInfo.isEnchantingRecipe
				local numScrollsAvailable = GetItemCount(38682)
				button:SetText(L_MISC_SCROLL.." ("..numScrollsAvailable..")")
				 if numScrollsAvailable == 0 then
					isEnchantingRecipe = false
				end
				if isEnchantingRecipe then
					button:Enable()
				else
					button:Disable()
				end
			else
				button:Hide()
			end
		else
			button:Hide()
		end
	end
end)