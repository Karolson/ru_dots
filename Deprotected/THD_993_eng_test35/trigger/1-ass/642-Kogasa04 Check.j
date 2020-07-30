function Trig_Kogasa04_Check_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0C7'
endfunction

function Trig_Kogasa04_Check takes unit caster returns boolean
    local player w = GetOwningPlayer(caster)
    local unit h
    local integer i
    set i = 0
    loop
    exitwhen i >= 12
        set h = udg_PlayerHeroes[i]
        if h != null and GetWidgetLife(h) >= 0.405 and IsUnitEnemy(h, w) then
            if IsUnitVisible(caster, GetOwningPlayer(h)) and IsUnitInRange(caster, h, 600.0) then
                set w = null
                set h = null
                return false
            endif
        endif
        set i = i + 1
    endloop
    set w = null
    set h = null
    return true
endfunction

function Trig_Kogasa04_Check_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer d = GetUnitCurrentOrder(caster)
    local boolean k = d == OrderId("windwalk")
    set k = k or (d >= 851972 and d <= 851976)
    set k = k or d == 851993
    set k = k or d == 0
    if GetUnitAbilityLevel(caster, 'B02K') > 0 and GetWidgetLife(caster) >= 0.405 and k then
        call TimerStart(t, 0.05, false, function Trig_Kogasa04_Check_Main)
    else
        call UnitRemoveAbility(caster, 'B02K')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C7', true)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call DebugMsg("Umbrella 04 canceled")
    endif
    set t = null
    set caster = null
endfunction

function Trig_Kogasa04_Check_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set udg_SK_Kogasa04_Stun = Trig_Kogasa04_Check(caster)
    if udg_SK_Kogasa04_Stun then
        call DebugMsg("true")
    else
        call DebugMsg("false")
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveReal(udg_ht, task, 0, ox)
    call SaveReal(udg_ht, task, 1, oy)
    call TimerStart(t, 0.5, false, function Trig_Kogasa04_Check_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Kogasa04_Check takes nothing returns nothing
endfunction