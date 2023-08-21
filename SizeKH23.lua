LUAGUI_NAME = "Size"
LUAGUI_AUTH = "KSX"
LUAGUI_DESC = "Size"
local offset = 0x3A0606
local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Size")
		canExecute = true
	end
end

function _OnFrame()
SizeX = ReadLong(0x2534680 - offset)+0x40, true
SizeZ = ReadLong(0x2534680 - offset)+0x44, true
SizeY = ReadLong(0x2534680 - offset)+0x48, true

	if canExecute == true then
		WriteFloat(SizeX, 1.095, true)
		WriteFloat(SizeZ, 1.095, true)
		WriteFloat(SizeY, 1.095, true)
	end
end