function Trig_Tokiko03_Damage_Conditions takes nothing returns boolean
    local integer k = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
    local unit hero = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    if GetEventDamage() == 0.0 then
        set hero = null
        return false
    endif
    if hero == null or GetUnitAbilityLevel(GetEventDamageSource(), 'A0ZU') > 0 then
        if HaveSavedBoolean(udg_SK_Tokiko03_Hashtable02[k], GetHandleId(GetEventDamageSource()), 0) then
            set hero = null
            return false
        else
            set hero = null
            return GetUnitAbilityLevel(GetTriggerUnit(), 'A0ZM') >= 1
        endif
        set hero = null
        return false
    elseif HaveSavedBoolean(udg_SK_Tokiko03_Hashtable02[k], GetHandleId(hero), 0) then
        set hero = null
        return false
    else
        set hero = null
        return GetUnitAbilityLevel(GetTriggerUnit(), 'A0ZM') >= 1
    endif
    set hero = null
    return false
endfunction

function Trig_Tokiko03_Damage_Fade takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    call FlushChildHashtable(udg_SK_Tokiko03_Hashtable02[k], GetHandleId(target))
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Tokiko03_Damage_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local unit target = GetEventDamageSource()
    local unit hero = GetPlayerCharacter(GetOwningPlayer(GetEventDamageSource()))
    local integer level = GetUnitAbilityLevel(caster, 'A0ZM')
    local real damage = GetEventDamage()
    local real healing
    local real ox
    local real oy
    local integer k = GetPlayerId(GetOwningPlayer(caster)) + 1
    if hero == null or GetUnitAbilityLevel(target, 'A0ZU') > 0 then
        set healing = RMinBJ(level * 10 + GetUnitState(target, UNIT_STATE_LIFE) * (0.04 * level), damage)
    else
        set healing = RMinBJ(level * 10 + GetUnitState(hero, UNIT_STATE_LIFE) * (0.04 * level), damage)
    endif
    if GetUnitState(caster, UNIT_STATE_LIFE) - GetEventDamage() + healing > 0 then
        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + healing)
    endif
    if hero == null or GetUnitAbilityLevel(target, 'A0ZU') > 0 then
        call SaveBoolean(udg_SK_Tokiko03_Hashtable02[k], GetHandleId(target), 0, true)
    else
        call SaveBoolean(udg_SK_Tokiko03_Hashtable02[k], GetHandleId(hero), 0, true)
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    if hero == null or GetUnitAbilityLevel(target, 'A0ZU') > 0 then
        call SaveUnitHandle(udg_ht, task, 1, target)
    else
        call SaveUnitHandle(udg_ht, task, 1, hero)
    endif
    call TimerStart(t, 10.0, false, function Trig_Tokiko03_Damage_Fade)
    set ox = GetUnitX(caster)
    set oy = GetUnitY(caster)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", ox, oy))
    set t = null
    set caster = null
    set target = null
    set hero = null
endfunction

function InitTrig_Tokiko03_Damage takes nothing returns nothing
endfunction