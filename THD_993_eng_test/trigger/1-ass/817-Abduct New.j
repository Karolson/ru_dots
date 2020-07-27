function Trig_Abduct_New_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1B9'
endfunction

function Trig_Abduct_New_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local real a
    set a = Atan2(GetUnitY(caster) - GetUnitY(target), GetUnitX(caster) - GetUnitX(target)) - 3.14
    call UnitBuffTarget(caster, target, 0.5, 'A17W', 0)
    if caster == target then
        set a = GetUnitFacing(caster) / 180 * 3.14 - 3.14
    endif
    call Lily_String_Main(target, 500, 1000, a, "Abilities\\Weapons\\GlaiveMissile\\GlaiveMissileTarget.mdl")
    set caster = null
    set target = null
endfunction

function InitTrig_Abduct_New takes nothing returns nothing
    set gg_trg_Abduct_New = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Abduct_New, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Abduct_New, Condition(function Trig_Abduct_New_Conditions))
    call TriggerAddAction(gg_trg_Abduct_New, function Trig_Abduct_New_Actions)
endfunction