function Trig_AI_Shizuha_Attacked_Conditions takes nothing returns boolean
    if IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_AI_Players) == false then
        return false
    endif
    return GetUnitTypeId(GetTriggerUnit()) == 'H01H' or GetUnitTypeId(GetTriggerUnit()) == 'H02F'
endfunction

function Trig_AI_Shizuha_Attacked_Actions takes nothing returns nothing
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
    if IsUnitType(attacker, UNIT_TYPE_STRUCTURE) then
        call AI_TowerRetreatOrderation(h, attacker)
    elseif IsUnitType(attacker, UNIT_TYPE_HERO) then
        set enemypower = GetUnitState(attacker, UNIT_STATE_LIFE) * GetUnitAttack(attacker) * GetUnitAttackSpeed(attacker) * GetUnitArmor(h)
        set enemypower2 = GetHeroInt(attacker, true) * 6.0
        if enemypower > power then
            call AI_IssueRetreatOrder(h)
            call IssueImmediateOrder(h, "unimmolation")
        elseif enemypower < power then
            if GetUnitState(attacker, UNIT_STATE_MANA) <= 200 then
                call IssueTargetOrder(h, "attack", attacker)
                call IssueImmediateOrder(h, "immolation")
            else
                if (GetHeroInt(attacker, true) + 40) * IMinBJ(GetHeroLevel(attacker) * 2, 7) <= GetUnitState(h, UNIT_STATE_LIFE) + 200 then
                    call IssueTargetOrder(h, "attack", attacker)
                    call IssueImmediateOrder(h, "immolation")
                else
                    call AI_IssueRetreatOrder(h)
                    call IssueImmediateOrder(h, "unimmolation")
                endif
            endif
        else
        endif
    else
        if GetRandomInt(0, 100) < 5 then
            call AI_IssueRetreatOrder(h)
            call IssueImmediateOrder(h, "unimmolation")
        endif
    endif
    set h = null
    set who = null
    set attacker = null
endfunction

function InitTrig_AI_Shizuha_Attacked takes nothing returns nothing
endfunction