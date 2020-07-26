function Trig_Alice_Dolls_KIA_Conditions takes nothing returns boolean
    local integer d = GetUnitTypeId(GetTriggerUnit())
    return 'h01B' <= d and d <= 'h01F' and IsUnitIllusion(GetTriggerUnit()) == false
endfunction

function Trig_Alice_Dolls_KIA_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit h = LoadUnitHandle(udg_sht, GetHandleId(u), 0)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", x, y))
    call RemoveDoll(h, u, false)
    set h = null
    set u = null
endfunction

function InitTrig_Alice_Dolls_KIA takes nothing returns nothing
endfunction