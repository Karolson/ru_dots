function Trig_Tower_Break_B_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE)
endfunction

function Trig_Tower_Break_B_Actions takes nothing returns nothing
    local integer i = 1
    loop
    exitwhen udg_BaseB[i] == GetTriggerUnit()
        set i = i + 1
    exitwhen i > 15
    endloop
    set udg_BaseB[i] = null
    if udg_BaseB[11] == null then
        call SetUnitInvulnerable(udg_BaseB[3], false)
    endif
    if udg_BaseB[12] == null then
        call SetUnitInvulnerable(udg_BaseB[4], false)
    endif
    if udg_BaseB[14] == null then
        call SetUnitInvulnerable(udg_BaseB[5], false)
    endif
    if udg_BaseB[1] == null and udg_BaseB[2] == null then
        call SetUnitInvulnerable(udg_BaseB[0], false)
    endif
    if udg_GameMode / 100 != 3 then
        if udg_BaseB[3] == null and udg_BaseB[4] == null and udg_BaseB[5] == null and GetUnitTypeId(GetTriggerUnit()) == 'h00A' then
            set udg_SU_ID_A[0] = udg_SUA_ID_A[0]
            set udg_SU_ID_A[1] = udg_SUA_ID_A[1]
            set udg_SU_ID_A[2] = udg_SUA_ID_A[2]
        endif
    endif
    if i == 1 or i == 2 or (6 <= i and i <= 15) then
        if udg_GameMode / 100 != 3 then
            call ShareGold(udg_PlayerA[0], 1200)
            call DisplayTextToForce(udg_TeamA, "|cffffcc00Breached an enemy line of defense and divided 1200 points reward among the team!|r")
        endif
        set i = GetPlayerId(udg_PlayerB[0])
        set udg_FlagDeath[i] = udg_FlagDeath[i] + 1
        call GIB_SetPlayerField(udg_PlayerB[0], 4, I2S(8 - udg_FlagDeath[i]))
        if udg_GameMode / 100 == 2 then
            set udg_GIB_PlayerScoreForSolo[0] = udg_GIB_PlayerScoreForSolo[0] + 1
            call BroadcastMessage("|cFFFF0000Hakurei has scored 1 point for destroying a tower|r，current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
            call Trig_SoloMode_CountingWinLose()
        endif
    endif
endfunction

function InitTrig_Tower_Break_B takes nothing returns nothing
    set gg_trg_Tower_Break_B = CreateTrigger()
    call TriggerAddCondition(gg_trg_Tower_Break_B, Condition(function Trig_Tower_Break_B_Conditions))
    call TriggerAddAction(gg_trg_Tower_Break_B, function Trig_Tower_Break_B_Actions)
endfunction