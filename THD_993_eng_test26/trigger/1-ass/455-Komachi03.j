function KOMACHI03 takes nothing returns integer
    return 'A0CN'
endfunction

function Komachi03_Kill_Conditions takes nothing returns boolean
    local unit u = GetKillingUnit()
    local unit v = GetTriggerUnit()
    local unit w
    local integer i
    local boolean result
    if IsUnitIllusion(v) or IsUnitIllusion(u) or GetUnitTypeId(v) == 'n01G' then
        set result = false
    elseif GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(u)), 'A0CN') > 0 then
        set w = GetPlayerCharacter(GetOwningPlayer(u))
        set i = LoadInteger(udg_sht, StringHash("Komachi03"), GetHandleId(w))
        if i < 1 + 2 * GetUnitAbilityLevel(w, 'A0CN') then
            set i = i + 1
            call SaveInteger(udg_sht, StringHash("Komachi03"), GetHandleId(w), i)
            set result = true
        else
            set result = false
        endif
    else
        set result = false
    endif
    set u = null
    set v = null
    set w = null
    return result
endfunction

function Komachi03_Spirit_Follow_Komachi takes nothing returns nothing
    local unit u = GetEnumUnit()
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_sht, GetHandleId(t), 1)
    local real a
    local real d
    if IsUnitInRange(u, caster, 125) or not IsUnitInRange(u, caster, 225) then
        set a = Atan2(GetUnitY(caster) - GetUnitY(u), GetUnitX(caster) - GetUnitX(u))
        set d = GetRandomReal(150.0, 200.0)
        if IsUnitInRange(u, caster, 1000) then
            call IssuePointOrder(u, "move", GetUnitX(caster) + d * Cos(a), GetUnitY(caster) + d * Sin(a))
        else
            call SetUnitX(u, GetUnitX(caster) + d * Cos(a))
            call SetUnitY(u, GetUnitY(caster) + d * Sin(a))
        endif
    endif
    set u = null
    set caster = null
    set t = null
endfunction

function Komachi03_Spirit_Return_To_Fountain takes nothing returns nothing
    local unit u = GetEnumUnit()
    local timer t = GetExpiredTimer()
    local real ox
    local real oy
    local real dx
    local real dy
    local real a
    if IsPlayerInForce(GetOwningPlayer(LoadUnitHandle(udg_sht, GetHandleId(t), 1)), udg_TeamA) then
        set ox = GetLocationX(udg_BirthPoint[0])
        set oy = GetLocationY(udg_BirthPoint[0])
    else
        set ox = GetLocationX(udg_BirthPoint[1])
        set oy = GetLocationY(udg_BirthPoint[1])
    endif
    if not IsUnitInRangeXY(u, ox, oy, 150.0) then
        set a = GetRandomReal(0, 3.14159)
        set dx = GetRandomReal(50.0, 150.0) * Cos(a)
        set dy = GetRandomReal(50.0, 150.0) * Sin(a)
        call SetUnitX(u, ox + dx)
        call SetUnitY(u, oy + dy)
    endif
    set t = null
    set u = null
endfunction

function Komachi03_Spirit_Follow_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local unit caster = LoadUnitHandle(udg_sht, task, 1)
    if GetWidgetLife(caster) > 0.405 then
        call ForGroup(g, function Komachi03_Spirit_Follow_Komachi)
    else
        call ForGroup(g, function Komachi03_Spirit_Return_To_Fountain)
    endif
    set t = null
    set g = null
    set caster = null
endfunction

function Komachi03_Kill_Actions takes nothing returns nothing
    local unit v = GetKillingUnit()
    local unit caster = GetPlayerCharacter(GetOwningPlayer(v))
    local unit target = GetTriggerUnit()
    local timer t
    local integer task
    local group g
    local unit u
    if HaveSavedHandle(udg_sht, StringHash("Komachi03"), GetHandleId(caster)) then
        set t = LoadTimerHandle(udg_sht, StringHash("Komachi03"), GetHandleId(caster))
        set task = GetHandleId(t)
        set g = LoadGroupHandle(udg_sht, task, 0)
    else
        set t = CreateTimer()
        set task = GetHandleId(t)
        set g = CreateGroup()
        call SaveTimerHandle(udg_sht, StringHash("Komachi03"), GetHandleId(caster), t)
        call SaveGroupHandle(udg_sht, task, 0, g)
        call SaveUnitHandle(udg_sht, task, 1, caster)
        call TimerStart(t, 0.5, true, function Komachi03_Spirit_Follow_Loop)
    endif
    set u = CreateUnit(GetOwningPlayer(caster), 'n01G', GetUnitX(target), GetUnitY(target), 270.0)
    call GroupAddUnit(g, u)
    set caster = null
    set target = null
    set t = null
    set g = null
    set u = null
    set v = null
endfunction

function InitTrig_Komachi03 takes nothing returns nothing
endfunction