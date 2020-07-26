function Trig_Tokiko04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0ZN'
endfunction

function Trig_Tokiko04_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real a = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer j = LoadInteger(udg_ht, task, 4)
    if a <= 360 then
        set a = a + 7.2
    else
        set a = a - 360
    endif
    call SetUnitXY(u, GetUnitX(caster) + 45 * CosBJ(a), GetUnitY(caster) + 45 * SinBJ(a))
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, i + 1)
    if i >= j then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Tokiko04_Fire takes unit caster, unit u, real a, integer i returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SetUnitXY(u, GetUnitX(caster) + 45 * CosBJ(a), GetUnitY(caster) + 45 * SinBJ(a))
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveReal(udg_ht, task, 2, a)
    call SaveInteger(udg_ht, task, 3, 1)
    call SaveInteger(udg_ht, task, 4, i * 50)
    call TimerStart(t, 0.02, true, function Trig_Tokiko04_Fire_Main)
    set t = null
endfunction

function Trig_Tokiko04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer lifebonus = LoadInteger(udg_ht, task, 1)
    local integer atkbonus = LoadInteger(udg_ht, task, 2)
    local integer intbonus = LoadInteger(udg_ht, task, 3)
    local real r = GetWidgetLife(caster) / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    call UnitAddMaxLife(caster, -lifebonus)
    call SetUnitState(caster, UNIT_STATE_LIFE, r * GetUnitState(caster, UNIT_STATE_MAX_LIFE))
    call UnitReduceAttackDamage(caster, atkbonus)
    call UnitAddBonusInt(caster, -intbonus)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_Tokiko04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0ZN')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer lifebonus = R2I((0.25 + 0.05 * level) * GetUnitState(target, UNIT_STATE_MAX_LIFE))
    local integer atkbonus = R2I((0.25 + 0.05 * level) * GetUnitAttack(target))
    local integer intbonus = R2I((0.25 + 0.05 * level) * GetHeroInt(target, true))
    local unit u
    local integer i
    local real r
    call AbilityCoolDownResetion(caster, 'A0ZN', 115 - 15 * level)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04H', GetUnitX(target) + 45 * Cos(0), GetUnitY(target) + 45 * Sin(0), 0)
    call SetUnitState(u, UNIT_STATE_LIFE, 25 + level * 25)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04H', GetUnitX(target) + 45 * Cos(1.57086), GetUnitY(target) + 45 * Sin(1.57086), 90)
    call SetUnitState(u, UNIT_STATE_LIFE, 25 + level * 25)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04H', GetUnitX(target) + 45 * Cos(3.14159), GetUnitY(target) + 45 * Sin(3.14159), 180)
    call SetUnitState(u, UNIT_STATE_LIFE, 25 + level * 25)
    set u = CreateUnit(GetOwningPlayer(caster), 'n04H', GetUnitX(target) + 45 * Cos(4.71239), GetUnitY(target) + 45 * Sin(4.71239), 270)
    call SetUnitState(u, UNIT_STATE_LIFE, 25 + level * 25)
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl", GetUnitX(caster), GetUnitY(caster)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", GetUnitX(caster), GetUnitY(caster)))
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl", GetUnitX(target), GetUnitY(target)))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", GetUnitX(target), GetUnitY(target)))
    call UnitMagicDamageTarget(caster, target, level * 70 + 70 + 2.0 * GetHeroInt(caster, true), 1)
    set r = GetWidgetLife(caster) / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    call UnitAddMaxLife(caster, lifebonus)
    call UnitHealingTarget(caster, caster, r * GetUnitState(caster, UNIT_STATE_MAX_LIFE) - GetUnitState(caster, UNIT_STATE_LIFE))
    call UnitAddAttackDamage(caster, atkbonus)
    call UnitAddBonusInt(caster, intbonus)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, lifebonus)
    call SaveInteger(udg_ht, task, 2, atkbonus)
    call SaveInteger(udg_ht, task, 3, intbonus)
    call TimerStart(t, 6 + 6 * level, false, function Trig_Tokiko04_Clear)
    set i = 0
    loop
        set u = CreateUnit(GetOwningPlayer(caster), 'n04I', GetUnitX(caster), GetUnitY(caster), i * 90)
        call Trig_Tokiko04_Fire(caster, u, i * 90, 6 + 6 * level)
        set i = i + 1
    exitwhen i == 4
    endloop
    set caster = null
    set target = null
    set u = null
    set t = null
endfunction

function InitTrig_Tokiko04 takes nothing returns nothing
endfunction