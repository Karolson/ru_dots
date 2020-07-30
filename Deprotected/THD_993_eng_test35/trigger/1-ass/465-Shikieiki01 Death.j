function Trig_Shikieiki01_Death_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if IsUnitType(u, UNIT_TYPE_HERO) == false then
        set u = null
        return false
    elseif IsUnitIllusion(u) then
        set u = null
        return false
    elseif IsUnitAlly(u, GetOwningPlayer(udg_SK_Shikieiki)) then
        set u = null
        return false
    endif
    set u = null
    return true
endfunction

function Trig_Shikieiki01_Death_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    call Trig_Shikieiki01_Debuff_Clear(udg_SK_Shikieiki, u)
    set u = null
endfunction

function InitTrig_Shikieiki01_Death takes nothing returns nothing
endfunction