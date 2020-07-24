function Trig_Yamame_Dis_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif GetEventDamage() == 0.0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return GetUnitAbilityLevel(GetEventDamageSource(), 'A0RD') > 0 and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) and GetUnitAbilityLevel(GetTriggerUnit(), 'A08A') == 0
endfunction

function Trig_Yamame_Dis_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real damage = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    set i = i - 1
    call SaveInteger(udg_ht, task, 3, i)
    if IsUnitType(target, UNIT_TYPE_DEAD) == false then
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PoisonArrow\\PoisonArrowMissile.mdl", tx, ty))
        set u = NewSpecialDummy(GetOwningPlayer(caster), tx, ty, 0)
        call UnitMagicDamageTarget(u, target, damage, 2)
        call ReleaseSpecialDummy(u)
    endif
    if i == 0 or IsUnitType(target, UNIT_TYPE_DEAD) then
        call UnitRemoveAbility(target, 'A08A')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Yamame_Dis_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real damage = 30.0 + 3.0 * GetHeroLevel(caster)
    call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\PoisonArrow\\PoisonArrowMissile.mdl", tx, ty))
    call UnitAddAbility(target, 'A08A')
    call UnitMakeAbilityPermanent(target, true, 'A08A')
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveReal(udg_ht, task, 2, damage)
    call SaveInteger(udg_ht, task, 3, 4)
    call TimerStart(t, 1.0, true, function Trig_Yamame_Dis_Main)
    set t = null
    set caster = null
    set target = null
endfunction

function InitTrig_Yamame_Dis takes nothing returns nothing
endfunction