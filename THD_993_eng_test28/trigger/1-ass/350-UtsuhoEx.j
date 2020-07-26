function Trig_UtsuhoEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local player w = GetOwningPlayer(caster)
    local integer level
    local group g = LoadGroupHandle(udg_ht, task, 1)
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    if caster == null then
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        set w = null
        set g = null
        set v = null
        return
    endif
    set level = GetUnitAbilityLevel(caster, 'A05Z')
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 99999.0, iff)
    if GetWidgetLife(caster) > 0.405 then
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitInRange(caster, v, 600.0) and GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_HERO) then
                if GetUnitAbilityLevel(v, 'A061') == 0 then
                    call UnitAddAbility(v, 'A061')
                    call UnitMakeAbilityPermanent(v, true, 'A061')
                    call SetPlayerAbilityAvailable(GetOwningPlayer(v), 'A061', false)
                endif
                call SetUnitAbilityLevel(v, 'A060', level)
            elseif GetUnitAbilityLevel(v, 'A061') > 0 then
                call UnitRemoveAbility(v, 'A061')
            endif
        endloop
    else
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitAbilityLevel(v, 'A061') > 0 then
                call UnitRemoveAbility(v, 'A061')
            endif
        endloop
    endif
    set t = null
    set caster = null
    set w = null
    set g = null
    set v = null
    set iff = null
endfunction

function InitTrig_UtsuhoEx takes nothing returns nothing
endfunction