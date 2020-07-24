function Komachi03_SoulExplosion takes unit caster, unit u returns nothing
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local group g = CreateGroup()
    local unit eu
    local unit v
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call KillUnit(u)
    call RemoveUnit(u)
    set eu = CreateUnit(GetOwningPlayer(caster), 'n055', GetUnitX(u), GetUnitY(u), 0.0)
    call UnitApplyTimedLife(eu, 'BTLF', 2.0)
    call GroupEnumUnitsInRange(g, ox, oy, 300, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and not (GetUnitAbilityLevel(v, 'A0IL') > 0) then
            call UnitMagicDamageTarget(caster, v, 0.02 * GetUnitState(v, UNIT_STATE_MAX_LIFE), 5)
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
    set eu = null
endfunction

function Trig_Komachi03_New_Conditions takes nothing returns boolean
    local unit caster
    local group g
    local unit v
    local real ox
    local real oy
    if GetSpellAbilityId() == 'A1CU' then
        call DebugMsg("Komachi03 New")
        set caster = GetTriggerUnit()
        call AbilityCoolDownResetion(caster, 'A1CU', 14 - 2 * GetUnitAbilityLevel(caster, 'A1CU'))
        set g = CreateGroup()
        set ox = GetUnitX(caster)
        set oy = GetUnitY(caster)
        set v = CreateUnit(GetOwningPlayer(caster), 'n054', GetUnitX(caster), GetUnitY(caster), 0.0)
        call UnitApplyTimedLife(v, 'BTLF', 2.0)
        call GroupAddGroup(LoadGroupHandle(udg_ht, GetHandleId(caster), 66), g)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetUnitTypeId(v) == 'n01G' and GetOwningPlayer(v) == GetOwningPlayer(caster) then
                call DebugMsg("Soul Explosion")
                call Komachi03_SoulExplosion(caster, v)
            endif
        endloop
        call DestroyGroup(g)
    endif
    set caster = null
    set g = null
    return false
endfunction

function Trig_Komachi03_New_Actions takes nothing returns nothing
endfunction

function InitTrig_Komachi03_New takes nothing returns nothing
endfunction