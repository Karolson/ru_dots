function Trig_Shikieiki03_Conditions takes nothing returns boolean
    if IsUnitIllusion(GetTriggerUnit()) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    endif
    return GetUnitTypeId(GetAttacker()) == 'E00V'
endfunction

function Trig_Shikieiki03_Damaged takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local integer task = GetHandleId(trg)
    local unit caster
    local unit target
    local integer level
    local integer ab02level
    local real damage
    local integer buffcount
    local integer buffneed
    local real exdamage
    if GetTriggerEventId() != EVENT_UNIT_DAMAGED then
        call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
        call DestroyTrigger(trg)
        call FlushChildHashtable(udg_ht, task)
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set caster = LoadUnitHandle(udg_ht, task, 0)
    if GetEventDamageSource() != caster then
        set trg = null
        set caster = null
        set target = null
        return
    endif
    set target = GetTriggerUnit()
    call DisableTrigger(trg)
    set level = GetUnitAbilityLevel(caster, 'A0SY')
    if level >= 1 then
        set damage = level * 5 + 5
    endif
    if IsUnitType(target, UNIT_TYPE_HERO) then
        if level >= 1 then
            set buffcount = GetUnitAbilityLevel(target, 'A0SZ') + 1
            set buffneed = 10 - GetUnitAbilityLevel(target, 'A0B0')
            call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, I2S(buffcount) + "/" + I2S(buffneed))
            if buffcount >= buffneed then
                set damage = damage + 40 + GetUnitAttack(caster) * (0.2 + 0.2 * level)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\ReviveDemon\\ReviveDemon.mdl", GetUnitX(target), GetUnitY(target)))
                call Trig_Shikieiki01_Debuff_Add(caster, target, level * 45 + 45.0)
                if GetUnitAbilityLevel(target, 'A0SZ') != 0 then
                    call UnitRemoveAbility(target, 'A0SZ')
                endif
            else
                if GetUnitAbilityLevel(target, 'A0SZ') == 0 then
                    call UnitAddAbility(target, 'A0SZ')
                    call UnitMakeAbilityPermanent(target, true, 'A0SZ')
                else
                    call SetUnitAbilityLevel(target, 'A0SZ', buffcount)
                endif
            endif
        else
            set damage = 0
        endif
        set exdamage = udg_FlagKill[GetPlayerId(GetOwningPlayer(target))] * 8 + udg_FlagAssist[GetPlayerId(GetOwningPlayer(target))] * 4 - udg_FlagDeath[GetPlayerId(GetOwningPlayer(target))] * 4
        if exdamage > 0 then
            set damage = damage + exdamage
        endif
        set ab02level = GetUnitAbilityLevel(caster, 'A0I4')
        if ab02level >= 1 and GetUnitAbilityLevel(target, 'A0B0') >= 1 then
            call UnitBuffTarget(caster, caster, 1.0, 'A194', 0)
            call SetUnitAbilityLevel(caster, 'A194', ab02level)
        endif
    endif
    if damage > 0 then
        call UnitAbsDamageTarget(caster, target, damage)
    endif
    call TriggerRemoveAction(trg, LoadTriggerActionHandle(udg_ht, task, 1))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_ht, task)
    set trg = null
    set caster = null
    set target = null
endfunction

function Trig_Shikieiki03_Actions takes nothing returns nothing
    local unit caster = GetAttacker()
    local unit target = GetTriggerUnit()
    local trigger trg
    local triggeraction tga
    set trg = CreateTrigger()
    set tga = TriggerAddAction(trg, function Trig_Shikieiki03_Damaged)
    call SaveUnitHandle(udg_ht, GetHandleId(trg), 0, caster)
    call SaveTriggerActionHandle(udg_ht, GetHandleId(trg), 1, tga)
    call TriggerRegisterUnitEvent(trg, target, EVENT_UNIT_DAMAGED)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(trg, caster, EVENT_UNIT_ISSUED_TARGET_ORDER)
    set trg = null
    set tga = null
    set caster = null
    set target = null
endfunction

function InitTrig_Shikieiki03 takes nothing returns nothing
endfunction