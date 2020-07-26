function Trig_Suika02_Conditions takes nothing returns boolean
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer p
    local integer rate = 0
    if GetUnitTypeId(caster) == 'H00L' or GetUnitTypeId(caster) == 'H00Q' then
        if GetUnitTypeId(target) == 'H00L' or GetUnitTypeId(target) == 'H00Q' then
            set caster = null
            set target = null
            return false
        elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) then
            set caster = null
            set target = null
            return false
        elseif GetUnitAbilityLevel(caster, 'A0BC') > 0 or GetUnitAbilityLevel(caster, 'A02I') == 0 then
            set caster = null
            set target = null
            return false
        elseif IsDamageNotUnitAttack(caster) then
            set caster = null
            set target = null
            return false
        elseif GetEventDamage() == 0 then
            set caster = null
            set target = null
            return false
        elseif IsUnitIllusion(caster) then
            set caster = null
            set target = null
            return false
        endif
        if GetUnitTypeId(caster) == 'H00Q' then
            set rate = 25 + 25 * GetUnitAbilityLevel(caster, 'A05W')
        elseif GetUnitTypeId(caster) == 'H00L' then
            set rate = 30
        endif
        set p = GetRandomInt(0, 100)
        if p <= rate then
            set udg_SK_Suika02_Count = 0
            set caster = null
            set target = null
            return true
        elseif udg_SK_Suika02_Count >= 4 then
            set udg_SK_Suika02_Count = 0
            set caster = null
            set target = null
            return true
        else
            set udg_SK_Suika02_Count = udg_SK_Suika02_Count + 1
        endif
    endif
    set target = null
    set caster = null
    return false
endfunction

function Trig_Suika02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = LoadUnitHandle(udg_sht, task, 1)
    local integer level = GetUnitAbilityLevel(caster, 'A02I')
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local effect e = AddSpecialEffect("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y)
    call DestroyEffect(e)
    call UnitSlowTargetArea(caster, x, y, 300, 1.7, 'A15T', 'BHtc')
    call UnitPhysicalDamageArea(caster, x, y, 300, ABCIExtraAtk(caster, 30 + level * 30, 0.6))
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    call EnableTrigger(gg_trg_Suika02)
    set e = null
    set t = null
    set caster = null
    set target = null
endfunction

function Trig_Suika02_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call DisableTrigger(gg_trg_Suika02)
    call SaveUnitHandle(udg_sht, task, 0, caster)
    call SaveUnitHandle(udg_sht, task, 1, target)
    call TimerStart(t, 0.0, false, function Trig_Suika02_Main)
    set caster = null
    set target = null
    set t = null
endfunction

function InitTrig_Suika02 takes nothing returns nothing
endfunction