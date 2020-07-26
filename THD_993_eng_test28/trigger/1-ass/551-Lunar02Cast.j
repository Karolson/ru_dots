function Trig_Lunar02Cast_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if udg_SK_Lunar03_PointX == 0 and udg_SK_Lunar03_PointY == 0 then
        set u = null
        return false
    elseif IsUnitType(u, UNIT_TYPE_HERO) == false then
        set u = null
        return false
    elseif IsUnitAlly(u, GetOwningPlayer(udg_SK_Lunar)) then
        set u = null
        return false
    endif
    if IsUnitInRangeXY(u, udg_SK_Lunar03_PointX, udg_SK_Lunar03_PointY, 250.0) then
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Trig_Lunar02Cast_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    if g != null then
        call GroupRemoveUnit(g, target)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set g = null
    set target = null
endfunction

function Trig_Lunar02Cast_Actions takes nothing returns nothing
    local unit caster = udg_SK_Lunar
    local unit target = GetTriggerUnit()
    local timer t
    local group g = LoadGroupHandle(udg_sht, GetHandleId(caster), 0)
    if g == null then
        set g = CreateGroup()
        call SaveGroupHandle(udg_sht, GetHandleId(caster), 0, g)
    endif
    if IsUnitInGroup(target, g) then
        set g = null
        set caster = null
        set target = null
        set t = null
        return
    endif
    call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 140, 2.2), 1)
    call UnitStunTarget(caster, target, 2.5, 0, 0)
    call GroupAddUnit(g, target)
    set t = CreateTimer()
    call SaveGroupHandle(udg_sht, GetHandleId(t), 0, g)
    call SaveUnitHandle(udg_sht, GetHandleId(t), 1, target)
    call TimerStart(t, 3.5, false, function Trig_Lunar02Cast_Clear)
    set t = null
    set g = null
    set caster = null
    set target = null
endfunction

function InitTrig_Lunar02Cast takes nothing returns nothing
endfunction