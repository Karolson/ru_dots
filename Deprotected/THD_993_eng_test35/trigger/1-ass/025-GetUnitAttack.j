function UnitInitAddAttack takes unit u returns nothing
    if GetUnitAbilityLevel(u, 'A0H9') > 0 then
        return
    endif
    call UnitAddAbility(u, 'A0H6')
    call UnitMakeAbilityPermanent(u, true, 'A0H6')
    call UnitAddAbility(u, 'A0H7')
    call UnitMakeAbilityPermanent(u, true, 'A0H7')
    call UnitAddAbility(u, 'A0H8')
    call UnitMakeAbilityPermanent(u, true, 'A0H8')
    call UnitAddAbility(u, 'A0H9')
    call UnitMakeAbilityPermanent(u, true, 'A0H9')
endfunction

function UnitAddAttackDamage takes unit u, integer d returns nothing
    local integer f = GetUnitAbilityLevel(u, 'A0H6')
    local integer g = GetUnitAbilityLevel(u, 'A0H7')
    local integer h = GetUnitAbilityLevel(u, 'A0H8')
    local integer i = GetUnitAbilityLevel(u, 'A0H9')
    local integer currentdamage = 1000 * (i - 1) + 100 * (h - 1) + 10 * (g - 1) + (f - 1)
    local integer newdamage = currentdamage + d
    local integer p
    local integer q
    local integer r
    local integer s
    if newdamage > 9999 then
        call BroadcastMessage("Damage Limit Exceeded")
        set newdamage = 9999
    endif
    set p = ModuloInteger(newdamage / 1000, 10)
    set q = ModuloInteger(newdamage / 100, 10)
    set r = ModuloInteger(newdamage / 10, 10)
    set s = ModuloInteger(newdamage, 10)
    call DebugMsg(I2S(currentdamage) + " increase by " + I2S(d) + " to " + I2S(newdamage))
    call SetUnitAbilityLevel(u, 'A0H6', s + 1)
    call SetUnitAbilityLevel(u, 'A0H7', r + 1)
    call SetUnitAbilityLevel(u, 'A0H8', q + 1)
    call SetUnitAbilityLevel(u, 'A0H9', p + 1)
endfunction

function UnitReduceAttackDamage takes unit u, integer d returns nothing
    local integer f = GetUnitAbilityLevel(u, 'A0H6')
    local integer g = GetUnitAbilityLevel(u, 'A0H7')
    local integer h = GetUnitAbilityLevel(u, 'A0H8')
    local integer i = GetUnitAbilityLevel(u, 'A0H9')
    local integer currentdamage = 1000 * (i - 1) + 100 * (h - 1) + 10 * (g - 1) + (f - 1)
    local integer newdamage = currentdamage - d
    local integer p
    local integer q
    local integer r
    local integer s
    if newdamage < 0 then
        call BroadcastMessage("Damage Reduced to Negative!")
        set newdamage = 0
    endif
    set p = ModuloInteger(newdamage / 1000, 10)
    set q = ModuloInteger(newdamage / 100, 10)
    set r = ModuloInteger(newdamage / 10, 10)
    set s = ModuloInteger(newdamage, 10)
    call DebugMsg(I2S(currentdamage) + " reduce by " + I2S(d) + " to " + I2S(newdamage))
    call SetUnitAbilityLevel(u, 'A0H6', s + 1)
    call SetUnitAbilityLevel(u, 'A0H7', r + 1)
    call SetUnitAbilityLevel(u, 'A0H8', q + 1)
    call SetUnitAbilityLevel(u, 'A0H9', p + 1)
endfunction

function GetUnitItemAttack takes unit v, integer itemr, real k returns real
    local integer i = 0
    local real attack = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set attack = attack + k
        endif
    exitwhen i == 6
    endloop
    return attack
endfunction

function GetUnitAbilityAttack takes unit v, integer abilyr, real k returns real
    local real attack = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set attack = attack + k
    endif
    return attack
endfunction

function GetUnitAbilityAttackMultiplier takes unit v, integer abilyr, real multi, real attack returns real
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set attack = attack * (1 + multi)
    endif
    return attack
endfunction

function GetUnitAbilityAttackMultiplierLevelIncome takes unit v, integer abilyr, real basicmulti, real incomemulti, real attack returns real
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set attack = attack * (1 + basicmulti - incomemulti + incomemulti * GetUnitAbilityLevel(v, abilyr))
    endif
    return attack
endfunction

function GetUnitAbilityAttackLevelIncome takes unit v, integer abilyr, real basic, real income returns real
    local real attack = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set attack = attack + basic - income + GetUnitAbilityLevel(v, abilyr) * income
    endif
    return attack
endfunction

function GetUnitTypeAttack takes unit v, integer utyper, real k, real a, real b returns real
    local real attack = 0.0
    if GetUnitTypeId(v) == utyper then
        set attack = attack + k + a * GetRandomReal(1, b)
    endif
    return attack
endfunction

function GetUnitFunctionedAttack takes unit u returns real
    local real d
    set d = (GetUnitAbilityLevel(u, 'A0H9') - 1) * 1000
    set d = d + (GetUnitAbilityLevel(u, 'A0H8') - 1) * 100
    set d = d + (GetUnitAbilityLevel(u, 'A0H7') - 1) * 10
    set d = d + (GetUnitAbilityLevel(u, 'A0H6') - 1) * 1
    if d < 0 then
        return 0.0
    else
        return d
    endif
endfunction

function GetUnitBaseAttack takes unit v returns integer
    local real attack = 0.0
    if IsUnitType(v, UNIT_TYPE_HERO) then
        set attack = attack + (LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAB') + LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAU')) / 2
        if LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'PRIM') == 1 then
            set attack = attack + GetHeroStr(v, false)
        elseif LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'PRIM') == 2 then
            set attack = attack + GetHeroAgi(v, false)
        else
            set attack = attack + GetHeroInt(v, false)
        endif
    endif
    return R2I(attack)
endfunction

function GetUnitAttack takes unit v returns integer
    local real attack = 0.0
    if IsUnitType(v, UNIT_TYPE_HERO) then
        set attack = attack + (LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAB') + LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAU')) / 2
        if LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'PRIM') == 1 then
            set attack = attack + GetHeroStr(v, true)
        elseif LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'PRIM') == 2 then
            set attack = attack + GetHeroAgi(v, true)
        else
            set attack = attack + GetHeroInt(v, true)
        endif
    else
        set attack = attack + GetUnitTypeAttack(v, 'h01C', 22, 1, 8)
    endif
    set attack = attack + GetUnitFunctionedAttack(v)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A0S4', 15, 15)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A05Y', 8, 4)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A1G4', -999, 4)
    set attack = attack + GetUnitAbilityAttack(v, 'A0WA', 10)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A06K', 10, 5)
    set attack = attack - GetUnitAbilityAttackLevelIncome(v, 'A0BE', 6, 6)
    set attack = attack - GetUnitAbilityAttackLevelIncome(v, 'A0BT', 8, 8)
    set attack = attack - GetUnitAbilityAttackLevelIncome(v, 'A0CU', 10, 10)
    set attack = attack - GetUnitAbilityAttackLevelIncome(v, 'A0CV', 12, 12)
    set attack = attack + GetUnitAbilityAttack(v, 'A0UD', 35)
    set attack = GetUnitAbilityAttackMultiplierLevelIncome(v, 'A0FB', 0.5, 0.5, attack)
    set attack = GetUnitAbilityAttackMultiplierLevelIncome(v, 'A0J7', 0.04, 0.04, attack)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A097', 20, 20)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A0OY', 1, 1)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A0YZ', 10, 10)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A07L', 0, 5)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A07M', 0, 50)
    set attack = attack + GetUnitAbilityAttackLevelIncome(v, 'A0P7', 35, 10)
    set attack = attack + udg_DMG_AllItemAttack[GetPlayerId(GetOwningPlayer(v))]
    set attack = attack + UnitGetBonusDmg(v)
    return R2I(attack)
endfunction

function InitTrig_GetUnitAttack takes nothing returns nothing
endfunction