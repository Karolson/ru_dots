function Trig_Defence_God_Conditions takes nothing returns boolean
    local unit u = GetSoldUnit()
    local boolean t = GetUnitTypeId(u) == 'n02M'
    set u = null
    return t
endfunction

function Trig_Defence_God_Actions takes nothing returns nothing
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
        call DisplayTextToPlayer(PLY, 0, 0, "Insufficient faith! 15 faith is needed to cast God's Wrath")
        call AddUnitToStock(caster, 'n02M', 1, 1)
        set caster = null
        set u = null
        set PLY = null
        set h = null
        set e = null
        return
    endif
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessageFriend(udg_PN[GetPlayerId(PLY)] + " casts God's Wrath!", PLY)
    call DisableTrigger(gg_trg_Weather_Fog_System)
    call Thunderstrike_CineFilterSS_Start()
    call StartSound(gg_snd_RollingThunder1)
    call RemoveUnitFromStockBJ('n02M', udg_BaseB[0])
    call AddUnitToStockBJ('n02M', udg_BaseB[0], 0, 1)
    call RemoveUnitFromStockBJ('n02M', gg_unit_H01Q_0120)
    call AddUnitToStockBJ('n02M', gg_unit_H01Q_0120, 0, 1)
    call RemoveUnitFromStockBJ('n02M', gg_unit_H01Q_0121)
    call AddUnitToStockBJ('n02M', gg_unit_H01Q_0121, 0, 1)
    call RemoveUnitFromStockBJ('n02M', gg_unit_H01Q_0122)
    call AddUnitToStockBJ('n02M', gg_unit_H01Q_0122, 0, 1)
    call RemoveUnitFromStockBJ('n02M', gg_unit_H01Q_0123)
    call AddUnitToStockBJ('n02M', gg_unit_H01Q_0123, 0, 1)
    call RemoveUnitFromStockBJ('n02M', gg_unit_H01Q_0124)
    call AddUnitToStockBJ('n02M', gg_unit_H01Q_0124, 0, 1)
    call TriggerSleepAction(2)
    set i = 0
    loop
        set h = udg_PlayerHeroes[i]
        if h != null and IsUnitEnemy(h, PLY) and not IsUnitCCImmune(h) and not IsUnitInvulnerable(h) then
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

function InitTrig_Defence_God takes nothing returns nothing
    set gg_trg_Defence_God = CreateTrigger()
    call TriggerAddCondition(gg_trg_Defence_God, Condition(function Trig_Defence_God_Conditions))
    call TriggerAddAction(gg_trg_Defence_God, function Trig_Defence_God_Actions)
endfunction