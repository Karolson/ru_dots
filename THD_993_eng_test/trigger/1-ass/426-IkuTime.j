function Trig_IkuTime_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetHeroLevel(caster)
    call SetUnitAbilityLevel(caster, 'A0OY', level)
    call UnitAddMaxLife(caster, 15)
    set caster = null
endfunction

function InitTrig_IkuTime takes nothing returns nothing
endfunction