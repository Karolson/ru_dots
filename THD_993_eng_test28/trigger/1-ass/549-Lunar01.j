function Trig_Lunar01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A19S'
endfunction

function Trig_Lunar01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real damage = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real px
    local real py
    local real a = Atan2(ty - oy, tx - ox)
    if target == null then
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set target = null
        set u = null
        return
    endif
    if i < 0 then
        set i = i + 1
        call SaveInteger(udg_ht, task, 4, i)
    else
        call SetUnitVertexColor(u, 0, 0, 255, 255)
        set px = ox + 25.0 * Cos(a)
        set py = oy + 25.0 * Sin(a)
        call SetUnitXY(u, px, py)
        call SetUnitFacing(u, bj_RADTODEG * a)
    endif
    if IsUnitInRange(u, target, 25.0) and i >= 0 then
        call UnitDamageTarget(caster, target, damage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        if udg_NewDebuffSys then
            call UnitSlowTargetAspd(caster, target, 60, 2.0, 3, 0)
            call UnitSlowTargetMspd(caster, target, 30, 2.0, 3, 0)
        else
            call UnitSlowTarget(caster, target, 2.0, 'A19T', 'B009')
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\Rifle\\RifleImpact.mdl", GetUnitX(target), GetUnitY(target)))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\Rifle\\RifleImpact.mdl", GetUnitX(target), GetUnitY(target)))
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_Lunar01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t
    local integer task
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local real damage
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 9 - level)
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set caster = null
            set target = null
            set t = null
            set u = null
            return
        endif
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    set damage = GetUnitAttack(caster) * (level * 0.01 + 0.05) + 15 + level * 15
    set u = CreateUnit(GetOwningPlayer(caster), 'e01Z', ox, oy, bj_RADTODEG * a)
    call SetUnitVertexColor(u, 0, 0, 255, 0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, damage)
    call SaveInteger(udg_ht, task, 4, 0)
    call TimerStart(t, 0.02, true, function Trig_Lunar01_Main)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'e01Z', ox, oy, bj_RADTODEG * a)
    call SetUnitVertexColor(u, 0, 0, 255, 0)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, damage)
    call SaveInteger(udg_ht, task, 4, -15)
    call TimerStart(t, 0.02, true, function Trig_Lunar01_Main)
    set caster = null
    set target = null
    set t = null
    set u = null
endfunction

function InitTrig_Lunar01 takes nothing returns nothing
endfunction