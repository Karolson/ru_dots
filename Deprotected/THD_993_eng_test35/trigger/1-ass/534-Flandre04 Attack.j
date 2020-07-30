function Trig_Flandre04_Attack_Conditions takes nothing returns boolean
    local unit attacker = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer ctask = GetHandleId(attacker)
    local integer hits = LoadInteger(udg_sht, StringHash("Flandre04"), ctask)
    local group g = LoadGroupHandle(udg_sht, StringHash("Flandre04"), ctask)
    if GetUnitAbilityLevel(attacker, 'A06Q') == 0 then
        set attacker = null
        set target = null
        set g = null
        return false
    endif
    if IsUnitAlly(target, GetOwningPlayer(attacker)) or IsDamageNotUnitAttack(attacker) or GetEventDamage() == 0 or IsUnitInGroup(target, g) or IsUnitType(target, UNIT_TYPE_STRUCTURE) or hits == 0 then
        call DebugMsg("Unit checked, no effect")
        set attacker = null
        set target = null
        set g = null
        return false
    endif
    set attacker = null
    set target = null
    set g = null
    return true
endfunction

function Flandre04_Clear_Target takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local group g = LoadGroupHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    call GroupRemoveUnit(g, u)
    call FlushChildHashtable(udg_sht, task)
    call ReleaseTimer(t)
    set t = null
    set g = null
    set u = null
endfunction

function Trig_Flandre04_Attack_Actions takes nothing returns nothing
    local unit attacker = GetEventDamageSource()
    local integer ctask = GetHandleId(attacker)
    local unit target = GetTriggerUnit()
    local timer t
    local integer task
    local integer hits = LoadInteger(udg_sht, StringHash("Flandre04"), ctask)
    local group g = LoadGroupHandle(udg_sht, StringHash("Flandre04"), ctask)
    call DebugMsg(GetUnitName(GetEventDamageSource()) + " " + R2SW(GetEventDamage(), 3, 1) + " " + GetUnitName(GetTriggerUnit()))
    call DebugMsg(I2S(hits) + " decreased to " + I2S(hits - 1))
    set hits = hits - 1
    if hits > 0 then
        call SaveInteger(udg_sht, StringHash("Flandre04"), ctask, hits)
        call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", target, "origin"))
        call GroupAddUnit(g, target)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveGroupHandle(udg_sht, task, 0, g)
        call SaveUnitHandle(udg_sht, task, 1, target)
        call TimerStart(t, 3, false, function Flandre04_Clear_Target)
    elseif hits == 0 then
        set t = LoadTimerHandle(udg_sht, StringHash("Flandre04Timer"), ctask)
        call TimerStart(t, 0.0, false, function Flandre04_Clear)
    endif
    set attacker = null
    set target = null
    set g = null
    set t = null
endfunction

function InitTrig_Flandre04_Attack takes nothing returns nothing
endfunction