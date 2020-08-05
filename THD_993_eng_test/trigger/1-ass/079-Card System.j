function CardStatShow takes nothing returns nothing
    local integer i = 0
    local integer cardid
    local player p
    loop
    exitwhen i >= 10
        set p = GetSortedPlayer(i)
        if udg_CardState[GetPlayerId(p)] != 0 then
            set cardid = udg_CardState[GetPlayerId(p)]
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 4.0, "|cff" + LoadStr(udg_Hashtable_Data, StringHash("CardColors"), cardid) + GetAbilityName(cardid) + "|r - " + udg_PN[GetPlayerId(p)])
        else
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 4.0, "no card - " + udg_PN[GetPlayerId(p)])
        endif
        set i = i + 1
    endloop
    set p = null
endfunction

function SetCardAbility takes unit u, integer id, boolean avail returns nothing
    local integer i = GetPlayerId(GetOwningPlayer(u))
    if GetUnitAbilityLevel(u, id) == 0 then
        call UnitAddAbility(u, id)
        call UnitMakeAbilityPermanent(u, true, id)
    endif
    if avail then
        set udg_CardState[i] = id
    else
        set udg_CardState[i] = 0
    endif
    call SetPlayerAbilityAvailable(GetOwningPlayer(u), id, avail)
endfunction

function GetCardAbility takes integer unitid returns integer
    return LoadInteger(udg_Hashtable_Data, unitid, StringHash("Id_U2A"))
endfunction

function RegCardAbility takes integer unitid, integer abilid returns nothing
    call SaveInteger(udg_Hashtable_Data, unitid, StringHash("Id_U2A"), abilid)
endfunction

function AddCardAbilityPlayer takes player p, integer abilid returns nothing
    local unit hero = GetPlayerCharacter(p)
    local integer i = GetPlayerId(p)
    call DebugMsg("Card Ability Type ID = " + I2S(abilid))
    if udg_CardState[i] != 0 then
        call SetCardAbility(hero, udg_CardState[i], false)
        call THD_AddCredit(p, 52)
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0, 0, "Refunded 52 points for unused card")
    endif
    call SetCardAbility(hero, abilid, true)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(p)] + " equipped |cff" + LoadStr(udg_Hashtable_Data, StringHash("CardColors"), abilid) + GetObjectName(abilid) + "|r", p)
    set hero = null
endfunction

function CardStartAction takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local player p = LoadPlayerHandle(udg_ht, GetHandleId(t), 0)
    if GetLocalPlayer() == p then
        call ForceUIKey("Q")
    endif
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set p = null
endfunction

function ReturnTrueCampAbility takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer dummyid = LoadInteger(udg_ht, task, 0)
    local integer trueid = LoadInteger(udg_ht, task, 1)
    local integer pid = LoadInteger(udg_ht, task, 2)
    local integer i
    local integer max
    if pid < 5 then
        set i = 0
        set max = 5
    else
        set i = 5
        set max = 10
    endif
    loop
        call UnitRemoveAbility(udg_PlayerReviveHouse[i], dummyid)
        call UnitAddAbility(udg_PlayerReviveHouse[i], trueid)
        set i = i + 1
    exitwhen i > max
    endloop
    call FlushChildHashtable(udg_ht, task)
    call ReleaseTimer(t)
    set t = null
endfunction

function Trig_Card_System_Actions takes nothing returns boolean
    local integer cardid = GetSpellAbilityId()
    local integer abilid = LoadInteger(udg_Hashtable_Data, cardid, StringHash("Id_U2A"))
    local integer orderid = LoadInteger(udg_Hashtable_Data, StringHash("CardOrders"), cardid)
    local integer dummyid = LoadInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), cardid)
    local integer pid = GetPlayerId(GetTriggerPlayer())
    local integer i
    local integer max
    local timer t
    if abilid != 0 then
        if pid < 5 then
            set i = 0
            set max = 5
        else
            set i = 5
            set max = 10
        endif
        loop
            call UnitRemoveAbility(udg_PlayerReviveHouse[i], cardid)
            call UnitAddAbility(udg_PlayerReviveHouse[i], dummyid)
            call IssueImmediateOrderById(udg_PlayerReviveHouse[i], orderid)
            set i = i + 1
        exitwhen i > max
        endloop
        set t = CreateTimer()
        call SaveInteger(udg_ht, GetHandleId(t), 0, dummyid)
        call SaveInteger(udg_ht, GetHandleId(t), 1, cardid)
        call SaveInteger(udg_ht, GetHandleId(t), 2, pid)
        call TimerStart(t, 240.0 - 0.05, false, function ReturnTrueCampAbility)
        call AddCardAbilityPlayer(GetTriggerPlayer(), abilid)
        if GetLocalPlayer() == GetTriggerPlayer() and not IsUnitDead(udg_PlayerHeroes[pid]) then
            call SelectUnit(udg_PlayerReviveHouse[pid], false)
            call SelectUnit(udg_PlayerHeroes[pid], true)
        endif
        //if not IsUnitDead(udg_PlayerHeroes[pid]) then
        //    set t = CreateTimer()
        //    call SavePlayerHandle(udg_ht, GetHandleId(t), 0, GetTriggerPlayer())
        //    call TimerStart(t, 0.05, false, function CardStartAction)
        //endif
    endif
    set t = null
    return false
endfunction

function InitTrig_Card_System takes nothing returns nothing
    call SaveInteger(udg_Hashtable_Data, 'A01Y', StringHash("Id_U2A"), 'A1FU')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1FU', "cfcf00")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A01Y', OrderId("channel"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A01Y', 'A01F')
    call SaveInteger(udg_Hashtable_Data, 'A020', StringHash("Id_U2A"), 'A1FV')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1FV', "008fcb")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A020', OrderId("charm"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A020', 'A025')
    call SaveInteger(udg_Hashtable_Data, 'A01P', StringHash("Id_U2A"), 'A1FZ')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1FZ', "339a02")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A01P', OrderId("chemicalrage"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A01P', 'A024')
    call SaveInteger(udg_Hashtable_Data, 'A01W', StringHash("Id_U2A"), 'A1G0')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1G0', "1f1f1f")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A01W', OrderId("cloudoffog"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A01W', 'A01I')
    call SaveInteger(udg_Hashtable_Data, 'A022', StringHash("Id_U2A"), 'A1FX')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1FX', "fc96f8")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A022', OrderId("clusterrockets"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A022', 'A01M')
    call SaveInteger(udg_Hashtable_Data, 'A01V', StringHash("Id_U2A"), 'A1FY')
    call SaveStr(udg_Hashtable_Data, StringHash("CardColors"), 'A1FY', "646464")
    call SaveInteger(udg_Hashtable_Data, StringHash("CardOrders"), 'A01V', OrderId("coldarrows"))
    call SaveInteger(udg_Hashtable_Data, StringHash("CardCooldownDummies"), 'A01V', 'A027')
    set gg_trg_Card_System = CreateTrigger()
    call TriggerRegisterAnyUnitEventFix(gg_trg_Card_System, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Card_System, Condition(function Trig_Card_System_Actions))
endfunction