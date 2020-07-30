function FLANDRE04 takes nothing returns integer
    return 'A06M'
endfunction

function Flandre04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A06M'
endfunction

function Flandre04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer ctask = GetHandleId(caster)
    local group g = LoadGroupHandle(udg_sht, StringHash("Flandre04"), ctask)
    local effect e1 = LoadEffectHandle(udg_sht, StringHash("Flandre04Effect01"), ctask)
    local effect e2 = LoadEffectHandle(udg_sht, StringHash("Flandre04Effect02"), ctask)
    call UnitRemoveAbility(caster, 'A06Q')
    call DisableTrigger(gg_trg_Flandre04_Attack)
    call DestroyEffect(e1)
    call DestroyEffect(e2)
    call RemoveSavedHandle(udg_sht, StringHash("Flandre04Timer"), ctask)
    call RemoveSavedInteger(udg_sht, StringHash("Flandre04"), ctask)
    call DestroyGroup(g)
    call RemoveSavedHandle(udg_sht, StringHash("Flandre04"), ctask)
    call RemoveSavedInteger(udg_sht, StringHash("Flandre04"), ctask)
    call RemoveSavedHandle(udg_sht, StringHash("Flandre04Effect01"), ctask)
    call RemoveSavedHandle(udg_sht, StringHash("Flandre04Effect02"), ctask)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    call DebugMsg("Flandre04 Clear")
    set t = null
    set caster = null
    set g = null
    set e1 = null
    set e2 = null
endfunction

function Flandre04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer ctask = GetHandleId(caster)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local integer level = GetUnitAbilityLevel(caster, 'A06M')
    local unit tmpunit
    local effect e1
    local effect e2
    local integer i = 1
    local integer id = GetUnitTypeId(caster)
    call AbilityCoolDownResetion(caster, 'A06M', 160 - 30 * level)
    call VE_Spellcast(caster)
    call SaveInteger(udg_sht, StringHash("Flandre04"), ctask, 1)
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
    loop
        set tmpunit = FirstOfGroup(g)
    exitwhen tmpunit == null
        call GroupRemoveUnit(g, tmpunit)
        if GetUnitTypeId(tmpunit) == id and IsUnitIllusion(tmpunit) then
            call KillUnit(tmpunit)
            set i = i + 1
        endif
    endloop
    call SaveInteger(udg_sht, StringHash("Flandre04"), ctask, i)
    call SaveGroupHandle(udg_sht, StringHash("Flandre04"), ctask, g)
    call DebugMsg("No. of hits: " + I2S(i))
    set e1 = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSRight.mdl", caster, "hand left")
    set e2 = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\TrollBerserk\\HeadhunterWEAPONSLeft.mdl", caster, "hand left")
    call SaveTimerHandle(udg_sht, StringHash("Flandre04Timer"), ctask, t)
    call SaveEffectHandle(udg_sht, StringHash("Flandre04Effect01"), ctask, e1)
    call SaveEffectHandle(udg_sht, StringHash("Flandre04Effect02"), ctask, e2)
    call UnitAddAbility(caster, 'A06Q')
    call SetUnitAbilityLevel(caster, 'A06R', level)
    call UnitMakeAbilityPermanent(caster, true, 'A06Q')
    call UnitMakeAbilityPermanent(caster, true, 'A06R')
    call EnableTrigger(gg_trg_Flandre04_Attack)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call TimerStart(t, 15.0, false, function Flandre04_Clear)
    set t = null
    set tmpunit = null
    set caster = null
    set g = null
    set e1 = null
    set e2 = null
endfunction

function InitTrig_Flandre04 takes nothing returns nothing
endfunction