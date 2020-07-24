function GetUnitItemAttackSpeed takes unit v, integer itemr, real k returns real
    local integer i = 0
    local real atkspd = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set atkspd = atkspd + k
        endif
    exitwhen i == 6
    endloop
    return atkspd
endfunction

function GetUnitAbilityAttackSpeedWithLevel takes unit v, integer abilyr, real k, real l returns real
    local real atkspd = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set atkspd = atkspd + k + l * (GetUnitAbilityLevel(v, abilyr) - 1)
    endif
    return atkspd
endfunction

function GetUnitAbilityAttackSpeed takes unit v, integer abilyr, real k returns real
    local real atkspd = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set atkspd = atkspd + k
    endif
    return atkspd
endfunction

function GetUnitAttackSpeed takes unit v returns real
    local real attackspeed = 1.0
    if IsUnitType(v, UNIT_TYPE_HERO) then
        set attackspeed = attackspeed + GetHeroAgi(v, true) * 0.01
    endif
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A0ZD', 0.3)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B044', 0.35)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A193', 0.4)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A10W', 0.25)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A10X', 0.3)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A10Y', 0.35)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A10Z', 0.4)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A114', 0.35)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A115', 0.45)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A116', 0.55)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A0BD', 0.35)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A15S', 0.4)
    if udg_SK_Ran01 != null then
        set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B017', 0.04 + GetUnitAbilityLevel(udg_SK_Ran01, 'A0TK'))
        set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B017', 0.04 + GetUnitAbilityLevel(udg_SK_Ran01, 'A0TL'))
    endif
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A118', 0.25)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeedWithLevel(v, 'A194', 0.1, 0.1)
    if udg_SK_Eirin != null then
        if v == udg_SK_Eirin then
            set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B00A', GetUnitAbilityLevel(udg_SK_Eirin, 'A0OT') * 0.14)
        else
            set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B00A', GetUnitAbilityLevel(udg_SK_Eirin, 'A0OT') * 0.1)
        endif
    endif
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B00S', GetUnitAbilityLevel(v, 'A04O') * 0.1 + 0.1)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B029', 1.2)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A04X', 0.05)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A04Y', 0.1)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A04Z', 0.2)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A050', 0.4)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A051', 0.8)
    if udg_SK_Mystia_Unit != null then
        set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B033', GetUnitAbilityLevel(udg_SK_Mystia_Unit, 'A0DI') * 0.1 + 0.1)
    endif
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A11D', 0.35)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A15T', 0.4)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeedWithLevel(v, 'A1HZ', 0.75, 0.25)
    if udg_SK_Yuka != null then
        set attackspeed = attackspeed + GetUnitAbilityLevel(udg_SK_Yuka, 'A18T') * 0.1
    endif
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B01A', 0.25)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B012', 0.45)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B013', 0.6)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B014', 0.75)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B015', 0.9)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A15Y', 0.08)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A15Z', 0.16)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A160', 0.24)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A161', 0.32)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A162', 0.4)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A163', 0.48)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A164', 0.56)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A165', 0.64)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A166', 0.72)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A167', 0.8)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A168', 0.88)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A169', 0.96)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16A', 1.04)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16B', 1.12)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16C', 1.2)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16D', 1.28)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16E', 1.36)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16F', 1.44)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16G', 1.52)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16H', 1.6)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16I', 1.68)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16J', 1.76)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16K', 1.84)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16L', 1.92)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A19T', 0.4)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A11T', 0.5)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeedWithLevel(v, 'A09D', 0.2, 0.2)
    set attackspeed = attackspeed + GetUnitAbilityLevel(v, 'A0E5')
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16U', 0.25)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16V', 0.3)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16W', 0.35)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'A16X', 0.4)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A14I', 0.35)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'B03Z', 1.0)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A17L', 0.25)
    set attackspeed = attackspeed - GetUnitAbilityAttackSpeed(v, 'B007', 0.45)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'Bblo', 1.0)
    if GetUnitAbilityLevel(v, 'BHca') >= 1 or GetUnitAbilityLevel(v, 'Bcsd') >= 1 or GetUnitAbilityLevel(v, 'Bcsi') >= 1 then
        set attackspeed = attackspeed - 0.25
    endif
    if GetUnitAbilityLevel(v, 'A0BA') >= 1 then
        set attackspeed = attackspeed + GetUnitAbilityLevel(v, 'A0BA') * 0.4 + 0.4
    endif
    if GetUnitAbilityLevel(v, 'A09W') >= 1 then
        set attackspeed = attackspeed + GetUnitAbilityLevel(v, 'A09W') * 0.05 + 0.1
    endif
    if GetUnitAbilityLevel(v, 'A04P') >= 1 then
        set attackspeed = attackspeed + 0.1 + GetUnitAbilityLevel(v, 'A04P') * 0.1
    endif
    if GetUnitAbilityLevel(v, 'A07H') >= 1 and GetUnitAbilityLevel(v, 'A07H') <= 4 then
        set attackspeed = attackspeed + GetUnitAbilityLevel(v, 'A07H') * 0.05
    elseif GetUnitAbilityLevel(v, 'A07H') == 6 then
        set attackspeed = attackspeed + 0.3
    elseif GetUnitAbilityLevel(v, 'A07H') == 8 then
        set attackspeed = attackspeed + 0.4
    endif
    if GetUnitAbilityLevel(v, 'A0TK') >= 1 then
        set attackspeed = attackspeed + GetUnitAbilityLevel(v, 'A0TK') * 0.07
    elseif GetUnitAbilityLevel(v, 'A0TL') >= 1 then
        set attackspeed = attackspeed - GetUnitAbilityLevel(v, 'A0TL') * 0.07
    endif
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A0BJ', 0.15)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A0BK', 0.3)
    set attackspeed = attackspeed + GetUnitAbilityAttackSpeed(v, 'A0BL', 0.45)
    set attackspeed = attackspeed + udg_DMG_AllItemAttackSpeed[GetPlayerId(GetOwningPlayer(v))]
    set attackspeed = attackspeed + UnitGetBonusAspd(v) / 100
    return attackspeed
endfunction

function Trig_GetUnitAttackSpeed_Actions takes nothing returns nothing
endfunction

function InitTrig_GetUnitAttackSpeed takes nothing returns nothing
endfunction