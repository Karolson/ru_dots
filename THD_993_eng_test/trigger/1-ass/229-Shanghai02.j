function Trig_Shanghai02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0HI'
endfunction

function Trig_Shanghai02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    if i > 0 and GetWidgetLife(caster) > 0.405 and GetUnitAbilityLevel(caster, 'A0HR') == 0 and GetUnitAbilityLevel(caster, 'A0HW') >= 1 then
        call SetUnitX(u, ox)
        call SetUnitY(u, oy)
        call UnitPhysicalDamageArea(caster, ox, oy, 135, 9 + level * 9 + GetHeroStr(GetCharacterHandle('H01A'), true) * 0.4)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call UnitRemoveAbility(caster, 'A0HW')
        call AddUnitAnimationProperties(caster, "spin", false)
        call UnitRemoveAbility(u, 'A0HJ')
        call ReleaseDummy(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Shanghai02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if GetUnitAbilityLevel(caster, 'A0HH') > 0 then
        call IssueImmediateOrder(caster, "undefend")
    endif
    set u = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 270.0)
    call UnitAddAbility(u, 'A0HJ')
    call SetUnitAbilityLevel(u, 'A0HJ', level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 0, level)
    call SaveInteger(udg_ht, task, 1, 10)
    call TimerStart(t, 0.5, true, function Trig_Shanghai02_Main)
    call UnitRemoveAbility(caster, 'BOww')
    call UnitAddAbility(caster, 'A0HW')
    call AddUnitAnimationProperties(caster, "spin", true)
    call ReleaseDummy(u)
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_Shanghai02 takes nothing returns nothing
endfunction