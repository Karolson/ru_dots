function Trig_ReimuMotherAnimSpeed_Func003001001 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C0' )
endfunction

function Trig_ReimuMotherAnimSpeed_Func003001002 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C2' )
endfunction

function Trig_ReimuMotherAnimSpeed_Func003001 takes nothing returns boolean
    return GetBooleanOr( Trig_ReimuMotherAnimSpeed_Func003001001(), Trig_ReimuMotherAnimSpeed_Func003001002() )
endfunction

function Trig_ReimuMotherAnimSpeed_Func003002001 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C1' )
endfunction

function Trig_ReimuMotherAnimSpeed_Func003002002 takes nothing returns boolean
    return ( GetSpellAbilityId() == 'A1C3' )
endfunction

function Trig_ReimuMotherAnimSpeed_Func003002 takes nothing returns boolean
    return GetBooleanOr( Trig_ReimuMotherAnimSpeed_Func003002001(), Trig_ReimuMotherAnimSpeed_Func003002002() )
endfunction

function Trig_ReimuMotherAnimSpeed_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellAbilityUnit()) == 'H02E' ) ) then
        return false
    endif
    if ( not GetBooleanOr( Trig_ReimuMotherAnimSpeed_Func003001(), Trig_ReimuMotherAnimSpeed_Func003002() ) ) then
        return false
    endif
    return true
endfunction

function Trig_ReimuMotherAnimSpeed_Actions takes nothing returns nothing
    call SetUnitTimeScalePercent( GetSpellAbilityUnit(), 200.00 )
endfunction

//===========================================================================
function InitTrig_ReimuMotherAnimSpeed takes nothing returns nothing
    set gg_trg_ReimuMotherAnimSpeed = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ReimuMotherAnimSpeed, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_ReimuMotherAnimSpeed, Condition( function Trig_ReimuMotherAnimSpeed_Conditions ) )
    call TriggerAddAction( gg_trg_ReimuMotherAnimSpeed, function Trig_ReimuMotherAnimSpeed_Actions )
endfunction

