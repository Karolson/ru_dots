function Trig_Koakuma03Cast_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A05A'
endfunction

function Trig_Koakuma03Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call Trig_Koakuma03_Timer_Set(caster)
    set caster = null
endfunction

function InitTrig_Koakuma03Cast takes nothing returns nothing
endfunction