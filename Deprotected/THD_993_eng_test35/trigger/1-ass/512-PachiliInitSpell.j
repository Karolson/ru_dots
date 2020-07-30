function Trig_PachiliInitSpell_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0XM' then
        return true
    elseif GetSpellAbilityId() == 'A0XN' then
        return true
    elseif GetSpellAbilityId() == 'A0XO' then
        return true
    elseif GetSpellAbilityId() == 'A0XP' then
        return true
    elseif GetSpellAbilityId() == 'A0XQ' then
        return true
    elseif GetSpellAbilityId() == 'A0XY' then
        return true
    elseif GetSpellAbilityId() == 'A0XZ' then
        return true
    endif
    return false
endfunction

function Trig_PachiliInitSpell_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer learnspell = GetSpellAbilityId()
    local boolean a
    local boolean b
    local boolean c
    local boolean d
    local boolean e
    local integer addabit = 0
    if learnspell >= 'A0XM' and learnspell <= 'A0XQ' then
        if learnspell == 'A0XM' then
            call UnitRemoveAbility(caster, 'A0XM')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Secondary element selected: |r Metal")
        elseif learnspell == 'A0XN' then
            call UnitRemoveAbility(caster, 'A0XN')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Secondary element selected: |r Wood")
        elseif learnspell == 'A0XO' then
            call UnitRemoveAbility(caster, 'A0XO')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Secondary element selected: |r Water")
        elseif learnspell == 'A0XP' then
            call UnitRemoveAbility(caster, 'A0XP')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Secondary element selected: |r Fire")
        elseif learnspell == 'A0XQ' then
            call UnitRemoveAbility(caster, 'A0XQ')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Secondary element selected: |r Earth")
        endif
        set a = GetUnitAbilityLevel(caster, 'A0XM') == 0
        set b = GetUnitAbilityLevel(caster, 'A0XN') == 0
        set c = GetUnitAbilityLevel(caster, 'A0XO') == 0
        set d = GetUnitAbilityLevel(caster, 'A0XP') == 0
        set e = GetUnitAbilityLevel(caster, 'A0XQ') == 0
        if a and b and c then
            set addabit = 'A0XW'
        elseif a and b and d then
            set addabit = 'A0YA'
        elseif a and b and e then
            set addabit = 'A0YB'
        elseif a and c and d then
            set addabit = 'A0YC'
        elseif a and c and e then
            set addabit = 'A0YD'
        elseif a and d and e then
            set addabit = 'A0YE'
        elseif b and c and d then
            set addabit = 'A0YF'
        elseif b and c and e then
            set addabit = 'A0YG'
        elseif b and d and e then
            set addabit = 'A0YH'
        elseif c and d and e then
            set addabit = 'A0YI'
        endif
        if addabit != 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), addabit, false)
            call UnitAddAbility(caster, addabit)
            call UnitMakeAbilityPermanent(caster, true, addabit)
            if a and b then
                call DisableTrigger(gg_trg_PachiliAB)
                call DestroyTrigger(gg_trg_PachiliAB)
                set gg_trg_PachiliAB = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliAB, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliAB, Condition(function Trig_PachiliAB_Conditions))
                call TriggerAddAction(gg_trg_PachiliAB, function Trig_PachiliAB_Actions)
            endif
            if a and c then
                call DisableTrigger(gg_trg_PachiliAC)
                call DestroyTrigger(gg_trg_PachiliAC)
                set gg_trg_PachiliAC = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliAC, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliAC, Condition(function Trig_PachiliAC_Conditions))
                call TriggerAddAction(gg_trg_PachiliAC, function Trig_PachiliAC_Actions)
            endif
            if a and d then
                call DisableTrigger(gg_trg_PachiliAD)
                call DestroyTrigger(gg_trg_PachiliAD)
                set gg_trg_PachiliAD = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliAD, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliAD, Condition(function Trig_PachiliAD_Conditions))
                call TriggerAddAction(gg_trg_PachiliAD, function Trig_PachiliAD_Actions)
            endif
            if a and e then
                call DisableTrigger(gg_trg_PachiliAE)
                call DestroyTrigger(gg_trg_PachiliAE)
                set gg_trg_PachiliAE = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliAE, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliAE, Condition(function Trig_PachiliAE_Conditions))
                call TriggerAddAction(gg_trg_PachiliAE, function Trig_PachiliAE_Actions)
            endif
            if b and c then
                call DisableTrigger(gg_trg_PachiliBC)
                call DestroyTrigger(gg_trg_PachiliBC)
                set gg_trg_PachiliBC = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliBC, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliBC, Condition(function Trig_PachiliBC_Conditions))
                call TriggerAddAction(gg_trg_PachiliBC, function Trig_PachiliBC_Actions)
            endif
            if b and d then
                call DisableTrigger(gg_trg_PachiliBD)
                call DestroyTrigger(gg_trg_PachiliBD)
                set gg_trg_PachiliBD = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliBD, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliBD, Condition(function Trig_PachiliBD_Conditions))
                call TriggerAddAction(gg_trg_PachiliBD, function Trig_PachiliBD_Actions)
            endif
            if b and e then
                call DisableTrigger(gg_trg_PachiliBE)
                call DestroyTrigger(gg_trg_PachiliBE)
                set gg_trg_PachiliBE = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliBE, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliBE, Condition(function Trig_PachiliBE_Conditions))
                call TriggerAddAction(gg_trg_PachiliBE, function Trig_PachiliBE_Actions)
            endif
            if c and d then
                call DisableTrigger(gg_trg_PachiliCD)
                call DestroyTrigger(gg_trg_PachiliCD)
                set gg_trg_PachiliCD = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliCD, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliCD, Condition(function Trig_PachiliCD_Conditions))
                call TriggerAddAction(gg_trg_PachiliCD, function Trig_PachiliCD_Actions)
            endif
            if c and e then
                call DisableTrigger(gg_trg_PachiliCE)
                call DestroyTrigger(gg_trg_PachiliCE)
                set gg_trg_PachiliCE = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliCE, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliCE, Condition(function Trig_PachiliCE_Conditions))
                call TriggerAddAction(gg_trg_PachiliCE, function Trig_PachiliCE_Actions)
            endif
            if d and e then
                call DisableTrigger(gg_trg_PachiliDE)
                call DestroyTrigger(gg_trg_PachiliDE)
                set gg_trg_PachiliDE = CreateTrigger()
                call TriggerRegisterUnitEvent(gg_trg_PachiliDE, caster, EVENT_UNIT_SPELL_EFFECT)
                call TriggerAddCondition(gg_trg_PachiliDE, Condition(function Trig_PachiliDE_Conditions))
                call TriggerAddAction(gg_trg_PachiliDE, function Trig_PachiliDE_Actions)
            endif
            if a == false then
                call UnitRemoveAbility(caster, 'A0XM')
            endif
            if b == false then
                call UnitRemoveAbility(caster, 'A0XN')
            endif
            if c == false then
                call UnitRemoveAbility(caster, 'A0XO')
            endif
            if d == false then
                call UnitRemoveAbility(caster, 'A0XP')
            endif
            if e == false then
                call UnitRemoveAbility(caster, 'A0XQ')
            endif
            call UnitRemoveAbility(caster, 'A03E')
            call UnitAddAbility(caster, 'A0DU')
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|c00ff00ffPlease select your main element|r")
        endif
    else
        if learnspell == 'A0XY' then
            call UnitRemoveAbility(caster, 'A0DU')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Main element selected: |r Sun")
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0XX', false)
            call UnitAddAbility(caster, 'A0XX')
            call UnitMakeAbilityPermanent(caster, true, 'A0XX')
            call UnitAddAbility(caster, 'A0WA')
            call UnitMakeAbilityPermanent(caster, true, 'A0WA')
            call UnitAddAbility(caster, 'A0DR')
            call UnitMakeAbilityPermanent(caster, true, 'A0DR')
            call UnitModifySkillPoints(caster, 1)
            call DisableTrigger(gg_trg_PachiliUltF)
            call DestroyTrigger(gg_trg_PachiliUltF)
            set gg_trg_PachiliUltF = CreateTrigger()
            call TriggerRegisterUnitEvent(gg_trg_PachiliUltF, caster, EVENT_UNIT_SPELL_EFFECT)
            call TriggerAddCondition(gg_trg_PachiliUltF, Condition(function Trig_PachiliUltF_Conditions))
            call TriggerAddAction(gg_trg_PachiliUltF, function Trig_PachiliUltF_Actions)
            call DestroyTrigger(GetTriggeringTrigger())
        elseif learnspell == 'A0XZ' then
            call UnitRemoveAbility(caster, 'A0DU')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|c00ffff00Main element selected: |r Moon")
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0YL', false)
            call UnitAddAbility(caster, 'A0YL')
            call UnitMakeAbilityPermanent(caster, true, 'A0YL')
            call UnitAddAbility(caster, 'A0WB')
            call UnitMakeAbilityPermanent(caster, true, 'A0WB')
            call UnitAddAbility(caster, 'A136')
            call UnitMakeAbilityPermanent(caster, true, 'A136')
            call UnitModifySkillPoints(caster, 1)
            call DisableTrigger(gg_trg_PachiliUltG)
            call DestroyTrigger(gg_trg_PachiliUltG)
            set gg_trg_PachiliUltG = CreateTrigger()
            call TriggerRegisterUnitEvent(gg_trg_PachiliUltG, caster, EVENT_UNIT_SPELL_EFFECT)
            call TriggerAddCondition(gg_trg_PachiliUltG, Condition(function Trig_PachiliUltG_Conditions))
            call TriggerAddAction(gg_trg_PachiliUltG, function Trig_PachiliUltG_Actions)
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endif
    set caster = null
endfunction

function InitTrig_PachiliInitSpell takes nothing returns nothing
endfunction