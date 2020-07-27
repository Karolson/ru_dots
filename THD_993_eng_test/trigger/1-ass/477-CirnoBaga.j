function Trig_CirnoBaga_Conditions takes nothing returns boolean
    local integer currentint = GetHeroInt(udg_SK_Cirno_Cirno, true)
    local real p = GetUnitState(udg_SK_Cirno_Cirno, UNIT_STATE_MANA) / GetUnitState(udg_SK_Cirno_Cirno, UNIT_STATE_MAX_MANA)
    if currentint != 9 then
        call UnitAddBonusInt(udg_SK_Cirno_Cirno, 9 - currentint)
        call SetUnitState(udg_SK_Cirno_Cirno, UNIT_STATE_MANA, GetUnitState(udg_SK_Cirno_Cirno, UNIT_STATE_MAX_MANA) * p)
    endif
    return false
endfunction

function Trig_CirnoBaga_Actions takes nothing returns nothing
    local unit baga = udg_SK_Cirno_Cirno
    local integer diff
    local real counter
    local real m0
    local real m1
    local integer c1
    local integer c10
    local integer c100
    set diff = GetHeroInt(udg_SK_Cirno_Cirno, true) - 9
    set udg_SK_Cirno_Baga = udg_SK_Cirno_Baga + diff
    if udg_SK_Cirno_Baga < 0 then
        set baga = null
        return
    endif
    set m0 = GetUnitState(baga, UNIT_STATE_MAX_MANA)
    set m1 = GetUnitState(baga, UNIT_STATE_MANA)
    call UnitAddAbility(baga, 'A0TE')
    set counter = udg_SK_Cirno_Baga
    if GetUnitAbilityLevel(baga, 'A0MZ') == 0 then
        call UnitAddAbility(baga, 'A0MZ')
    endif
    if GetUnitAbilityLevel(baga, 'A0MY') == 0 then
        call UnitAddAbility(baga, 'A0MY')
    endif
    if GetUnitAbilityLevel(baga, 'A0MX') == 0 then
        call UnitAddAbility(baga, 'A0MX')
    endif
    set c100 = R2I(counter / 100) + 1
    set counter = counter - R2I(counter / 100) * 100
    set c10 = R2I(counter / 10) + 1
    set counter = counter - R2I(counter / 10) * 10
    set c1 = R2I(counter) + 1
    set counter = 0
    call SetUnitAbilityLevel(baga, 'A0MX', c1)
    call SetUnitAbilityLevel(baga, 'A0MY', c10)
    call SetUnitAbilityLevel(baga, 'A0MZ', c100)
    call UnitRemoveAbility(baga, 'A0TE')
    call SetUnitState(baga, UNIT_STATE_MANA, GetUnitState(baga, UNIT_STATE_MAX_MANA) * (m1 / m0))
    set baga = null
endfunction

function InitTrig_CirnoBaga takes nothing returns nothing
endfunction