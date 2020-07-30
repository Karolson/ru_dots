function Trig_Kogasa04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0C7'
endfunction

function Trig_Kogasa04_Target takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function Trig_Kogasa04_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local effect e = LoadEffectHandle(udg_ht, task, 2)
    call DestroyEffect(e)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set target = null
    set e = null
endfunction

function Trig_Kogasa04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u
    local effect e
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real rx = LoadReal(udg_ht, task, 1)
    local real ry = LoadReal(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 0)
    local boolean o = false
    local boolean k = udg_SK_Kogasa04_Stun
    local group g
    local filterfunc f
    if GetWidgetLife(caster) > 0.405 and GetUnitAbilityLevel(caster, 'B02K') > 0 then
        if ox != rx or oy != ry then
            set udg_SK_Kogasa04_Stun = false
            set k = false
        endif
        set g = CreateGroup()
        set f = Filter(function Trig_Kogasa04_Target)
        call GroupEnumUnitsInRange(g, ox, oy, 400.0, f)
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
            call GroupRemoveUnit(g, u)
            if IsUnitEnemy(u, GetOwningPlayer(caster)) and IsUnitVisible(u, GetOwningPlayer(caster)) then
                set o = true
            endif
        exitwhen o
        endloop
        call DestroyFilter(f)
        call DestroyGroup(g)
        if o then
            call DisableTrigger(gg_trg_Kogasa04_Cancel)
            call UnitRemoveAbility(caster, 'B02K')
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C7', true)
            call SetUnitAnimation(caster, "stand")
            call IssuePointOrder(caster, "attack", GetUnitX(u), GetUnitY(u))
            set e = AddSpecialEffectTarget("Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl", u, "overhead")
            if GetRandomInt(1, 300000000) <= 7874790 then
                call CastSpell(caster, "德_西_!!!")
            else
                call CastSpell(caster, "哇_!!!")
            endif
            call SaveUnitHandle(udg_ht, task, 1, u)
            call SaveEffectHandle(udg_ht, task, 2, e)
            if k then
                call UnitStunArea(caster, 2.5, ox, oy, 600, 0, 'B02M')
                call UnitMagicDamageArea(caster, ox, oy, 600, 200 + 100 * level + GetUnitAttack(caster), 5)
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", ox, oy))
            endif
            call TimerStart(t, 2.5, false, function Trig_Kogasa04_End)
        endif
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set e = null
    set u = null
    set g = null
    set f = null
endfunction

function Trig_Kogasa04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0C7')
    local timer t
    call AbilityCoolDownResetion(caster, 'A0C7', 39 - level * 9)
    call SetUnitAnimation(caster, "spell slam")
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0C7', false)
    call IssueImmediateOrder(caster, "holdposition")
    call EnableTrigger(gg_trg_Kogasa04_Cancel)
    call UnitAddAbility(caster, 'Abun')
    call UnitMakeAbilityPermanent(caster, true, 'Abun')
    call TriggerSleepAction(4.0 - 1.0 * level)
    call UnitRemoveAbility(caster, 'Abun')
    if GetUnitAbilityLevel(caster, 'B02K') > 0 then
        set t = CreateTimer()
        call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
        call SaveInteger(udg_ht, GetHandleId(t), 0, level)
        call SaveReal(udg_ht, GetHandleId(t), 1, GetUnitX(caster))
        call SaveReal(udg_ht, GetHandleId(t), 2, GetUnitY(caster))
        call TimerStart(t, 0.2, true, function Trig_Kogasa04_Main)
    endif
    set caster = null
    set t = null
endfunction

function InitTrig_Kogasa04 takes nothing returns nothing
endfunction