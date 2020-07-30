function Trig_Meirin02_Conditions takes nothing returns boolean
    if GetSpellAbilityId() != 'A0GB' then
        return false
    endif
    call Trig_MeirinStar_Cast()
    return true
endfunction

function Trig_Meirin02_Target takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) < 0.405 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') > 0 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_ETHEREAL) then
        return false
    elseif GetCustomState(GetFilterUnit(), 5) != 0 then
        return false
    elseif GetCustomState(GetFilterUnit(), 1) != 0 then
        return false
    elseif IsUnitType(GetFilterUnit(), UNIT_TYPE_GIANT) then
        return false
    elseif GetUnitAbilityLevel(GetFilterUnit(), 'BOvc') >= 1 then
        return false
    endif
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_GROUND)
endfunction

function MeilingSkill2ActMain takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local real casterx = GetUnitX(u)
    local real castery = GetUnitY(u)
    local real ux
    local real uy
    local integer level = LoadInteger(udg_Hashtable, tid, 0)
    local integer count = LoadInteger(udg_Hashtable, tid, 2)
    local integer countmax = LoadInteger(udg_Hashtable, tid, 3)
    local real movedistance = LoadReal(udg_Hashtable, tid, 4)
    local real angle = LoadReal(udg_Hashtable, tid, 5)
    local real angle2
    local group g = LoadGroupHandle(udg_Hashtable, tid, 6)
    local group effg
    local boolexpr f
    local unit tempu
    local real tempux
    local real tempuy
    local unit target = LoadUnitHandle(udg_Hashtable, tid, 7)
    local real targetx = GetUnitX(target)
    local real targety = GetUnitY(target)
    local boolean flag
    local real originx = LoadReal(udg_Hashtable, tid, 9)
    local real originy = LoadReal(udg_Hashtable, tid, 10)
    if count > countmax or GetUnitState(u, UNIT_STATE_LIFE) <= 0 then
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyEffect(LoadEffectHandle(udg_Hashtable, tid, 6))
        call FlushChildHashtable(udg_Hashtable, tid)
        call SetUnitFlag(u, 5, false)
        if target != null then
            call SetUnitFlag(target, 5, false)
            call SetUnitFlag(target, 3, false)
        endif
        set t = null
        set u = null
        set g = null
        set f = null
        set effg = null
        set tempu = null
        set target = null
        return
    endif
    set ux = casterx + movedistance * Cos(angle)
    set uy = castery + movedistance * Sin(angle)
    set flag = SetUnitXYGround(u, ux, uy)
    if flag == false then
        call SetUnitX(u, casterx)
        call SetUnitY(u, castery)
    endif
    if target != null and IsMobileUnit(target) and GetUnitTypeId(target) == 'n006' == false then
        set targetx = GetUnitX(target)
        set targety = GetUnitY(target)
        if (targetx - casterx) * (targetx - casterx) + (targety - castery) * (targety - castery) <= 100 * 100 then
            if IsUnitInGroup(target, g) == false then
                call UnitPhysicalDamageTarget(u, target, 100 + 50 * level)
                call GroupAddUnit(g, target)
                call SetUnitFlag(target, 5, true)
                call SetUnitFlag(target, 3, true)
            endif
            set targetx = ux + 100 * Cos(angle)
            set targety = uy + 100 * Sin(angle)
            set flag = SetUnitXYGround(target, targetx, targety)
            if flag == false then
                call SetUnitX(target, ux)
                call SetUnitY(target, uy)
            endif
        endif
    endif
    set f = Filter(function Trig_Meirin02_Target)
    set effg = CreateGroup()
    call GroupEnumUnitsInRange(effg, casterx, castery, 150, f)
    call GroupRemoveUnit(effg, u)
    loop
        set tempu = FirstOfGroup(effg)
    exitwhen tempu == null
        call GroupRemoveUnit(effg, tempu)
        if IsUnitInGroup(tempu, g) == false and IsUnitEnemy(tempu, GetOwningPlayer(u)) and IsMobileUnit(tempu) then
            call GroupAddUnit(g, tempu)
            call UnitDamageTarget(u, tempu, 110 + 40 * level, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            set tempux = GetUnitX(tempu)
            set tempuy = GetUnitY(tempu)
            set angle2 = Atan2(tempuy - originy, tempux - originx)
            if angle2 >= angle then
                call MeilingPushUnit(tempu, 100, angle + 3.1415926 / 2)
            endif
            if angle2 < angle then
                call MeilingPushUnit(tempu, 100, angle - 3.1415926 / 2)
            endif
        endif
    endloop
    call SaveInteger(udg_Hashtable, tid, 2, count + 1)
    call DestroyGroup(effg)
    call DestroyBoolExpr(f)
    set t = null
    set u = null
    set g = null
    set f = null
    set effg = null
    set tempu = null
    set target = null
endfunction

function Trig_Meirin02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real casterx = GetUnitX(caster)
    local real castery = GetUnitY(caster)
    local unit target = GetSpellTargetUnit()
    local real locx
    local real locy
    local timer t
    local integer tid
    local real angle
    local integer level = GetUnitAbilityLevel(caster, 'A0GB')
    local real distance = 350.0 + 50.0 * level
    local group g
    local location targetloc
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 21 - 3 * level)
    if GetUnitAbilityLevel(caster, 'A0V4') == 1 or GetUnitAbilityLevel(caster, 'A0A1') == 1 then
        set caster = null
        set t = null
        set g = null
        set target = null
        set targetloc = null
        return
    endif
    set t = CreateTimer()
    set tid = GetHandleId(t)
    set g = CreateGroup()
    set targetloc = GetSpellTargetLoc()
    if IsUnitAlly(target, GetOwningPlayer(caster)) then
        set target = null
    endif
    if target == null then
        set locx = GetLocationX(targetloc)
        set locy = GetLocationY(targetloc)
    endif
    if target != null then
        set locx = GetUnitX(target)
        set locy = GetUnitY(target)
    endif
    set angle = Atan2(locy - castery, locx - casterx)
    call MeilingSkillsAnime(caster, "spell channel", 0.6)
    call SetUnitFlag(caster, 5, true)
    call TimerStart(t, 0.03, true, function MeilingSkill2ActMain)
    call SaveUnitHandle(udg_Hashtable, tid, 1, caster)
    call SaveInteger(udg_Hashtable, tid, 0, level)
    call SaveInteger(udg_Hashtable, tid, 2, 0)
    call SaveInteger(udg_Hashtable, tid, 3, 20)
    call SaveReal(udg_Hashtable, tid, 4, distance / 20.0)
    call SaveReal(udg_Hashtable, tid, 5, angle)
    call SaveGroupHandle(udg_Hashtable, tid, 6, g)
    call SaveUnitHandle(udg_Hashtable, tid, 7, target)
    call SaveReal(udg_Hashtable, tid, 9, casterx)
    call SaveReal(udg_Hashtable, tid, 10, castery)
    call RemoveLocation(targetloc)
    set caster = null
    set t = null
    set g = null
    set target = null
    set targetloc = null
endfunction

function InitTrig_Meirin02 takes nothing returns nothing
endfunction