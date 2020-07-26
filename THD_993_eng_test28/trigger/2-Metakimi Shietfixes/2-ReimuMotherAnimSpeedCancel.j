function Trig_ReimuMotherAnimSpeedCancel_Func003001001 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C0' )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Func003001002 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C2' )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Func003001 takes nothing returns boolean
    return GetBooleanOr( Trig_ReimuMotherAnimSpeedCancel_Func003001001(), Trig_ReimuMotherAnimSpeedCancel_Func003001002() )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Func003002001 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C1' )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Func003002002 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C3' )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Func003002 takes nothing returns boolean
    return GetBooleanOr( Trig_ReimuMotherAnimSpeedCancel_Func003002001(), Trig_ReimuMotherAnimSpeedCancel_Func003002002() )
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'H02E' ) ) then
        return false
    endif
    if ( not GetBooleanOr( Trig_ReimuMotherAnimSpeedCancel_Func003001(), Trig_ReimuMotherAnimSpeedCancel_Func003002() ) ) then
        return false
    endif
    return true
endfunction

function Trig_ReimuMotherAnimSpeedCancel_Actions takes nothing returns nothing
    call SetUnitTimeScalePercent( GetSpellAbilityUnit(), 100.00 )
endfunction

//===========================================================================
function InitTrig_ReimuMotherAnimSpeedCancel takes nothing returns nothing
    set gg_trg_ReimuMotherAnimSpeedCancel = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ReimuMotherAnimSpeedCancel, EVENT_PLAYER_UNIT_SPELL_FINISH )
    call TriggerAddCondition( gg_trg_ReimuMotherAnimSpeedCancel, Condition( function Trig_ReimuMotherAnimSpeedCancel_Conditions ) )
    call TriggerAddAction( gg_trg_ReimuMotherAnimSpeedCancel, function Trig_ReimuMotherAnimSpeedCancel_Actions )
endfunction

