function Trig_Satsuki03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1HC'
endfunction

function Trig_Satsuki03_CallBack takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer cnt = LoadInteger(udg_ht, task, 1)
    local integer dur = LoadInteger(udg_ht, task, 2) - 1
    local integer level = LoadInteger(udg_ht, task, 3)
    local unit u
    local group g
    local integer i
    local unit v
    local boolean flag = false
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call SaveInteger(udg_ht, task, 2, dur)
    set i = 0
    set g = CreateGroup()
    loop
    exitwhen i >= cnt or flag or dur > 5 * 50
        set u = LoadUnitHandle(udg_ht, task, 5 + i)
        if dur == 5 * 50 then
            call SetUnitAnimation(u, "stand")
        endif
        call GroupClear(g)
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 60.0, iff)
        set v = FirstOfGroup(g)
        if v != null and GetWidgetLife(v) >= 0.405 and IsUnitType(v, UNIT_TYPE_HERO) then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", GetUnitX(v), GetUnitY(v)))
            call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, -30 + level * 70, 1.8), 5)
            call UnitStunTarget(caster, v, 1.6 + level * 0.2, 0, 0)
            set i = cnt
            set flag = true
            set dur = -1
        endif
        set i = i + 1
    endloop
    call DestroyGroup(g)
    if dur <= 0 or flag then
        set i = 0
        call PauseTimer(t)
        call ReleaseTimer(t)
        call DebugMsg("PauseTimer")
        loop
        exitwhen i == cnt
            set u = LoadUnitHandle(udg_ht, task, 5 + i)
            call KillUnit(u)
            set i = i + 1
        endloop
        call DebugMsg("PauseSuccess")
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
    set iff = null
    set g = null
endfunction

function Trig_Satsuki03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real ux
    local real uy
    local real a = Atan2(ty - oy, tx - ox) * bj_RADTODEG
    local real dis = RMinBJ(SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox)), 1000)
    local integer i = 0
    local integer cnt = 600 / 50
    local unit u
    local timer t
    local real j = -300
    local integer task
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 12)
    set t = CreateTimer()
    set task = GetHandleId(t)
    loop
    exitwhen i == cnt
        set ux = ox + Cos(a * bj_DEGTORAD) * dis + Cos((a + 90) * bj_DEGTORAD) * j
        set uy = oy + Sin(a * bj_DEGTORAD) * dis + Sin((a + 90) * bj_DEGTORAD) * j
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\HealingSpray\\HealBottleMissile.mdl", ux, uy))
        set u = CreateUnit(GetOwningPlayer(caster), 'e03Z', ux, uy, bj_RADTODEG * a)
        call SetUnitAnimation(u, "birth")
        call SaveUnitHandle(udg_ht, task, 5 + i, u)
        set j = j + 50
        set i = i + 1
    endloop
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, cnt)
    call SaveInteger(udg_ht, task, 2, 5 * 50 + 34)
    call SaveInteger(udg_ht, task, 3, level)
    call TimerStart(t, 0.02, true, function Trig_Satsuki03_CallBack)
    set u = null
    set t = null
    set caster = null
endfunction

function InitTrig_Satsuki03 takes nothing returns nothing
endfunction