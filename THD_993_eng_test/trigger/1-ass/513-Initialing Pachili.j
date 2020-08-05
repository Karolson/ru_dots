function Trig_Initialing_Pachili_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('U00N')
    call FirstAbilityInit('A0NO')
    call FirstAbilityInit('A0WB')
    call FirstAbilityInit('A0WE')
    call FirstAbilityInit('A0WA')
    call FirstAbilityInit('A0YM')
    call FirstAbilityInit('A0W9')
    call FirstAbilityInit('A0WC')
    call FirstAbilityInit('A16L')
    call FirstAbilityInit('A0X6')
    call FirstAbilityInit('Aloc')
    call FirstAbilityInit('A0WF')
    call FirstAbilityInit('Avul')
    call FirstAbilityInit('A0WH')
    call FirstAbilityInit('A0WG')
    call FirstAbilityInit('A0XG')
    call FirstAbilityInit('A0XH')
    call FirstAbilityInit('A0XI')
    call FirstAbilityInit('A0XJ')
    call FirstAbilityInit('A0XL')
    call FirstAbilityInit('A0XK')
    call FirstAbilityInit('A0XM')
    call FirstAbilityInit('A0XN')
    call FirstAbilityInit('A0XO')
    call FirstAbilityInit('A0XP')
    call FirstAbilityInit('A0XQ')
    call FirstAbilityInit('A0XY')
    call FirstAbilityInit('A0XZ')
    call FirstAbilityInit('A0DR')
    call FirstAbilityInit('A136')
    if h == null then
        return
    endif
    call DebugMsg(GetHeroProperName(h) + " skill initialization completed")
    if not udg_Repick then
        call DestroyTrigger(GetTriggeringTrigger())
    endif
    call SetHeroLifeIncreaseValue(h, 28)
    call SetHeroManaIncreaseValue(h, 1)
    call SetHeroManaBaseRegenValue(h, 0.3)
    call UnitAddAbility(h, 'A03E')
    call DisplayTextToPlayer(GetOwningPlayer(h), 0, 0, "|c00ff00ffPlease select three secondary elements|r")
    call ModifyHeroSkillPoints(h, bj_MODIFYMETHOD_SUB, 1)
    call DisableTrigger(gg_trg_PachiliInitSpell)
    call DestroyTrigger(gg_trg_PachiliInitSpell)
    set gg_trg_PachiliInitSpell = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_PachiliInitSpell, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_PachiliInitSpell, Condition(function Trig_PachiliInitSpell_Conditions))
    call TriggerAddAction(gg_trg_PachiliInitSpell, function Trig_PachiliInitSpell_Actions)
    set h = null
endfunction

function InitTrig_Initialing_Pachili takes nothing returns nothing
    set gg_trg_Initialing_Pachili = CreateTrigger()
    call TriggerAddAction(gg_trg_Initialing_Pachili, function Trig_Initialing_Pachili_Actions)
endfunction