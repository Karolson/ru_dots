function Trig_ReimuMotherAttackAnim_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'H02E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ReimuMotherAttackAnim_Actions takes nothing returns nothing
    call SetUnitAnimation( GetAttacker(), "Spell Two" )
endfunction

//===========================================================================
function InitTrig_ReimuMotherAttackAnim takes nothing returns nothing
    set gg_trg_ReimuMotherAttackAnim = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ReimuMotherAttackAnim, EVENT_PLAYER_UNIT_ATTACKED )
    call TriggerAddCondition( gg_trg_ReimuMotherAttackAnim, Condition( function Trig_ReimuMotherAttackAnim_Conditions ) )
    call TriggerAddAction( gg_trg_ReimuMotherAttackAnim, function Trig_ReimuMotherAttackAnim_Actions )
endfunction

