function Trig_AI_Team_Players takes nothing returns nothing
    local integer i = GetPlayerId(GetEnumPlayer())
    if IsPlayerInForce(GetEnumPlayer(), udg_TeamA) then
        call GroupAddUnit(udg_AI_Groups[2], udg_PlayerHeroes[i])
    elseif IsPlayerInForce(GetEnumPlayer(), udg_TeamB) then
        call GroupAddUnit(udg_AI_Groups[3], udg_PlayerHeroes[i])
    endif
endfunction

function Trig_AI_PickHero takes nothing returns nothing
    local player PLY = GetEnumPlayer()
    local integer i = GetPlayerId(PLY)
    local unit caster = udg_PlayerHeroesBan[i]
    if udg_PlayerHeroes[i] == null then
        call RescueUnitBJ(caster, PLY, true)
        set udg_PlayerHeroes[i] = caster
        call SetUnitUserData(caster, 0)
        set udg_PlayerName[i] = udg_PlayerColors[i] + GetPlayerName(Player(i)) + "|r"
        call SetPlayerName(PLY, GetPlayerName(PLY) + " " + "(" + GetHeroProperName(udg_PlayerHeroes[i]) + ")")
        set udg_PN[i] = udg_PlayerColors[i] + GetPlayerName(Player(i)) + "|r"
        call TriggerRegisterUnitEvent(gg_trg_CE_Input, udg_PlayerHeroes[i], EVENT_UNIT_DAMAGED)
        call UnitRemoveAbility(udg_PlayerHeroes[i], 'Asud')
        call UnitRemoveAbility(udg_PlayerHeroes[i], 'Aall')
        call ModifyHeroSkillPoints(udg_PlayerHeroes[i], bj_MODIFYMETHOD_SET, 1)
        call TriggerExecute(gg_trg_Setup_Game_Info_Board)
    endif
    set PLY = null
    set caster = null
endfunction

function Trig_AI_Register_Learning_Skill takes nothing returns nothing
    local integer i = GetPlayerId(GetEnumPlayer())
    call AI_LearnSkill(udg_PlayerHeroes[i])
    call TriggerRegisterUnitEvent(gg_trg_AI_Learn, udg_PlayerHeroes[i], EVENT_UNIT_HERO_LEVEL)
endfunction

function Trig_AI_Register_Revive_Events takes nothing returns nothing
    local integer i = GetPlayerId(GetEnumPlayer())
    call TriggerRegisterUnitEvent(gg_trg_AI_Revive, udg_PlayerHeroes[i], EVENT_UNIT_HERO_REVIVE_FINISH)
endfunction

function Trig_AI_Init_Conditions takes nothing returns boolean
    call CountAIPlayerSum()
    return udg_AI_DataBase[0] > 0
endfunction

function Trig_AI_Init_Actions takes nothing returns nothing
    call DestroyTrigger(gg_trg_AI_Init)
    if ModuloInteger(udg_GameMode, 100) / 10 == 5 then
        call ForForce(udg_AI_Players, function Trig_AI_PickHero)
    endif
    call ForForce(udg_OnlinePlayers, function Trig_AI_Team_Players)
    set gg_trg_AI_Learn = CreateTrigger()
    call ForForce(udg_AI_Players, function Trig_AI_Register_Learning_Skill)
    call TriggerAddAction(gg_trg_AI_Learn, function Trig_AI_Learn_Actions)
    set gg_trg_AI_Revive = CreateTrigger()
    call ForForce(udg_AI_Players, function Trig_AI_Register_Revive_Events)
    call TriggerAddCondition(gg_trg_AI_Revive, Condition(function Trig_AI_Revive_Conditions))
    call TriggerAddAction(gg_trg_AI_Revive, function Trig_AI_Revive_Actions)
    set gg_trg_AI_EXP_Bonus = CreateTrigger()
    call YDWETriggerRegisterEnterRectSimpleNull(gg_trg_AI_EXP_Bonus, gg_rct_BaseA)
    call YDWETriggerRegisterEnterRectSimpleNull(gg_trg_AI_EXP_Bonus, gg_rct_BaseB)
    call TriggerAddCondition(gg_trg_AI_EXP_Bonus, Condition(function Trig_AI_EXP_Bonus_Conditions))
    call TriggerAddAction(gg_trg_AI_EXP_Bonus, function Trig_AI_EXP_Bonus_Actions)
    set udg_TeamWorkingModeA = -1
    set udg_TeamWorkingModeB = -1
    call TriggerExecute(gg_trg_AI_Action)
endfunction

function InitTrig_AI_Init takes nothing returns nothing
    set gg_trg_AI_Init = CreateTrigger()
    call TriggerAddCondition(gg_trg_AI_Init, Condition(function Trig_AI_Init_Conditions))
    call TriggerAddAction(gg_trg_AI_Init, function Trig_AI_Init_Actions)
endfunction