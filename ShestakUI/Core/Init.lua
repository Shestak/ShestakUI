----------------------------------------------------------------
-- initiation of tukui
----------------------------------------------------------------

-- including system
local addon, engine = ...
engine[1] = {} -- T, functions, constants, variables
engine[2] = {} -- C, config
engine[3] = {} -- L, localization

Tukui = engine -- Allow other addons to use Engine

---------------------------------------------------------------------------------
--	This should be at the top of every file inside of the Tukui AddOn:	
--	local T, C, L = unpack(select(2, ...))

--	This is how another addon imports the Tukui engine:	
--	local T, C, L = unpack(Tukui)
---------------------------------------------------------------------------------

local T, C, L = unpack(select(2, ...))

---------------------------------------------------------------------------------
-- Adding this for extras mod build around t12 or less to be compatible with t13.
-- NOTE: DEPRECATED ! IT WILL DISAPEAR COUPLES OF BUILD AFTER t13 RELEASE, see /core/deprecated.lua for details)
---------------------------------------------------------------------------------

TukuiDB = T 
TukuiCF = C
tukuilocal = L