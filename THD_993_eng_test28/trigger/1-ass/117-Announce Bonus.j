function AnnounceHeroBonus takes unit killer, unit dead returns boolean
    local player winner = GetOwningPlayer(killer)
    local player loser = GetOwningPlayer(dead)
    local integer giveGold = 110
    local integer loseGold = 50 + 7 * GetHeroLevel(dead)
    local integer bonus = 0
    local force team = null
    local boolean TK = false
    local integer qjc
    local string msg
    local integer i = GetPlayerId(loser)
    local integer j = GetPlayerId(winner)
    local real x = udg_FlagKill[i] + 0.5 * udg_FlagAssist[i]
    set udg_FlagDeath[i] = udg_FlagDeath[i] + 1
    if udg_smodestat and winner != Player(PLAYER_NEUTRAL_AGGRESSIVE) and winner != udg_PlayerB[0] and winner != udg_PlayerA[0] then
        set killer = GetPlayerCharacter(winner)
        if udg_smode_jcu == dead then
            set udg_smode_jcu = killer
        endif
        if YDWEGetInventoryIndexOfItemTypeBJNull(dead, 'I075') > 0 then
            call UnitMagicDamageTarget(dead, killer, 200 + GetHeroLevel(dead) * 40, 4)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX(dead), GetUnitY(dead)))
        endif
        call CE_ItemEffect_Add(killer)
        set qjc = udg_smode_jc[GetPlayerId(loser)] / 3
        set udg_smode_jc[GetPlayerId(winner)] = udg_smode_jc[GetPlayerId(winner)] + qjc + 150
        set udg_smode_jc[GetPlayerId(loser)] = R2I(udg_smode_jc[GetPlayerId(loser)] * (1 - 0.333 - 0.1))
        set udg_FlagKill[GetPlayerId(winner)] = udg_FlagKill[GetPlayerId(winner)] + 1
        set msg = udg_PN[GetPlayerId(winner)] + " has killed " + udg_PN[GetPlayerId(loser)] + " for " + I2S(qjc) + " points"
        call BroadcastMessage(msg)
        set msg = "Extra reward: " + I2S(qjc * 2) + " points"
        call BroadcastMessage(msg)
        call THD_AddCredit(winner, R2I(qjc * 2))
        return false
    endif
    if udg_GameMode / 100 == 3 then
        set loseGold = R2I(loseGold * 2.0)
        if YDWEUnitHasItemOfTypeBJNull(dead, 'I07J') then
            set loseGold = R2I(loseGold * 0.75)
        endif
        if YDWEUnitHasItemOfTypeBJNull(dead, 'I08Q') then
            set loseGold = R2I(loseGold * 0.75)
            call UnitBuffTarget(dead, dead, 180, 'A196', 0)
        endif
        if GetUnitTypeId(dead) == 'E01A' then
            set loseGold = loseGold - 15
        elseif GetUnitTypeId(dead) == 'E01B' then
            set loseGold = R2I(loseGold * 0.75)
        elseif GetUnitAbilityLevel(dead, 'A11F') >= 1 then
            set loseGold = loseGold - 15
        endif
    endif
    if GetPlayerState(loser, PLAYER_STATE_RESOURCE_GOLD) > loseGold then
        set udg_PlayerNonItemGoldLoss[i] = udg_PlayerNonItemGoldLoss[i] + loseGold
    else
        set udg_PlayerNonItemGoldLoss[i] = GetPlayerState(loser, PLAYER_STATE_RESOURCE_GOLD)
    endif
    if udg_FlagDeath[i] * 0.5 > x then
        set loseGold = R2I(0.75 * loseGold)
    elseif udg_FlagDeath[i] * 0.4 > x then
        set loseGold = R2I(0.5 * loseGold)
    elseif udg_FlagDeath[i] * 0.3 > x then
        set loseGold = R2I(0.25 * loseGold)
    endif
    call THD_AddCredit(loser, -loseGold)
    set bonus = udg_FlagPerfect[i]
    set udg_FlagPerfect[i] = 0
    if winner == loser then
        set msg = udg_PN[GetPlayerId(loser)] + " has committed suicide and lost " + I2S(loseGold) + " points"
        set udg_FlagUnusualDeath[i] = udg_FlagUnusualDeath[i] + 1
        call BroadcastMessage(msg)
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return false
    endif
    if winner == Player(PLAYER_NEUTRAL_AGGRESSIVE) then
        set msg = udg_PN[GetPlayerId(loser)] + " has miserably died and lost " + I2S(loseGold) + " points"
        call BroadcastMessage(msg)
        set udg_FlagUnusualDeath[i] = udg_FlagUnusualDeath[i] + 1
        set udg_FlagKill[j] = udg_FlagKill[j] + 1
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return false
    endif
    if winner == udg_PlayerA[0] then
        if not IsPlayerInForce(loser, udg_TeamB) and not IsPlayerInForce(loser, udg_SK_Medi_Team) then
            set msg = udg_PN[GetPlayerId(loser)] + " has died!"
            call BroadcastMessage(msg)
            set winner = null
            set loser = null
            set team = null
            set msg = null
            return false
        endif
        set msg = udg_PN[GetPlayerId(udg_PlayerA[0])] + " has defeated " + udg_PN[GetPlayerId(loser)]
        call BroadcastMessage(msg)
        set udg_FlagUnusualDeath[i] = udg_FlagUnusualDeath[i] + 1
        call CE_Bonus(killer, dead, giveGold, 0)
        set udg_FlagKill[j] = udg_FlagKill[j] + 1
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return true
    endif
    if winner == udg_PlayerB[0] then
        if not IsPlayerInForce(loser, udg_TeamA) and not IsPlayerInForce(loser, udg_SK_Medi_Team) then
            set msg = udg_PN[GetPlayerId(loser)] + " has died!"
            call BroadcastMessage(msg)
            set winner = null
            set loser = null
            set team = null
            set msg = null
            return false
        endif
        set msg = udg_PN[GetPlayerId(udg_PlayerB[0])] + " has defeated " + udg_PN[GetPlayerId(loser)]
        call BroadcastMessage(msg)
        set udg_FlagUnusualDeath[i] = udg_FlagUnusualDeath[i] + 1
        call CE_Bonus(killer, dead, giveGold, 0)
        set udg_FlagKill[j] = udg_FlagKill[j] + 1
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return true
    endif
    if IsPlayerAlly(winner, loser) then
        set team = null
        set TK = true
    elseif IsPlayerInForce(winner, udg_TeamA) or winner == udg_PlayerA[0] then
        if IsPlayerInForce(loser, udg_TeamB) then
            set team = udg_TeamA
            set udg_FlagKill[5] = udg_FlagKill[5] + 1
        else
            set team = null
            set TK = true
        endif
    elseif IsPlayerInForce(winner, udg_TeamB) or winner == udg_PlayerB[0] then
        if IsPlayerInForce(loser, udg_TeamA) then
            set team = udg_TeamB
            set udg_FlagKill[11] = udg_FlagKill[11] + 1
        else
            set team = null
            set TK = true
        endif
    endif
    if team != null then
        set udg_FlagKill[j] = udg_FlagKill[j] + 1
        if bonus >= 12 then
            set msg = udg_PN[GetPlayerId(winner)] + " has successfully overthrown " + udg_PN[GetPlayerId(loser)] + " the Genocider"
            call BroadcastMessage(msg)
        elseif bonus == 11 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Ownage streak"
            call BroadcastMessage(msg)
        elseif bonus == 10 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Beyond Godlike streak"
            call BroadcastMessage(msg)
        elseif bonus == 9 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Godlike streak"
            call BroadcastMessage(msg)
        elseif bonus == 8 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Monster Kill streak"
            call BroadcastMessage(msg)
        elseif bonus == 7 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Wicked Sick streak"
            call BroadcastMessage(msg)
        elseif bonus == 6 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Unstoppable streak"
            call BroadcastMessage(msg)
        elseif bonus == 5 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Mega Kill streak"
            call BroadcastMessage(msg)
        elseif bonus == 4 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Dominating streak"
            call BroadcastMessage(msg)
        elseif bonus == 3 then
            set msg = udg_PN[GetPlayerId(winner)] + " has just ended " + udg_PN[GetPlayerId(loser)] + " Killing Spree"
            call BroadcastMessage(msg)
        else
            set msg = udg_PN[GetPlayerId(winner)] + " has defeated " + udg_PN[GetPlayerId(loser)]
            call BroadcastMessage(msg)
        endif
        if udg_FlagFirst then
            set udg_FlagFirst = false
            set msg = "|cffffcc00Additional 150 points have been rewarded for the first overthrow!|r"
            call BroadcastMessage(msg)
            set giveGold = giveGold + 150
        endif
        call CE_Bonus(killer, dead, giveGold, 0)
        set udg_FlagPerfect[j] = udg_FlagPerfect[j] + 1
        if udg_FlagPerfect[j] >= 12 then
            set msg = udg_PN[GetPlayerId(winner)] + " commits a GENOCIDE!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 11 then
            set msg = udg_PN[GetPlayerId(winner)] + " is on an OWNAGE streak!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 10 then
            set msg = udg_PN[GetPlayerId(winner)] + " is BEYOND GODLIKE!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 9 then
            set msg = udg_PN[GetPlayerId(winner)] + " is GODLIKE!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 8 then
            set msg = udg_PN[GetPlayerId(winner)] + " is on a Monster Kill streak!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 7 then
            set msg = udg_PN[GetPlayerId(winner)] + " is Wicked Sick!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 6 then
            set msg = udg_PN[GetPlayerId(winner)] + " is Unstoppable!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 5 then
            set msg = udg_PN[GetPlayerId(winner)] + " is on a Mega Kill streak!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 4 then
            set msg = udg_PN[GetPlayerId(winner)] + " is Dominating!"
            call BroadcastMessage(msg)
        elseif udg_FlagPerfect[j] == 3 then
            set msg = udg_PN[GetPlayerId(winner)] + " is on a Killing Spree!"
            call BroadcastMessage(msg)
        endif
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return true
    endif
    if TK then
        set msg = udg_PN[GetPlayerId(winner)] + "'s hand has slipped and killed " + udg_PN[GetPlayerId(loser)]
        call BroadcastMessage(msg)
        set udg_FlagUnusualDeath[i] = udg_FlagUnusualDeath[i] + 1
        set msg = "No rewards..."
        call BroadcastMessage(msg)
        set winner = null
        set loser = null
        set team = null
        set msg = null
        return false
    endif
    set msg = udg_PN[GetPlayerId(loser)] + " has been taken by a UFO"
    call BroadcastMessage(msg)
    set winner = null
    set loser = null
    set team = null
    set msg = null
    return false
endfunction

function InitTrig_Announce_Bonus takes nothing returns nothing
endfunction