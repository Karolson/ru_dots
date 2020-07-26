function Trig_Toramaru01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0P2'
endfunction

function Trig_Toramaru01_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real i = LoadReal(udg_ht, task, 888) - 0.1
    call SaveReal(udg_ht, GetHandleId(caster), 888, i)
    call SaveReal(udg_ht, task, 888, i)
    if GetUnitAbilityLevel(caster, 'A0PB') == 0 or i <= 0 then
        call DestroyEffect(udg_SK_Toramaru01_Effect)
        set udg_SK_Toramaru01_Effect = null
        call UnitRemoveAbility(caster, 'A0PB')
        call UnitRemoveAbility(caster, 'B05P')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Toramaru01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0P2')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0P2', 15 - 1 * level)
    if udg_SK_ToramaruDB_Count > 0 then
        set udg_SK_ToramaruDB_Count = udg_SK_ToramaruDB_Count - 1
        call Trig_ToramaruDB_Change()
        call UnitHealingTarget(caster, caster, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.02)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
    endif
    if GetUnitAbilityLevel(caster, 'A0PB') != 0 then
        call DestroyEffect(udg_SK_Toramaru01_Effect)
        set udg_SK_Toramaru01_Effect = null
        call UnitRemoveAbility(caster, 'A0PB')
        call UnitRemoveAbility(caster, 'B05P')
    endif
    set udg_SK_Toramaru01_Effect = AddSpecialEffectTarget("toramaru_0.mdx", caster, "hand left")
    call UnitAddAbility(caster, 'A0PB')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0PB', false)
    call SetUnitAbilityLevel(caster, 'A0SS', level)
    call SetUnitAbilityLevel(caster, 'A0ST', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, GetHandleId(caster), 888, 5.0)
    call SaveReal(udg_ht, task, 888, 5.0)
    call TimerStart(t, 0.1, true, function Trig_Toramaru01_Clear)
    set caster = null
    set t = null
endfunction

function InitTrig_Toramaru01 takes nothing returns nothing
endfunction