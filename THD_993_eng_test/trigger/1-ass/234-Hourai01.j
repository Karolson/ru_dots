function Trig_Hourai01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HA'
endfunction

function Trig_Hourai01_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit h = LoadUnitHandle(udg_sht, GetHandleId(u), 0)
    local group g = LoadGroupHandle(udg_sht, GetHandleId(h), 3)
    local real HP = GetUnitLifePercent(u)
    local real MP = GetUnitManaPercent(u)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real a = GetUnitFacing(u)
    call FlushChildHashtable(udg_sht, GetHandleId(u))
    call GroupRemoveUnit(g, u)
    call RemoveUnit(u)
    set u = CreateUnit(GetOwningPlayer(h), 'h01F', ox, oy, a)
    call GroupAddUnit(g, u)
    call SetDollProperty(h, u)
    call SetUnitLifePercentBJ(u, HP)
    call SetUnitManaPercentBJ(u, MP)
    call UnitApplyTimedLife(u, 'B02I', 180.0)
    call SaveUnitHandle(udg_sht, GetHandleId(u), 0, h)
    call SetUnitColor(u, PLAYER_COLOR_PURPLE)
    set u = null
    set h = null
    set g = null
endfunction

function InitTrig_Hourai01 takes nothing returns nothing
endfunction