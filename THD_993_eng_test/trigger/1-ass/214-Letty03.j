function Trig_Letty03_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A15K'
endfunction

function Trig_Letty03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    call UnitAddMaxLife(caster, 100)
    set caster = null
endfunction

function InitTrig_Letty03 takes nothing returns nothing
endfunction