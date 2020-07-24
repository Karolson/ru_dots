function Trig_Agi04_Mobile_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I06X') != true then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    elseif GetUnitAbilityLevel(GetEventDamageSource(), 'A170') == 5 then
        return false
    endif
    return IsUnitIllusion(GetEventDamageSource()) == false
endfunction

function MobileAddAtkAs takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local integer bufflevel = LoadInteger(udg_sht, StringHash("Mobile"), GetHandleId(caster))
    set bufflevel = bufflevel - 1
    call SaveInteger(udg_sht, StringHash("Mobile"), GetHandleId(caster), bufflevel)
    call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(caster, 'I06X'), bufflevel)
    call UnitAddBonusDmg(caster, -6)
    call UnitAddBonusAspd(caster, -6)
    set udg_DMG_AllItemAttackSpeed[GetPlayerId(GetOwningPlayer(caster))] = udg_DMG_AllItemAttackSpeed[GetPlayerId(GetOwningPlayer(caster))] - 0.06
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set t = null
    set caster = null
endfunction

function Trig_Agi04_Mobile_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local integer task
    local timer t
    local integer bufflevel = LoadInteger(udg_sht, StringHash("Mobile"), GetHandleId(caster))
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 4) 
    if bufflevel < 5 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        set bufflevel = bufflevel + 1
        call SetItemCharges(YDWEGetItemOfTypeFromUnitBJNull(caster, 'I06X'), bufflevel)
        call SaveInteger(udg_sht, StringHash("Mobile"), GetHandleId(caster), bufflevel)
        call UnitAddBonusDmg(caster, 6)
        call UnitAddBonusAspd(caster, 6)
        set udg_DMG_AllItemAttackSpeed[GetPlayerId(GetOwningPlayer(caster))] = udg_DMG_AllItemAttackSpeed[GetPlayerId(GetOwningPlayer(caster))] + 0.06
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call TimerStart(t, 5.0, false, function MobileAddAtkAs)
    endif
    set t = null
endfunction

function InitTrig_Agi04_Mobile takes nothing returns nothing
    set gg_trg_Agi04_Mobile = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_Agi04_Mobile)
    call TriggerAddCondition(gg_trg_Agi04_Mobile, Condition(function Trig_Agi04_Mobile_Conditions))
    call TriggerAddAction(gg_trg_Agi04_Mobile, function Trig_Agi04_Mobile_Actions)
endfunction