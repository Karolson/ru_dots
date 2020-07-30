function Trig_Captain04_LostShip_Conditions takes nothing returns boolean
    return GetTriggerUnit() == udg_SK_Caption04_Ship
endfunction

function Trig_Captain04_LostShip_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer level = GetUnitAbilityLevel(udg_SK_Caption04_Hero, 'A1AW')
    call UnitRemoveAbility(udg_SK_Caption04_Hero, 'A1AW')
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1AW', false)
    call UnitAddAbility(udg_SK_Caption04_Hero, 'A1AX')
    call SetUnitAbilityLevel(udg_SK_Caption04_Hero, 'A1AX', level)
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1AX', true)
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_Captain04_LostShip_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer level = GetUnitAbilityLevel(udg_SK_Caption04_Hero, 'A1AX')
    set udg_SK_Caption04_Ship = null
    call UnitRemoveAbility(udg_SK_Caption04_Hero, 'A1AX')
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1AX', false)
    call UnitAddAbility(udg_SK_Caption04_Hero, 'A1AW')
    call SetUnitAbilityLevel(udg_SK_Caption04_Hero, 'A1AW', level)
    call SetPlayerAbilityAvailable(GetOwningPlayer(udg_SK_Caption04_Hero), 'A1AW', true)
    if YDWEUnitHasItemOfTypeBJNull(udg_SK_Caption04_Hero, 'I00B') then
        call TimerStart(t, 80 * 0.75, false, function Trig_Captain04_LostShip_Clear)
    else
        call TimerStart(t, 80, false, function Trig_Captain04_LostShip_Clear)
    endif
    set t = null
endfunction

function InitTrig_Captain04_LostShip takes nothing returns nothing
endfunction