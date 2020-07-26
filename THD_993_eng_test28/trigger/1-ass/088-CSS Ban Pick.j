function Trig_CSS_Ban_Pick_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetSoldUnit()) == 'n00D'
endfunction

function Trig_CSS_Ban_Pick_Actions takes nothing returns nothing
    local player PLY = GetOwningPlayer(GetSoldUnit())
    local unit caster = GetTriggerUnit()
    local integer i = GetPlayerId(PLY)
    local integer n
    if PLY == udg_PlayerA[0] or PLY == udg_PlayerB[0] then
        set PLY = null
        return
    endif
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
        set n = LoadInteger(udg_ht, GetHandleId(caster), 0)
        call FlushChildHashtable(udg_ht, GetHandleId(caster))
        if GetUnitTypeId(caster) == 'O016' or GetUnitTypeId(caster) == 'O019' then
            call TriggerExecute(udg_HeroCloth03Init[n])
        elseif GetUnitTypeId(caster) == 'H02E' then
            call TriggerExecute(udg_HeroCloth02Init[n])
        else
            call TriggerExecute(udg_HeroInit[n])
        endif
        call TriggerExecute(gg_trg_Setup_Game_Info_Board)
    endif
    set PLY = null
    set caster = null
endfunction

function InitTrig_CSS_Ban_Pick takes nothing returns nothing
    set gg_trg_CSS_Ban_Pick = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CSS_Ban_Pick, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_CSS_Ban_Pick, Condition(function Trig_CSS_Ban_Pick_Conditions))
    call TriggerAddAction(gg_trg_CSS_Ban_Pick, function Trig_CSS_Ban_Pick_Actions)
endfunction