function Trig_DustOfAppearance_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'AItb'
endfunction

function THD_IsUnitInvisible takes unit v returns boolean
    return GetUnitAbilityLevel(v, 'A09L') + GetUnitAbilityLevel(v, 'A07K') + GetUnitAbilityLevel(v, 'B059') + GetUnitAbilityLevel(v, 'Binv') + GetUnitAbilityLevel(v, 'B02K') + GetUnitAbilityLevel(v, 'A0G0') + GetUnitAbilityLevel(v, 'B09F') + GetUnitAbilityLevel(v, 'B01P') + GetUnitAbilityLevel(v, 'A0LI') + GetUnitAbilityLevel(v, 'A0TW') + GetUnitAbilityLevel(v, 'A0TV') != 0
endfunction

function Trig_DustOfAppearance_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit v
    local group g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 1100, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetUnitAbilityLevel(v, 'Bdet') != 0 then
            if THD_IsUnitInvisible(v) then
                call UnitSlowTarget(caster, v, 11.85, 'A1IC', 'B0AE')
            endif
        endif
    endloop
    call DestroyGroup(g)
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set caster = null
    set t = null
    set v = null
endfunction

function Trig_DustOfAppearance_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 1, GetTriggerUnit())
    call TimerStart(t, 0.15, false, function Trig_DustOfAppearance_Main)
    set t = null
endfunction

function InitTrig_DustOfAppearance takes nothing returns nothing
    set gg_trg_DustOfAppearance = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_DustOfAppearance, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(gg_trg_DustOfAppearance, Condition(function Trig_DustOfAppearance_Conditions))
    call TriggerAddAction(gg_trg_DustOfAppearance, function Trig_DustOfAppearance_Actions)
endfunction