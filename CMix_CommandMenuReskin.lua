LUAGUI_NAME = "CMix_CommandMenuReskin"
LUAGUI_AUTH = "Xendra"
LUAGUI_DESC = "Changes the appearance of the Command Menu"
local offset = 0x3A0606
local canExecute = false

local selectionOutline = 0x2854CF0 - offset
local attackSlot = 0x28525E0 - offset
local magicSlot = attackSlot + 0xC0
local itemSlot = magicSlot + 0xC0
local summonSlot = 0x28534E0 - offset

local selectGradientTopWidth = 0x2854E78 - offset
local selectGradientBottomWidth = 0x2854DB8 - offset
local selectionLeftR = 0x2857F38 - offset
local selectionLeftG = selectionLeftR+4
local selectionLeftB = selectionLeftR+8

local selectionRightR = 0x2857F58 - offset
local selectionRightG = selectionRightR+4
local selectionRightB = selectionRightR+8

local commandColor = 0x2855AD8 - offset
local commandState = 0x2855AD0 - offset

local attackIconRGBA = 0x2854400 - offset

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("CMix_CommandMenuReskin - installed")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end
	
	WriteByte(commandColor, 0x01)
	WriteByte(selectGradientTopWidth, 0x60)
	WriteByte(selectGradientBottomWidth, 0x60)

	custom_command_menu()
	set_attack_icon_color()


	:: done ::
end


function set_attack_icon_color()
	local red = 0xd3
	local green = 0x98
	local blue = 0xa9
	local alpha = 0x70
	if ReadShort(commandState) == 0x5950 then -- In Combat
		red = 0xfa
		green = 0x1f
		blue = 0xff
		
		WriteFloat(selectionLeftR, 98)
		WriteFloat(selectionLeftG, 12)
		WriteFloat(selectionLeftB, 100)
		
		WriteFloat(selectionRightR, 98)
		WriteFloat(selectionRightG, 8)
		WriteFloat(selectionRightB, 100)
	else
		WriteFloat(selectionLeftR, 83)
		WriteFloat(selectionLeftG, 60)
		WriteFloat(selectionLeftB, 66)
		
		WriteFloat(selectionRightR, 83)
		WriteFloat(selectionRightG, 55)
		WriteFloat(selectionRightB, 66)
	end
	
	
	if (ReadByte(0x233D035-0x3A0606)//0x40)%2 == 1 then -- Flicker When Pressing X
		red = math.min(0xFF, red + 40)
		green =  math.min(0xFF, green + 40)
		blue =  math.min(0xFF, blue + 40)
		alpha = alpha + 10
	end
	
	WriteByte(attackIconRGBA, red)
	WriteByte(attackIconRGBA+4, green)
	WriteByte(attackIconRGBA+8, blue)
	WriteByte(attackIconRGBA+12, alpha)
end




function draw_slot(_slot)

WriteLong(_slot+0x00, 0x0000000300000003)
WriteLong(_slot+0x08, 0x0000001600000074)
WriteLong(_slot+0x10, 0x0000006400000000)
WriteLong(_slot+0x18, 0x0000007B00000077)
WriteLong(_slot+0x20, 0x0000000000000000)
WriteLong(_slot+0x28, 0x0000005000000000) -- Alpha

WriteLong(_slot+0x30, 0x0000008000000080)
WriteLong(_slot+0x38, 0x0000008000000080)
WriteLong(_slot+0x40, 0x0000008000000080)
WriteLong(_slot+0x48, 0x0000008000000080)
WriteLong(_slot+0x50, 0x0000008000000080)
WriteLong(_slot+0x58, 0x0000008000000080)
WriteLong(_slot+0x60, 0x0000001E00000000)
WriteLong(_slot+0x68, 0x0000000200000001)

WriteLong(_slot+0x70, 0x00000006004413c8)
WriteLong(_slot+0x78, 0x0000008000000080)
WriteLong(_slot+0x80, 0x0000000000000000)
WriteLong(_slot+0x88, 0x0000000000000000)
WriteLong(_slot+0x90, 0x0000000300000002)
WriteLong(_slot+0x98, 0x0000000600ffffff)

end


function custom_command_menu()
	WriteByte(selectionOutline, 0xF0)
	WriteLong(0x2855820 - offset, 0x0000000000000000) -- Erase Line
	WriteLong(0x2855828 - offset, 0x0000000000000000) -- Erase Line
	WriteLong(0x284FF30 - offset, 0x0000000000000000) -- Erase Header BG
	WriteLong(0x284FF38 - offset, 0x0000000000000000) -- Erase Header BG
	WriteByte(0x2850A78 - offset, 0) -- Hide Command Header Text
	draw_slot(attackSlot)
	draw_slot(magicSlot)
	draw_slot(itemSlot)
	draw_slot(summonSlot)
end