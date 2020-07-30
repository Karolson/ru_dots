function Trig_AI_Utsuho_Attacked_Conditions takes nothing returns boolean
    if IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_AI_Players) == false then
        return false
    endif
    return GetUnitTypeId(GetTriggerUnit()) == 'O009'
endfunction

function Trig_AI_Utsuho_Attacked_Actions takes nothing returns nothing
    local unit h = GetTriggerUnit()
    local player who = GetOwningPlayer(h)
    local unit attacker
    local real power
    if GetTriggerEventId() != EVENT_PLAYER_UNIT_ATTACKED then
        set attacker = GetEventDamageSource()
    else
        set attacker = GetAttacker()
    endif
    set power = GetUnitState(h, UNIT_STATE_LIFE) * GetUnitAttack(h) * GetUnitAttackSpeed(h) * GetUnitArmor(h)
    if IsUnitType(attacker, UNIT_TYPE_STRUCTURE) then
        call AI_TowerRetreatOrderation(h, attacker)
    elseif IsUnitType(attacker, UNIT_TYPE_HERO) then
        if GetUnitCurrentOrder(h) == OrderId("acidbomb") then
        elseif GetUnitCurrentOrder(h) == OrderId("avatar") then
        elseif GetUnitCurrentOrder(h) == OrderId("stomp") then
        elseif GetUnitCurrentOrder(h) == OrderId("cyclone") then
        elseif udg_AIUtsuho03_Time > 20 and udg_AIUtsuho03_Time < 25 then
        else
            if GetRandomInt(0, 100) < 45 then
                call AI_IssueRetreatOrder(h)
            endif
        endif
    else
        if GetUnitCurrentOrder(h) == OrderId("acidbomb") then
        elseif GetUnitCurrentOrder(h) == OrderId("avatar") then
        elseif GetUnitCurrentOrder(h) == OrderId("stomp") then
        elseif GetUnitCurrentOrder(h) == OrderId("cyclone") then
        elseif udg_AIUtsuho03_Time > 20 and udg_AIUtsuho03_Time < 25 then
        else
            if GetRandomInt(0, 100) < 8 then
                call AI_IssueRetreatOrder(h)
            endif
        endif
    endif
    set h = null
    set who = null
    set attacker = null
endfunction

function InitTrig_AI_Utsuho_Attacked takes nothing returns nothing
endfunction