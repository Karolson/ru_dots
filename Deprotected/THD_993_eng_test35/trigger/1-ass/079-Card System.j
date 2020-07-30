function Key_Id_U2A takes nothing returns integer
    return StringHash("Id_U2A")
endfunction

function CardStatShow takes nothing returns nothing
    local integer i = 0
    local integer cardid
    local player p
    loop
    exitwhen i >= 10
        set p = GetSortedPlayer(i)
        if udg_CardState[GetPlayerId(p)] != 0 then
            set cardid = udg_CardState[GetPlayerId(p)]
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 4.0, GetAbilityName(cardid) + " - " + udg_PN[GetPlayerId(p)])
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
    endif
    call SetCardAbility(hero, abilid, true)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(p)] + " equipped |cffffcc00" + GetObjectName(abilid) + "|r", p)
    set hero = null
endfunction

function AddCardAbility takes unit u, integer abilid returns nothing
    call AddCardAbilityPlayer(GetOwningPlayer(u), abilid)
endfunction

function Trig_Card_System_Actions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local integer abilid = LoadInteger(udg_Hashtable_Data, GetUnitTypeId(u), StringHash("Id_U2A"))
    if abilid != 0 then
        call AddCardAbility(u, abilid)
        call KillUnit(u)
    endif
    set u = null
    return false
endfunction

function InitTrig_Card_System takes nothing returns nothing
    call SaveInteger(udg_Hashtable_Data, 'u01E', StringHash("Id_U2A"), 'A1FU')
    call SaveInteger(udg_Hashtable_Data, 'u016', StringHash("Id_U2A"), 'A1FV')
    call SaveInteger(udg_Hashtable_Data, 'u015', StringHash("Id_U2A"), 'A1FX')
    call SaveInteger(udg_Hashtable_Data, 'u014', StringHash("Id_U2A"), 'A1FY')
    call SaveInteger(udg_Hashtable_Data, 'u01F', StringHash("Id_U2A"), 'A1FZ')
    call SaveInteger(udg_Hashtable_Data, 'u018', StringHash("Id_U2A"), 'A1G0')
    set gg_trg_Card_System = CreateTrigger()
    call TriggerRegisterAnyUnitEventFix(gg_trg_Card_System, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Card_System, Condition(function Trig_Card_System_Actions))
endfunction