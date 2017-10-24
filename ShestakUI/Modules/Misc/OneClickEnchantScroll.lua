local T, C, L, _ = unpack(select(2, ...))
if C.misc.enchantment_scroll ~= true then return end

----------------------------------------------------------------------------------------
--	Enchantment scroll on TradeSkill frame(OneClickEnchantScroll by Sara.Festung)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TradeSkillUI" and not IsAddOnLoaded("OneClickEnchantScroll") then
		local button = CreateFrame("Button", "TradeSkillCreateScrollButton", TradeSkillFrame, "MagicButtonTemplate")
		if C.skins.blizzard_frames == true then
			button:SkinButton(true)
			button:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT", -1, 0)
		else
			button:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT")
		end
		button:SetScript("OnClick", function()
			C_TradeSkillUI.CraftRecipe(TradeSkillFrame.DetailsFrame.selectedRecipeID)
			UseItemByName(38682)
		end)

		hooksecurefunc(TradeSkillFrame.RecipeList, "OnRecipeButtonClicked", function(_, recipeInfo)
			if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
				button:Hide()
			elseif recipeInfo.tradeSkillInfo.alternateVerb then
				local _, tradeSkillName = C_TradeSkillUI.GetTradeSkillLine()
				if tradeSkillName == GetSpellInfo(7411) then
					button:Show()
					local numCreateable = recipeInfo.tradeSkillInfo.numAvailable
					local numScrollsAvailable = GetItemCount(38682)
					button:SetText(L_MISC_SCROLL.." ("..numScrollsAvailable..")")
					 if numScrollsAvailable == 0 then
						numCreateable = 0
					end
					if numCreateable > 0 then
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
		end)

		hooksecurefunc(TradeSkillFrame, "RefreshTitle", function()
			button:Hide()
		end)
	end
end)