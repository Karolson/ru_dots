function Trig_AgiInt03_Arrow_Conditions takes nothing returns boolean
    if YDWEUnitHasItemOfTypeBJNull(GetEventDamageSource(), 'I07H') != true then
        return false
    elseif IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetEventDamageSource())) then
        return false
    elseif IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitIllusion(GetEventDamageSource()) then
        return false
    elseif GetEventDamage() == 0 then
        return false
    elseif IsDamageNotUnitAttack(GetEventDamageSource()) then
        return false
    endif
    return true
endfunction

function Trig_AgiInt03_Arrow_HealReduce takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real oldhp = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real newhp
    local real nowhp
    if i >= 0 then
        set nowhp = GetUnitState(target, UNIT_STATE_LIFE)
        if nowhp > oldhp then
            set newhp = nowhp - (nowhp - oldhp) * 0.5
            call SetUnitState(target, UNIT_STATE_LIFE, newhp)
        endif
        call SaveReal(udg_ht, task, 2, GetUnitState(target, UNIT_STATE_LIFE))
    endif
    set i = i + 1
    call SaveInteger(udg_ht, task, 3, i)
    if i >= 300 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_AgiInt03_Arrow_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local timer t
    local integer task
    call UnitMagicDamageTarget(caster, target, 25 + 0.2 * GetHeroInt(caster, true), 4)
    if GetUnitAbilityLevel(target, 'A148') == 0 and GetUnitAbilityLevel(target, 'A149') == 0 and GetUnitAbilityLevel(target, 'A14A') == 0 and GetUnitAbilityLevel(target, 'A14B') == 0 then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call SaveUnitHandle(udg_ht, task, 1, target)
        call SaveReal(udg_ht, task, 2, GetUnitState(target, UNIT_STATE_LIFE))
        call SaveInteger(udg_ht, task, 3, 0)
        call TimerStart(t, 0.01, true, function Trig_AgiInt03_Arrow_HealReduce)
    endif
    if GetUnitAbilityLevel(target, 'A148') == 0 then
        call UnitSlowTarget(caster, target, 3.0, 'A148', 0)
    elseif GetUnitAbilityLevel(target, 'A149') == 0 then
        call UnitSlowTarget(caster, target, 3.0, 'A149', 0)
    elseif GetUnitAbilityLevel(target, 'A14A') == 0 then
        call UnitSlowTarget(caster, target, 3.0, 'A14A', 0)
    elseif GetUnitAbilityLevel(target, 'A14B') == 0 then
        call UnitSlowTarget(caster, target, 3.0, 'A14B', 0)
    else
        call UnitSlowTarget(caster, target, 3.0, 'A14C', 0)
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\OrbOfDeath\\OrbOfDeathMissile.mdl", GetUnitX(target), GetUnitY(target)))
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_AgiInt03_Arrow takes nothing returns nothing
    set gg_trg_AgiInt03_Arrow = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_AgiInt03_Arrow)
    call TriggerAddCondition(gg_trg_AgiInt03_Arrow, Condition(function Trig_AgiInt03_Arrow_Conditions))
    call TriggerAddAction(gg_trg_AgiInt03_Arrow, function Trig_AgiInt03_Arrow_Actions)
endfunction