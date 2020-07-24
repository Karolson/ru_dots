function BaseHeroReduction takes unit target returns real
    if IsUnitType(target, UNIT_TYPE_HERO) then
        return 1.0
    endif
    return 1.0
endfunction

function IsDamagePhsyicalAttack takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_AbsDamageUnit[i] then
            return true
        elseif caster == udg_A_DelDamageUnit[i] then
            return true
        elseif caster == udg_A_MagicDamageUnit[i] then
            return true
        elseif caster == udg_A_PhysicalDamageUnit[i] then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    return false
endfunction

function IsDamagePhsyicalItemDamage takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_PhysicalItemDamageUnit[i] then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    return false
endfunction

function IsDamagePhsyicalAbilityDamage takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_PhysicalAbilityDamageUnit[i] then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    return false
endfunction

function IsDamageMagicDamage takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_MagicDamageUnit[i] then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    return false
endfunction

function IsDamageNotUnitAttack takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_AbsDamageUnit[i] then
            return true
        endif
        if caster == udg_A_DelDamageUnit[i] then
            return true
        endif
        if caster == udg_A_MagicDamageUnit[i] then
            return true
        endif
        if caster == udg_A_PhysicalDamageUnit[i] then
            return true
        endif
        if caster == udg_A_PhysicalAbilityDamageUnit[i] then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    if GetUnitTypeId(caster) == 'n00E' then
        return true
    endif
    return false
endfunction

function IsDamageADamage takes unit caster returns boolean
    local integer i
    set i = 0
    loop
        if caster == udg_A_AbsDamageUnit[i] then
            return true
        endif
        if caster == udg_A_DelDamageUnit[i] then
            return true
        endif
        if caster == udg_A_MagicDamageUnit[i] then
            return true
        endif
        if caster == udg_A_PhysicalDamageUnit[i] then
            return true
        endif
        if IsUnitType(caster, UNIT_TYPE_HERO) then
            return true
        endif
        set i = i + 1
    exitwhen i >= 16
    endloop
    return false
endfunction

function Trig_OverAllDSBoolean_Actions takes nothing returns nothing
endfunction

function InitTrig_OverAllDSBoolean takes nothing returns nothing
endfunction