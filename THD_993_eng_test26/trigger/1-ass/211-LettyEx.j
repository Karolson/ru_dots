function Trig_LettyEx_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real px = LoadReal(udg_ht, task, 1)
    local real py = LoadReal(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    endif
    if ox == px and oy == py then
        set i = i + 1
        call SaveInteger(udg_ht, task, 3, i)
        if i >= 30 and GetUnitAbilityLevel(caster, 'A0XC') == 0 then
            call UnitAddAbility(caster, 'A0XC')
            call SetUnitAbilityLevel(caster, 'A0XB', 2)
        endif
        if i >= 60 and GetUnitAbilityLevel(caster, 'A0XC') < 2 then
            call SetUnitAbilityLevel(caster, 'A0XC', 2)
            call SetUnitAbilityLevel(caster, 'A0XB', 3)
        endif
        if i >= 90 and GetUnitAbilityLevel(caster, 'A0XC') < 3 then
            call SetUnitAbilityLevel(caster, 'A0XC', 3)
            call SetUnitAbilityLevel(caster, 'A0XB', 4)
        endif
    else
        set i = 0
        call SaveInteger(udg_ht, task, 3, i)
        call SaveReal(udg_ht, task, 1, ox)
        call SaveReal(udg_ht, task, 2, oy)
        if GetUnitAbilityLevel(caster, 'A0XC') > 0 then
            call UnitRemoveAbility(caster, 'A0XC')
            call SetUnitAbilityLevel(caster, 'A0XB', 1)
        endif
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_LettyEx takes nothing returns nothing
endfunction