function Trig_Tower_Break_A_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE)
endfunction

function Trig_Tower_Break_A_Actions takes nothing returns nothing
    local integer i = 1
    loop
    exitwhen udg_BaseA[i] == GetTriggerUnit()
        set i = i + 1
    exitwhen i > 15
    endloop
    set udg_BaseA[i] = null
    if udg_BaseA[11] == null then
        call SetUnitInvulnerable(udg_BaseA[3], false)
    endif
    if udg_BaseA[12] == null then
        call SetUnitInvulnerable(udg_BaseA[4], false)
    endif
    if udg_BaseA[14] == null then
        call SetUnitInvulnerable(udg_BaseA[5], false)
    endif
    if udg_GameMode / 100 == 3 then
        if udg_BaseA[1] == null and udg_BaseA[2] == null then
            call SetUnitInvulnerable(udg_BaseA[0], false)
        endif
    else
        if udg_BaseA[1] == null and udg_BaseA[2] == null then
            call SetUnitInvulnerable(udg_BaseA[0], false)
        endif
    endif
    if udg_GameMode / 100 != 3 then
        if udg_BaseA[3] == null and udg_BaseA[4] == null and udg_BaseA[5] == null and GetUnitTypeId(GetTriggerUnit()) == 'h013' then
            set udg_SU_ID_B[0] = udg_SUA_ID_B[0]
            set udg_SU_ID_B[1] = udg_SUA_ID_B[1]
            set udg_SU_ID_B[2] = udg_SUA_ID_B[2]
        endif
    endif
    if i == 1 or i == 2 or (6 <= i and i <= 15) then
        if udg_GameMode / 100 != 3 then
            if i == 1 or i == 2 then
                call ShareGold(udg_PlayerB[0], 2400)
                call DisplayTextToForce(udg_TeamB, "|cffffcc00Tower destroyed, team divided 1200 points reward!|r")
            else
                call ShareGold(udg_PlayerB[0], 1200)
                call DisplayTextToForce(udg_TeamB, "|cffffcc00Tower destroyed, team divided 1200 points reward!|r")
            endif
        endif
        set i = GetPlayerId(udg_PlayerA[0])
        set udg_FlagDeath[i] = udg_FlagDeath[i] + 1
        call GIB_SetPlayerField(udg_PlayerA[0], 4, I2S(8 - udg_FlagDeath[i]))
        if udg_GameMode / 100 == 2 then
            set udg_GIB_PlayerScoreForSolo[1] = udg_GIB_PlayerScoreForSolo[1] + 1
            call BroadcastMessage("|cFF00FF00Moriya has scored 1 point for destroying a tower|r，current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
            call Trig_SoloMode_CountingWinLose()
        endif
    endif
endfunction

function InitTrig_Tower_Break_A takes nothing returns nothing
    set gg_trg_Tower_Break_A = CreateTrigger()
    call TriggerAddCondition(gg_trg_Tower_Break_A, Condition(function Trig_Tower_Break_A_Conditions))
    call TriggerAddAction(gg_trg_Tower_Break_A, function Trig_Tower_Break_A_Actions)
endfunction