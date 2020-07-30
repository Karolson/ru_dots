function Trig_ParseeEx_Conditions takes nothing returns boolean
    if IsUnitType(udg_SK_Parsee, UNIT_TYPE_DEAD) then
        return false
    endif
    if udg_SK_ParseeEx_CD then
        return false
    endif
    return GetUnitState(udg_SK_Parsee, UNIT_STATE_LIFE) > 0 and GetUnitState(udg_SK_Parsee, UNIT_STATE_LIFE) / GetUnitState(udg_SK_Parsee, UNIT_STATE_MAX_LIFE) <= 0.2
endfunction

function Trig_ParseeEx_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    set udg_SK_ParseeEx_CD = false
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_ParseeEx_Actions takes nothing returns nothing
    local unit caster = udg_SK_Parsee
    local unit w
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local timer t = CreateTimer()
    set udg_SK_ParseeEx_CD = true
    call TimerStart(t, 90.0, false, function Trig_ParseeEx_Clear)
    set w = CreateUnit(GetOwningPlayer(caster), 'n01X', ox, oy, 0)
    call UnitAddAbility(w, 'A0W5')
    call IssueTargetOrderById(w, 852274, caster)
    set caster = null
    set w = null
    set t = null
endfunction

function InitTrig_ParseeEx takes nothing returns nothing
endfunction