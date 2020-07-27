function Trig_YukariEyebug_Conditions takes nothing returns boolean
    if IsUnitSpawn(GetEnteringUnit()) != true then
        return false
    endif
    return GetOwningPlayer(GetEnteringUnit()) == Player(4) or GetOwningPlayer(GetEnteringUnit()) == Player(10)
endfunction

function Trig_YukariEyebug_Actions takes nothing returns nothing
    call KillUnit(GetEnteringUnit())
endfunction

function InitTrig_YukariEyebug takes nothing returns nothing
endfunction