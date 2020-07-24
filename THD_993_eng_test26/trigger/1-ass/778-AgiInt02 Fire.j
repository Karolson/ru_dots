function Trig_AgiInt02_Fire_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A18K' then
        return true
    elseif GetSpellAbilityId() == 'A18L' then
        return true
    elseif GetSpellAbilityId() == 'A18M' then
        return true
    elseif GetSpellAbilityId() == 'A18N' then
        return true
    elseif GetSpellAbilityId() == 'A18O' then
        return true
    endif
    return false
endfunction

function Trig_AgiInt02_Fire_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real damage = LoadReal(udg_ht, task, 3)
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
    set px = ox + 18.0 * Cos(a)
    set py = oy + 18.0 * Sin(a)
    call SetUnitXY(u, px, py)
    call SetUnitFacing(u, bj_RADTODEG * a)
    if IsUnitInRange(u, target, 20.0) then
        call UnitMagicDamageTarget(caster, target, damage, 3)
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function Trig_AgiInt02_Fire_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    local real damage
    if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) == false then
        if IsUnitType(GetSpellTargetUnit(), UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] and IsUnitIllusionBJ(GetSpellTargetUnit()) == false then
            call Item_BLTalismanicRunningCD(GetSpellTargetUnit())
            set t = null
            set caster = null
            set target = null
            set u = null
            return
        endif
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    if GetSpellAbilityId() == 'A18K' then
        set damage = 80 + (GetUnitState(target, UNIT_STATE_MAX_LIFE) - GetUnitState(target, UNIT_STATE_LIFE)) * 0.4
    elseif GetSpellAbilityId() == 'A18L' then
        set damage = 300
    elseif GetSpellAbilityId() == 'A18M' then
        set damage = 400
    elseif GetSpellAbilityId() == 'A18N' then
        set damage = 500
    elseif GetSpellAbilityId() == 'A18O' then
        set damage = 600
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'e02K', ox, oy, bj_RADTODEG * a)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, damage)
    call TimerStart(t, 0.02, true, function Trig_AgiInt02_Fire_Main)
    set t = null
    set caster = null
    set target = null
    set u = null
endfunction

function InitTrig_AgiInt02_Fire takes nothing returns nothing
    set gg_trg_AgiInt02_Fire = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AgiInt02_Fire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_AgiInt02_Fire, Condition(function Trig_AgiInt02_Fire_Conditions))
    call TriggerAddAction(gg_trg_AgiInt02_Fire, function Trig_AgiInt02_Fire_Actions)
endfunction