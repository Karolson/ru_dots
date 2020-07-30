function Trig_Lunar02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0FX'
endfunction

function Trig_Lunar02_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u1 = LoadUnitHandle(udg_ht, task, 0)
    local unit u2 = LoadUnitHandle(udg_ht, task, 1)
    local unit u3 = LoadUnitHandle(udg_ht, task, 2)
    local group g
    set udg_SK_Lunar03_PointX = 0
    set udg_SK_Lunar03_PointY = 0
    call KillUnit(u1)
    call KillUnit(u2)
    call KillUnit(u3)
    call ReleaseTimer(t)
    if HaveSavedHandle(udg_sht, GetHandleId(udg_SK_Lunar), 0) then
        set g = LoadGroupHandle(udg_sht, GetHandleId(udg_SK_Lunar), 0)
        call DestroyGroup(g)
    endif
    call FlushChildHashtable(udg_sht, GetHandleId(udg_SK_Lunar))
    call FlushChildHashtable(udg_ht, task)
    set g = null
    set t = null
    set u1 = null
    set u2 = null
    set u3 = null
endfunction

function Trig_Lunar02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0FX')
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local unit u1
    local unit u2
    local unit u3
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A0FX', 26 - 2 * level)
    set u1 = CreateUnit(GetOwningPlayer(caster), 'e02O', tx, ty, 0)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'e02O', tx, ty, 90)
    set u3 = CreateUnit(GetOwningPlayer(caster), 'e02O', tx, ty, 180)
    set udg_SK_Lunar03_PointX = tx
    set udg_SK_Lunar03_PointY = ty
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, u1)
    call SaveUnitHandle(udg_ht, task, 1, u2)
    call SaveUnitHandle(udg_ht, task, 2, u3)
    call TimerStart(t, 3.0 + level * 1.5, false, function Trig_Lunar02_Clear)
    set caster = null
    set t = null
    set u1 = null
    set u2 = null
    set u3 = null
endfunction

function InitTrig_Lunar02 takes nothing returns nothing
endfunction