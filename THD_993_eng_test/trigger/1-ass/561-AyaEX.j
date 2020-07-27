function Trig_AyaEX_Conditions takes nothing returns boolean
    if GetTriggerEventId() == EVENT_UNIT_HERO_LEVEL then
        return GetUnitTypeId(GetTriggerUnit()) == 'E008'
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        return GetUnitTypeId(GetSummonedUnit()) == 'E008'
    endif
    return false
endfunction

function Trig_AyaEX_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit v
    local integer level = GetHeroLevel(u)
    if GetTriggerEventId() == EVENT_UNIT_HERO_LEVEL then
        set u = GetTriggerUnit()
        set level = GetHeroLevel(u)
        call SetUnitAbilityLevel(u, 'A05Q', level)
        call SetUnitAbilityLevel(u, 'A08Q', level)
        if level == 10 then
            call UnitAddAbility(u, 'A0LG')
        elseif level == 15 then
            call UnitAddAbility(u, 'A0LH')
        endif
    elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_SUMMON then
        set u = GetCharacterHandle('E008')
        set v = GetSummonedUnit()
        set level = GetHeroLevel(u)
        if level >= 15 then
            call UnitAddAbility(v, 'A0LG')
            call UnitAddAbility(v, 'A0LH')
        elseif level >= 10 then
            call UnitAddAbility(v, 'A0LG')
        endif
    endif
    set u = null
    set v = null
endfunction

function InitTrig_AyaEX takes nothing returns nothing
endfunction