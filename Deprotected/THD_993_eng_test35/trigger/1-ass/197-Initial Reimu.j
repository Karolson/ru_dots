function Trig_Initial_Reimu_Actions takes nothing returns nothing
    local unit h = GetCharacterHandle('H001')
    local timer t
    local integer task
    local integer i = 0
    if h == null then
        call TriggerExecute(gg_trg_Initial_ReimuN)
        return
    endif
    call SetHeroLifeIncreaseValue(h, 21)
    call SetHeroManaIncreaseValue(h, 6)
    call SetHeroManaBaseRegenValue(h, 0.4)
    call RecHeroBasicArmorValue(h, 0.0)
    call RecHeroIncreArmorValue(h, 0.0)
    call RecHeroAttackBaseValue(h, 26)
    call RecHeroAttackUppeValue(h, 36)
    call RecHeroStaterTypeValue(h, 3)
    set i = 0
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A0T4')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 0)
    set i = 1
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A048')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 1)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, 600.0 * 1.0)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, 0.0 * 1.0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, 215)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, 115)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, 215)
    call SqSaveUnitCircl(h, i, 0)
    set i = 2
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A049')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 0)
    set i = 3
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A04A')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 1)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, 600.0 * 1.0)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, 0.0 * 1.0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, 85)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, 85)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, 215)
    call SqSaveUnitCircl(h, i, 0)
    set i = 4
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, 'A04B')
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, 2)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, 250.0 * 1.0)
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, 50.0 * 1.0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, 255)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, 0)
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, 0)
    call SqSaveUnitCircl(h, i, 0)
    if gg_trg_ReimuSpecial == null then
        set gg_trg_ReimuSpecial = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(gg_trg_ReimuSpecial, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(gg_trg_ReimuSpecial, Condition(function Trig_ReimuSpecial_Conditions))
    endif
    set udg_SK_ReimuEx_Record_Salary = 4
    set udg_SK_ReimuEx_Record_KillGold = 50
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, h)
    call TimerStart(t, 12.0, true, function Trig_ReimuEx_Actions)
    if udg_GameMode / 100 == 3 or udg_NewMid then
        call THD_AddCredit(GetOwningPlayer(h), udg_SK_ReimuEx_Record_Salary * 15)
    endif
    set gg_trg_Reimu01 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reimu01, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reimu01, Condition(function Trig_Reimu01_Conditions))
    call TriggerAddAction(gg_trg_Reimu01, function Trig_Reimu01_Actions)
    set gg_trg_Reimu02 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reimu02, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reimu02, Condition(function Trig_Reimu02_Conditions))
    call TriggerAddAction(gg_trg_Reimu02, function Trig_Reimu02_Actions)
    set gg_trg_Reimu03 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reimu03, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reimu03, Condition(function Trig_Reimu03_Conditions))
    call TriggerAddAction(gg_trg_Reimu03, function Trig_Reimu03_Actions)
    set gg_trg_Reimu04 = CreateTrigger()
    call TriggerRegisterUnitEvent(gg_trg_Reimu04, h, EVENT_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_Reimu04, Condition(function Trig_Reimu04_Conditions))
    call TriggerAddAction(gg_trg_Reimu04, function Trig_Reimu04_Actions)
    call FirstAbilityInit('A04E')
    call FirstAbilityInit('A0CC')
    call FirstAbilityInit('A010')
    call FirstAbilityInit('A04D')
    set h = null
    set t = null
endfunction

function InitTrig_Initial_Reimu takes nothing returns nothing
    set gg_trg_Initial_Reimu = CreateTrigger()
    call TriggerAddAction(gg_trg_Initial_Reimu, function Trig_Initial_Reimu_Actions)
endfunction