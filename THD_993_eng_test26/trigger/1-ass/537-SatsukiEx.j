function Trig_SatsukiEx_Actions takes nothing returns nothing
    call Trig_MoonMan(GetTriggerUnit())
    call UnitAddAbility(GetTriggerUnit(), 'A1I8')
endfunction

function InitTrig_SatsukiEx takes nothing returns nothing
endfunction