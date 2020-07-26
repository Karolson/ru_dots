function GetUnitItemResists takes unit v, integer itemr, real k returns real
    local integer i = 0
    local real resist = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set resist = resist + k
        endif
    exitwhen i == 6
    endloop
    return resist
endfunction

function GetUnitAbilityResists takes unit v, integer abilyr, real k returns real
    local real resist = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set resist = resist + k
    endif
    return resist
endfunction

function GetUnitMagicResist takes unit v returns real
    local real resist = 0.0
    if IsUnitType(v, UNIT_TYPE_HERO) then
        set resist = resist + 7.0
        set resist = resist + udg_DMG_AllItemMagicResist[GetPlayerId(GetOwningPlayer(v))]
        if GetUnitAbilityLevel(v, 'A0XC') >= 1 then
            set resist = resist + 3 * GetUnitAbilityLevel(v, 'A0XC')
        endif
        if GetUnitAbilityLevel(v, 'A0DH') >= 1 then
            set resist = resist + 1 + 2 * GetUnitAbilityLevel(v, 'A0DH')
        endif
        if GetUnitAbilityLevel(v, 'A14J') >= 1 then
            set resist = resist + 12
        endif
        if GetUnitAbilityLevel(v, 'A0ES') >= 1 then
            set resist = resist + 5
        endif
        if GetUnitAbilityLevel(v, 'A0SS') >= 1 then
            set resist = resist + 5 * GetUnitAbilityLevel(v, 'A0SS')
        endif
        if GetUnitAbilityLevel(v, 'A04T') >= 1 then
            set resist = resist + 10 + 5 * GetUnitAbilityLevel(v, 'A04T')
        endif
        if GetUnitAbilityLevel(v, 'A0I7') >= 1 then
            set resist = resist + 6 + 3 * GetUnitAbilityLevel(v, 'A0I7')
        endif
        if GetUnitAbilityLevel(v, 'A014') >= 1 then
            set resist = resist + R2I(GetHeroInt(v, true) / 15)
        endif
        if GetUnitAbilityLevel(v, 'A0FA') >= 1 then
            set resist = resist + 20
        endif
        if GetUnitAbilityLevel(v, 'B09T') >= 1 then
            set resist = resist + GetUnitAbilityLevel(udg_SK_Shinki, 'A1F0') + 1
        endif
    elseif IsUnitType(v, UNIT_TYPE_STRUCTURE) then
        set resist = resist + 10
    endif
    set resist = resist + GetUnitAbilityResists(v, 'A02F', 7.0)
    set resist = resist + GetUnitAbilityResists(v, 'A09H', 25.0)
    set resist = resist + GetUnitAbilityResists(v, 'A12P', 14.0)
    set resist = resist + GetUnitAbilityResists(v, 'A12O', 32.0)
    set resist = resist + GetUnitAbilityResists(v, 'A12N', -3.0)
    if GetUnitAbilityLevel(v, 'A0CY') > 0 then
        set resist = resist + 2.0 * GetUnitAbilityLevel(v, 'A0CY')
    endif
    if GetUnitTypeId(v) == 'h01C' then
        set resist = resist + 2
    endif
    if GetUnitTypeId(v) == 'h01B' or GetUnitTypeId(v) == 'h01E' then
        set resist = resist + 5
    endif
    if GetUnitTypeId(v) == 'n02Z' then
        set resist = resist + 70
    endif
    if GetUnitTypeId(v) == 'u008' then
        set resist = resist + 2
    endif
    if GetUnitTypeId(v) == 'u00C' then
        set resist = resist + 4
    endif
    if GetUnitTypeId(v) == 'u00D' then
        set resist = resist + 6
    endif
    if GetUnitTypeId(v) == 'u00E' then
        set resist = resist + 8
    endif
    if GetUnitTypeId(v) == 'o00F' then
        set resist = resist + 4
    endif
    if GetUnitTypeId(v) == 'o00G' then
        set resist = resist + 6
    endif
    if GetUnitTypeId(v) == 'o00H' then
        set resist = resist + 8
    endif
    if GetUnitTypeId(v) == 'o00I' then
        set resist = resist + 10
    endif
    if GetUnitTypeId(v) == 'h01O' then
        set resist = resist + 8
    endif
    if GetUnitTypeId(v) == 'u00F' or GetUnitTypeId(v) == 'u00G' or GetUnitTypeId(v) == 'u00H' or GetUnitTypeId(v) == 'u00I' then
        set resist = resist + 10
    endif
    set resist = resist + GetUnitAbilityResists(v, 'B072', 6.0)
    set resist = resist + GetUnitAbilityResists(v, 'A148', -1.25)
    set resist = resist + GetUnitAbilityResists(v, 'A149', -1.25)
    set resist = resist + GetUnitAbilityResists(v, 'A14A', -1.25)
    set resist = resist + GetUnitAbilityResists(v, 'A14B', -1.25)
    set resist = resist + GetUnitAbilityResists(v, 'A14C', -1.25)
    set resist = resist + GetUnitAbilityResists(v, 'A082', -5.0)
    set resist = resist + GetUnitAbilityResists(v, 'B00D', -7)
    set resist = resist + GetUnitAbilityResists(v, 'A0AH', -7)
    set resist = resist + GetUnitAbilityResists(v, 'A10P', -7)
    if GetUnitAbilityLevel(v, 'A04J') >= 1 then
        set resist = resist - 1.5 - 1.5 * GetUnitAbilityLevel(v, 'A04J')
    endif
    if GetUnitAbilityLevel(v, 'A0S2') >= 1 then
        set resist = resist - 2 - 2 * GetUnitAbilityLevel(v, 'A0S2')
    endif
    if GetUnitAbilityLevel(v, 'A12L') >= 1 then
        set resist = resist + 6 * GetUnitAbilityLevel(v, 'A12L')
    endif
    set resist = resist + GetUnitAbilityResists(v, 'A0C6', 50)
    if GetUnitAbilityLevel(v, 'A0V5') >= 1 then
        set resist = resist - 0.5 * GetUnitAbilityLevel(v, 'A0V5')
    endif
    set resist = resist + GetUnitAbilityResists(v, 'A060', -4)
    set resist = resist + GetUnitAbilityResists(v, 'A123', -12)
    set resist = resist + GetUnitAbilityResists(v, 'h02F', 15)
    return resist
endfunction

function GetMagicResistTrueValue takes real k returns real
    local real resist = 0.0
    local real res = 1.0
    local integer i = 0
    if k == 0 then
        set resist = 0.0
    elseif k > 0 then
        set resist = k * 0.05 / (k * 0.05 + 1)
    else
        set i = 0
        loop
        exitwhen i == R2I(-k)
            set i = i + 1
            set res = res * 0.95
        endloop
        set resist = -1 + res
    endif
    return resist
endfunction

function InitTrig_GetUnitMagicResist takes nothing returns nothing
endfunction