function Trig_Renko04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A14D'
endfunction

function Trig_Renko04_Clear takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local effect e = LoadEffectHandle(udg_ht, task, 0)
    call DestroyEffect(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set e = null
endfunction

function Trig_Renko04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A14D')
    local effect e
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local group g
    local filterfunc f
    local unit v
    local real time
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A14D', 45 - 5 * level)
    call Trig_RenkoEx_TurnsOn(caster)
    set time = 8.0
    if udg_SK_Renko_LastSpell == 2 then
        set time = 16.0
    endif
    call UnitBuffTarget(caster, caster, time, 'A14L', 0)
    call SetUnitAbilityLevel(caster, 'A14L', level)
    if udg_SK_Renko_LastSpell == 1 then
        call SetUnitAbilityLevel(caster, 'A14L', level + 3)
    endif
    if udg_SK_Renko_LastSpell == 3 then
        set g = CreateGroup()
        set f = Filter(function Trig_Renko01_Target03)
        call GroupEnumUnitsInRange(g, ox, oy, 450.0, f)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            call UnitBuffTarget(caster, v, time, 'A14L', 0)
            call SetUnitAbilityLevel(v, 'A14L', level)
        endloop
        call DestroyFilter(f)
        call DestroyGroup(g)
    endif
    if udg_SK_Renko_LastSpell == 4 then
        call UnitBuffTarget(caster, caster, time, 'A14M', 0)
    endif
    set e = AddSpecialEffectTarget("Usami Renko_W.MDX", caster, "origin")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveEffectHandle(udg_ht, task, 0, e)
    call TimerStart(t, time, false, function Trig_Renko04_Clear)
    set udg_SK_Renko_LastSpell = 4
    set caster = null
    set f = null
    set e = null
    set g = null
    set v = null
    set t = null
endfunction

function InitTrig_Renko04 takes nothing returns nothing
endfunction