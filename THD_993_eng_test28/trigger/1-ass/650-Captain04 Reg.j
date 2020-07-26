function Trig_Captain04_Reg_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1AX'
endfunction

function Trig_Captain04_Reg_Actions takes nothing returns nothing
    local integer level = GetUnitAbilityLevel(udg_SK_Caption04_Hero, 'A1AX')
    local real ox = GetUnitX(udg_SK_Caption04_Hero)
    local real oy = GetUnitY(udg_SK_Caption04_Hero)
    local unit oldboat = udg_SK_Caption04_Ship
    if udg_SK_Caption04_Ship != null then
        set udg_SK_Caption04_Ship = null
        call KillUnit(oldboat)
    endif
    if level == 1 then
        set udg_SK_Caption04_Ship = CreateUnit(GetOwningPlayer(udg_SK_Caption04_Hero), 'n01S', ox, oy, 0)
    elseif level == 2 then
        set udg_SK_Caption04_Ship = CreateUnit(GetOwningPlayer(udg_SK_Caption04_Hero), 'n01U', ox, oy, 0)
        call SetUnitAbilityLevel(udg_SK_Caption04_Ship, 'A0AG', 1)
    elseif level == 3 then
        set udg_SK_Caption04_Ship = CreateUnit(GetOwningPlayer(udg_SK_Caption04_Hero), 'n01V', ox, oy, 0)
        call SetUnitAbilityLevel(udg_SK_Caption04_Ship, 'A0AG', 2)
    endif
    set oldboat = null
endfunction

function InitTrig_Captain04_Reg takes nothing returns nothing
endfunction