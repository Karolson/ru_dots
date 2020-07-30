function SetHeroLifeIncreaseValue takes unit h, integer life returns nothing
    call UnitAddAbility(h, 'A19F')
    call UnitMakeAbilityPermanent(h, true, 'A19F')
    call SetUnitAbilityLevel(h, 'A19F', life + 1)
endfunction

function SetHeroManaIncreaseValue takes unit h, integer mana returns nothing
    call UnitAddAbility(h, 'A01Z')
    call UnitMakeAbilityPermanent(h, true, 'A01Z')
    call SetUnitAbilityLevel(h, 'A01Z', mana + 1)
endfunction

function SetHeroManaBaseRegenValue takes unit h, real manaregen returns nothing
    call UnitAddAbility(h, 'A026')
    call UnitMakeAbilityPermanent(h, true, 'A026')
    call SetUnitAbilityLevel(h, 'A026', R2I(manaregen * 10) + 1)
endfunction

function Trig_LevelUpIncreaseState_Actions takes nothing returns nothing
    call UnitAddAbility(GetTriggerUnit(), 'A195')
    call SetUnitAbilityLevel(GetTriggerUnit(), 'A195', GetUnitAbilityLevel(GetTriggerUnit(), 'A19F'))
    call UnitRemoveAbility(GetTriggerUnit(), 'A195')
    call UnitAddAbility(GetTriggerUnit(), 'A01L')
    call SetUnitAbilityLevel(GetTriggerUnit(), 'A01L', GetUnitAbilityLevel(GetTriggerUnit(), 'A01Z'))
    call UnitRemoveAbility(GetTriggerUnit(), 'A01L')
    call SetPlayerTechResearched(GetOwningPlayer(GetTriggerUnit()), 'Rhst', GetHeroLevel(GetTriggerUnit()) - 1)
endfunction

function InitTrig_LevelUpIncreaseState takes nothing returns nothing
    set gg_trg_LevelUpIncreaseState = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LevelUpIncreaseState, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(gg_trg_LevelUpIncreaseState, function Trig_LevelUpIncreaseState_Actions)
endfunction