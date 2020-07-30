function Trig_SanaeEx_Main takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real s = Deg2Rad(GetUnitFacing(caster))
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local real dis = GetRandomReal(300, 700)
    call UnitRemoveAbility(caster, 'A00I')
    call UnitAddAbility(caster, 'A1GO')
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", x, y))
    set x = x + dis * Cos(s)
    set y = y + dis * Sin(s)
    call Trig_BlinkPlaceRealer(x, y, dis, s)
    set x = udg_SK_BlinkPlace_x
    set y = udg_SK_BlinkPlace_y
    call SetUnitX(caster, x)
    call SetUnitY(caster, y)
    call IssueImmediateOrder(caster, "stop")
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", x, y))
    set caster = null
endfunction

function Trig_SanaeEx_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A00I' then
        return true
    endif
    return false
endfunction

function Trig_Sanae01_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A1AC' then
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call UnitRemoveAbility(GetTriggerUnit(), 'A1AC')
        call SetPlayerAbilityAvailable(GetOwningPlayer(GetTriggerUnit()), 'A0RC', true)
    endif
    return GetSpellAbilityId() == 'A0RC'
endfunction

function Trig_Sanae01_Damage takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real damage = LoadReal(udg_ht, task, 2)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local integer level = LoadInteger(udg_ht, task, 6)
    local integer cnt = LoadInteger(udg_ht, task, 5) + 1
    call SaveInteger(udg_ht, task, 5, cnt)
    if I2R(R2I(I2R(cnt) * 0.02)) == I2R(cnt) * 0.02 then
        call UnitMagicDamageArea(caster, x, y, 250, damage, 6)
        call UnitSlowTargetArea(caster, x, y, 250, 1, 'A16T' + 4, 'B01C')
    endif
    if GetUnitAbilityLevel(caster, 'A1AC') > 0 then
        call SetUnitX(u, GetUnitX(caster) - LoadReal(udg_ht, task, 3))
        call SetUnitY(u, GetUnitY(caster) - LoadReal(udg_ht, task, 4))
    endif
    if cnt >= R2I(5.0 / 0.02) then
        call KillUnit(u)
        call FlushChildHashtable(udg_ht, task)
        call UnRegisterAreaShow(u, 'A0RC')
        call ReleaseTimer(t)
        call UnitRemoveAbility(caster, 'A1AC')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0RC', true)
    endif
    set u = null
    set t = null
    set caster = null
endfunction

function Sanae01_MoveToSamePoint takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER and GetIssuedOrderId() == 851971 or GetIssuedOrderId() == 851983 or GetIssuedOrderId() == 851986 then
        call IssuePointOrderById(LoadUnitHandle(udg_ht, GetHandleId(GetTriggeringTrigger()), 1), 851986, GetOrderPointX(), GetOrderPointY())
    elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER and GetIssuedOrderId() == 851971 or GetIssuedOrderId() == 851983 or GetIssuedOrderId() == 851986 then
        call IssueTargetOrderById(LoadUnitHandle(udg_ht, GetHandleId(GetTriggeringTrigger()), 1), 851986, GetOrderTarget())
    else
        call TriggerRemoveCondition(GetTriggeringTrigger(), LoadTriggerConditionHandle(udg_ht, GetHandleId(GetTriggeringTrigger()), 0))
        call FlushChildHashtable(udg_ht, GetHandleId(GetTriggeringTrigger()))
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    return false
endfunction

function Trig_Sanae01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local timer t
    local integer task
    local integer level = GetUnitAbilityLevel(caster, 'A0RC')
    if GetUnitAbilityLevel(caster, 'A1AC') != 0 then
        call AbilityCoolDownResetion(caster, 'A0RC', 11 - level * 0)
    endif
    call UnitAddAbility(caster, 'A1AC')
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0RC', false)
    call AbilityCoolDownResetion(caster, 'A0RC', 11)
    set t = CreateTimer()
    set task = GetHandleId(t)
    set u = CreateUnit(GetOwningPlayer(caster), 'n019', tx, ty, 270.0)
    call SetUnitAbilityLevel(u, 'A06T', level)
    call UnitApplyTimedLife(u, 'B04F', 5.0)
    call SetUnitMoveSpeed(u, GetUnitMoveSpeed(caster))
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveReal(udg_ht, task, 3, GetUnitX(caster) - tx)
    call SaveReal(udg_ht, task, 4, GetUnitY(caster) - ty)
    call SaveReal(udg_ht, task, 2, 12 + 12 * level + 0.5 * GetHeroInt(caster, true))
    call SaveInteger(udg_ht, task, 5, 0)
    call SaveInteger(udg_ht, task, 6, level)
    call TimerStart(t, 0.02, true, function Trig_Sanae01_Damage)
    call RegisterAreaShow(u, 'A0RC', 250, 4, 0, "Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl", 0.02)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Sanae01 takes nothing returns nothing
endfunction