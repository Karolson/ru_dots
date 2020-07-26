function Trig_Power_Main_Conditions takes nothing returns boolean
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == false then
        return false
    endif
    return GetItemTypeId(GetManipulatedItem()) == 'I03H' or GetItemTypeId(GetManipulatedItem()) == 'I08K' or GetItemTypeId(GetManipulatedItem()) == 'I06P'
endfunction

function Trig_Power_Main_Actions takes nothing returns nothing
    local unit h = GetPlayerCharacter(GetOwningPlayer(GetTriggerUnit()))
    local player who = GetOwningPlayer(h)
    local integer i = GetPlayerId(who) + 1
    local integer c = LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'PRIM')
    local integer d = udg_PlayerPower[i]
    if GetItemTypeId(GetManipulatedItem()) == 'I08K' or GetItemTypeId(GetManipulatedItem()) == 'I06P' then
        if GetItemTypeId(GetManipulatedItem()) == 'I06P' then
            call UnitBuffTarget(h, h, 240, 'A192', 0)
            call UnitMakeAbilityPermanent(h, true, 'A192')
            call UnitMakeAbilityPermanent(h, true, 'A11V')
        else
            call UnitBuffTarget(h, h, 240, 'A0AW', 0)
            call UnitMakeAbilityPermanent(h, true, 'A0AW')
        endif
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", h, "origin"))
    else
        call RemoveItem(GetManipulatedItem())
        if d < 30 then
            set udg_PlayerPower[i] = d + 1
            if c == 1 then
                call SetHeroStr(h, GetHeroStr(h, false) + 1, true)
            elseif c == 2 then
                call SetHeroAgi(h, GetHeroAgi(h, false) + 1, true)
            elseif c == 3 then
                call SetHeroInt(h, GetHeroInt(h, false) + 1, true)
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", h, "origin"))
        else
        endif
        if udg_PlayerPower[i] < 30 and GetUnitAbilityLevel(h, 'A0PP') != 0 and GetRandomInt(0, 100) < 15 then
            set udg_PlayerPower[i] = d + 1
            if c == 1 then
                call SetHeroStr(h, GetHeroStr(h, false) + 1, true)
            elseif c == 2 then
                call SetHeroAgi(h, GetHeroAgi(h, false) + 1, true)
            elseif c == 3 then
                call SetHeroInt(h, GetHeroInt(h, false) + 1, true)
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", h, "origin"))
        else
        endif
    endif
    set h = null
    set who = null
endfunction

function InitTrig_Power_Get takes nothing returns nothing
    set gg_trg_Power_Get = CreateTrigger()
    call TriggerAddCondition(gg_trg_Power_Get, Condition(function Trig_Power_Main_Conditions))
    call TriggerAddAction(gg_trg_Power_Get, function Trig_Power_Main_Actions)
endfunction