function Trig_Cirno03Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A056'
endfunction

function Trig_Cirno03Cast_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local boolean k = false
    if GetUnitAbilityLevel(caster, 'A058') == 0 then
        set k = true
    elseif udg_SK_Cirno03Cast_Armor <= 0 then
        set k = true
    endif
    if k then
        set udg_SK_Cirno03Cast_Armor = 0
        call UnitRemoveAbility(caster, 'A058')
        call UnitRemoveAbility(caster, 'B05J')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set t = null
endfunction

function Trig_Cirno03Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A056')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A056', 15)
    set udg_SK_Cirno03Cast_Armor = 75 + level * 75
    call UnitBuffTarget(caster, caster, 6.0, 'A058', 'B05J')
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call TimerStart(t, 0.1, true, function Trig_Cirno03Cast_Main)
    set caster = null
    set t = null
endfunction

function InitTrig_Cirno03Cast takes nothing returns nothing
endfunction