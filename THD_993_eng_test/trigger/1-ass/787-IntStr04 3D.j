function Trig_IntStr04_3D_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A02H' then
        call UnitCurseTarget(GetTriggerUnit(), GetSpellTargetUnit(), 5.0, 'A18A', "drunkenhaze")
    endif
    return false
endfunction

function InitTrig_IntStr04_3D takes nothing returns nothing
    set gg_trg_IntStr04_3D = CreateTrigger()
    call FirstAbilityInit('A18A')
    call TriggerRegisterAnyUnitEventBJ(gg_trg_IntStr04_3D, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_IntStr04_3D, Condition(function Trig_IntStr04_3D_Conditions))
endfunction