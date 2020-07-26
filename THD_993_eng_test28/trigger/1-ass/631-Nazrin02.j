function Trig_Nazrin02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0D8'
endfunction

function Trig_Nazrin02_Damage takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = GetEnteringUnit()
    local integer level = LoadInteger(udg_ht, task, 0)
    if GetWidgetLife(target) > 0.405 and IsUnitType(target, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(target, 'A0IL') > 0 == false then
        call UnitMagicDamageTarget(caster, target, 15 + level * 15 + GetHeroInt(caster, true) * 0.25, 6)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\DragonHawkMissile\\DragonHawkMissile.mdl", target, "chest"))
    endif
    set caster = null
    set target = null
endfunction

function Trig_Nazrin02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local real ox
    local real oy
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local real d = LoadReal(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local trigger trg
    local triggeraction tga
    if i > 0 and GetWidgetLife(target) > 0.405 then
        call SaveReal(udg_ht, task, 0, a + 3.6)
        call SaveInteger(udg_ht, task, 1, i - 1)
        set ox = GetUnitX(target)
        set oy = GetUnitY(target)
        set u = LoadUnitHandle(udg_ht, task, 4)
        set a = a + 120.0
        set px = ox + d * Cos(a * 0.017454)
        set py = oy + d * Sin(a * 0.017454)
        call SetUnitXYFly(u, px, py)
        set u = LoadUnitHandle(udg_ht, task, 5)
        set a = a + 120.0
        set px = ox + d * Cos(a * 0.017454)
        set py = oy + d * Sin(a * 0.017454)
        call SetUnitXYFly(u, px, py)
        set u = LoadUnitHandle(udg_ht, task, 6)
        set a = a + 120.0
        set px = ox + d * Cos(a * 0.017454)
        set py = oy + d * Sin(a * 0.017454)
        call SetUnitXYFly(u, px, py)
    else
        call UnitRemoveAbility(target, 'A0L9')
        set trg = LoadTriggerHandle(udg_ht, task, 2)
        set tga = LoadTriggerActionHandle(udg_ht, task, 3)
        call TriggerRemoveAction(trg, tga)
        call DestroyTrigger(trg)
        call RemoveUnit(LoadUnitHandle(udg_ht, task, 4))
        call RemoveUnit(LoadUnitHandle(udg_ht, task, 5))
        call RemoveUnit(LoadUnitHandle(udg_ht, task, 6))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set target = null
    set u = null
    set t = null
    set trg = null
    set tga = null
endfunction

function Trig_Nazrin02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0D8')
    local integer c
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real px
    local real py
    local real a = 0.0
    local real d = 120.0
    local real s
    local real r
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local trigger trg = CreateTrigger()
    local triggeraction tga = TriggerAddAction(trg, function Trig_Nazrin02_Damage)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call AbilityCoolDownResetion(caster, 'A0D8', 12)
    call UnitAddAbility(target, 'A0L9')
    call UnitMakeAbilityPermanent(target, true, 'A0I6')
    call UnitMakeAbilityPermanent(target, true, 'A0I7')
    call UnitMakeAbilityPermanent(target, true, 'A0L8')
    call UnitMakeAbilityPermanent(target, true, 'A0L9')
    call SetUnitAbilityLevel(target, 'A0I6', level)
    call SetUnitAbilityLevel(target, 'A0I7', level)
    call SetUnitAbilityLevel(target, 'A0L8', level)
    set c = R2I(50 * 7)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveTriggerHandle(udg_ht, task, 2, trg)
    call SaveTriggerActionHandle(udg_ht, task, 3, tga)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, c)
    call SaveReal(udg_ht, task, 0, a)
    call SaveReal(udg_ht, task, 1, d)
    set s = 2.0 + 0.3 * (level - 1)
    set r = 85.0 + 5.0 * level
    set a = a + 120.0
    set px = ox + d * Cos(a * 0.017454)
    set py = oy + d * Sin(a * 0.017454)
    set u = CreateUnit(GetOwningPlayer(caster), 'n03L', px, py, a)
    call SetUnitScale(u, s, s, s)
    call SaveUnitHandle(udg_ht, task, 4, u)
    call TriggerRegisterUnitInRange(trg, u, r, iff)
    set a = a + 120.0
    set px = ox + d * Cos(a * 0.017454)
    set py = oy + d * Sin(a * 0.017454)
    set u = CreateUnit(GetOwningPlayer(caster), 'n03L', px, py, a)
    call SetUnitScale(u, s, s, s)
    call SaveUnitHandle(udg_ht, task, 5, u)
    call TriggerRegisterUnitInRange(trg, u, r, iff)
    set a = a + 120.0
    set px = ox + d * Cos(a * 0.017454)
    set py = oy + d * Sin(a * 0.017454)
    set u = CreateUnit(GetOwningPlayer(caster), 'n03L', px, py, a)
    call SetUnitScale(u, s, s, s)
    call SaveUnitHandle(udg_ht, task, 6, u)
    call TriggerRegisterUnitInRange(trg, u, r, iff)
    call TimerStart(t, 0.02, true, function Trig_Nazrin02_Main)
    set task = GetHandleId(trg)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    set caster = null
    set target = null
    set u = null
    set t = null
    set iff = null
    set trg = null
    set tga = null
endfunction

function InitTrig_Nazrin02 takes nothing returns nothing
    set gg_trg_Nazrin02 = CreateTrigger()
    call TriggerAddAction(gg_trg_Nazrin02, function Trig_Nazrin02_Actions)
endfunction