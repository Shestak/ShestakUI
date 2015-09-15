--斩杀提示
local T, C, _, _ = unpack(select(2, ...))
if C.zzz.SuddenDeath ~= true then return end

local show = 0
-- 0是显示左右两边，1是左边，2是右边

addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_TARGET_CHANGED")
addon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
addon:RegisterEvent("UNIT_HEALTH")
addon:RegisterEvent("UNIT_AURA")

local function showoverlay()
  if show == 0 then
    SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, "KILL", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP", "LEFT", 1, 255, 255, 255, false, false)
    SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, "KILL", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP", "RIGHT", 1, 255, 255, 255, false, true)
  elseif show == 1 then
    SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, "KILL", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP", "LEFT", 1, 255, 255, 255, false, false)
  elseif show == 2 then
    SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, "KILL", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP", "RIGHT", 1, 255, 255, 255, false, true)
  end
end

local function hideoverlay()
  SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, "KILL")
end

addon:SetScript("OnEvent", function(self, event)

  local track = 0
  if UnitCanAttack("player","target") and not UnitIsDeadOrGhost("target") then
    local percent = UnitHealth("target") / UnitHealthMax("target") * 100
    local class = select(2, UnitClass("player"))
    if class == "ROGUE" and GetSpecialization() == 1 then
      if percent <= 35 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "DEATHKNIGHT" then
      if GetSpecialization() == 3 and IsSpellKnown(157342) and percent <= 45 then
        showoverlay()
      elseif percent <= 35 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "MONK" then
      if percent <= 10 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "PALADIN" then
      if GetSpecialization() == 3 and IsSpellKnown(157496) and percent <= 35 then
          showoverlay()
      elseif percent <= 20 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "PRIEST" then
      if GetSpecialization() == 3 and percent <= 20 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "HUNTER" then
      if GetSpecialization() ~= 3 then
        if IsSpellKnown(157707) and percent <= 35 then
          showoverlay()
        elseif percent <= 20 then
          showoverlay()
        else
          hideoverlay()
        end
      end
    elseif class == "WARRIOR" then
      for i = 1,40 do 
        _,_,_,_,_,_,_,_,_,_,id=UnitAura("Player",i) 
        if id == 52437 then
          if show == 1 then
            SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame,52437,"TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP","RIGHT",1,255,255,255,false,true)
          else
            SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame,52437,"TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP","LEFT",1,255,255,255,false,false)
          end
          track = 1
        end 
      end 
      if track == 0 then
        SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame,52437)
      end

      if percent <= 20 then
        showoverlay()
      else
        hideoverlay()
      end
    elseif class == "WARLOCK" then
      if GetSpecialization() == 3 and IsSpellKnown(17877) and percent <= 20 then
        showoverlay()
      else
        hideoverlay()
      end
    else
      hideoverlay()
    end
  else
    hideoverlay()
  end

end) 