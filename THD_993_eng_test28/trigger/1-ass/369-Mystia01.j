function Trig_Mystia01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0DE' or (GetSpellAbilityId() == 'A0DN' and udg_SK_Mystia_Last == 'A0DE')
endfunction

function Mystia04_Multi takes unit u returns real
    return GetUnitAbilityLevel(u, 'A0DN') * 0.25 + 1.0
endfunction

function MystiaEx takes nothing returns boolean
    local unit u = GetEventDamageSource()
    local unit v = GetTriggerUnit()
    if not IsDamageNotUnitAttack(u) and GetEventDamage() > 0 then
        if GetUnitAbilityLevel(u, 'A0PK') > 0 or GetUnitAbilityLevel(v, 'A0PK') > 0 or GetUnitAbilityLevel(u, 'A0Z2') > 0 or GetUnitAbilityLevel(v, 'A0Z2') > 0 and GetUnitLevel(u) > GetUnitLevel(v) then
            call DisableTrigger(GetTriggeringTrigger())
            call UnitMagicDamageTarget(u, v, 30.0 + 3 * (GetUnitLevel(u) - GetUnitLevel(v)), 2)
            call EnableTrigger(GetTriggeringTrigger())
        endif
    endif
    set u = null
    set v = null
    return false
endfunction

function Trig_Mystia01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer level = GetUnitAbilityLevel(caster, 'A0DE')
    local integer i
    local unit u
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    local unit w
    local real multi = 1.0
    local boolean m04 = false
    if GetSpellAbilityId() == 'A0DN' then
        set m04 = true
        set multi = (GetUnitAbilityLevel(caster, 'A0DN') * 0.25 + 1.0) * multi
        call TriggerSleepAction(0.3)
    else
        call AbilityCoolDownResetion(caster, 'A0DE', 11)
        set udg_SK_Mystia_Last = GetSpellAbilityId()
    endif
    set u = NewDummy(GetOwningPlayer(caster), ox, oy, 270.0)
    call UnitAddAbility(u, 'A0DC')
    call SetUnitAbilityLevel(u, 'A0DC', level)
    call IssuePointOrder(u, "silence", ox, oy)
    call UnitRemoveAbility(u, 'A0DC')
    call ReleaseDummy(u)
    set u = null
    call GroupEnumUnitsInRange(g, ox, oy, 600.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if udg_NewDebuffSys then
            call UnitDebuffTarget(caster, v, 2.0 * 1.0, 2, true, 'A04D', 1, 'B084', "drunkenhaze", 'A05P', "")
        else
            call UnitCurseTarget(caster, v, 2.0, 'A0T7', "drunkenhaze")
        endif
    endloop
    call DestroyGroup(g)
    call UnitMagicDamageArea(caster, ox, oy, 600 * multi, 70 + 30 * level + 1.7 * GetHeroInt(caster, true), 5)
    set u = NewDummy(GetOwningPlayer(caster), ox, oy, 270.0)
    call UnitAddAbility(u, 'A0E3')
    set i = 0
    loop
    exitwhen i >= 12
        set px = ox + 150.0 * Cos(30.0 * i * 0.017454)
        set py = oy + 150.0 * Sin(30.0 * i * 0.017454)
        call IssuePointOrder(u, "breathoffrost", px, py)
        set i = i + 1
    endloop
    call UnitRemoveAbility(u, 'A0E3')
    call ReleaseDummy(u)
    set caster = null
    set u = null
    set g = null
    set iff = null
    set v = null
    set w = null
endfunction

function InitTrig_Mystia01 takes nothing returns nothing
endfunction