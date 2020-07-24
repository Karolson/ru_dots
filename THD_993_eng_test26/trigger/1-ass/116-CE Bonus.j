function CE_ItemEffect_Add takes unit u returns nothing
    local integer i2
    local integer i3
    if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I07Z') > 0 then
        set i3 = GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I07Z'))
        if i3 < 15 * 4 then
            call UnitAddBonusDmg(u, 4)
            call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I07Z'), i3 + 4)
        endif
    endif
    if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I073') > 0 then
        set i2 = GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I073'))
        if i2 < 15 * 3 then
            call UnitAddBonusInt(u, 3)
            call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I073'), i2 + 3)
            if LoadInteger(udg_HeroDatabase, GetUnitTypeId(u), 'PRIM') == 3 then
                call UnitAddBonusDmg(u, -3)
            endif
        endif
    endif
endfunction

function CE_ItemEffect_Reduce takes unit u returns nothing
    local integer i2
    local integer i3
    local integer reduce
    if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I07Z') > 0 then
        set i3 = GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I07Z'))
        set reduce = R2I(i3 * 0.4)
        call UnitAddBonusDmg(u, -reduce)
        call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I07Z'), i3 - reduce)
    endif
    if YDWEGetInventoryIndexOfItemTypeBJNull(u, 'I073') > 0 then
        set i2 = GetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I073'))
        set reduce = R2I(i2 * 0.4)
        call UnitAddBonusInt(u, -reduce)
        call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(u, 'I073'), i2 - reduce)
        if LoadInteger(udg_HeroDatabase, GetUnitTypeId(u), 'PRIM') == 3 then
            call UnitAddBonusDmg(u, reduce)
        endif
    endif
endfunction

function CE_Bonus takes unit h, unit v, real total, real extra returns nothing
    local player A = GetOwningPlayer(h)
    local player B = GetOwningPlayer(v)
    local player w
    local integer i
    local integer j
    local integer pid
    local unit u
    local integer offset = GetPlayerId(B) * 16
    local real p
    local real s
    local integer d
    local string msg = ""
    local string msgpart = ""
    local integer msgassist = 0
    local real kill
    local real death
    local real assist
    local real undeath
    local real tarkill
    local real tardeath
    local real tarassist
    local real tarundeath
    local real bonusper
    local sound snd = null
    if udg_GameMode / 100 == 3 or udg_NewMid then
        set total = total * 0.75
        set extra = extra * 0.75
    endif
    set s = 0.0
    set i = 0
    loop
    exitwhen i >= 16
        set w = Player(i)
        if GetPlayerCharacter(w) != null and IsPlayerOpponent(w, B) then
            set p = udg_CE_Response[offset + i]
            set udg_CE_Response[offset + i] = 0.0
            set s = s + p
            set udg_CE_register[i] = p
        else
            set udg_CE_register[i] = 0.0
        endif
        set i = i + 1
    endloop
    set i = 0
    set u = GetPlayerCharacter(A)
    set pid = GetPlayerId(B)
    set j = GetUnitAbilityLevel(u, 'A0PF')
    if j > 0 then
        loop
        exitwhen i > 11
            if udg_CE_register[i] > 0 then
                set udg_HeroRevivePenalty[pid] = udg_HeroRevivePenalty[pid] + j + 1.0
            endif
            set i = i + 1
        endloop
    endif
    set tarkill = udg_FlagKill[pid]
    set tardeath = udg_FlagDeath[pid]
    set tarassist = udg_FlagAssist[pid]
    set tarundeath = udg_FlagUnusualDeath[pid]
    set i = 0
    loop
    exitwhen i >= 16
        set w = Player(i)
        set u = GetPlayerCharacter(w)
        if s > 0.0 then
            set p = total * (udg_CE_register[i] / s)
        else
            set p = 0.0
        endif
        if w == A then
            set d = R2I(p + extra)
            if d > 0 then
                set d = d + 200
                set kill = udg_FlagKill[i]
                set death = udg_FlagDeath[i]
                set assist = udg_FlagAssist[i]
                set undeath = udg_FlagUnusualDeath[i]
                set bonusper = 0.5 * (1 - (1 + kill * 0.08 + assist * 0.04) / (1 + death * 0.08 - undeath * 0.08)) + (1 + tarkill * 0.08 + tarassist * 0.04) / (1 + tardeath * 0.08 - tarundeath * 0.08)
                if bonusper > 1.0 then
                    if bonusper > 2.0 then
                        set bonusper = 2.0
                    endif
                    set d = R2I(d * (1 + (bonusper - 1) * 0.25))
                else
                    if bonusper < 0.15 then
                        set bonusper = 0.15
                    endif
                    set d = R2I(d * (1 - (1 - bonusper) * (1 - bonusper) * (1 - bonusper)))
                endif
                set msg = udg_PN[GetPlayerId(w)] + "|cffff3333Kill reward: |r|cffffcc00" + I2S(d) + "|r"
            endif
            call THD_AddCredit(w, d - 100)
            if GetUnitAbilityLevel(u, 'A1GO') != 0 then
                call UnitRemoveAbility(u, 'A1GO')
                call UnitAddAbility(u, 'A00I')
            elseif GetUnitAbilityLevel(u, 'A0T4') >= 1 then
                call THD_AddCredit(w, udg_SK_ReimuEx_Record_KillGold)
            endif
            if GetUnitAbilityLevel(u, 'A1HG') != 0 then
                call Trig_MoonMan(u)
                call UnitAddAbility(u, 'A1I8')
            endif
            if YDWEGetInventoryIndexOfItemTypeBJNull(v, 'I075') > 0 then
                call UnitMagicDamageTarget(v, u, 200 + GetHeroLevel(v) * 40, 4)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX(u), GetUnitY(u)))
            endif
            call CE_ItemEffect_Add(u)
        else
            set udg_CE_register[i] = p
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
    exitwhen i >= 16
        set w = Player(i)
        set u = GetPlayerCharacter(w)
        set d = R2I(udg_CE_register[i])
        if d > 0 and w != A then
            set msgassist = msgassist + 1
            set udg_FlagAssist[i] = udg_FlagAssist[i] + 1
            call GIB_SetPlayerField(w, 4, I2S(udg_FlagAssist[i]))
            set d = d + 100
            set kill = udg_FlagKill[i]
            set death = udg_FlagDeath[i]
            set assist = udg_FlagAssist[i]
            set undeath = udg_FlagUnusualDeath[i]
            set bonusper = 0.5 * (1 - (1 + kill * 0.08 + assist * 0.04) / (1 + death * 0.08 - undeath * 0.08)) + (1 + tarkill * 0.08 + tarassist * 0.04) / (1 + tardeath * 0.08 - tarundeath * 0.08)
            if bonusper > 1.0 then
                if bonusper > 2.0 then
                    set bonusper = 2.0
                endif
                set d = R2I(d * (1 + (bonusper - 1) * 0.25))
            else
                if bonusper < 0.15 then
                    set bonusper = 0.15
                endif
                set d = R2I(d * (1 - (1 - bonusper) * (1 - bonusper) * (1 - bonusper)))
            endif
            set msgpart = msgpart + " " + udg_PN[GetPlayerId(w)] + "|cff33ff33Kill assist reward |r|cffffcc00" + I2S(d) + "|r"
            call THD_AddCredit(w, d)
            if GetUnitAbilityLevel(u, 'A1GO') != 0 then
                call UnitRemoveAbility(u, 'A1GO')
                call UnitAddAbility(u, 'A00I')
            elseif GetUnitTypeId(u) == 'H001' then
                call THD_AddCredit(w, 80)
            endif
            if GetUnitAbilityLevel(u, 'A1HG') != 0 then
                call Trig_MoonMan(u)
                call UnitAddAbility(u, 'A1I8')
            endif
            if YDWEGetInventoryIndexOfItemTypeBJNull(v, 'I075') > 0 then
                call UnitMagicDamageTarget(v, u, 100 + GetHeroLevel(v) * 20, 4)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX(u), GetUnitY(u)))
            endif
            call CE_ItemEffect_Add(u)
            if w == udg_SK_nue_rscd_player and udg_SK_nue_rscd_player != null then
                call NueResetCD(GetPlayerCharacter(w), v)
            endif
        endif
        set udg_CE_register[i] = 0.0
        set i = i + 1
    endloop
    if msgassist == 0 then
        set msg = msg
    elseif msgassist == 1 then
        set msg = msg + msgpart
    elseif msgassist > 1 then
        set msg = msg + " |cff33ff33Joint kill, each girl gets the assist reward|r"
    endif
    set snd = CreateSound("THDots\\music\\"+udg_PlayerCharacterString[GetPlayerId(GetOwningPlayer(v))]+"Death0.0mp3",false,false,true,12700,12700,"DefaultEAXON")
    if snd != null then
        call SetSoundVolume(snd, 127)
        call StartSoundForPlayerBJ(GetOwningPlayer(v), snd)
        call KillSoundWhenDone(snd)
        set snd = null
    endif
    if msg != "" then
        call BroadcastMessage(msg)
    endif
    call CE_ItemEffect_Reduce(v)
    set h = null
    set v = null
    set A = null
    set B = null
    set w = null
    set msg = ""
    set msgpart = ""
    set u = null
endfunction

function InitTrig_CE_Bonus takes nothing returns nothing
endfunction