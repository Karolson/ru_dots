function Trig_BagetAccelerator_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A02V' then
        return true
    endif
    return false
endfunction

function Trig_BagetAccelerator_Destroy_Effect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    call DestroyEffect(LoadEffectHandle(udg_ht, task, 0))
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
endfunction

function Trig_BagetAccelerator_Move takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real damage = LoadReal(udg_ht, task, 2)
    local real speed = LoadReal(udg_ht, task, 3)
    local real angle = GetUnitFacing(target) * bj_DEGTORAD
    local group g = CreateGroup()
    local unit v
    local player p = GetOwningPlayer(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real txnext = tx + speed * Cos(angle)
    local real tynext = ty + speed * Sin(angle)
    local timer teffect = CreateTimer()
    call SaveEffectHandle(udg_ht, GetHandleId(teffect), 0, AddSpecialEffect("Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl", tx + 15.0 * Cos(angle + bj_PI), ty + 15.0 * Sin(angle + bj_PI)))
    call TimerStart(teffect, 0.1, false, function Trig_BagetAccelerator_Destroy_Effect)
    call SetUnitX(target, txnext)
    call SetUnitY(target, tynext)
    call GroupEnumUnitsInRangeFix(g, tx, ty, 80.0)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, p) and not LoadBoolean(udg_ht, task, GetHandleId(v)) then
            call UnitMagicDamageTarget(caster, v, damage, 5)
            call SaveBoolean(udg_ht, task, GetHandleId(v), true)
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set t = null
    set caster = null
    set target = null
    set teffect = null
endfunction

function Trig_BagetAccelerator_Move_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local timer tmove = LoadTimerHandle(udg_ht, task, 0)
    local integer taskmove = GetHandleId(tmove)
    local unit target = LoadUnitHandle(udg_ht, taskmove, 1)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real angle = (GetUnitFacing(target) - 180.0) * bj_DEGTORAD
    local real newx = tx
    local real newy = ty
    call ReleaseTimer(tmove)
    call ReleaseTimer(t)
    if GetCustomState(target, 1) == 0 and GetCustomState(target, 2) == 0 and GetCustomState(target, 3) == 0 and GetCustomState(target, 5) == 0 then
        call SetUnitPathing(target, true)
        loop
        exitwhen not IsTerrainPathable(newx, newy, PATHING_TYPE_WALKABILITY)
            set newx = newx + 6.0 * Cos(angle)
            set newy = newy + 6.0 * Sin(angle)
        endloop
        call SetUnitPosition(target, newx, newy)
    endif
    call FlushChildHashtable(udg_ht, task)
    call FlushChildHashtable(udg_ht, taskmove)
    set t = null
    set tmove = null
    set target = null
endfunction

function Trig_BagetAccelerator_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local timer tend = CreateTimer()
    local integer taskend = GetHandleId(tend)
    local integer mainstat = LoadInteger(udg_HeroDatabase, GetUnitTypeId(caster), 'PRIM')
    local real angle = (GetUnitFacing(target) - 180.0) * bj_DEGTORAD
    local real damage = 100.0
    local real distance = 600.0
    local real speed = 1800.0
    if mainstat == 1 then
        set damage = damage + 2.0 * GetHeroStr(caster, true)
    elseif mainstat == 2 then
        set damage = damage + 2.0 * GetHeroAgi(caster, true)
    elseif mainstat == 3 then
        set damage = damage + 2.0 * GetHeroInt(caster, true)
    endif
    if IsUnitEnemy(target, GetOwningPlayer(caster)) then
        call UnitMagicDamageTarget(caster, target, damage, 1)
    endif
    call SetUnitPathing(target, false)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveReal(udg_ht, task, 2, damage)
    call SaveReal(udg_ht, task, 3, speed * 0.01)
    call TimerStart(t, 0.01, true, function Trig_BagetAccelerator_Move)
    call SaveTimerHandle(udg_ht, taskend, 0, t)
    call TimerStart(tend, distance / speed, false, function Trig_BagetAccelerator_Move_End)
    call DestroyEffect(AddSpecialEffect("objects\\spawnmodels\\other\\neutralbuildingexplosion\\neutralbuildingexplosion.mdl", GetUnitX(target) + 25.0 * Cos(angle), GetUnitY(target) + 25.0 * Sin(angle)))
    set caster = null
    set target = null
    set t = null
    set tend = null
endfunction

function InitTrig_BagetAccelerator takes nothing returns nothing
    set gg_trg_BagetAccelerator = CreateTrigger()
    call TriggerAddAction(gg_trg_BagetAccelerator, function Trig_BagetAccelerator_Actions)
    call TriggerAddCondition(gg_trg_BagetAccelerator, Condition(function Trig_BagetAccelerator_Conditions))
    call TriggerRegisterAnyUnitEventFix(gg_trg_BagetAccelerator, EVENT_PLAYER_UNIT_SPELL_EFFECT)
endfunction