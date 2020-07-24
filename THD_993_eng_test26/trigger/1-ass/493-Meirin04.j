function Trig_Meirin04_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0GD' then
        return false
    endif
    call Trig_MeirinStar_Cast()
    return true
endfunction

function Trig_Meirin04_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 0)
    local integer k = LoadInteger(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer r
    local integer g
    local integer b
    if i < 12 then
        if k == 1 then
            set ox = ox + 200.0 * Cos(a * 0.017454)
            set oy = oy + 200.0 * Sin(a * 0.017454)
            set px = ox + 150.0 * Cos((a + 180.0 + 30.0 * i) * 0.017454)
            set py = oy + 150.0 * Sin((a + 180.0 + 30.0 * i) * 0.017454)
            set u = CreateUnit(GetOwningPlayer(caster), 'n03E', px, py, a)
            call SetUnitAnimation(u, "birth")
            call UnitApplyTimedLife(u, 'BTLF', 0.7)
            set r = udg_SK_Meirin_RGB[i * 3]
            set g = udg_SK_Meirin_RGB[i * 3 + 1]
            set b = udg_SK_Meirin_RGB[i * 3 + 2]
            call SetUnitVertexColor(u, r, g, b, 255)
        elseif k == 2 then
            set px = ox + 250.0 * Cos((a + 5.0 + 10.0 * (i - 6)) * 0.017454)
            set py = oy + 250.0 * Sin((a + 5.0 + 10.0 * (i - 6)) * 0.017454)
            set u = CreateUnit(GetOwningPlayer(caster), 'n03E', px, py, a)
            call UnitApplyTimedLife(u, 'BTLF', 0.7)
            set r = udg_SK_Meirin_RGB[i * 3]
            set g = udg_SK_Meirin_RGB[i * 3 + 1]
            set b = udg_SK_Meirin_RGB[i * 3 + 2]
            call SetUnitVertexColor(u, r, g, b, 255)
            call SetUnitAnimation(u, "birth")
        elseif k == 3 then
            set px = ox + i * 40.0 * Cos(a * 0.017454)
            set py = oy + i * 40.0 * Sin(a * 0.017454)
            set u = CreateUnit(GetOwningPlayer(caster), 'n03E', px, py, a)
            call SetUnitAnimation(u, "birth")
            call UnitApplyTimedLife(u, 'BTLF', 0.7)
            set r = udg_SK_Meirin_RGB[i * 3]
            set g = udg_SK_Meirin_RGB[i * 3 + 1]
            set b = udg_SK_Meirin_RGB[i * 3 + 2]
            call SetUnitVertexColor(u, r, g, b, 255)
        endif
        call SaveInteger(udg_ht, task, 1, i + 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
endfunction

function Trig_Meirin04_Effect takes unit caster, integer k, real a returns nothing
    local unit u
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 0, k)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 0, a * bj_RADTODEG)
    call TimerStart(t, 0.03, true, function Trig_Meirin04_Effect_Main)
    set u = null
    set t = null
endfunction

function MeilingSkill4ActMain takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, tid, 0)
    local integer level = LoadInteger(udg_Hashtable, tid, 0)
    local integer count = LoadInteger(udg_Hashtable, tid, 1)
    local unit helper
    local real angle = LoadReal(udg_Hashtable, tid, 0)
    local real castx = GetUnitX(caster) + 200 * Cos(angle)
    local real casty = GetUnitY(caster) + 200 * Sin(angle)
    local boolean k = not (IsUnitMorphed(caster) or GetCustomState(caster, 1) != 0 or GetCustomState(caster, 6) != 0)
    local trigger tr = LoadTriggerHandle(udg_Hashtable, tid, 4)
    set k = k and GetUnitCurrentOrder(caster) == OrderId("clusterrockets")
    call SetUnitFacing(caster, angle * bj_RADTODEG)
    if count == 2 and GetWidgetLife(caster) > 0.405 and k then
        call MeilingSkillsAnime(caster, "spell second", 1.0)
        call MeilingPushUnit(caster, 50, GetUnitFacing(caster) / 180 * 3.1415926)
    endif
    if count == 5 and GetWidgetLife(caster) > 0.405 and k then
        call MeilingSkillsAnime(caster, "spell third", 1.0)
        call MeilingPushUnit(caster, 50, GetUnitFacing(caster) / 180 * 3.1415926)
    endif
    if count == 3 and GetWidgetLife(caster) > 0.405 and k then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
        call UnitStunArea(caster, 0.75, castx, casty, 525, 0, 0)
        call UnitPhysicalDamageArea(caster, castx, casty, 525, 60 + 60 * level)
        call Trig_Meirin04_Effect(caster, 2, angle)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
    endif
    if count == 6 and GetWidgetLife(caster) > 0.405 and k then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
        call UnitStunArea(caster, 1.2 + 0.3 * level, castx, casty, 525, 0, 0)
        call UnitPhysicalDamageArea(caster, castx, casty, 525, 80 + 80 * level)
        call Trig_Meirin04_Effect(caster, 3, angle)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
    endif
    if count == 6 or GetWidgetLife(caster) <= 0.405 or not k then
        call UnitRemoveAbility(caster, 'A0AN')
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, tid)
    endif
    if count != 6 then
        call SaveInteger(udg_Hashtable, tid, 1, count + 1)
    endif
    set helper = null
    set caster = null
    set t = null
endfunction

function MeilingSkill4PushUnit takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_Hashtable, tid, 0)
    local integer count = LoadInteger(udg_Hashtable, tid, 1)
    local boolexpr f
    local group effg
    local unit u
    local real ux
    local real uy
    local real casterx
    local real castery
    if count > 6 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, tid)
        set t = null
        set f = null
        set caster = null
        set effg = null
        set u = null
    endif
    set casterx = GetUnitX(caster)
    set castery = GetUnitY(caster)
    set effg = CreateGroup()
    set f = Filter(function Trig_Meirin02_Target)
    call GroupEnumUnitsInRange(effg, GetUnitX(caster), GetUnitY(caster), 100, f)
    call DestroyBoolExpr(f)
    call GroupRemoveUnit(effg, caster)
    loop
        set u = FirstOfGroup(effg)
    exitwhen u == null
        if IsMobileUnit(u) then
            set ux = GetUnitX(u)
            set uy = GetUnitY(u)
            call MeilingPushUnit(u, 50, Atan2(uy - castery, ux - casterx))
        endif
        call GroupRemoveUnit(effg, u)
    endloop
    call SaveInteger(udg_Hashtable, tid, 1, count + 1)
    call DestroyGroup(effg)
    set t = null
    set caster = null
    set effg = null
    set f = null
    set u = null
endfunction

function Trig_Meirin04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local timer t = CreateTimer()
    local integer tid = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer t2id = GetHandleId(t2)
    local integer level = GetUnitAbilityLevel(caster, 'A0GD')
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real castx = GetUnitX(caster) + 200 * Cos(a)
    local real casty = GetUnitY(caster) + 200 * Sin(a)
    local unit helper
    call AbilityCoolDownResetion(caster, 'A0GD', 150 - 20 * level)
    call VE_Spellcast(caster)
    call SaveReal(udg_Hashtable, tid, 0, a)
    call SaveUnitHandle(udg_Hashtable, tid, 0, caster)
    call SaveInteger(udg_Hashtable, tid, 0, level)
    call SaveInteger(udg_Hashtable, tid, 1, 0)
    if GetWidgetLife(caster) > 0.405 then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
        set helper = CreateUnit(GetOwningPlayer(caster), 'o000', castx, casty, 0)
        call UnitAddAbility(helper, 'A0G7')
        call SetUnitAbilityLevel(helper, 'A0G7', level)
        call UnitApplyTimedLife(helper, 'BTLF', 2)
        call IssueImmediateOrder(helper, "thunderclap")
        call UnitSlowTargetArea(caster, castx, casty, 550, 6.0, 'A11T', 'B06K')
        call UnitPhysicalDamageArea(caster, castx, casty, 550, 40 + 40 * level)
        call Trig_Meirin04_Effect(caster, 1, a)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", castx, casty))
    endif
    call TimerStart(t, 0.5, true, function MeilingSkill4ActMain)
    call SaveUnitHandle(udg_Hashtable, t2id, 0, caster)
    call SaveInteger(udg_Hashtable, t2id, 1, 1)
    call TimerStart(t2, 0.33, true, function MeilingSkill4PushUnit)
    call UnitAddAbility(caster, 'A0AN')
    set caster = null
    set t = null
    set t2 = null
endfunction

function InitTrig_Meirin04 takes nothing returns nothing
endfunction