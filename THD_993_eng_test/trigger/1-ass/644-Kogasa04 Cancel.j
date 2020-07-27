function Trig_Kogasa04_Cancel_Condition takes nothing returns boolean
    local unit caster = GetTriggerUnit()
    if GetUnitAbilityLevel(caster, 'B02K') > 0 then
        call UnitRemoveAbility(caster, 'B02K')
        if GetUnitAbilityLevel(caster, 'Abun') > 0 then
            call UnitRemoveAbility(caster, 'Abun')
        endif
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C7', true)
        call DisableTrigger(gg_trg_Kogasa04_Cancel)
    endif
    set caster = null
    return false
endfunction

function InitTrig_Kogasa04_Cancel takes nothing returns nothing
endfunction