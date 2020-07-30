function Trig_YukariEx_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0GL'
endfunction

function Trig_YukariEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real tx = LoadReal(udg_ht, task, 1)
    local real ty = LoadReal(udg_ht, task, 2)
    if GetUnitCurrentOrder(caster) == OrderId("starfall") then
        call SetUnitXY(caster, tx, ty)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
endfunction

function Trig_YukariEx_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A0GL', 85)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        return
    endif
    call BroadcastMessage("「八云の巢」")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 1, tx)
    call SaveReal(udg_ht, task, 2, ty)
    call TimerStart(t, 3.0, false, function Trig_YukariEx_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_YukariEx takes nothing returns nothing
endfunction