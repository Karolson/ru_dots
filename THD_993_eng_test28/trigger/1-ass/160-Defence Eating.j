function Trig_Defence_Eating_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local unit v = GetSellingUnit()
    if GetUnitTypeId(u) != 'n00B' then
        set u = null
        set v = null
        return false
    endif
    if GetUnitTypeId(u) == 'n00B' and GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER) < 5 then
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! 5 faith is required to use Devour")
        call RemoveUnit(u)
        call AddUnitToStock(v, 'n00B', 1, 1)
        set u = null
        set v = null
        return false
    endif
    set u = null
    set v = null
    return true
endfunction

function Eating_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    local unit caster = GetSellingUnit()
    local player PLY = GetOwningPlayer(caster)
    local boolean t = false
    if IsUnitEnemy(u, PLY) and IsUnitType(u, UNIT_TYPE_HERO) == false and IsUnitType(u, UNIT_TYPE_STRUCTURE) == false and GetWidgetLife(u) > 0.405 and IsUnitType(u, UNIT_TYPE_ANCIENT) == false and IsUnitIllusion(u) == false then
        set t = true
    endif
    if IsUnitInvulnerable(u) then
        set t = false
    elseif GetUnitTypeId(u) == 'o012' then
        set t = false
    elseif GetUnitTypeId(u) == 'n01S' then
        set t = false
    elseif GetUnitTypeId(u) == 'n01U' then
        set t = false
    elseif GetUnitTypeId(u) == 'n01V' then
        set t = false
    endif
    set u = null
    set caster = null
    set PLY = null
    return t
endfunction

function Trig_Defence_Eating_Actions takes nothing returns nothing
    local integer cost = 5
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local group g = CreateGroup()
    local filterfunc f = Filter(function Eating_Filter)
    local effect e
    local player PLY = GetOwningPlayer(u)
    local boolean eating = false
    call RemoveUnit(u)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 400, f)
    call DestroyFilter(f)
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    if u == null then
        call DisplayTextToPlayer(PLY, 0, 0, "There is no unit to eat near the Genji tower. Genji has swallowed air and the recovery time is doubled")
        set eating = false
    else
        set eating = true
    endif
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " swallowed", PLY)
    if eating then
        call IssueTargetOrder(caster, "attack", u)
    endif
    call SetUnitAnimation(caster, "Attack Spell")
    call TriggerSleepAction(0.3)
    if eating then
        set e = AddSpecialEffect("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", GetUnitX(u), GetUnitY(u))
        call DestroyEffect(e)
        call KillUnit(u)
    endif
    set u = NewDummy(udg_PlayerA[0], GetUnitX(caster), GetUnitY(caster), 0)
    if eating then
        call UnitAddAbility(u, 'A06N')
        call IssueTargetOrder(u, "rejuvination", caster)
        call UnitRemoveAbility(u, 'A06N')
    else
        call UnitAddAbility(u, 'A0NQ')
        call IssueTargetOrder(u, "rejuvination", caster)
        call UnitRemoveAbility(u, 'A0NQ')
    endif
    call ReleaseDummy(u)
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    set caster = null
    set u = null
    set g = null
    set e = null
    set PLY = null
    set f = null
endfunction

function InitTrig_Defence_Eating takes nothing returns nothing
    set gg_trg_Defence_Eating = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_Eating, Condition(function Trig_Defence_Eating_Conditions))
    call TriggerAddAction(gg_trg_Defence_Eating, function Trig_Defence_Eating_Actions)
endfunction