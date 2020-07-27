function Trig_Keine_04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0MB' and GetUnitTypeId(GetTriggerUnit()) == 'E01A'
endfunction

function Trig_Keine_04_Clear takes nothing returns nothing
    local timer p = GetExpiredTimer()
    local integer pask = GetHandleId(p)
    local unit caster = LoadUnitHandle(udg_ht, pask, 0)
    local integer level = LoadInteger(udg_ht, pask, 1)
    local real k0
    local real k1
    set udg_SK_Keine = caster
    set udg_SK_Keine_Wolf = 0
    set k0 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    set k1 = GetUnitState(caster, UNIT_STATE_LIFE)
    if udg_SK_Keine04_count == 0 then
        set udg_SK_Keine04_count = 1
        call SetHeroStr(caster, GetHeroStr(caster, false) - udg_SK_Keine_Str, true)
    endif
    if GetUnitState(caster, UNIT_STATE_LIFE) > 0 then
        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * (k1 / k0))
    endif
    call Trig_Keine_Ability_Change_Actions()
    call ReleaseTimer(p)
    call FlushChildHashtable(udg_ht, pask)
    set caster = null
    set p = null
endfunction

function Trig_Keine_04_AtkStr_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real m = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local timer p
    local integer pask
    local unit keine = caster
    local integer atk = GetHeroStr(caster, true) - GetHeroInt(caster, true) + 1
    local integer latk = LoadInteger(udg_ht, task, 4)
    set i = i + 1
    if i == 1 then
        call Trig_Keine_Ability_Change_Actions()
        call SetUnitAnimation(caster, "Morph")
    endif
    if GetUnitTypeId(keine) == 'E01B' and IsUnitType(caster, UNIT_TYPE_DEAD) == false then
        if GetUnitAbilityLevel(caster, 'A0MH') == 0 then
            call UnitAddAbility(caster, 'A0MH')
        endif
        if GetUnitAbilityLevel(caster, 'A0MG') == 0 then
            call UnitAddAbility(caster, 'A0MG')
        endif
        if GetUnitAbilityLevel(caster, 'A0MF') == 0 then
            call UnitAddAbility(caster, 'A0MF')
        endif
        if atk > latk then
            call UnitAddAttackDamage(caster, atk - latk)
            call SaveInteger(udg_ht, task, 4, atk)
        elseif atk < latk then
            call UnitReduceAttackDamage(caster, latk - atk)
            call SaveInteger(udg_ht, task, 4, atk)
        endif
        call SaveInteger(udg_ht, task, 3, i)
    else
        call UnitReduceAttackDamage(caster, latk)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set p = CreateTimer()
        set pask = GetHandleId(p)
        call SaveUnitHandle(udg_ht, pask, 0, caster)
        call SaveInteger(udg_ht, pask, 1, level)
        call TimerStart(p, 0.01, false, function Trig_Keine_04_Clear)
    endif
    set p = null
    set t = null
    set caster = null
    set keine = null
endfunction

function Trig_Keine_04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer level = GetUnitAbilityLevel(caster, 'A0MB')
    local real m = GetUnitState(caster, UNIT_STATE_MANA)
    local real k0
    local real k1
    call VE_Spellcast(caster)
    set udg_SK_Keine = caster
    set udg_SK_Keine_Wolf = level
    set udg_SK_Keine04_count = 0
    set udg_SK_Keine_Str = 15 + level * 15
    set k0 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    set k1 = GetUnitState(caster, UNIT_STATE_LIFE)
    call UnitInitAddAttack(caster)
    call SetHeroStr(caster, GetHeroStr(caster, false) + udg_SK_Keine_Str, true)
    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * (k1 / k0))
    call Trig_Keine_Ability_Change_Actions()
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveReal(udg_ht, task, 2, m)
    call SaveInteger(udg_ht, task, 3, 0)
    call SaveInteger(udg_ht, task, 4, 0)
    call TimerStart(t, 0.02, true, function Trig_Keine_04_AtkStr_Actions)
    set caster = null
    set t = null
endfunction

function InitTrig_Keine04 takes nothing returns nothing
endfunction