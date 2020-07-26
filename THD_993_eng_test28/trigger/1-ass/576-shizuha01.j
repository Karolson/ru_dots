function Trig_shizuha01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0J8'
endfunction

function Trig_shizuha01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit v
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local real Range = 158.0 + 25.0 * level
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call AbilityCoolDownResetion(caster, 'A0J8', 11)
    call TriggerSleepAction(0.4)
    set u = NewDummy(GetOwningPlayer(caster), x, y, 0)
    call UnitAddAbility(u, 'A0JD')
    call UnitAddAbility(u, 'A00C')
    call SetUnitAbilityLevel(u, 'A0JD', level)
    call GroupEnumUnitsInRange(g, x, y, Range + 10.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if GetUnitAbilityLevel(v, 'A0AN') == 0 then
            if GetUnitCurrentOrder(v) != OrderId("metamorphosis") then
                call UnitDebuffTarget(caster, v, 0.5 * I2R(level), 1, true, 'A0JD', level, 'B04S', "entanglingroots", 0, "")
                call CCSystem_textshow("Root", v, DebuffDuration(v, 0.5 * I2R(level)))
                call UnitMagicDamageTarget(caster, v, 30 * level - 10 + 3.6 * GetHeroInt(caster, true), 5)
            endif
        endif
    endloop
    call DestroyGroup(g)
    call UnitRemoveAbility(u, 'A0JD')
    call UnitRemoveAbility(u, 'A00C')
    call ReleaseDummy(u)
    set caster = null
    set v = null
    set u = null
    set g = null
    set iff = null
endfunction

function InitTrig_shizuha01 takes nothing returns nothing
endfunction