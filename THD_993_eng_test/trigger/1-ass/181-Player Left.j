function Trig_Player_Left_Control takes nothing returns nothing
    if GetTriggerPlayer() != GetEnumPlayer() then
        call SetPlayerAlliance(GetTriggerPlayer(), GetEnumPlayer(), ALLIANCE_SHARED_CONTROL, true)
    endif
endfunction

function Trig_Player_Left_Actions takes nothing returns nothing
    local player who = GetTriggerPlayer()
    local unit h = GetPlayerCharacter(who)
    local unit v
    local integer gold
    local string msg
    local force m
    local group g = CreateGroup()
    local integer i
    local integer cost
    call TriggerSleepAction(2.0)
    set msg = udg_PN[GetPlayerId(who)] + " has left the game"
    call BroadcastMessage(msg)
    if udg_smodestat then
        set who = null
        set v = null
        set msg = null
        set g = null
        set m = null
        set h = null
        return
    endif
    set i = 0
    set cost = 0
    call GroupEnumUnitsOfPlayer(g, who, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        loop
        exitwhen i >= bj_MAX_INVENTORY
            set cost = cost + GetItemLevel(UnitItemInSlot(v, i))
            call RemoveItem(UnitItemInSlot(v, i))
            set i = i + 1
        endloop
        set i = 0
    endloop
    call DestroyGroup(g)
    set gold = GetPlayerState(who, PLAYER_STATE_RESOURCE_GOLD) + R2I(0.75 * cost)
    call SetPlayerState(who, PLAYER_STATE_RESOURCE_GOLD, 0)
    if IsPlayerInForce(who, udg_TeamA) then
        call SetUnitPositionLoc(h, udg_RevivePoint[0])
        call ShareGold(who, gold)
        call ForForce(udg_TeamA, function Trig_Player_Left_Control)
        call SetPlayerAlliance(who, udg_PlayerA[0], ALLIANCE_SHARED_CONTROL, true)
    elseif IsPlayerInForce(who, udg_TeamB) then
        call SetUnitPositionLoc(h, udg_RevivePoint[1])
        call ShareGold(who, gold)
        call ForForce(udg_TeamB, function Trig_Player_Left_Control)
        call SetPlayerAlliance(who, udg_PlayerB[0], ALLIANCE_SHARED_CONTROL, true)
    endif
    set who = null
    set v = null
    set msg = null
    set g = null
    set m = null
    set h = null
endfunction

function InitTrig_Player_Left takes nothing returns nothing
    set gg_trg_Player_Left = CreateTrigger()
    call TriggerAddAction(gg_trg_Player_Left, function Trig_Player_Left_Actions)
endfunction