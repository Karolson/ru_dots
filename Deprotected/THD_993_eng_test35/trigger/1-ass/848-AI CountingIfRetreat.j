function CountingUnitPower takes unit h returns real
    local real a = GetUnitState(h, UNIT_STATE_LIFE) / 100 * GetUnitAttack(h) * GetUnitAttackSpeed(h)
    local real b = 0
    if IsUnitType(h, UNIT_TYPE_HERO) then
        set b = GetUnitState(h, UNIT_STATE_LIFE) / 200 * (GetHeroInt(h, true) + 40) * 1.5 * IMinBJ(GetHeroLevel(h) * 2, IMinBJ(7, R2I(GetUnitState(h, UNIT_STATE_MANA) / 70)))
    endif
    set a = a * (GetUnitArmor(h) * 0.5 + GetUnitMagicResist(h) * 0.5)
    set b = b * (GetUnitArmor(h) * 0.5 + GetUnitMagicResist(h) * 0.5)
    return RMaxBJ(a, b)
endfunction

function AI_CountingIfRetreat takes unit h, real atr returns boolean
    local real power = 0
    local real epower = 0
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local group g
    local unit v
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, ox, oy, 1600, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_HERO) then
            if IsUnitEnemy(v, GetOwningPlayer(h)) == false then
                set power = power + CountingUnitPower(v) * (2400 - RMinBJ(DistanceBetweenUnits(h, v), 800))
            else
                set epower = epower + CountingUnitPower(v) * (2400 - RMinBJ(DistanceBetweenUnits(h, v), 800))
            endif
        elseif IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) and DistanceBetweenUnits(h, v) <= 650 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) == false then
                set power = power + CountingUnitPower(v)
            else
                set epower = epower + CountingUnitPower(v)
            endif
        elseif IsUnitType(v, UNIT_TYPE_DEAD) == false and DistanceBetweenUnits(h, v) <= 650 then
            if IsUnitEnemy(v, GetOwningPlayer(h)) == false then
                set power = power + CountingUnitPower(v) * 0.3
            else
                set epower = epower + CountingUnitPower(v) * 0.3
            endif
        endif
    endloop
    call DestroyGroup(g)
    set g = null
    set v = null
    if AIDIFF(h) == 0 then
        set power = GetRandomReal(50, 150) / 100 * power
        set epower = GetRandomReal(50, 150) / 100 * epower
    elseif AIDIFF(h) == 1 then
        set power = GetRandomReal(75, 125) / 100 * power
        set epower = GetRandomReal(75, 125) / 100 * epower
    elseif AIDIFF(h) == 1 then
        set power = GetRandomReal(90, 110) / 100 * power
        set epower = GetRandomReal(90, 110) / 100 * epower
    endif
    return epower > power * atr
endfunction

function InitTrig_AI_CountingIfRetreat takes nothing returns nothing
endfunction