function Trig_Shanghai04_Alice_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HU'
endfunction

function Trig_Shanghai04_Alice_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real dx
    local real dy
    local real d
    local real s = 999999.9
    local group g = CreateGroup()
    local boolexpr f = Filter(function Trig_Shanghai04_Shanghai)
    local integer n
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real abilitycooldownlv01 = 140
    local real abilitycooldownlv02 = 140
    local real abilitycooldownlv03 = 140
    local real abilitycooldownlv04 = 140
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I00B') then
        if GetUnitAbilityLevel(caster, GetSpellAbilityId()) == 1 then
            call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv01)
        elseif GetUnitAbilityLevel(caster, GetSpellAbilityId()) == 2 then
            call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv02)
        elseif GetUnitAbilityLevel(caster, GetSpellAbilityId()) == 3 then
            call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv03)
        elseif GetUnitAbilityLevel(caster, GetSpellAbilityId()) == 4 then
            call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv04)
        endif
    endif
    set n = 0
    set u = null
    set v = null
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 1200.0, f)
    loop
        set u = FirstOfGroup(g)
    exitwhen u == null
        call GroupRemoveUnit(g, u)
        set n = n + 1
        set dx = GetUnitX(u) - tx
        set dy = GetUnitY(u) - ty
        set d = SquareRoot(dx * dx + dy * dy)
        if d < s then
            set v = u
            set s = d
        endif
    exitwhen n >= 12
    endloop
    call DestroyBoolExpr(f)
    call DestroyGroup(g)
    if n < 6 then
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, "|cffff1100The current number of Shanghai dolls is not enough to launch 'Doll of War'!|r")
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 299.0)
        call UnitRemoveAbility(caster, 'A0HU')
        call UnitAddAbility(caster, 'A0HU')
        call SetUnitAbilityLevel(caster, 'A0HU', level)
    else
        call ClearAllNegativeBuff(v, true)
        call IssuePointOrder(v, "shockwave", tx, ty)
    endif
    set caster = null
    set f = null
    set g = null
    set u = null
    set v = null
endfunction

function InitTrig_Shanghai04_Alice takes nothing returns nothing
endfunction