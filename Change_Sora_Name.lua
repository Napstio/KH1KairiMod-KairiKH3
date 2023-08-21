LUAGUI_NAME = "Change Sora Name"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Change Sora Name"
local offset = 0x3A0606
soraname = 0x2E179E6 - offset

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Change Sora Name - installed")
	else
		ConsolePrint("Change Sora Name - failed")
	end
end

function _OnFrame()
if canExecute == true then
WriteArray(soraname, {0x35, 0x45, 0x4D, 0x56, 0x4D, 0x00})
--removes Donald Name, nothing I can do (Except giving Kairi a shorter name or having Kairi named "KairiDonald")
end
end