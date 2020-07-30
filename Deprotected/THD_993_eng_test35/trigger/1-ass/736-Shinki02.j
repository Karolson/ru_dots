function Shinki02 takes nothing returns integer
    return 'A1DX'
endfunction

function Shinki02_Range takes nothing returns real
    return 500.0
endfunction

function Shinki02_Buff takes nothing returns integer
    return 'B09N'
endfunction

function Shinki02_BuffSK takes nothing returns integer
    return 'A1DY'
endfunction

function Shinki02_If takes nothing returns boolean
    if GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) <= 0 then
        return false
    endif
    if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') != 0 then
        return false
    endif
    if IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(GetFilterUnit(), 'A0IL') > 0 then
        return false
    endif
    return true
endfunction

function Trig_Shinki02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1DX'
endfunction

function Trg_Shinki02_TimerActions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 0)
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local group g = CreateGroup()
    local unit v
    local boolexpr iff
    if UnitHasBuffBJ(caster, 'B09N') then
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.01)
        set iff = Filter(function Shinki02_If)
        call GroupEnumUnitsInRange(g, x, y, 500.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, GetOwningPlayer(caster)) then
                call AddSpecialEffect("Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", GetUnitX(v), GetUnitY(v))
                call DestroyEffect(GetLastCreatedEffectBJ())
                if v != caster then
                    call UnitHealingTarget(caster, v, 10.0 + 5.0 * level + 0.1 * GetHeroInt(caster, true))
                else
                    call UnitHealingTarget(caster, v, 10.0 + 5.0 * level + 0.1 * GetHeroInt(caster, true) * 0.5)
                endif
            else
                if GetUnitAbilityLevel(caster, 'A1DV') > 0 then
                    call AddSpecialEffect("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", GetUnitX(v), GetUnitY(v))
                    call DestroyEffect(GetLastCreatedEffectBJ())
                    call UnitMagicDamageTarget(caster, v, 0.2 * GetHeroInt(caster, true) + 10.0 + 10.0 * GetUnitAbilityLevel(caster, 'A1DV'), 1)
                endif
            endif
        endloop
    else
        call UnitRemoveAbility(caster, 'A1DY')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    call DestroyGroup(g)
    set t = null
    set caster = null
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_Shinki02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A1DX')
    if GetUnitAbilityLevel(caster, 'A1DY') == 0 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call UnitAddAbility(caster, 'A1DY')
        call SaveInteger(udg_ht, task, 0, level)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 1, true, function Trg_Shinki02_TimerActions)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_Shinki02 takes nothing returns nothing
    set gg_trg_Shinki02 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Shinki02, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Shinki02, Condition(function Trig_Shinki02_Conditions))
    call TriggerAddAction(gg_trg_Shinki02, function Trig_Shinki02_Actions)
endfunction