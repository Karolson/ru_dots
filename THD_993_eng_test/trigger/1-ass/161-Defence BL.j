function Trig_Defence_BL_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A01C' or GetSpellAbilityId() == 'A01D' then
        return true
    endif
    return false
endfunction

function Thunderstrike_CineFilterBL_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer switch = LoadInteger(udg_ht, task, 0)
    if switch == 0 then
        call SaveInteger(udg_ht, task, 0, 1)
        call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
        call SetCineFilterBlendMode(BLEND_MODE_BLEND)
        call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
        call SetCineFilterStartUV(0, 0, 1, 1)
        call SetCineFilterEndUV(0, 0, 1, 1)
        call SetCineFilterStartColor(255, 255, 0, 240)
        call SetCineFilterEndColor(255, 255, 0, 0)
        call SetCineFilterDuration(1.2)
        call DisplayCineFilter(true)
        call TimerStart(t, 1.5, false, function Thunderstrike_CineFilterBL_Clear)
    else
        call FlushChildHashtable(udg_ht, task)
        call FogEnable(true)
        call FogMaskEnable(true)
        call DisplayCineFilter(false)
        call ReleaseTimer(t)
    endif
    set t = null
endfunction

function Thunderstrike_CineFilterBL_Start takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer switch = 0
    call SaveInteger(udg_ht, task, 0, switch)
    call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
    call SetCineFilterBlendMode(BLEND_MODE_BLEND)
    call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
    call SetCineFilterStartUV(0, 0, 1, 1)
    call SetCineFilterEndUV(0, 0, 1, 1)
    call SetCineFilterStartColor(255, 255, 0, 0)
    call SetCineFilterEndColor(255, 255, 0, 240)
    call SetCineFilterDuration(0.2)
    call DisplayCineFilter(true)
    call TimerStart(t, 0.4, false, function Thunderstrike_CineFilterBL_Clear)
    set t = null
endfunction

function Thunderstrike_CineFilterSS_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer switch = LoadInteger(udg_ht, task, 0)
    if switch == 0 then
        call SaveInteger(udg_ht, task, 0, 1)
        call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
        call SetCineFilterBlendMode(BLEND_MODE_BLEND)
        call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
        call SetCineFilterStartUV(0, 0, 1, 1)
        call SetCineFilterEndUV(0, 0, 1, 1)
        call SetCineFilterStartColor(0, 140, 255, 240)
        call SetCineFilterEndColor(0, 140, 255, 0)
        call SetCineFilterDuration(1.2)
        call DisplayCineFilter(true)
        call TimerStart(t, 1.5, false, function Thunderstrike_CineFilterBL_Clear)
    else
        call FlushChildHashtable(udg_ht, task)
        call FogEnable(true)
        call FogMaskEnable(true)
        call DisplayCineFilter(false)
        call ReleaseTimer(t)
    endif
    set t = null
endfunction

function Thunderstrike_CineFilterSS_Start takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer switch = 0
    call SaveInteger(udg_ht, task, 0, switch)
    call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
    call SetCineFilterBlendMode(BLEND_MODE_BLEND)
    call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
    call SetCineFilterStartUV(0, 0, 1, 1)
    call SetCineFilterEndUV(0, 0, 1, 1)
    call SetCineFilterStartColor(0, 140, 255, 0)
    call SetCineFilterEndColor(0, 140, 255, 240)
    call SetCineFilterDuration(0.2)
    call DisplayCineFilter(true)
    call TimerStart(t, 0.4, false, function Thunderstrike_CineFilterBL_Clear)
    set t = null
endfunction

function ThunderStrike_Stun takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(udg_Hashtable, GetHandleId(t), 0)
    local unit h
    local integer i
    local integer max
    if GetPlayerId(GetOwningPlayer(caster)) < 5 then
        set i = 5
        set max = 10
    else
        set i = 0
        set max = 5
    endif
    loop
        set h = udg_PlayerHeroes[i]
        if h != null and not IsUnitCCImmune(h) and not IsUnitInvulnerable(h) then
            call UnitStunTarget(caster, h, 1.0, 0, 0)
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", GetUnitX(h), GetUnitY(h)))
        endif
        set i = i + 1
    exitwhen i > max
    endloop
    call FlushChildHashtable(udg_Hashtable, GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set caster = null
    set h = null
endfunction

function Trig_Defence_BL_Actions takes nothing returns nothing
    local integer cost = 15
    local unit caster = GetTriggerUnit()
    local player PLY = GetTriggerPlayer()
    local integer pid = GetPlayerId(PLY)
    local integer i
    local integer max
    local timer t
    local integer dummyid
    local integer trueid
    call THD_AddSpirit(PLY, -cost)
    call SetPlayerState(PLY, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(PLY, PLAYER_STATE_RESOURCE_LUMBER) + cost)
    call DisableTrigger(gg_trg_Weather_Fog_System)
    call StartSound(gg_snd_RollingThunder1)
    if pid < 5 then
        set i = 0
        set max = 5
        set dummyid = 'A02O'
        set trueid = 'A01C'
        call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " casts Hakurei Binding Enchantment!", PLY)
        call Thunderstrike_CineFilterBL_Start()
    else
        set i = 5
        set max = 10
        set dummyid = 'A02J'
        set trueid = 'A01D'
        call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " casts God's Wrath!", PLY)
        call Thunderstrike_CineFilterSS_Start()
    endif
    loop
        call UnitRemoveAbility(udg_PlayerReviveHouse[i], trueid)
        call UnitAddAbility(udg_PlayerReviveHouse[i], dummyid)
        call IssueImmediateOrder(udg_PlayerReviveHouse[i], "coupleinstant")
        set i = i + 1
    exitwhen i > max
    endloop
    set t = CreateTimer()
    call SaveInteger(udg_ht, GetHandleId(t), 0, dummyid)
    call SaveInteger(udg_ht, GetHandleId(t), 1, trueid)
    call SaveInteger(udg_ht, GetHandleId(t), 2, pid)
    call TimerStart(t, 300.0 - 0.05, false, function ReturnTrueCampAbility)
    set t = CreateTimer()
    call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 0, caster)
    call TimerStart(t, 2.0, false, function ThunderStrike_Stun)
    set caster = null
    set PLY = null
    set t = null
endfunction

function InitTrig_Defence_BL takes nothing returns nothing
    set gg_trg_Defence_BL = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_BL, Condition(function Trig_Defence_BL_Conditions))
    call TriggerAddAction(gg_trg_Defence_BL, function Trig_Defence_BL_Actions)
endfunction