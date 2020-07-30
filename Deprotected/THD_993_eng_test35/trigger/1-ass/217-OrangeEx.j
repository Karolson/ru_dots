function Trig_OrangeEx_Actions takes nothing returns nothing
    local unit caster = udg_SK_Chen
    local integer level = GetHeroLevel(caster)
    call SetUnitAbilityLevel(caster, 'A0TQ', level)
    set caster = null
endfunction

function InitTrig_OrangeEx takes nothing returns nothing
endfunction