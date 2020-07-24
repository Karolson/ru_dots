function Trig_Nazrin_Pet_Collect takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local item w = GetEnumItem()
    if GetItemTypeId(w) == 'I03F' and GetWidgetLife(w) > 0 then
        call SaveBoolean(udg_ht, task, 1, true)
        call SaveItemHandle(udg_ht, task, 2, w)
    endif
    set w = null
    set t = null
endfunction

function Trig_Nazrin_Pet_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit h = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local item w
    local rect r
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local real px
    local real py
    local real a
    local real d
    local integer i = LoadInteger(udg_ht, task, 1)
    local boolean k = LoadBoolean(udg_ht, task, 0)
    if h == null then
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set h = null
        set u = null
        set w = null
        set r = null
        return
    endif
    if GetWidgetLife(h) >= 0.405 then
        if IsUnitVisible(h, GetLocalPlayer()) == false then
            call SetUnitVertexColor(u, 255, 255, 255, 0)
        else
            call SetUnitVertexColor(u, 255, 255, 255, 255)
        endif
        if k then
            call ShowUnit(u, true)
            call PauseUnit(u, false)
            call SaveBoolean(udg_ht, task, 0, false)
            call UnitRemoveAbility(u, 'Aloc')
            call UnitAddAbility(u, 'Aloc')
            call SetUnitPosition(u, ox, oy)
        endif
        if not IsUnitInRange(u, h, 1200.0) then
            call SetUnitPosition(u, ox, oy)
        endif
        set w = null
        set k = false
        if udg_SK_Nazrin_Pick then
            set r = Rect(ox - 512.0, oy - 512.0, ox + 512.0, oy + 512.0)
            call SaveBoolean(udg_ht, task, 1, false)
            call EnumItemsInRect(r, null, function Trig_Nazrin_Pet_Collect)
            set k = LoadBoolean(udg_ht, task, 1)
            set w = LoadItemHandle(udg_ht, task, 2)
            call RemoveRect(r)
        endif
        if k then
            call IssueTargetOrder(u, "smart", w)
            call SaveInteger(udg_ht, task, 1, i + 5)
            call TimerStart(t, 2.5, false, function Trig_Nazrin_Pet_Main)
        else
            if IsUnitInRange(u, h, 250.0) == false or GetRandomReal(0.0, 100.0) < 15.0 then
                set a = GetRandomReal(0.0, 6.28344)
                set d = GetRandomReal(40.0, 160.0)
                set px = ox + d * Cos(a)
                set py = oy + d * Sin(a)
                call IssuePointOrder(u, "move", px, py)
            endif
            call SaveInteger(udg_ht, task, 1, i + 1)
            call TimerStart(t, 0.5, false, function Trig_Nazrin_Pet_Main)
        endif
    else
        if k == false then
            call ShowUnit(u, false)
            call PauseUnit(u, true)
            call SaveBoolean(udg_ht, task, 0, true)
        endif
        call SaveInteger(udg_ht, task, 1, i + 2)
        call TimerStart(t, 1.0, false, function Trig_Nazrin_Pet_Main)
    endif
    set t = null
    set h = null
    set u = null
    set w = null
    set r = null
endfunction

function Trig_Nazrin_Pet_Conditions takes nothing returns boolean
    if GetIssuedOrderId() == OrderId("parasiteon") then
        set udg_SK_Nazrin_Pick = true
        return false
    elseif GetIssuedOrderId() == OrderId("parasiteoff") then
        set udg_SK_Nazrin_Pick = false
        return false
    endif
    return false
endfunction

function InitTrig_Nazrin_Pet takes nothing returns nothing
endfunction