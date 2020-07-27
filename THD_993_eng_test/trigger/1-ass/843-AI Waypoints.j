function Trig_AI_Waypoints_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == false then
        return false
    elseif IsUnitIllusion(GetTriggerUnit()) then
        return false
    elseif GetUnitAbilityLevel(GetTriggerUnit(), 'Aloc') != 0 then
        return false
    elseif IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_AI_Players) == false then
        return false
    endif
    return true
endfunction

function Trig_AI_Waypoints_Actions takes nothing returns nothing
    local unit h = GetEnteringUnit()
    local player w = GetOwningPlayer(h)
    local location p
    local real ox = GetUnitX(h)
    local real oy = GetUnitY(h)
    local real dx
    local real dy
    local integer i
    local integer offset
    local integer addset
    local integer rnum
    if GetPlayerForceId(GetOwningPlayer(h)) == 0 then
        set offset = 0
    else
        set offset = 32
    endif
    if GetUnitAbilityLevel(h, 'A1A4') == 0 then
        call UnitAddAbility(h, 'A1A4')
        if w == udg_PlayerA[1] or w == udg_PlayerB[1] then
            call SetUnitAbilityLevel(h, 'A1A4', 1)
        elseif w == udg_PlayerA[2] or w == udg_PlayerB[2] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[3] or w == udg_PlayerB[3] then
            call SetUnitAbilityLevel(h, 'A1A4', 2)
        elseif w == udg_PlayerA[4] or w == udg_PlayerB[4] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        elseif w == udg_PlayerA[5] or w == udg_PlayerB[5] then
            call SetUnitAbilityLevel(h, 'A1A4', 3)
        endif
    endif
    set addset = -8 + 8 * GetUnitAbilityLevel(h, 'A1A4')
    set i = 0
    loop
        set p = udg_AI_Waypoints[offset + i + addset]
    exitwhen p == null
        set dx = GetLocationX(p) - ox
        set dy = GetLocationY(p) - oy
    exitwhen SquareRoot(dx * dx + dy * dy) < 360.0
        set i = i + 1
    exitwhen i == 8
    endloop
    if IsUnitAlly(h, udg_PlayerA[1]) then
        if udg_TeamWorkingModeA > 0 and GetUnitAbilityLevel(h, 'A1A4') != udg_TeamWorkingModeA then
            set rnum = udg_TeamWorkingModeA
            if rnum == 1 then
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            elseif rnum == 2 then
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            else
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            endif
            call SetUnitAbilityLevel(h, 'A1A4', udg_TeamWorkingModeA)
        endif
    else
        if udg_TeamWorkingModeB > 0 and GetUnitAbilityLevel(h, 'A1A4') != udg_TeamWorkingModeB then
            set rnum = udg_TeamWorkingModeB
            if rnum == 1 then
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            elseif rnum == 2 then
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            else
                call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
            endif
            call SetUnitAbilityLevel(h, 'A1A4', udg_TeamWorkingModeB)
        endif
    endif
    if i == 0 and udg_GameTime >= 1500 then
        if IsUnitAlly(h, udg_PlayerA[1]) then
            if udg_TeamWorkingModeA < 0 then
                set rnum = GetRandomInt(1, 3)
                set udg_TeamWorkingModeA = GetRandomInt(1, 3)
                if rnum == 1 then
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                elseif rnum == 2 then
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                else
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                endif
                call SetUnitAbilityLevel(h, 'A1A4', udg_TeamWorkingModeA)
            endif
        else
            if udg_TeamWorkingModeB < 0 then
                set rnum = GetRandomInt(1, 3)
                set udg_TeamWorkingModeB = GetRandomInt(1, 3)
                if rnum == 1 then
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                elseif rnum == 2 then
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                else
                    call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
                endif
                call SetUnitAbilityLevel(h, 'A1A4', udg_TeamWorkingModeB)
            endif
        endif
    elseif i == 0 and udg_GameTime >= 300 and udg_GameTime < 1500 then
        set rnum = GetRandomInt(1, 3)
        call SetUnitAbilityLevel(h, 'A1A4', rnum)
        if rnum == 1 then
            call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
        elseif rnum == 2 then
            call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
        else
            call BroadcastMessageFriend("Ally " + udg_PN[GetPlayerId(GetOwningPlayer(h))] + ": I decided to push the middle road with the regiment", w)
        endif
    endif
    if i != 8 then
        set udg_AI_States[GetPlayerId(w) * 512 + 1 * 16 + 0] = i
    endif
    if IsPlayerInForce(w, udg_AI_Players) then
        if udg_AI_States[GetPlayerId(w) * 512 + 2 * 16 + 0] == 1 then
        else
        endif
    endif
    set h = null
    set w = null
    set p = null
endfunction

function InitTrig_AI_Waypoints takes nothing returns nothing
    set gg_trg_AI_Waypoints = CreateTrigger()
    call TriggerAddCondition(gg_trg_AI_Waypoints, Condition(function Trig_AI_Waypoints_Conditions))
    call TriggerAddAction(gg_trg_AI_Waypoints, function Trig_AI_Waypoints_Actions)
endfunction