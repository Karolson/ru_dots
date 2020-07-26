function Trig_Yuugi01Cast_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A11C'
endfunction

function Trig_Yuugi01Cast_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer lifebonus = LoadInteger(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 3)
    local effect e2 = LoadEffectHandle(udg_ht, task, 4)
    local effect e3 = LoadEffectHandle(udg_ht, task, 5)
    local integer atk = LoadInteger(udg_ht, task, 6)
    call UnitAddMaxLife(caster, -lifebonus)
    call SaveInteger(udg_sht, StringHash("Yuugi01"), GetHandleId(caster), 0)
    call DestroyEffect(e)
    call DestroyEffect(e2)
    call DestroyEffect(e3)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set e = null
    set e2 = null
    set e3 = null
endfunction

function Trig_Yuugi01Cast_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A11C')
    local integer lifebonus = R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) / 20 * (level + 1))
    local integer attackbonus = R2I(GetUnitState(caster, UNIT_STATE_MAX_LIFE) / 20 * (level + 1) * 0.1)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local effect e = AddSpecialEffectTarget("Environment\\NightElfBuildingFire\\ElfSmallBuildingFire2.mdl", caster, "hand right")
    local effect e2 = AddSpecialEffectTarget("Environment\\NightElfBuildingFire\\ElfSmallBuildingFire2.mdl", caster, "hand right")
    local effect e3 = AddSpecialEffectTarget("Environment\\NightElfBuildingFire\\ElfSmallBuildingFire2.mdl", caster, "hand right")
    call AbilityCoolDownResetion(caster, 'A11C', 24)
    call UnitAddMaxLife(caster, lifebonus)
    call SaveInteger(udg_sht, StringHash("Yuugi01"), GetHandleId(caster), attackbonus)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, lifebonus)
    call SaveEffectHandle(udg_ht, task, 3, e)
    call SaveEffectHandle(udg_ht, task, 4, e2)
    call SaveEffectHandle(udg_ht, task, 5, e3)
    call TimerStart(t, 9.0, false, function Trig_Yuugi01Cast_Main)
    set caster = null
    set t = null
    set e = null
    set e2 = null
    set e3 = null
endfunction

function InitTrig_Yuugi01Cast takes nothing returns nothing
endfunction