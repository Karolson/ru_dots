function Trig_Mystia02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0DI' or (GetSpellAbilityId() == 'A0DN' and udg_SK_Mystia_Last == 'A0DI')
endfunction

function Trig_Mystia02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    if i > 0 and GetWidgetLife(caster) > 0.405 then
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        if level == 1 then
            call UnitRemoveAbility(caster, 'A0DM')
        elseif level == 2 then
            call UnitRemoveAbility(caster, 'A0TB')
        elseif level == 3 then
            call UnitRemoveAbility(caster, 'A0TC')
        elseif level == 4 then
            call UnitRemoveAbility(caster, 'A0TD')
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
endfunction

function Trig_Mystia02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer i
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local unit u
    local real multi = 1.0
    local boolean m04 = false
    local texttag e
    if GetSpellAbilityId() == 'A0DN' then
        set m04 = true
        set multi = multi * (GetUnitAbilityLevel(caster, 'A0DN') * 0.25 + 1.0)
    else
        call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 10)
        set udg_SK_Mystia_Last = GetSpellAbilityId()
    endif
    if level == 1 then
        call UnitAddAbility(caster, 'A0DM')
        call UnitMakeAbilityPermanent(caster, true, 'A0DM')
        call UnitMakeAbilityPermanent(caster, true, 'A0DD')
    elseif level == 2 then
        call UnitAddAbility(caster, 'A0TB')
        call UnitMakeAbilityPermanent(caster, true, 'A0TB')
        call UnitMakeAbilityPermanent(caster, true, 'A0T8')
    elseif level == 3 then
        call UnitAddAbility(caster, 'A0TC')
        call UnitMakeAbilityPermanent(caster, true, 'A0TC')
        call UnitMakeAbilityPermanent(caster, true, 'A0T9')
    elseif level == 4 then
        call UnitAddAbility(caster, 'A0TD')
        call UnitMakeAbilityPermanent(caster, true, 'A0TD')
        call UnitMakeAbilityPermanent(caster, true, 'A0TA')
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, R2I(6 * multi))
    call SaveInteger(udg_ht, task, 2, level)
    call TimerStart(t, 0.5, true, function Trig_Mystia02_Main)
    set u = NewDummy(GetOwningPlayer(caster), ox, oy, 270.0)
    call UnitAddAbility(u, 'A0E2')
    set i = 0
    loop
    exitwhen i >= 24
        set px = ox + 100.0 * CosBJ(15.0 * i)
        set py = oy + 100.0 * SinBJ(15.0 * i)
        call IssuePointOrder(u, "breathoffrost", px, py)
        set i = i + 1
    endloop
    set e = CastSpell(caster, "La la la~")
    if IsVisibleToPlayer(ox, oy, GetLocalPlayer()) == false then
        call SetTextTagVisibility(e, false)
    else
        call SetTextTagVisibility(e, true)
    endif
    call UnitRemoveAbility(u, 'A0E2')
    call ReleaseDummy(u)
    set caster = null
    set t = null
    set u = null
    set e = null
endfunction

function InitTrig_Mystia02 takes nothing returns nothing
endfunction