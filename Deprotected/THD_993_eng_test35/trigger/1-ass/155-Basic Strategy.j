function Trig_Basic_Strategy_Conditions takes nothing returns boolean
    local integer cost = 45
    local unit caster = GetSellingUnit()
    local unit u = GetSoldUnit()
    local unit tower = GetTriggerUnit()
    local player PLY = GetOwningPlayer(u)
    local string str01
    local integer i
    local unit v
    local unit w
    if GetUnitTypeId(u) == 'n05L' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Nether Key 'Fazioli's Meditation'"
        set i = 0
        loop
        exitwhen i >= 12
            if IsUnitAlly(udg_PlayerHeroes[i], PLY) then
                call UnitHealingTarget(udg_PlayerHeroes[i], udg_PlayerHeroes[i], 150 + GetHeroLevel(udg_PlayerHeroes[i]))
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(udg_PlayerHeroes[i]), GetUnitY(udg_PlayerHeroes[i])))
            endif
            set i = i + 1
        endloop
    elseif GetUnitTypeId(u) == 'n05M' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Drowning 'Sparkling underwater heartbreak'"
        set i = 0
        loop
        exitwhen i >= 15
            if IsUnitAlly(caster, udg_PlayerA[0]) then
                set v = udg_BaseA[i]
            else
                set v = udg_BaseB[i]
            endif
            if v != null then
                set w = CreateUnit(PLY, 'e03H', GetUnitX(v), GetUnitY(v), 0.0)
                call SetUnitPathing(w, false)
                call SetUnitX(w, GetUnitX(v))
                call SetUnitY(w, GetUnitY(v))
                call UnitBuffTarget(v, v, 8.0, 'A0Z9', 0)
                call UnitApplyTimedLife(w, 'B07E', 8.0)
            endif
            set i = i + 1
        endloop
        set v = null
        set w = null
    elseif GetUnitTypeId(u) == 'n05N' then
        if THD_GetSpirit(PLY) < cost then
            call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "Insufficient faith! Need " + I2S(cost) + " faith to launch")
            call RemoveUnit(u)
            call AddUnitToStock(caster, GetUnitTypeId(u), 1, 1)
            set u = null
            set v = null
            return false
        endif
        set str01 = "Rune 'God's Footsteps'"
        set i = 0
        loop
        exitwhen i >= 12
            if IsUnitAlly(udg_PlayerHeroes[i], PLY) then
                call UnitBuffTarget(udg_PlayerHeroes[i], udg_PlayerHeroes[i], 8.0, 'A1E1', 0)
            endif
            set i = i + 1
        endloop
    else
        set caster = null
        set u = null
        set tower = null
        set PLY = null
        return false
    endif
    call RemoveUnit(u)
    call THD_AddSpirit(GetOwningPlayer(GetSellingUnit()), -cost)
    call BroadcastMessage(udg_PN[GetPlayerId(PLY)] + " has used |cff8000ff" + str01 + "|r!")
    set caster = null
    set u = null
    set tower = null
    set PLY = null
    return false
endfunction

function Trig_Basic_Strategy_Actions takes nothing returns nothing
endfunction

function InitTrig_Basic_Strategy takes nothing returns nothing
    set gg_trg_Basic_Strategy = CreateTrigger()
    call TriggerAddCondition(gg_trg_Basic_Strategy, Condition(function Trig_Basic_Strategy_Conditions))
endfunction