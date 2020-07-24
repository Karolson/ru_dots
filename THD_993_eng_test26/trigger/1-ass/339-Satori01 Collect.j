function Trig_Satori01_Collect_Conditions takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Satori01_Collect_Actions takes nothing returns nothing
    local integer task = GetHandleId(GetTriggeringTrigger())
    local integer skill = GetSpellAbilityId()
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit target = GetTriggerUnit()
    if target != caster and IsUnitInRange(caster, target, 1200.0) and Trig_Satori01_Check(caster, target, skill) then
        if GetUnitAbilityLevel(caster, 'A0IW') > 0 then
            call Trig_Satori01_Add(caster, target, skill)
        endif
    endif
    set caster = null
    set target = null
endfunction

function InitTrig_Satori01_Collect takes nothing returns nothing
endfunction