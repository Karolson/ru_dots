function Trig_Koishi04_DS_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetTriggerUnit()) == 'E011'
endfunction

function Trig_Koishi04_DS_Actions takes nothing returns nothing
    if IsUnitAlly(GetTriggerUnit(), GetLocalPlayer()) then
        call SelectUnit(GetTriggerUnit(), false)
    endif
endfunction

function InitTrig_Koishi04_DS takes nothing returns nothing
endfunction