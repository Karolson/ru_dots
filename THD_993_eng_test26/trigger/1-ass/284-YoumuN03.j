function Trig_YoumuN03_Follow takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 0)
    local integer i = LoadInteger(udg_sht, GetHandleId(t), 1)
    local integer task = GetHandleId(caster)
    local unit u = LoadUnitHandle(udg_sht, task, 0)
    local unit v = LoadUnitHandle(udg_sht, task, 1)
    local boolean k = LoadBoolean(udg_sht, task, 0)
    local boolean q = LoadBoolean(udg_sht, task, 1)
    local boolean illusion = LoadBoolean(udg_sht, task, 2)
    local boolean l = GetWidgetLife(caster) >= 0.405
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real dx
    local real dy
    local real a = GetUnitFacing(caster) - 75.0
    local real d
    if q and l then
        if not k then
            call ShowUnit(u, true)
            call UnitAddAbility(u, 'Aloc')
            call SaveBoolean(udg_sht, task, 0, true)
        endif
        if IsUnitInvisible(caster, Player(bj_PLAYER_NEUTRAL_EXTRA)) then
            call ShowUnit(u, false)
            call UnitRemoveAbility(u, 'Aloc')
        else
            call ShowUnit(u, true)
            call UnitAddAbility(u, 'Aloc')
        endif
        set px = ox + 75.0 * CosBJ(a)
        set py = oy + 75.0 * SinBJ(a)
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set dx = px - ox
        set dy = py - oy
        set d = SquareRoot(dx * dx + dy * dy)
        set a = Atan2(dy, dx)
        call SetUnitFacing(u, bj_RADTODEG * a)
        if d <= 400.0 then
            set d = d / 40.0
            set px = ox + d * Cos(a)
            set py = oy + d * Sin(a)
            call SetUnitX(u, px)
            call SetUnitY(u, py)
            call TimerStart(t, 0.02, false, function Trig_YoumuN03_Follow)
        elseif d <= 1500.0 then
            call IssuePointOrder(u, "move", px, py)
            call TimerStart(t, 0.5, false, function Trig_YoumuN03_Follow)
        else
            call SetUnitPosition(u, px, py)
            call TimerStart(t, 0.02, false, function Trig_YoumuN03_Follow)
        endif
        if i / 256 * 256 == i then
            call SetUnitFlyHeight(u, GetRandomReal(30.0, 70.0), 10.0)
        endif
        call SaveInteger(udg_sht, GetHandleId(t), 1, i + 1)
    else
        if IsUnitDead(caster) and not q then
            call KillUnit(v)
        endif
        if k then
            call ShowUnit(u, false)
            call UnitRemoveAbility(u, 'Aloc')
            call SaveBoolean(udg_sht, task, 0, false)
        endif
        call SetUnitX(u, ox)
        call SetUnitY(u, oy)
        if not illusion then
            call TimerStart(t, 0.02, false, function Trig_YoumuN03_Follow)
        else
            call FlushChildHashtable(udg_sht, GetHandleId(t))
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_sht, task)
        endif
    endif
    set t = null
    set caster = null
    set u = null
    set v = null
endfunction

function Trig_YoumuN03_Init takes unit h, boolean illusion returns nothing
    local timer t = CreateTimer()
    local integer task
    local unit u
    call SaveUnitHandle(udg_sht, GetHandleId(t), 0, h)
    call SaveInteger(udg_sht, GetHandleId(t), 1, 0)
    set u = CreateUnit(GetOwningPlayer(h), 'n02S', GetUnitX(h), GetUnitY(h), 0.0)
    set task = GetHandleId(h)
    call SaveUnitHandle(udg_sht, task, 0, u)
    call SaveUnitHandle(udg_sht, task, 1, null)
    call SaveBoolean(udg_sht, task, 0, true)
    call SaveBoolean(udg_sht, task, 1, true)
    call SaveBoolean(udg_sht, task, 2, illusion)
    call TimerStart(t, 0.02, false, function Trig_YoumuN03_Follow)
    set t = null
    set u = null
endfunction

function Trig_YoumuN03_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        return GetSpellAbilityId() == 'A1GI'
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        return GetUnitTypeId(GetSummonedUnit()) == 'O019'
    endif
    if GetTriggerEventId() == EVENT_PLAYER_UNIT_DEATH then
        return IsUnitIllusion(GetTriggerUnit())
    endif
    return false
endfunction

function Trig_YoumuN03_Duplicate_Order_Issue takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit v = LoadUnitHandle(udg_ht, task, 0)
    local integer ID = LoadInteger(udg_ht, task, 0)
    local integer k = LoadInteger(udg_ht, task, 1)
    if k == 1 then
        call IssueImmediateOrderById(v, ID)
    elseif k == 2 then
        call IssuePointOrderById(v, ID, LoadReal(udg_ht, task, 0), LoadReal(udg_ht, task, 1))
    elseif k == 3 then
        call IssueTargetOrderById(v, ID, LoadUnitHandle(udg_ht, task, 1))
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set v = null
endfunction

function Trig_YoumuN03_Duplicate_Order takes nothing returns nothing
    local integer ID = GetIssuedOrderId()
    local unit caster = GetTriggerUnit()
    local unit target = GetOrderTargetUnit()
    local unit v = LoadUnitHandle(udg_sht, GetHandleId(caster), 1)
    local real tx = GetOrderPointX()
    local real ty = GetOrderPointY()
    local timer t
    local integer task
    if v != null and ID <= 852032 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, v)
        call SaveInteger(udg_ht, task, 0, ID)
        if GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER then
            call SaveInteger(udg_ht, task, 1, 1)
        elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER then
            call SaveInteger(udg_ht, task, 1, 2)
            call SaveReal(udg_ht, task, 0, tx)
            call SaveReal(udg_ht, task, 1, ty)
        elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER then
            call SaveInteger(udg_ht, task, 1, 3)
            call SaveUnitHandle(udg_ht, task, 1, target)
        endif
        call TimerStart(t, 0.3, false, function Trig_YoumuN03_Duplicate_Order_Issue)
    endif
    set caster = null
    set target = null
    set v = null
    set t = null
endfunction

function Trig_YoumuN03_Actions takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit u
    local unit v
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 18)
        set caster = GetTriggerUnit()
        call SaveUnitHandle(udg_sht, task, 0, caster)
        set u = CreateUnit(GetOwningPlayer(caster), 'o00O', GetUnitX(caster), GetUnitY(caster), 270.0)
        call UnitAddAbility(u, 'A0E0')
        call SetUnitAbilityLevel(u, 'A0E0', GetUnitAbilityLevel(caster, 'A1GI'))
        call IssueTargetOrderById(u, 852274, caster)
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON and GetUnitTypeId(GetSummoningUnit()) == 'o00O' then
        set u = LoadUnitHandle(udg_sht, GetHandleId(caster), 0)
        set v = GetSummonedUnit()
        call UnitAddAbility(v, 'Aloc')
        call SetUnitVertexColor(v, 255, 255, 255, 160)
        call SetUnitX(v, GetUnitX(u))
        call SetUnitY(v, GetUnitY(u))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", v, "origin"))
        call SaveBoolean(udg_sht, GetHandleId(caster), 1, false)
        call SaveUnitHandle(udg_sht, GetHandleId(caster), 1, v)
        call EnableTrigger(gg_trg_YoumuN03)
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON and GetUnitTypeId(GetSummoningUnit()) != 'o00O' then
        call Trig_YoumuN03_Init(GetSummonedUnit(), true)
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_DEATH then
        call DisableTrigger(gg_trg_YoumuN03)
        set v = LoadUnitHandle(udg_sht, GetHandleId(caster), 1)
        if GetTriggerUnit() == v then
            call SaveBoolean(udg_sht, GetHandleId(caster), 1, true)
            call SaveUnitHandle(udg_sht, GetHandleId(caster), 1, null)
        endif
    endif
    set caster = null
    set u = null
    set v = null
endfunction

function InitTrig_YoumuN03 takes nothing returns nothing
endfunction