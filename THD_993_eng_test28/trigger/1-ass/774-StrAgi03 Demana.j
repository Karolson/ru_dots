function Trig_StrAgi03_Demana_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A143'
endfunction

function Trig_StrAgi03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call UnitManaingTarget(caster, caster, 275)
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
endfunction

function Trig_StrAgi03_Demana_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - (220 + 0.075 * GetUnitState(target, UNIT_STATE_MAX_MANA)))
    if udg_NewDebuffSys then
        call UnitCurseTargetNew(caster, target, 100, 4.0, 2, 'A04W')
    else
        call UnitCurseTarget(caster, target, 4.0, 'A145', "curse")
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) + 50, GetUnitY(target) + 50))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) + 100, GetUnitY(target) + 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) - 50, GetUnitY(target) + 50))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) - 100, GetUnitY(target) + 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) - 50, GetUnitY(target) - 50))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) - 100, GetUnitY(target) - 100))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) + 50, GetUnitY(target) - 50))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", GetUnitX(target) + 100, GetUnitY(target) - 100))
    set caster = null
    set target = null
endfunction

function InitTrig_StrAgi03_Demana takes nothing returns nothing
    set gg_trg_StrAgi03_Demana = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StrAgi03_Demana, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_StrAgi03_Demana, Condition(function Trig_StrAgi03_Demana_Conditions))
    call TriggerAddAction(gg_trg_StrAgi03_Demana, function Trig_StrAgi03_Demana_Actions)
endfunction