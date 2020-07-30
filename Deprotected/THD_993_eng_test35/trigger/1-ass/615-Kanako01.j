function Trig_Kanako01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0F1' or GetSpellAbilityId() == 'A0F0'
endfunction

function Trig_Kanako01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real tx
    local real ty
    local integer level
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer abid = LoadInteger(udg_ht, task, 2)
    if i > 0 then
        call SetUnitFlyHeight(u, 100.0 * (i - 1), 2000.0)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        set tx = GetUnitX(u)
        set ty = GetUnitY(u)
        set caster = LoadUnitHandle(udg_ht, task, 0)
        set level = LoadInteger(udg_ht, task, 0)
        call KillUnit(u)
        if abid == 'A0F1' then
            call UnitStunArea(caster, 1.0 + 0.2 * level, tx, ty, 150, 0, 0)
            call UnitMagicDamageArea(caster, tx, ty, 150, 20 + 30 * (level + 2) + RMaxBJ(GetHeroInt(caster, true) * 2.0, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.125), 5)
        else
            call UnitStunArea(caster, 1.5, tx, ty, 150, 0, 0)
            call UnitMagicDamageArea(caster, tx, ty, 150, 140 + RMaxBJ(GetHeroInt(caster, true) * 1.15, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.1), 5)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Kanako01_Actions takes nothing returns nothing
    local unit caster = GetPlayerCharacter(GetOwningPlayer(GetTriggerUnit()))
    local unit u
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if abid == 'A0F1' then
        call AbilityCoolDownResetion(caster, abid, 9)
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'n031', tx, ty, 270.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 10)
    call SaveInteger(udg_ht, task, 2, abid)
    call SaveReal(udg_ht, task, 0, 0.0)
    call TimerStart(t, 0.05, true, function Trig_Kanako01_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Kanako01 takes nothing returns nothing
endfunction