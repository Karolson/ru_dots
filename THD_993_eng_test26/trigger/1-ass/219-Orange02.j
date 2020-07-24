function OrangeAb02 takes nothing returns integer
    return 'A0TM'
endfunction

function Trig_Orange02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0TM'
endfunction

function Trig_Orange02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit w
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i
    local integer j
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    set i = 0
    loop
        set i = i + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl", tx + CosBJ(i * 18) * 300, ty + SinBJ(i * 18) * 300))
    exitwhen i == 18
    endloop
    set i = 0
    loop
        set i = i + 1
        set j = 0
        loop
            set j = j + 1
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl", tx + CosBJ(i * 72) * j * 40, ty + SinBJ(i * 72) * j * 40))
        exitwhen j == 7
        endloop
    exitwhen i == 4
    endloop
    set udg_SK_Chen02 = null
    if udg_SK_Chen02_Stun then
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 35 + level * 25, 1.35), 1)
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, target, (1.2 + 0.3 * level) * 1.0, 2, true, 'A0QV', 1, 'B07U', "firebolt", 0, "")
        else
            call UnitStunTarget(caster, target, 1.2 + 0.3 * level, 0, 0)
        endif
    else
        call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 35 + level * 25, 1.35), 1)
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, target, (1.2 + 0.3 * level) * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A04N', "")
        else
            call UnitCurseTarget(caster, target, 1.2 + 0.3 * level, 'A04K', "drunkenhaze")
        endif
    endif
    call Trig_Orange03_Effecting(caster)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
    set w = null
endfunction

function Trig_Orange02_Functioned takes unit caster, unit target, integer level returns nothing
    local timer t
    local integer task
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local integer i
    local integer j
    set i = 0
    loop
        set i = i + 1
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl", tx + CosBJ(i * 18) * 300, ty + SinBJ(i * 18) * 300))
    exitwhen i == 18
    endloop
    set i = 0
    loop
        set i = i + 1
        set j = 0
        loop
            set j = j + 1
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl", tx + CosBJ(i * 72) * j * 40, ty + SinBJ(i * 72) * j * 40))
        exitwhen j == 7
        endloop
    exitwhen i == 5
    endloop
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 35 + level * 25, 1.35), 1)
    set udg_SK_Chen02 = target
    set udg_SK_Chen02_Stun = false
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, level)
    call TimerStart(t, 3.0, false, function Trig_Orange02_Clear)
    set t = null
endfunction

function Trig_Orange02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 9)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            return
        endif
    endif
    call Trig_Orange02_Functioned(caster, target, level)
    set caster = null
    set target = null
endfunction

function InitTrig_Orange02 takes nothing returns nothing
endfunction