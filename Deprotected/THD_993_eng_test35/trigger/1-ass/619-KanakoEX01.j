function Trig_KanakoEX01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FE'
endfunction

function Trig_KanakoEX01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real ox = LoadReal(udg_ht, task, 2)
    local real oy = LoadReal(udg_ht, task, 3)
    local real d
    local real a
    local real tx
    local real ty
    local unit u
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 and GetUnitCurrentOrder(caster) == OrderId("starfall") then
        set a = GetRandomReal(0.0, 6.28344)
        set d = GetRandomReal(0.0, 600.0)
        set tx = ox + d * Cos(a)
        set ty = oy + d * Sin(a)
        if IsTerrainPathable(tx, ty, PATHING_TYPE_FLYABILITY) == false then
            set u = NewDummy(GetOwningPlayer(caster), tx, ty, 0.0)
            call UnitAddAbility(u, 'A0F0')
            call IssuePointOrder(u, "dreadlordinferno", tx, ty)
            call UnitRemoveAbility(u, 'A0F0')
            call ReleaseDummy(u)
        endif
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_KanakoEX01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0FE')
    local integer n = 2 * (level + 2)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0FE', 15)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, n)
    call SaveReal(udg_ht, task, 2, ox)
    call SaveReal(udg_ht, task, 3, oy)
    call TimerStart(t, 3.5 / n, true, function Trig_KanakoEX01_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_KanakoEX01 takes nothing returns nothing
endfunction