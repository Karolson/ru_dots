function Trig_ReimuN01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer z = LoadInteger(udg_ht, task, 3)
    local integer tcnt = LoadInteger(udg_ht, task, 4)
    local real v = LoadReal(udg_ht, task, 5)
    local real h = LoadReal(udg_ht, task, 6)
    local real dx = LoadReal(udg_ht, task, 10)
    local real dy = LoadReal(udg_ht, task, 11)
    local real g = -1.2
    local real damage
    local real stun
    local real dis
    local group m = LoadGroupHandle(udg_ht, task, 12)
    local group g2
    local unit w
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local real dmgarea = LoadReal(udg_ht, task, 9)
    if i < z then
        set h = h + v
        call SetUnitFlyHeight(u, h, 2000)
        call SetUnitX(u, GetUnitX(u) + dx)
        call SetUnitY(u, GetUnitY(u) + dy)
        if h < 5.0 and v < 0 then
            set v = -0.75 * v
            set damage = LoadReal(udg_ht, task, 7)
            set stun = LoadReal(udg_ht, task, 8)
            set g2 = CreateGroup()
            call GroupEnumUnitsInRange(g2, GetUnitX(u), GetUnitY(u), LoadReal(udg_ht, task, 9), iff)
            loop
                set w = FirstOfGroup(g2)
            exitwhen w == null
                call GroupRemoveUnit(g2, w)
                if GetWidgetLife(w) > 0.405 and IsUnitType(w, UNIT_TYPE_STRUCTURE) == false and IsUnitInGroup(w, m) == false then
                    call GroupAddUnit(m, w)
                    call UnitMagicDamageTarget(caster, w, damage, 5)
                    call UnitStunTarget(caster, w, stun, 0, 0)
                endif
            endloop
            call DestroyGroup(g2)
            call SaveInteger(udg_ht, task, 4, tcnt + 1)
            if tcnt == 0 then
                set dis = SquareRoot(dx * dx + dy * dy) * 32
                call SaveReal(udg_ht, task, 10, dx * 150 / dis)
                call SaveReal(udg_ht, task, 11, dy * 150 / dis)
            endif
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(u), GetUnitY(u)))
        endif
        set v = v + g
        set i = i + 1
        call SaveInteger(udg_ht, task, 2, i)
        call SaveReal(udg_ht, task, 5, v)
        call SaveReal(udg_ht, task, 6, h)
    else
        call DestroyGroup(m)
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
    set iff = null
    set g2 = null
    set w = null
    set m = null
endfunction

function Trig_ReimuN01_Functioned takes unit caster, real tx, real ty, integer level, real damage, real stun, real dmgarea returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    local group g = CreateGroup()
    set u = CreateUnit(GetOwningPlayer(caster), 'n00S', GetUnitX(caster), GetUnitY(caster), 0.0)
    call SetUnitScale(u, 2.5 + 0.5 * level, 2.5 + 0.5 * level, 2.5 + 0.5 * level)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, 0)
    call SaveInteger(udg_ht, task, 3, R2I(2.3 * 50))
    call SaveInteger(udg_ht, task, 4, 0)
    call SaveReal(udg_ht, task, 5, 0)
    call SaveReal(udg_ht, task, 6, 600)
    call SaveReal(udg_ht, task, 7, damage)
    call SaveReal(udg_ht, task, 8, stun)
    call SaveReal(udg_ht, task, 9, dmgarea)
    call SaveReal(udg_ht, task, 10, (tx - GetUnitX(caster)) / 32)
    call SaveReal(udg_ht, task, 11, (ty - GetUnitY(caster)) / 32)
    call SaveGroupHandle(udg_ht, task, 12, g)
    call TimerStart(t, 0.02, true, function Trig_ReimuN01_Main)
    set t = null
    set u = null
    set g = null
endfunction

function Trig_ReimuN01_Conditions takes nothing returns boolean
    local unit caster
    local real tx
    local real ty
    local integer abid = GetSpellAbilityId()
    local integer level
    local real damagebase
    local real damageinc
    local real stun
    local real dmgarea
    local real damage
    if abid != 'A1G5' then
        return false
    endif
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    set caster = GetTriggerUnit()
    set level = GetUnitAbilityLevel(caster, abid)
    set damagebase = 50 + level * 70
    set damageinc = 0.2
    set stun = 0
    set dmgarea = 230.0
    set damage = ABCIAllInt(caster, damagebase, damageinc)
    call AbilityCoolDownResetion(caster, abid, 9.0)
    call Trig_ReimuN01_Functioned(caster, tx, ty, level, damage, stun, dmgarea)
    set caster = null
    return false
endfunction

function Trig_ReimuN01_Actions takes nothing returns nothing
endfunction

function InitTrig_ReimuN01 takes nothing returns nothing
    set gg_trg_ReimuN01 = CreateTrigger()
    call DisableTrigger(gg_trg_ReimuN01)
    call TriggerAddCondition(gg_trg_ReimuN01, Condition(function Trig_ReimuN01_Conditions))
    call TriggerAddAction(gg_trg_ReimuN01, function Trig_ReimuN01_Actions)
endfunction