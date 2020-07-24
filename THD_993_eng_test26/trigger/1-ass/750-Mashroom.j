function Trig_Mashroom_Conditions takes nothing returns boolean
    local item mashroom = GetManipulatedItem()
    local integer ItemType = GetItemTypeId(mashroom)
    if ItemType == 'I00R' or ItemType == 'I00T' or ItemType == 'I00S' then
        set mashroom = null
        return true
    endif
    set mashroom = null
    return false
endfunction

function Trig_Mashroom_Actions takes nothing returns nothing
    local item mashroom = GetManipulatedItem()
    local integer ItemType = GetItemTypeId(mashroom)
    local unit caster = GetManipulatingUnit()
    local effect e
    if IsUnitType(caster, UNIT_TYPE_HERO) then
        if ItemType == 'I00R' then
            call SetHeroStr(caster, GetHeroStr(caster, false) + 3, true)
        elseif ItemType == 'I00T' then
            call SetHeroAgi(caster, GetHeroAgi(caster, false) + 3, true)
        elseif ItemType == 'I00S' then
            call SetHeroInt(caster, GetHeroInt(caster, false) + 3, true)
        endif
        set e = AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", caster, "origin")
        call DestroyEffect(e)
    endif
    set e = null
    set mashroom = null
    set caster = null
endfunction

function InitTrig_Mashroom takes nothing returns nothing
    set gg_trg_Mashroom = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Mashroom, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(gg_trg_Mashroom, Condition(function Trig_Mashroom_Conditions))
    call TriggerAddAction(gg_trg_Mashroom, function Trig_Mashroom_Actions)
endfunction