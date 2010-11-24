----------------------------------------------------------------------------------------
--	Universal Mount macro(by Monolit)
--	/script Mountz ("your_ground_mount","your_flying_mount","your_underwater_mount")
--	or /script Mountz("your_ground_mount","your_flying_mount")
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount, underwatermount)
	local num = GetNumCompanions("MOUNT")
	if not num or IsMounted() then
		Dismount()
		return
	end
	if CanExitVehicle() then 
		VehicleExit()
		return
	end
	local swimablex = IsSwimming()
	local v = GetBuildInfo()
	local flyablex
	if v == "4.0.3" then -- remove with cata release 
		flyablex = IsFlyableArea() and ((GetCurrentMapContinent()==4 and UnitLevel("player")>67) or (GetCurrentMapContinent()==3 and UnitLevel("player")>59))
	else
		flyablex = IsFlyableArea()
	end
	if IsControlKeyDown() then
		flyablex = not flyablex
	end
	if IsShiftKeyDown() then
		swimablex = not swimablex
    end
	for i = 1, num, 1 do
		local _, info = GetCompanionInfo("MOUNT", i)
		if flyingmount and info == flyingmount and flyablex and not swimablex then
			CallCompanion("MOUNT", i)
			return
		elseif groundmount and info == groundmount and not flyablex and not swimablex then
			CallCompanion("MOUNT", i)
			return
		elseif underwatermount and info == underwatermount and swimablex then
			CallCompanion("MOUNT", i)
			return
		end
	end
end


