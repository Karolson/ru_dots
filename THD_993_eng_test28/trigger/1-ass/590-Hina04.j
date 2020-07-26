function HINA04 takes nothing returns integer
    return 'A0E9'
endfunction

function Trig_Hina04_Target takes nothing returns boolean
    local unit u = GetFilterUnit()
    if GetWidgetLife(u) < 0.405 then
        set u = null
        return false
    elseif IsUnitType(u, UNIT_TYPE_STRUCTURE) then
        set u = null
        return false
    elseif GetUnitAbilityLevel(u, 'Aloc') != 0 then
        set u = null
        return false
    elseif GetUnitAbilityLevel(u, 'A0IL') > 0 then
        set u = null
        return false
    endif
    set u = null
    return true
endfunction

function Hina04_Act_Main_End takes unit caster, integer level, real damage returns nothing
    local unit u
    local unit v
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local player w = GetOwningPlayer(caster)
    local group g = CreateGroup()
    local filterfunc f
    local integer i
    set u = NewDummy(w, ox, oy, 0.0)
    if GetUnitAbilityLevel(caster, 'BPSE') <= 0 then
        call UnitStunTarget(caster, caster, 3, 0, 0)
        call SetUnitAnimation(caster, "Spell Channel")
    endif
    call UnitAddAbility(u, 'A0EB')
    set i = 1
    loop
    exitwhen i > 12
        set px = ox + 100.0 * Cos(i * 0.52362)
        set py = oy + 100.0 * Sin(i * 0.52362)
        call IssuePointOrder(u, "carrionswarm", px, py)
        set i = i + 1
    endloop
    call UnitRemoveAbility(u, 'A0EB')
    call ReleaseDummy(u)
    set f = Filter(function Trig_Hina04_Target)
    call GroupEnumUnitsInRange(g, ox, oy, 650.0, f)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, w) then
            call UnitAbsDamageTarget(caster, v, damage)
            call UnitStunTarget(caster, v, 1 + level * 0.5, 0, 0)
        endif
    endloop
    call DestroyGroup(g)
    call DestroyFilter(f)
    set w = null
    set u = null
    set v = null
    set g = null
    set f = null
endfunction

function Hina04_UnitDamaged takes nothing returns nothing
    local trigger tr = GetTriggeringTrigger()
    local integer task_tr = GetHandleId(tr)
    local unit damaged = GetTriggerUnit()
    local unit caster = LoadUnitHandle(udg_Hashtable, task_tr, 1)
    local timer t = LoadTimerHandle(udg_Hashtable, task_tr, 2)
    local integer task_t = GetHandleId(t)
    local real damage = LoadReal(udg_Hashtable, task_t, 4)
    local integer level = LoadInteger(udg_Hashtable, task_t, 5)
    local group triggeredgroup = LoadGroupHandle(udg_Hashtable, task_t, 6)
    if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
        set damaged = GetTriggerUnit()
        set damage = damage + GetEventDamage() * 0.3
        call SaveReal(udg_Hashtable, task_t, 4, damage)
    else
        set damaged = LoadUnitHandle(udg_Hashtable, task_tr, 3)
        if not IsUnitInRange(damaged, caster, 650.0) then
            call GroupRemoveUnit(triggeredgroup, damaged)
            call SaveGroupHandle(udg_Hashtable, task_t, 6, triggeredgroup)
            call FlushChildHashtable(udg_Hashtable, task_tr)
            call RemoveSavedHandle(udg_Hashtable, task_t, GetHandleId(damaged))
            call TriggerClearActions(tr)
            call DestroyTrigger(tr)
        endif
    endif
    set tr = null
    set damaged = null
    set caster = null
    set t = null
    set triggeredgroup = null
endfunction

function Hina04_Clear takes nothing returns nothing
    local unit target = GetEnumUnit()
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local trigger trg = LoadTriggerHandle(udg_Hashtable, task, GetHandleId(target))
    call DestroyTrigger(trg)
    call FlushChildHashtable(udg_Hashtable, GetHandleId(trg))
    set target = null
    set trg = null
    set t = null
endfunction

function Hina04_Act_Main takes nothing returns nothing
    local timer main_t = GetExpiredTimer()
    local integer task = GetHandleId(main_t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx
    local real ty
    local real angle
    local integer l__skilltime = LoadInteger(udg_Hashtable, task, 2)
    local integer count = LoadInteger(udg_Hashtable, task, 3)
    local real damage = LoadReal(udg_Hashtable, task, 4)
    local integer level = LoadInteger(udg_Hashtable, task, 5)
    local group triggeredgroup = LoadGroupHandle(udg_Hashtable, task, 6)
    local player castplayer = GetOwningPlayer(caster)
    local group g = CreateGroup()
    local filterfunc f
    local unit target
    local unit helper
    local trigger tr
    local integer task_tr
    if count > l__skilltime or IsUnitType(caster, UNIT_TYPE_DEAD) then
        call DestroyEffect(LoadEffectHandle(udg_Hashtable, task, 7))
        call SetUnitTimeScale(caster, 1.0)
        if GetWidgetLife(caster) > 0.405 then
            call IssueImmediateOrder(caster, "phaseshiftoff")
        else
            set ox = LoadReal(udg_Hashtable, task, 2)
            set oy = LoadReal(udg_Hashtable, task, 3)
        endif
        call AddUnitAnimationProperties(caster, "Spin", false)
        call Hina04_Act_Main_End(caster, level, damage)
        call ForGroup(triggeredgroup, function Hina04_Clear)
        call DebugMsg("Hina04 End")
        call DestroyGroup(triggeredgroup)
        call DestroyGroup(g)
        call ReleaseTimer(main_t)
        set main_t = null
        set caster = null
        set castplayer = null
        set g = null
        set target = null
        set tr = null
        set triggeredgroup = null
        set helper = null
        set f = null
        return
    endif
    call SaveReal(udg_Hashtable, task, 2, ox)
    call SaveReal(udg_Hashtable, task, 3, oy)
    set f = Filter(function Trig_Hina04_Target)
    call GroupEnumUnitsInRangeOfLoc(g, GetUnitLoc(caster), 650.0, f)
    loop
        set target = FirstOfGroup(g)
    exitwhen target == null
        if IsUnitAlly(target, castplayer) then
            if not IsUnitInGroup(target, triggeredgroup) then
                set tr = CreateTrigger()
                set task_tr = GetHandleId(tr)
                call TriggerRegisterUnitEvent(tr, target, EVENT_UNIT_DAMAGED)
                call TriggerRegisterTimerEvent(tr, 0.03, true)
                call TriggerAddAction(tr, function Hina04_UnitDamaged)
                call SaveUnitHandle(udg_Hashtable, task_tr, 1, caster)
                call SaveTimerHandle(udg_Hashtable, task_tr, 2, main_t)
                call SaveUnitHandle(udg_Hashtable, task_tr, 3, target)
                call SaveTriggerHandle(udg_Hashtable, task, GetHandleId(target), tr)
                call GroupAddUnit(triggeredgroup, target)
            endif
        elseif IsMobileUnit(target) and GetCustomState(target, 7) != 0 == false and GetUnitTypeId(target) != 'U00M' then
            set tx = GetUnitX(target)
            set ty = GetUnitY(target)
            set angle = Atan2(oy - ty, ox - tx)
            if not IsUnitInRange(caster, target, 3.0) then
                set tx = tx + (40 + 35 * level) * 0.03 * Cos(angle)
                set ty = ty + (40 + 35 * level) * 0.03 * Sin(angle)
                call SetUnitXYGround(target, tx, ty)
            endif
        endif
        call GroupRemoveUnit(g, target)
    endloop
    call DestroyGroup(g)
    call DestroyFilter(f)
    call SaveReal(udg_Hashtable, task, 4, damage)
    call SaveInteger(udg_Hashtable, task, 3, count + 1)
    call SaveGroupHandle(udg_Hashtable, task, 6, triggeredgroup)
    set main_t = null
    set caster = null
    set castplayer = null
    set g = null
    set f = null
    set target = null
    set tr = null
    set triggeredgroup = null
    set helper = null
endfunction

function Hina04_Act takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local timer efft = CreateTimer()
    local integer efftid = GetHandleId(efft)
    local group g = CreateGroup()
    local unit helper
    local real unitX = GetUnitX(caster)
    local real unitY = GetUnitY(caster)
    local effect spelleff = AddSpecialEffectTarget("Abilities\\Spells\\Items\\VampiricPotion\\VampPotionCaster.mdl", caster, "origin")
    call AbilityCoolDownResetion(caster, 'A0E9', 180)
    call SetUnitTimeScale(caster, 15.0)
    call TimerStart(t, 0.03, true, function Hina04_Act_Main)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveInteger(udg_Hashtable, task, 2, 233)
    call SaveInteger(udg_Hashtable, task, 3, 0)
    call SaveReal(udg_Hashtable, task, 2, unitX)
    call SaveReal(udg_Hashtable, task, 3, unitY)
    call SaveReal(udg_Hashtable, task, 4, 0)
    call SaveInteger(udg_Hashtable, task, 5, GetUnitAbilityLevel(caster, 'A0E9'))
    call SaveGroupHandle(udg_Hashtable, task, 6, g)
    call SaveEffectHandle(udg_Hashtable, task, 7, spelleff)
    call AddUnitAnimationProperties(caster, "Spin", true)
    if GetUnitAbilityLevel(caster, 'A0EY') == 0 then
        call UnitAddAbility(caster, 'A0EY')
    endif
    set efft = null
    set spelleff = null
    set caster = null
    set helper = null
    set t = null
    set g = null
endfunction

function UpperInt takes integer i returns integer
    if i / 100 * 100 == i then
        return i / 100
    else
        return i / 100 + 1
    endif
endfunction

function Trig_Hina04_Main_New takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local real damage = LoadReal(udg_Hashtable, task, 2)
    local integer i = LoadInteger(udg_Hashtable, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx
    local real ty
    local real a
    local real dis
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local unit v
    if i > 0 and GetWidgetLife(caster) >= 0.405 then
        call SaveInteger(udg_Hashtable, task, 3, i - 1)
        if R2I(i / 5) * 5 == i then
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, ox, oy, 500.0, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                set tx = GetUnitX(v)
                set ty = GetUnitY(v)
                set dis = SquareRoot((tx - ox) * (tx - ox) + (ty - oy) * (ty - oy))
                if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                    call UnitMagicDamageTarget(caster, v, damage * 0.1 * (3.5 - UpperInt(R2I(dis)) * 0.5), 6)
                endif
            endloop
            call DestroyGroup(g)
        endif
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 500.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            set tx = GetUnitX(v)
            set ty = GetUnitY(v)
            set a = Atan2(ty - oy, tx - ox)
            set dis = SquareRoot((tx - ox) * (tx - ox) + (ty - oy) * (ty - oy))
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                set dis = dis - (1.0 + GetUnitAbilityLevel(caster, 'A0E9') * 1.0)
                if dis > 30 then
                    call SetUnitXYGround(v, ox + dis * Cos(a), oy + dis * Sin(a))
                endif
            endif
        endloop
        call DestroyGroup(g)
    else
        call SetUnitPathing(caster, true)
        call DestroyEffect(LoadEffectHandle(udg_ht, task, 4))
        call AddUnitAnimationProperties(caster, "Spin", false)
        call UnitRemoveAbility(caster, 'A0EY')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set caster = null
    set g = null
    set iff = null
    set v = null
endfunction

function Trig_Hina04_Actions_New takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A0E9')
    local effect e = AddSpecialEffectTarget("Abilities\\Spells\\Items\\VampiricPotion\\VampPotionCaster.mdl", caster, "origin")
    call SaveTimerHandle(udg_Hashtable, task, 0, t)
    call SaveUnitHandle(udg_Hashtable, task, 1, caster)
    call SaveReal(udg_Hashtable, task, 2, 20 * level + GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.022)
    call SaveInteger(udg_Hashtable, task, 3, 175 + 25 * level)
    call SaveEffectHandle(udg_ht, task, 4, e)
    call TimerStart(t, 0.02, true, function Trig_Hina04_Main_New)
    call AddUnitAnimationProperties(caster, "Spin", true)
    call VE_Spellcast(caster)
    call SetUnitPathing(caster, false)
    if GetUnitAbilityLevel(caster, 'A0EY') == 0 then
        call UnitAddAbility(caster, 'A0EY')
    endif
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Hina04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() == 'A0E9' then
        call Hina04_Act()
    endif
    return false
endfunction

function InitTrig_Hina04 takes nothing returns nothing
endfunction