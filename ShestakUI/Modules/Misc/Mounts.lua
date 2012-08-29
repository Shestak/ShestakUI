----------------------------------------------------------------------------------------
--	Universal Mount macro(by Monolit)
--	/script Mountz("your_ground_mount","your_flying_mount")
----------------------------------------------------------------------------------------
function Mountz(groundmount, flyingmount, underwatermount)
	local flyablex, swimablex, vjswim, underwater, InVj, nofly
	local num = GetNumCompanions("MOUNT")
	if not num or IsMounted() then
		Dismount()
		return
	end
	if CanExitVehicle() then
		VehicleExit()
		return
	end
	if IsUsableSpell(59569) == nil then
		nofly = true
	end
	if not nofly and IsFlyableArea() then
		flyablex = true
	end
	for i = 1, 40 do
		local sid = select(11, UnitBuff("player", i))
		if sid == 73701 or sid == 76377 then
			InVj = true
		end
	end
	if InVj and nofly then
		vjswim = true
	end
	if IsSwimming() and nofly and not vjswim then
		swimablex = true
	end
	if IsControlKeyDown() then
		flyablex = not flyablex
	end
	for i = 1, num, 1 do
		local _, info, id = GetCompanionInfo("MOUNT", i)
		if underwatermount and info == underwatermount and swimablex then
			CallCompanion("MOUNT", i)
			return
		elseif flyingmount and info == flyingmount and flyablex and not swimablex then
			CallCompanion("MOUNT", i)
			return
		elseif groundmount and info == groundmount and not flyablex and not swimablex then
			CallCompanion("MOUNT", i)
			return
		elseif id == 75207 and vjswim and IsSwimming() and not swimablex then
			CallCompanion("MOUNT", i)
			return
		end
	end
end