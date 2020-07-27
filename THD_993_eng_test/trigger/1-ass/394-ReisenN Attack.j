function Trig_ReisenN04_CallBack takes nothing returns nothing
    local unit caster = udg_PS_Source
    local unit target = udg_PS_Target
    local integer level = GetUnitAbilityLevel(caster, 'A1GT')
    local real damage = ABCIAllInt(caster, 0 - 50 + 150 * level, 2.7)
    call UnitMagicDamageTarget(caster, target, damage, 1)
    call DestroyEffect(AddSpecialEffect("RedLaser.mdl", GetUnitX(target), GetUnitY(target)))
endfunction

function Trig_ReisenN04_Timeout takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit dummy = LoadUnitHandle(udg_ht, task, 2)
    local unit target = LoadUnitHandle(udg_ht, task, 3)
    if GetWidgetLife(dummy) >= 0.405 then
        call LaunchProjectileToUnitEx("RedLaserX.mdl", 2.0, caster, GetUnitX(dummy), GetUnitY(dummy), 1400, target, "Trig_ReisenN04_CallBack")
        call PauseUnit(dummy, false)
        call SetUnitAnimation(dummy, "attack")
    endif
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
    set dummy = null
endfunction

function Trig_ReisenN04_Main takes unit caster, unit dummy, unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveUnitHandle(udg_ht, task, 2, dummy)
    call SaveUnitHandle(udg_ht, task, 3, target)
    call UnitAddAbility(dummy, 'A1DI')
    call PauseUnit(dummy, true)
    call SetUnitAnimation(dummy, "stand")
    call TimerStart(t, 4.0, false, function Trig_ReisenN04_Timeout)
    set t = null
endfunction

function Trig_ReisenN_Attack_Conditions takes nothing returns boolean
    local unit h
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        if GetUnitAbilityLevel(GetEventDamageSource(), 'A0RW') == 0 then
            return false
        elseif GetEventDamage() == 0.0 then
            return false
        elseif IsUnitAlly(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit())) then
            return false
        elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
            return false
        elseif IsUnitIllusion(GetEventDamageSource()) then
            return false
        endif
        return true
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        if GetUnitTypeId(GetSummonedUnit()) != 'O016' then
            return false
        elseif IsUnitIllusion(GetSummonedUnit()) != true then
            return false
        endif
        set h = GetPlayerCharacter(GetOwningPlayer(GetSummonedUnit()))
        if LoadInteger(udg_ht, GetHandleId(h), 1) == 3 then
            call SetUnitXYGround(GetSummonedUnit(), LoadReal(udg_ht, GetHandleId(h), 2), LoadReal(udg_ht, GetHandleId(h), 3))
            call UnitApplyTimedLife(GetSummonedUnit(), 'B0A3', 1 + GetUnitAbilityLevel(h, 'A1GR'))
        endif
        if LoadInteger(udg_ht, GetHandleId(h), 1) == 4 then
            call SetUnitXYGround(GetSummonedUnit(), LoadReal(udg_ht, GetHandleId(h), 2), LoadReal(udg_ht, GetHandleId(h), 3))
            call Trig_ReisenN04_Main(LoadUnitHandle(udg_ht, GetHandleId(h), 4), GetSummonedUnit(), LoadUnitHandle(udg_ht, GetHandleId(h), 5))
        endif
        return false
    endif
    return false
endfunction

function Trig_ReisenN_Attack_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer ab02level = GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A1GS')
    local real damage = 1.0
    local real krsv = 0.0
    local real krsu = 0.0
    local real a = AngleBetweenUnits(target, caster)
    local real b = GetUnitFacing(target)
    local real ox
    local real oy
    local real tx
    local real ty
    local real dis
    set krsv = GetUnitMagicResist(target) * 3.5
    if krsv != 0 then
        call UnitAbsDamageTarget(caster, target, krsv)
    endif
    if ab02level >= 1 and not IsUnitType(target, UNIT_TYPE_MECHANICAL) and caster != target then
        if GetUnitAbilityLevel(caster, 'A1GP') != 0 then
            set ox = GetUnitX(caster)
            set oy = GetUnitY(caster)
            set tx = GetUnitX(target)
            set ty = GetUnitY(target)
            set dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
            call UnitRemoveAbility(caster, 'A1GP')
            set damage = 1.0
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", target, "chest"))
            set krsu = ABCIAllInt(caster, 45 * ab02level, 2.0) * damage
            call UnitMagicDamageTarget(caster, target, krsu, 1)
            if dis < 250 then
                call UnitStunTarget(caster, target, 1.0 * damage, 0, 0)
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", target, "chest"))
        endif
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_ReisenN_Attack takes nothing returns nothing
endfunction