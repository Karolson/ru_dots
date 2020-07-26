function Trig_Defence_BL_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local boolean t = GetUnitTypeId(u) == 'n03X'
    set u = null
    return t
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

function Trig_Defence_BL_Actions takes nothing returns nothing
    local integer cost = 15
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local player PLY = GetOwningPlayer(u)
    local integer i
    local unit h
    local effect e
    if udg_GameMode / 100 == 3 then
        set cost = 0
    endif
    call RemoveUnit(u)
    if THD_GetSpirit(PLY) < cost then
        call DisplayTextToPlayer(PLY, 0, 0, "Insufficient faith! 15 faith is needed to cast Hakurei Binding Enchantment")
        call AddUnitToStock(caster, 'n03X', 1, 1)
        set caster = null
        set u = null
        set PLY = null
        set h = null
        set e = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " casts Hakurei Binding Enchantment!", PLY)
    call DisableTrigger(gg_trg_Weather_Fog_System)
    call Thunderstrike_CineFilterBL_Start()
    call StartSound(gg_snd_RollingThunder1)
    call RemoveUnitFromStockBJ('n03X', udg_BaseA[0])
    call AddUnitToStockBJ('n03X', udg_BaseA[0], 0, 1)
    call RemoveUnitFromStockBJ('n03X', gg_unit_h01Q_0033)
    call AddUnitToStockBJ('n03X', gg_unit_h01Q_0033, 0, 1)
    call RemoveUnitFromStockBJ('n03X', gg_unit_h01Q_0048)
    call AddUnitToStockBJ('n03X', gg_unit_h01Q_0048, 0, 1)
    call RemoveUnitFromStockBJ('n03X', gg_unit_h01Q_0059)
    call AddUnitToStockBJ('n03X', gg_unit_h01Q_0059, 0, 1)
    call RemoveUnitFromStockBJ('n03X', gg_unit_h01Q_0118)
    call AddUnitToStockBJ('n03X', gg_unit_h01Q_0118, 0, 1)
    call RemoveUnitFromStockBJ('n03X', gg_unit_h01Q_0119)
    call AddUnitToStockBJ('n03X', gg_unit_h01Q_0119, 0, 1)
    call TriggerSleepAction(2)
    set i = 0
    loop
        set h = udg_PlayerHeroes[i]
        if h != null and IsUnitEnemy(h, PLY) and GetUnitAbilityLevel(h, 'B097') == 0 and GetUnitAbilityLevel(h, 'A0AN') == 0 and GetUnitCurrentOrder(h) != OrderId("metamorphosis") and IsUnitInvulnerable(h) == false then
            call UnitStunTarget(u, h, 1.0, 0, 0)
            set e = AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", GetUnitX(h), GetUnitY(h))
            call DestroyEffect(e)
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
    set caster = null
    set u = null
    set PLY = null
    set h = null
    set e = null
endfunction

function InitTrig_Defence_BL takes nothing returns nothing
    set gg_trg_Defence_BL = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_BL, Condition(function Trig_Defence_BL_Conditions))
    call TriggerAddAction(gg_trg_Defence_BL, function Trig_Defence_BL_Actions)
endfunction