function Trig_ReimuSpecial_Conditions takes nothing returns boolean
    local unit u = GetAttacker()
    local unit v = GetTriggerUnit()
    local real ox
    local real oy
    local real tx
    local real ty
    local real dis
    if GetUnitTypeId(GetAttacker()) == 'H02E' then
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set tx = GetUnitX(v)
        set ty = GetUnitY(v)
        set dis = (ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)
        if dis <= 200 * 200 then
            call SetUnitAnimation(u, "Attack Slam")
        endif
    endif
    set u = null
    set v = null
    return false
endfunction

function InitTrig_ReimuSpecial takes nothing returns nothing
endfunction