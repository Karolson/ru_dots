function Nue02_Marker takes nothing returns integer
    return 'A0DW'
endfunction

function Trig_Nue02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0M2'
endfunction

function Trig_Nue02_Fly takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real facing = LoadReal(udg_ht, task, 2)
    local unit u = LoadUnitHandle(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local group grp2 = LoadGroupHandle(udg_ht, task, 5)
    local integer level = LoadInteger(udg_ht, task, 6)
    local group grp1 = CreateGroup()
    local unit target = null
    local real nmdamage = NueDamageCounting(caster) * 3.0
    call GroupEnumUnitsInRange(grp1, GetUnitX(u), GetUnitY(u), 140, null)
    loop
        set target = FirstOfGroup(grp1)
    exitwhen target == null
        call GroupRemoveUnit(grp1, target)
        if IsUnitEnemy(target, GetOwningPlayer(u)) and IsUnitInGroup(target, grp2) == false and IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, target, 70 + level * 30 + GetHeroInt(caster, true) * 1.3 + nmdamage, 5)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", GetUnitX(target), GetUnitY(target)))
            call GroupAddUnit(grp2, target)
        endif
    endloop
    call DestroyGroup(grp1)
    if i > 0 then
        call SaveInteger(udg_ht, task, 4, i - 1)
        call SetUnitXY(u, GetUnitX(u) + 40 * Cos(facing * bj_DEGTORAD), GetUnitY(u) + 40 * Sin(facing * bj_DEGTORAD))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", GetUnitX(u), GetUnitY(u)))
    else
        call DestroyGroup(grp2)
        call KillUnit(u)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", GetUnitX(u), GetUnitY(u)))
        call FlushChildHashtable(udg_ht, task)
        call ReleaseTimer(t)
    endif
    set t = null
    set u = null
    set grp1 = null
    set grp2 = null
    set caster = null
    set target = null
endfunction

function Trig_Nue02_Fire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real facing = LoadReal(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 6)
    local integer range
    local unit u = CreateUnit(GetOwningPlayer(caster), 'e018', GetUnitX(caster) + 10 * Cos(facing * bj_DEGTORAD), GetUnitY(caster) + 10 * Sin(facing * bj_DEGTORAD), facing)
    local group grp2 = CreateGroup()
    call PauseUnit(caster, false)
    call SetUnitTimeScale(caster, 1)
    call UnitRemoveAbility(caster, 'A0DW')
    call PauseTimer(t)
    call SaveUnitHandle(udg_ht, task, 3, u)
    if level == 1 then
        set range = 17
    endif
    if level == 2 then
        set range = 24
    endif
    if level == 3 then
        set range = 31
    endif
    if level == 4 then
        set range = 38
    endif
    call SaveInteger(udg_ht, task, 4, range)
    call SaveGroupHandle(udg_ht, task, 5, grp2)
    call TimerStart(t, 0.02, true, function Trig_Nue02_Fly)
    set t = null
    set caster = null
    set u = null
    set grp2 = null
endfunction

function Trig_Nue02_Go takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    call SetUnitTimeScale(caster, 2)
    call SetUnitAnimationByIndex(caster, 5)
    call PauseTimer(t)
    call TimerStart(t, 0.5, false, function Trig_Nue02_Fire)
    set t = null
    set caster = null
endfunction

function Trig_Nue02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real facing = 57.29578 * Atan2(GetSpellTargetY() - GetUnitY(caster), GetSpellTargetX() - GetUnitX(caster))
    local integer level = GetUnitAbilityLevel(caster, 'A0M2')
    call AbilityCoolDownResetion(caster, 'A0M2', 10 - level)
    call UnitAddAbility(caster, 'A0DW')
    call DMG_DamageReduce(caster, 0.75, 1, "All")
    call UnitMakeAbilityPermanent(caster, true, 'A0DW')
    call PauseUnit(caster, true)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 2, facing)
    call SaveInteger(udg_ht, task, 6, level)
    call TimerStart(t, 0.01, false, function Trig_Nue02_Go)
    set caster = null
    set t = null
endfunction

function InitTrig_Nue02 takes nothing returns nothing
endfunction