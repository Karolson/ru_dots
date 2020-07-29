function Trig_LiMa05_Blow_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A17G'
endfunction

function Trig_LiMa05_Blow_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit w = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0.0)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set w = null
        return
    endif
    call UnitRemoveAbility(caster, 'B01R')
    call UnitRemoveAbility(caster, 'B04S')
    call UnitRemoveAbility(caster, 'B07N')
    call UnitRemoveAbility(caster, 'B09K')
    call UnitRemoveAbility(caster, 'B09A')
    call UnitAddAbility(w, 'A17H')
    call IssueTargetOrder(w, "cyclone", caster)
    call UnitRemoveAbility(w, 'A17H')
    call ReleaseDummy(w)
    set caster = null
    set w = null
endfunction

function InitTrig_LiMa05_Blow takes nothing returns nothing
    set gg_trg_LiMa05_Blow = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LiMa05_Blow, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_LiMa05_Blow, Condition(function Trig_LiMa05_Blow_Conditions))
    call TriggerAddAction(gg_trg_LiMa05_Blow, function Trig_LiMa05_Blow_Actions)
endfunction