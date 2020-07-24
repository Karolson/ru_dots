function Trig_Yuka04_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        return GetSpellAbilityId() == 'A0DA'
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        if GetUnitTypeId(GetSummoningUnit()) != 'o00U' then
            return false
        endif
        return GetUnitTypeId(GetSummonedUnit()) == 'N00L'
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_DEATH then
        return IsUnitIllusion(GetTriggerUnit())
    endif
    return false
endfunction

function Trig_Yuka04_Actions takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster = GetTriggerUnit()
    local unit target
    local unit u
    local real tx
    local real ty
    local integer level = GetUnitAbilityLevel(caster, 'A0DA')
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        set target = GetSpellTargetUnit()
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 135 - 15 * level)
        call VE_Spellcast(caster)
        if GetUnitTypeId(target) == 'o00C' or GetUnitTypeId(target) == 'o00D' then
            set tx = GetUnitX(target)
            set ty = GetUnitY(target)
            call SaveUnitHandle(udg_ht, task, 0, caster)
            call SaveReal(udg_ht, task, 1, tx)
            call SaveReal(udg_ht, task, 2, ty)
            set u = CreateUnit(GetOwningPlayer(caster), 'o00U', GetUnitX(caster), GetUnitY(caster), 270.0)
            call UnitAddAbility(u, 'A04I')
            call SetUnitAbilityLevel(u, 'A04I', GetUnitAbilityLevel(caster, 'A0DA'))
            call IssueTargetOrderById(u, 852274, caster)
            call RemoveUnit(target)
        endif
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        set u = GetSummonedUnit()
        call VE_Spellcast(u)
        set caster = LoadUnitHandle(udg_ht, task, 0)
        set tx = LoadReal(udg_ht, task, 1)
        set ty = LoadReal(udg_ht, task, 2)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", u, "origin"))
        call SetUnitXY(u, tx, ty)
        call UnitInitAddAttack(u)
        set udg_SK_Yuka_Unit = u
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_DEATH then
        if GetTriggerUnit() == udg_SK_Yuka_Unit then
            set udg_SK_Yuka_Unit = null
        endif
    endif
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_Yuka04 takes nothing returns nothing
endfunction