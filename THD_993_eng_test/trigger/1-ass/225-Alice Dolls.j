function GetDollType takes unit u returns integer
    local integer d = GetUnitTypeId(u)
    if d == 'h01C' then
        return 1
    elseif d == 'h01B' or d == 'h01E' then
        return 2
    elseif d == 'h01D' or d == 'h01F' then
        return 3
    endif
    return 0
endfunction

function ConvertDollType takes integer d returns integer
    if d == 1 then
        return 'h01C'
    elseif d == 2 then
        return 'h01B'
    elseif d == 3 then
        return 'h01D'
    endif
    return 0
endfunction

function CountDollsInGroupEnum takes nothing returns nothing
    local unit u = GetEnumUnit()
    if IsUnitDead(u) then
        call GroupRemoveUnit(udg_SK_AliceDollsCountingGroup, u)
    else
        set udg_SK_AliceDollsCounting = udg_SK_AliceDollsCounting + 1
    endif
    set u = null
endfunction

function CountDollsInGroup takes group g returns integer
    set udg_SK_AliceDollsCounting = 0
    set udg_SK_AliceDollsCountingGroup = g
    call ForGroup(g, function CountDollsInGroupEnum)
    set udg_SK_AliceDollsCountingGroup = null
    return udg_SK_AliceDollsCounting
endfunction

function ChangeDollLifeAndAttack takes unit doll, integer atk, integer life returns nothing
    call UnitAddMaxLife(doll, life)
    call UnitAddAttackDamage(doll, atk)
endfunction

function SetDollProperty takes unit caster, unit u returns nothing
    local integer STR = GetHeroStr(caster, true)
    local integer AGI = GetHeroAgi(caster, true)
    local integer INT = GetHeroInt(caster, true)
    local integer ATK = 0
    local integer HP = 0
    if GetDollType(u) == 1 then
        set ATK = R2I(STR * 0.8)
        set HP = R2I(STR * 4.0)
    elseif GetDollType(u) == 2 then
        set ATK = R2I(AGI * 1.0)
        set HP = R2I(AGI * 4.0)
    elseif GetDollType(u) == 3 then
        set ATK = R2I(INT * 1.0)
        set HP = R2I(INT * 4.0)
    endif
    call ChangeDollLifeAndAttack(u, ATK, HP)
endfunction

function RemoveDoll takes unit caster, unit u, boolean remove returns nothing
    local integer task = GetHandleId(caster)
    local integer d = GetDollType(u)
    local real px = GetUnitX(u)
    local real py = GetUnitY(u)
    local real mana = 0.0
    local group g
    if d > 0 then
        set mana = 50.0
        set g = LoadGroupHandle(udg_sht, GetHandleId(caster), d)
        call GroupRemoveUnit(g, u)
        call FlushChildHashtable(udg_sht, GetHandleId(u))
    endif
    if remove then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualCaster.mdl", caster, "origin"))
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + mana)
        call RemoveUnit(u)
    endif
    set g = null
endfunction

function CreateDoll takes unit caster, integer d, real x, real y, real a, code f returns unit
    local unit u
    local lightning e
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz = GetPositionZ(ox, oy)
    local real z = GetPositionZ(x, y)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), d, x, y, a)
    call EnableHeight(u)
    set z = z + GetUnitFlyHeight(u)
    set e = AddLightningEx("DSTR", false, ox, oy, oz + 80.0, x, y, z + 40.0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveLightningHandle(udg_ht, task, 2, e)
    call TimerStart(t, 0.03, true, f)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", x, y))
    call UnitInitAddAttack(u)
    call SaveUnitHandle(udg_sht, GetHandleId(u), 0, caster)
    set bj_lastCreatedUnit = u
    set u = null
    set e = null
    set t = null
    return bj_lastCreatedUnit
endfunction

function InitTrig_Alice_Dolls takes nothing returns nothing
endfunction