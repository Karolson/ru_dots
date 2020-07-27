function Trig_yongjiutingbo_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0AG'
endfunction

function zisha takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, StringHash("caster"))
    local location p = LoadLocationHandle(udg_Hashtable, task, StringHash("p"))
    local location loc = GetUnitLoc(caster)
    local location loc2 = PolarProjectionBJ(loc, 17.0, AngleBetweenPoints(loc, p))
    call SetUnitPositionLoc(caster, loc2)
    if IsUnitInRangeLoc(caster, p, 9.0) then
        if GetWidgetLife(caster) > 0.405 then
            call UnitMagicDamageArea(caster, GetUnitX(caster), GetUnitY(caster), 300, 100.0 + GetUnitAbilityLevel(caster, 'A0AG') * 200, 5)
            call UnitStunArea(caster, 2, GetUnitX(caster), GetUnitY(caster), 300, 0, 0)
            call KillUnit(caster)
            call DestroyEffect(AddSpecialEffectLoc("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", p))
            call DestroyEffect(AddSpecialEffectLoc("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", p))
        endif
        call ReleaseTimer(t)
        call RemoveLocation(p)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    call RemoveLocation(loc)
    call RemoveLocation(loc2)
    set t = null
    set caster = null
    set p = null
    set loc = null
    set loc2 = null
endfunction

function Trig_yongjiutingbo_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local location p = GetSpellTargetLoc()
    call SetUnitFlyHeight(caster, 0.0, 500.0)
    call SaveUnitHandle(udg_Hashtable, task, StringHash("caster"), caster)
    call SaveLocationHandle(udg_Hashtable, task, StringHash("p"), p)
    call TimerStart(t, 0.02, true, function zisha)
    set t = null
    set caster = null
    set p = null
endfunction

function InitTrig_Captain04_yongjiutingbo takes nothing returns nothing
endfunction