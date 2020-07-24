function THD_SyncSpirit_A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, udg_ScoreSpirit[5])
endfunction

function THD_SyncSpirit_B takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, udg_ScoreSpirit[11])
endfunction

function THD_SyncSpirit takes nothing returns nothing
    call ForForce(udg_TeamA, function THD_SyncSpirit_A)
    call SetPlayerStateBJ(udg_PlayerA[0], PLAYER_STATE_RESOURCE_LUMBER, udg_ScoreSpirit[5])
    call ForForce(udg_TeamB, function THD_SyncSpirit_B)
    call SetPlayerStateBJ(udg_PlayerB[0], PLAYER_STATE_RESOURCE_LUMBER, udg_ScoreSpirit[11])
endfunction

function THD_AddSpirit takes player who, integer amount returns nothing
    if IsPlayerAlly(who, udg_PlayerA[0]) then
        set udg_ScoreSpirit[5] = IMinBJ(150, udg_ScoreSpirit[5] + amount)
    elseif IsPlayerAlly(who, udg_PlayerB[0]) then
        set udg_ScoreSpirit[11] = IMinBJ(150, udg_ScoreSpirit[11] + amount)
    endif
    call THD_SyncSpirit()
endfunction

function THD_GetSpirit takes player who returns integer
    if IsPlayerAlly(who, udg_PlayerA[0]) then
        return udg_ScoreSpirit[5]
    endif
    if IsPlayerAlly(who, udg_PlayerB[0]) then
        return udg_ScoreSpirit[11]
    endif
    return 0
endfunction

function THD_AddCredit takes player who, integer amount returns nothing
    local unit u = udg_PlayerHeroes[GetPlayerId(who)]
    local texttag e
    local real tmp = amount
    local real tmp2
    if u != null then
        set e = CreateTextTag()
        if amount > 0 then
            call SetTextTagTextBJ(e, "+" + I2S(amount), 11.0)
            call SetTextTagColor(e, 255, 255, 0, 240)
        else
            call SetTextTagTextBJ(e, "-" + I2S(-amount), 11.0)
            call SetTextTagColor(e, 80, 80, 255, 240)
        endif
        call SetTextTagPos(e, GetUnitX(u) - 15, GetUnitY(u), 50.0)
        if IsVisibleToPlayer(GetUnitX(u), GetUnitY(u), GetLocalPlayer()) == false or IsPlayerAlly(GetLocalPlayer(), GetOwningPlayer(u)) == false then
            call SetTextTagVisibility(e, false)
        else
            call SetTextTagVisibility(e, true)
        endif
        call SetTextTagVelocityBJ(e, 150, 90)
        call SetTextTagPermanent(e, false)
        call SetTextTagLifespan(e, 1.67)
        set e = null
    endif
    if amount > 0 then
        call SetPlayerState(who, PLAYER_STATE_GOLD_GATHERED, GetPlayerState(who, PLAYER_STATE_GOLD_GATHERED) + amount)
    endif
    call SetPlayerState(who, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(who, PLAYER_STATE_RESOURCE_GOLD) + amount)
    if GetUnitAbilityLevel(u, 'A1GB') != 0 then
        set tmp2 = GetUnitState(u, UNIT_STATE_MAX_LIFE) - GetUnitState(u, UNIT_STATE_LIFE)
        if tmp2 > tmp then
            set tmp2 = tmp
        endif
        set tmp = tmp - tmp2
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + tmp2)
        if tmp > 0 then
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + tmp)
        endif
        call KillUnit(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e014', GetUnitX(u), GetUnitY(u), 22.5))
    endif
endfunction

function THD_GetCredit takes player who returns integer
    return GetPlayerState(who, PLAYER_STATE_RESOURCE_GOLD)
endfunction

function InitTrig_Resource_System takes nothing returns nothing
endfunction