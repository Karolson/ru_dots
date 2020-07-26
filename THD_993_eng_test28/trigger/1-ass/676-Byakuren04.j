function Trig_Byakuren04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0O2'
endfunction

function Trig_Byakuren04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 3)
    local player w = GetOwningPlayer(caster)
    local group g
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call SaveInteger(udg_ht, task, 1, i - 1)
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 99999.0, iff)
    if GetWidgetLife(caster) > 0.405 and i > 0 then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitInRange(caster, v, 600.0) and GetWidgetLife(v) >= 0.405 and IsUnitType(v, UNIT_TYPE_SUMMONED) == false then
                if GetUnitAbilityLevel(v, 'A124') == 0 then
                    call CE_Input(caster, v, 100)
                    call UnitAddAbility(v, 'A124')
                    call UnitMakeAbilityPermanent(v, true, 'A124')
                    call SetPlayerAbilityAvailable(GetOwningPlayer(v), 'A124', false)
                endif
                call SetUnitAbilityLevel(v, 'A123', level)
            elseif GetUnitAbilityLevel(v, 'A124') > 0 then
                call UnitRemoveAbility(v, 'A124')
            endif
        endloop
    else
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitAbilityLevel(v, 'A124') > 0 then
                call UnitRemoveAbility(v, 'A124')
            endif
        endloop
    endif
    call DestroyGroup(g)
    if i <= 0 then
        call DestroyEffect(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set w = null
        set g = null
        set v = null
        set iff = null
        set e = null
    endif
    set t = null
    set caster = null
    set e = null
    set w = null
    set g = null
    set v = null
    set iff = null
endfunction

function Trig_Byakuren04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local effect e
    local timer t
    local integer task
    local unit v
    local group g
    local boolexpr iff
    local real damage02 = 0
    local unit e2
    call AbilityCoolDownResetion(caster, 'A0O2', 100)
    call VE_Spellcast(caster)
    set e = AddSpecialEffectTarget("hijiri byakuren4.MDx", caster, "origin")
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 10 + GetUnitAbilityLevel(caster, GetSpellAbilityId()) * 30)
    call SaveEffectHandle(udg_ht, task, 2, e)
    call SaveInteger(udg_ht, task, 3, GetUnitAbilityLevel(caster, GetSpellAbilityId()))
    call TimerStart(t, 0.1, true, function Trig_Byakuren04_Main)
    set g = CreateGroup()
    set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if udg_SK_Byakuren02_Record > 0 then
        set damage02 = udg_SK_Byakuren02_Record
        set udg_SK_Byakuren02_Record = 0
    endif
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, damage02, 5)
            if damage02 > 0 then
                set e2 = CreateUnit(GetOwningPlayer(caster), 'e01M', GetUnitX(v), GetUnitY(v), 0)
                call SetUnitPathing(e2, false)
                call SetUnitXY(e2, GetUnitX(v), GetUnitY(v))
            endif
        endif
    endloop
    call DestroyGroup(g)
    set caster = null
    set e = null
    set t = null
    set v = null
    set g = null
    set iff = null
    set e2 = null
endfunction

function InitTrig_Byakuren04 takes nothing returns nothing
endfunction