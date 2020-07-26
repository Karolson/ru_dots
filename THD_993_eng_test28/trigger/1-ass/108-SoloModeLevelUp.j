function Trig_SoloModeLevelUp_Conditions takes nothing returns boolean
    if GetHeroLevel(GetTriggerUnit()) != 11 then
        return false
    endif
    return udg_GameMode / 100 == 2
endfunction

function Trig_SoloModeLevelUp_Actions takes nothing returns nothing
    if IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()), udg_TeamA) then
        set udg_GIB_PlayerScoreForSolo[0] = udg_GIB_PlayerScoreForSolo[0] + 1
        call BroadcastMessage("|cFFFF0000A Hakurei player reached level 11 first. Hakurei scores a point.|r，current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
    else
        set udg_GIB_PlayerScoreForSolo[1] = udg_GIB_PlayerScoreForSolo[1] + 1
        call BroadcastMessage("|cFF00FF00A Moriya player reached level 11 first. Moriya scores a point.|r，current score: " + I2S(udg_GIB_PlayerScoreForSolo[0]) + "(Hakurei) " + I2S(udg_GIB_PlayerScoreForSolo[1]) + "(Moriya)")
    endif
    call Trig_SoloMode_CountingWinLose()
    call DisableTrigger(gg_trg_SoloModeLevelUp)
endfunction

function InitTrig_SoloModeLevelUp takes nothing returns nothing
    set gg_trg_SoloModeLevelUp = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SoloModeLevelUp, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(gg_trg_SoloModeLevelUp, Condition(function Trig_SoloModeLevelUp_Conditions))
    call TriggerAddAction(gg_trg_SoloModeLevelUp, function Trig_SoloModeLevelUp_Actions)
endfunction