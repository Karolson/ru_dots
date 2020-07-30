function Kumoi03 takes nothing returns integer
    return 'A10E'
endfunction

function Kumoi03_SK takes nothing returns integer
    return 'A10L'
endfunction

function Trig_Kumoi03_Conditions takes nothing returns boolean
    local unit target = GetTriggerUnit()
    local unit caster = GetEventDamageSource()
    if GetEventDamage() == 0 then
        set target = null
        set caster = null
        return false
    elseif IsUnitIllusion(caster) then
        set target = null
        set caster = null
        return false
    elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        set target = null
        set caster = null
        return false
    elseif IsDamageNotUnitAttack(caster) then
        set target = null
        set caster = null
        return false
    elseif GetUnitAbilityLevel(caster, 'A10E') > 0 then
        set target = null
        set caster = null
        return true
    endif
    set target = null
    set caster = null
    return false
endfunction

function Trig_Kumoi03_Fist_Move takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local unit caster
    local unit target
    local integer level
    local integer i = LoadInteger(udg_ht, task, 0) + 8
    local real ox = LoadReal(udg_ht, task, 0)
    local real oy = LoadReal(udg_ht, task, 1)
    local real tx = LoadReal(udg_ht, task, 2)
    local real ty = LoadReal(udg_ht, task, 3)
    local real d = LoadReal(udg_ht, task, 4)
    local real a = Atan2(GetUnitY(u) - ty, GetUnitX(u) - tx)
    if i < 256 then
        call SetUnitX(u, GetUnitX(u) + d * Cos(a))
        call SetUnitY(u, GetUnitY(u) + d * Sin(a))
        call SetUnitVertexColor(u, 255, 255, 255, i)
        call SaveInteger(udg_ht, task, 0, i)
    else
        set caster = LoadUnitHandle(udg_ht, task, 1)
        set target = LoadUnitHandle(udg_ht, task, 2)
        set level = GetUnitAbilityLevel(caster, 'A10E')
        call SetUnitVertexColor(u, 255, 255, 255, 255)
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 3))
        call ReleaseSpecialDummy(u)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(u), GetUnitY(u)))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\OrbCorruption\\OrbCorruptionMissile.mdl", target, "origin"))
        call UnitPhysicalDamageTarget(caster, target, 40.0 * level - 30.0 + 1.0 * GetUnitAttack(caster))
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set caster = null
        set target = null
    endif
    set t = null
    set u = null
endfunction

function Trig_Kumoi03_PunchTo takes unit caster, unit target, real ox, real oy, real tx, real ty returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u = NewSpecialDummy(GetOwningPlayer(caster), ox, oy, 0)
    local effect e = AddSpecialEffectTarget("kumoi_2.mdx", u, "origin")
    call SetUnitPathing(u, false)
    call PauseUnit(u, true)
    call SetUnitVertexColor(u, 255, 255, 255, 0)
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveUnitHandle(udg_ht, task, 2, target)
    call SaveEffectHandle(udg_ht, task, 3, e)
    call SaveInteger(udg_ht, task, 0, 0)
    call SaveReal(udg_ht, task, 0, ox)
    call SaveReal(udg_ht, task, 1, oy)
    call SaveReal(udg_ht, task, 2, tx)
    call SaveReal(udg_ht, task, 3, ty)
    call SaveReal(udg_ht, task, 4, 0.03125 * SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)))
    call TimerStart(t, 0.0125, true, function Trig_Kumoi03_Fist_Move)
    set u = null
    set t = null
    set e = null
endfunction

function Trig_Kumoi03_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A10E')
    local real a = GetRandomReal(0.0, 6.2832)
    set udg_SK_Kumoi03 = udg_SK_Kumoi03 + 1
    if udg_SK_Kumoi03 == 3 then
        call UnitAddAbility(caster, 'A10L')
    endif
    if udg_SK_Kumoi03 == 4 then
        call UnitRemoveAbility(caster, 'A10L')
        call Trig_Kumoi03_PunchTo(caster, target, GetUnitX(target) + 250.0 * Cos(a), GetUnitY(target) + 250.0 * Sin(a), GetUnitX(target), GetUnitY(target))
        set udg_SK_Kumoi03 = 0
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Kumoi03 takes nothing returns nothing
endfunction