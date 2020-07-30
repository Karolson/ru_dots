function Trig_Nazrin04NewDeath_Conditions takes nothing returns boolean
    return GetTriggerUnit() == udg_SK_Nazrin04New_Target
endfunction

function Trig_Nazrin04NewDeath_Actions takes nothing returns nothing
    local integer i = 0
    local unit v
    loop
    exitwhen i >= 16
        set v = udg_PlayerHeroes[i]
        if IsUnitAlly(udg_SK_Nazrin04New_Target, GetOwningPlayer(v)) == false and udg_SK_Nazrin04New_Attacked[GetConvertedPlayerId(GetOwningPlayer(v))] == 1 then
            call SetPlayerStateBJ(GetOwningPlayer(v), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(v), PLAYER_STATE_RESOURCE_GOLD) + 50)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(v), GetUnitY(v)))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(v) + 100, GetUnitY(v) + 100))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(v) + 100, GetUnitY(v) - 100))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(v) - 100, GetUnitY(v) - 100))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl", GetUnitX(v) - 100, GetUnitY(v) + 100))
        endif
        set i = i + 1
    endloop
    set udg_SK_Nazrin04New_Target = null
    set v = null
endfunction

function InitTrig_Nazrin04NewDeath takes nothing returns nothing
endfunction