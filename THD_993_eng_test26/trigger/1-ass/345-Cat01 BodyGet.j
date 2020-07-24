function Trig_Cat01_BoydyGet_FF takes nothing returns boolean
    if IsUnitIllusion(GetFilterUnit()) then
        return false
    endif
    if GetUnitTypeId(GetFilterUnit()) == 'E00W' then
        return false
    endif
    if udg_Orin_suicide_check then
        set udg_Orin_suicide_check = false
        return false
    endif
    return GetUnitAbilityLevel(GetFilterUnit(), 'A0X8') > 0
endfunction

function Trig_Cat01_BodyGet_Conditions takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local group g
    local real x
    local real y
    local boolexpr iff
    local unit v
    if IsUnitType(u, UNIT_TYPE_HERO) == false then
        return false
    endif
    set x = GetUnitX(u)
    set y = GetUnitY(u)
    set g = CreateGroup()
    set iff = Filter(function Trig_Cat01_BoydyGet_FF)
    call GroupEnumUnitsInRange(g, x, y, 600.0, iff)
    set v = FirstOfGroup(g)
    if v == null then
        return false
    endif
    if GetUnitAbilityLevel(v, 'A0X8') == 0 then
        set u = null
        set g = null
        set v = null
        set iff = null
        return false
    endif
    if Cat_GetMaxiumBody(v) <= Cat_GetBodyCount(v) then
        set u = null
        set g = null
        set v = null
        set iff = null
        return false
    endif
    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", x, y))
    call Cat_SetBodyCount(v, Cat_GetBodyCount(v) + 1)
    call DebugMsg(I2S(Cat_GetBodyCount(v)))
    set u = null
    set g = null
    set v = null
    set iff = null
    return false
endfunction

function Trig_Cat01_BodyGet_Actions takes nothing returns nothing
endfunction

function InitTrig_Cat01_BodyGet takes nothing returns nothing
endfunction