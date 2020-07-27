function MarisaAbEx takes nothing returns integer
    return 'A107'
endfunction

function MarisaEx_ColdFinish takes nothing returns nothing
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(GetExpiredTimer()), 1)
    call UnitAddAbility(caster, 'A02L')
    call UnitAddAbility(caster, 'A02Q')
    call UnitRemoveAbility(caster, 'A02M')
    set caster = null
endfunction

function MarisaEx_ColdTimer takes unit caster returns nothing
    local timer t = LoadTimerHandle(udg_Hashtable_CDInReimu, GetHandleId(caster), 'A02L' * 10 + 0)
    local integer task = GetHandleId(t)
    if GetUnitAbilityLevel(caster, 'A02L') != 0 then
        call UnitRemoveAbility(caster, 'A02L')
        call UnitRemoveAbility(caster, 'A02Q')
        call UnitAddAbility(caster, 'A02M')
    endif
    call TimerStart(t, 10, false, function MarisaEx_ColdFinish)
    set t = null
endfunction

function Trig_MarisaEx_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A107'
endfunction

function Trig_MarisaEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local integer i = LoadInteger(udg_ht, task, 2)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 3)
    local real d = LoadReal(udg_ht, task, 4)
    local real damage = LoadReal(udg_ht, task, 5)
    local group g
    local boolexpr iff
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        call SetUnitXY(u, px, py)
        call SaveInteger(udg_ht, task, 2, i - 1)
    else
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 200, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, damage, 5)
            endif
        endloop
        call DestroyEffect(AddSpecialEffect("bottlemissile.mdl", GetUnitX(u), GetUnitY(u)))
        call DestroyEffect(AddSpecialEffect("bottlemissile.mdl", GetUnitX(u) + 45, GetUnitY(u)))
        call DestroyEffect(AddSpecialEffect("bottlemissile.mdl", GetUnitX(u) - 45, GetUnitY(u)))
        call StopSoundBJ(gg_snd_TrollBatriderLiquidFire1, false)
        call DestroyGroup(g)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_MarisaEx_Funtioned takes unit caster, real tx, real ty, real damage returns nothing
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = Atan2(ty - oy, tx - ox)
    local real dis
    local real dis2
    local timer t
    local integer task
    set t = CreateTimer()
    set task = GetHandleId(t)
    set dis = SquareRoot((tx - ox) * (tx - ox) + (ty - oy) * (ty - oy))
    set dis2 = 25
    set u = CreateUnit(GetOwningPlayer(caster), 'n04J', ox, oy, bj_RADTODEG * a)
    call PlaySoundOnUnitBJ(gg_snd_TrollBatriderLiquidFire1, 128, u)
    call SetUnitPathing(u, false)
    call EnableHeight(u)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, R2I(RMaxBJ(dis / dis2, 1)))
    call SaveReal(udg_ht, task, 3, a)
    call SaveReal(udg_ht, task, 4, dis2)
    call SaveReal(udg_ht, task, 5, damage)
    call TimerStart(t, 0.01, true, function Trig_MarisaEx_Main)
    set caster = null
    set u = null
    set t = null
endfunction

function Trig_MarisaEx_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer abid = GetSpellAbilityId()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local integer i = GetPlayerId(GetOwningPlayer(caster)) + 1
    local integer c = LoadInteger(udg_HeroDatabase, GetUnitTypeId(caster), 'PRIM')
    local real basedamage = 120
    local real incdamage = 0.7
    local real damage = ABCIAllInt(caster, basedamage, incdamage)
    if udg_PlayerPower[i] < 2 then
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "|cffff0000There are not enough P points to activate the explosion.|r")
        call AbilityCoolDownReset(caster, abid)
        set caster = null
        return
    endif
    set udg_PlayerPower[i] = udg_PlayerPower[i] - 2
    if c == 1 then
        call SetHeroStr(caster, GetHeroStr(caster, false) - 2, true)
    elseif c == 2 then
        call SetHeroAgi(caster, GetHeroAgi(caster, false) - 2, true)
    elseif c == 3 then
        call SetHeroInt(caster, GetHeroInt(caster, false) - 2, true)
    endif
    call AbilityCoolDownResetion(caster, abid, 16.0)
    call Trig_MarisaEx_Funtioned(caster, tx, ty, damage)
    set caster = null
endfunction

function InitTrig_MarisaEx takes nothing returns nothing
endfunction