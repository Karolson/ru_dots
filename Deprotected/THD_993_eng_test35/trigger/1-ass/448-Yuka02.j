function Trig_Yuka02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A06I'
endfunction

function Trig_Yuka02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u
    local unit w
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer j = LoadInteger(udg_ht, task, 3)
    local real damage = LoadReal(udg_ht, task, 4)
    local real ox = LoadReal(udg_ht, task, 5)
    local real oy = LoadReal(udg_ht, task, 6)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real a = Atan2(ty - oy, tx - ox)
    set ox = ox + 10.0 * Cos(a)
    set oy = oy + 10.0 * Sin(a)
    set j = j - 1
    if j == 0 then
        set j = 8
        set i = i - 1
        call Yuka_Create_Temp_Flower(caster, ox, oy, 4.0, R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.2), R2I(0.3 * GetUnitAttack(caster)))
    endif
    call SaveInteger(udg_ht, task, 2, i)
    call SaveInteger(udg_ht, task, 3, j)
    call SaveReal(udg_ht, task, 5, ox)
    call SaveReal(udg_ht, task, 6, oy)
    if IsUnitInRangeXY(target, ox, oy, 20.0) then
        call UnitPhysicalDamageTarget(caster, target, damage)
        call UnitStunTarget(caster, target, 1.5, 0, 0)
        set i = 0
    endif
    if i == 0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
    set u = null
    set w = null
endfunction

function Trig_Yuka02_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A06I')
    local real damage = 50 + level * 50 + GetUnitAttack(caster)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx
    local real ty
    local real a
    local timer t2
    local integer task2
    call AbilityCoolDownResetion(caster, 'A06I', 15)
    if IsUnitAlly(target, GetTriggerPlayer()) == false then
        if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusion(target) == false then
            call Item_BLTalismanicRunningCD(target)
            set caster = null
            set target = null
            set t = null
            set t2 = null
            return
        endif
    endif
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveInteger(udg_ht, task, 2, 20)
    call SaveInteger(udg_ht, task, 3, 8)
    call SaveReal(udg_ht, task, 4, damage)
    call SaveReal(udg_ht, task, 5, ox)
    call SaveReal(udg_ht, task, 6, oy)
    call TimerStart(t, 0.01, true, function Trig_Yuka02_Main)
    if udg_SK_Yuka_Unit != null then
        set t2 = CreateTimer()
        set task2 = GetHandleId(t2)
        set ox = GetUnitX(udg_SK_Yuka_Unit)
        set oy = GetUnitY(udg_SK_Yuka_Unit)
        set tx = GetUnitX(target)
        set ty = GetUnitY(target)
        set a = Atan2(ty - oy, tx - ox)
        call SetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA, GetUnitState(udg_SK_Yuka_Unit, UNIT_STATE_MANA) - 100)
        call SetUnitFacing(udg_SK_Yuka_Unit, 57.29578 * a)
        call IssueImmediateOrderById(udg_SK_Yuka_Unit, 851972)
        call SaveUnitHandle(udg_ht, task2, 0, caster)
        call SaveUnitHandle(udg_ht, task2, 1, target)
        call SaveInteger(udg_ht, task2, 2, 20)
        call SaveInteger(udg_ht, task2, 3, 8)
        call SaveReal(udg_ht, task2, 4, damage)
        call SaveReal(udg_ht, task2, 5, ox)
        call SaveReal(udg_ht, task2, 6, oy)
        call TimerStart(t2, 0.01, true, function Trig_Yuka02_Main)
    endif
    set caster = null
    set target = null
    set t = null
    set t2 = null
endfunction

function InitTrig_Yuka02 takes nothing returns nothing
endfunction