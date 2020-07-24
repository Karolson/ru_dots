function GetUnitControlAllReduce takes unit caster, unit target returns real
    local real timeper = 1.0
    if udg_SK_Parsee01 > 0 and IsUnitEnemy(target, GetOwningPlayer(udg_SK_Parsee)) and IsUnitInRange(target, udg_SK_Parsee, 900.0) then
        set timeper = timeper * (1 + udg_SK_Parsee01)
    endif
    if GetUnitAbilityLevel(target, 'A1CE') >= 1 then
        set timeper = timeper * (1 - 0.1 * GetUnitAbilityLevel(target, 'A1CE'))
    endif
    if YDWEUnitHasItemOfTypeBJNull(target, 'I071') or YDWEUnitHasItemOfTypeBJNull(target, 'I07D') then
        set timeper = timeper * 0.65
    endif
    if GetUnitAbilityLevel(target, 'B08E') > 0 then
        set timeper = timeper * (1.2 + GetUnitAbilityLevel(target, 'B08E') * 0.1)
    endif
    if GetUnitAbilityLevel(target, 'B08F') > 0 then
        set timeper = timeper * 0.7
    endif
    if GetUnitAbilityLevel(target, 'B08H') != 0 then
        set timeper = timeper * 1.4
    endif
    return timeper
endfunction

function InitTrig_GetUnitControlIncRed takes nothing returns nothing
endfunction