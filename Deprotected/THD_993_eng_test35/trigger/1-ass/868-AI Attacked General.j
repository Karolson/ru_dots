function Trig_AI_Attacked_General_Conditions takes nothing returns boolean
    if IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_AI_Players) == false then
        return false
    endif
    if IsAIFinished(GetTriggerUnit()) then
        return false
    endif
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_AI_Attacked_General_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    local player who = GetOwningPlayer(h)
    local unit attacker
    local real power
    local real enemypower
    local real enemypower2
    if GetTriggerEventId() != EVENT_PLAYER_UNIT_ATTACKED then
        set attacker = GetEventDamageSource()
    else
        set attacker = GetAttacker()
    endif
    set power = GetUnitState(h, UNIT_STATE_LIFE) * GetUnitAttack(h) * GetUnitAttackSpeed(h) * GetUnitArmor(h)
    call DebugMsg("AI " + GetPlayerName(who) + " Attacked")
    if IsUnitType(attacker, UNIT_TYPE_STRUCTURE) then
        call DebugMsg("AI " + GetPlayerName(who) + " Order: Retreat from Tower")
        call AI_TowerRetreatOrderation(h, attacker)
    elseif IsUnitType(attacker, UNIT_TYPE_HERO) then
        set enemypower = GetUnitState(attacker, UNIT_STATE_LIFE) * GetUnitAttack(attacker) * GetUnitAttackSpeed(attacker) * GetUnitArmor(h)
        set enemypower2 = GetHeroInt(attacker, true) * 6.0
        call DebugMsg("AI " + GetPlayerName(who) + " Order: Calc Power")
        if enemypower > power then
            call AI_IssueRetreatOrder(h)
            call UnitBuffTarget(h, h, 9, 'A19L', 0)
        elseif enemypower < power then
            if GetUnitState(attacker, UNIT_STATE_MANA) <= 200 then
                call IssueTargetOrder(h, "attack", attacker)
            else
                if (GetHeroInt(attacker, true) + 40) * IMinBJ(GetHeroLevel(attacker) * 2, 7) <= GetUnitState(h, UNIT_STATE_LIFE) + 200 then
                    call IssueTargetOrder(h, "attack", attacker)
                else
                    call AI_IssueRetreatOrder(h)
                    call UnitBuffTarget(h, h, 9, 'A19L', 0)
                endif
            endif
        endif
    else
        if GetRandomInt(0, 100) < 15 then
            call AI_IssueRetreatOrder(h)
            call UnitBuffTarget(h, h, 1.5, 'A19L', 0)
        endif
    endif
    set h = null
    set who = null
    set attacker = null
endfunction

function InitTrig_AI_Attacked_General takes nothing returns nothing
    set gg_trg_AI_Minoriko_Attacked = CreateTrigger()
    set gg_trg_AI_Attacked_General = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_AI_ChangeDefendingArea)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AI_Attacked_General, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(gg_trg_AI_Attacked_General, Condition(function Trig_AI_Attacked_General_Conditions))
    call TriggerAddAction(gg_trg_AI_Attacked_General, function Trig_AI_Attacked_General_Actions)
endfunction