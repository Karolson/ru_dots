function Trig_AgiInt05_Doll_Issue_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A03J'
endfunction

function Trig_AgiInt05_Doll_Issue_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u = CreateUnit(GetOwningPlayer(caster), 'n00G', GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    set udg_ObjectsDoll = caster
    call UnitAddAbility(u, 'A03K')
    call IssueTargetOrderById(u, 852274, caster)
    set caster = null
    set u = null
endfunction

function InitTrig_AgiInt05_Doll_Issue takes nothing returns nothing
    set gg_trg_AgiInt05_Doll_Issue = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AgiInt05_Doll_Issue, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_AgiInt05_Doll_Issue, Condition(function Trig_AgiInt05_Doll_Issue_Conditions))
    call TriggerAddAction(gg_trg_AgiInt05_Doll_Issue, function Trig_AgiInt05_Doll_Issue_Actions)
endfunction