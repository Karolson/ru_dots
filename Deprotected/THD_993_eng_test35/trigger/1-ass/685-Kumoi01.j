function KumoiAb01 takes nothing returns integer
    return 'A10C'
endfunction

function KumoiAb01_Buff takes nothing returns integer
    return 'B08S'
endfunction

function KumoiAb01_Unit takes nothing returns integer
    return 'e03I'
endfunction

function KumoiAb01_BaseMana takes nothing returns real
    return 65.0
endfunction

function KumoiAb01_BaseManaIncPerLevel takes nothing returns real
    return -5.0
endfunction

function KumoiAb01_BaseDamage takes nothing returns real
    return 10.0
endfunction

function KumoiAb01_BaseDamageIncPerLevel takes nothing returns real
    return 55.0
endfunction

function KumoiAb01_BaseDamageIncPerAttack takes nothing returns real
    return 1.0
endfunction

function KumoiAb01_BaseEffectArea takes nothing returns real
    return 100.0
endfunction

function KumoiAb01_BaseEffectAreaIncPerLevel takes nothing returns real
    return 25.0
endfunction

function KumoiAb01_BaseEffectAreaIncPerAttack takes nothing returns real
    return 1.3
endfunction

function KumoiAb01_CoolDown takes nothing returns integer
    local real k = 2.5
    set k = k * 100
    return R2I(k)
endfunction

function KumoiAb01_MoveSpeed takes nothing returns real
    return 750.0
endfunction

function KumoiAb01_MaxRange takes nothing returns real
    return 900.0
endfunction

function KumoiAb01_DropTime takes nothing returns real
    return 0.45
endfunction

function KumoiAb01_Size takes nothing returns real
    return 100.0
endfunction

function Trig_Kumoi01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10C'
endfunction

function Trig_Kumoi01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local real damagebase
    local real damageinc
    local real damageareabase
    local real damageareainc
    local real movespeed
    local real maxrange
    local real droptime = LoadReal(udg_ht, task, 9)
    local integer j = LoadInteger(udg_ht, task, 10)
    local integer i = LoadInteger(udg_ht, task, 11)
    local real ox
    local real oy
    local real px
    local real py
    local real a
    local real s
    local group g
    local unit v
    if GetUnitAbilityLevel(caster, 'B08S') > 0 and LoadInteger(udg_ht, StringHash("Stupids Utopia"), 0) == j and i == 0 then
        set damageareabase = LoadReal(udg_ht, task, 5)
        set damageareainc = LoadReal(udg_ht, task, 6)
        set movespeed = LoadReal(udg_ht, task, 7)
        set maxrange = LoadReal(udg_ht, task, 8)
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set a = GetUnitFacing(caster) * bj_DEGTORAD
        set px = ox + movespeed / 50 * Cos(a)
        set py = oy + movespeed / 50 * Sin(a)
        if px > GetUnitX(caster) + maxrange then
            set px = px - 4000
        elseif px < GetUnitX(caster) - maxrange then
            set px = px + 4000
        endif
        if py > GetUnitY(caster) + maxrange then
            set py = py - 4000
        elseif py < GetUnitY(caster) - maxrange then
            set py = py + 4000
        endif
        call SetUnitXY(u, px, py)
        set s = (damageareabase + damageareainc * GetUnitAttack(caster) * 0.5) / 100.0
        call SetUnitScale(u, s, s, s)
    elseif i < R2I(droptime * 50) then
        set i = i + 1
        set damageareabase = LoadReal(udg_ht, task, 5)
        set damageareainc = LoadReal(udg_ht, task, 6)
        set s = (damageareabase + damageareainc * GetUnitAttack(caster) * 0.5) / 100.0
        call SetUnitScale(u, s, s, s)
        call SetUnitFlyHeight(u, 300 * (1 - i * i / 2500 / droptime / droptime), 0)
        call SaveInteger(udg_ht, task, 11, i)
    elseif i == R2I(droptime * 50) then
        set i = i + 1
        set ox = GetUnitX(u)
        set oy = GetUnitY(u)
        set damagebase = LoadReal(udg_ht, task, 3)
        set damageinc = LoadReal(udg_ht, task, 4)
        set damageareabase = LoadReal(udg_ht, task, 5)
        set damageareainc = LoadReal(udg_ht, task, 6)
        set s = (damageareabase + damageareainc * GetUnitAttack(caster) * 0.5) / 100.0
        call SetUnitScale(u, s, s, s)
        call SetUnitFlyHeight(u, 0, 0)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(u), GetUnitY(u)))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, damageareabase + damageareainc * GetUnitAttack(caster), null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(caster)) and GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'Aloc') == 0 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, damagebase, damageinc), 5)
                else
                    call UnitMagicDamageTarget(caster, v, ABCIAllAtk(caster, damagebase, damageinc) * 0.33, 5)
                endif
            endif
        endloop
        call DestroyGroup(g)
        call SaveInteger(udg_ht, task, 11, i)
    elseif i < R2I(droptime * 50) + 15 then
        set i = i + 1
        call SetUnitVertexColor(u, 255, 255, 255, R2I(185 - 185 * (i - R2I(droptime * 50)) / 15))
        call SaveInteger(udg_ht, task, 11, i)
    else
        call KillUnit(u)
        call RemoveUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set v = null
endfunction

function Trig_Kumoi01_Creat takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local real damagebase
    local real damageinc
    local real damageareabase
    local real damageareainc
    local integer i
    local integer j = LoadInteger(udg_ht, task, 7)
    local real perpunchmana = LoadReal(udg_ht, task, 8)
    local real movespeed
    local real maxrange
    local real droptime
    local timer t2
    local integer task2
    local real ox
    local real oy
    local real a
    local unit u
    local real s
    if GetUnitAbilityLevel(caster, 'B08S') > 0 and LoadInteger(udg_ht, StringHash("Stupids Utopia"), 0) == j then
        set i = LoadInteger(udg_ht, task, 6)
        if KumoiAb01_CoolDown() == i then
            set i = -9999999
            if GetUnitState(caster, UNIT_STATE_MANA) > perpunchmana or true then
                set damagebase = LoadReal(udg_ht, task, 2)
                set damageinc = LoadReal(udg_ht, task, 3)
                set damageareabase = LoadReal(udg_ht, task, 4)
                set damageareainc = LoadReal(udg_ht, task, 5)
                set movespeed = LoadReal(udg_ht, task, 9)
                set maxrange = LoadReal(udg_ht, task, 10)
                set droptime = LoadReal(udg_ht, task, 11)
                if i != 0 and false then
                    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - perpunchmana)
                endif
                set t2 = CreateTimer()
                set task2 = GetHandleId(t2)
                set ox = GetUnitX(caster)
                set oy = GetUnitY(caster)
                set a = GetUnitFacing(caster) * bj_DEGTORAD
                set u = CreateUnit(GetOwningPlayer(caster), 'e03I', ox, oy, a * bj_RADTODEG)
                set s = (damageareabase + damageareainc * GetUnitAttack(caster) * 0.5) / 100.0
                call SetUnitScale(u, s, s, s)
                call SetUnitVertexColor(u, 255, 255, 255, 185)
                call SetUnitPathing(u, false)
                call SetUnitFlyHeight(u, 300, 0)
                call SaveTimerHandle(udg_ht, task2, 0, t2)
                call SaveUnitHandle(udg_ht, task2, 1, caster)
                call SaveUnitHandle(udg_ht, task2, 2, u)
                call SaveReal(udg_ht, task2, 3, damagebase)
                call SaveReal(udg_ht, task2, 4, damageinc)
                call SaveReal(udg_ht, task2, 5, damageareabase)
                call SaveReal(udg_ht, task2, 6, damageareainc)
                call SaveReal(udg_ht, task2, 7, movespeed)
                call SaveReal(udg_ht, task2, 8, maxrange)
                call SaveReal(udg_ht, task2, 9, droptime)
                call SaveInteger(udg_ht, task2, 10, j)
                call SaveInteger(udg_ht, task2, 11, 0)
                call TimerStart(t2, 0.02, true, function Trig_Kumoi01_Main)
            endif
        else
        endif
        set i = i + 1
        call SaveInteger(udg_ht, task, 6, i)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set caster = null
    set t = null
    set t2 = null
endfunction

function Trig_Kumoi01_Functioned takes unit caster, integer level, real damagebase, real damageinc, real dmgareabase, real dmgareainc, real perpunchmana, real punchtime, real movespeed, real maxrange, real droptime returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer j = LoadInteger(udg_ht, StringHash("Stupids Utopia"), 0)
    set j = j + 1
    call SaveInteger(udg_ht, StringHash("Stupids Utopia"), 0, j)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveReal(udg_ht, task, 2, damagebase)
    call SaveReal(udg_ht, task, 3, damageinc)
    call SaveReal(udg_ht, task, 4, dmgareabase)
    call SaveReal(udg_ht, task, 5, dmgareainc)
    call SaveInteger(udg_ht, task, 6, KumoiAb01_CoolDown() - 10)
    call SaveInteger(udg_ht, task, 7, j)
    call SaveReal(udg_ht, task, 8, perpunchmana)
    call SaveReal(udg_ht, task, 9, movespeed)
    call SaveReal(udg_ht, task, 10, maxrange)
    call SaveReal(udg_ht, task, 11, droptime)
    call TimerStart(t, 0.01, true, function Trig_Kumoi01_Creat)
    set t = null
endfunction

function Trig_Kumoi01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer abid = GetSpellAbilityId()
    local integer level = GetUnitAbilityLevel(caster, abid)
    local real damagebase = 10.0 + level * 55.0
    local real damageinc = 1.0
    local real dmgareabase = 100.0 + level * 25.0
    local real dmgareainc = 1.3
    local real perpunchmana = 65.0 + level * -5.0
    local real punchtime = KumoiAb01_CoolDown()
    local real movespeed = 750.0
    local real maxrange = 900.0
    local real droptime = 0.45
    call Trig_Kumoi01_Functioned(caster, level, damagebase, damageinc, dmgareabase, dmgareainc, perpunchmana, punchtime, movespeed, maxrange, droptime)
    set caster = null
endfunction

function InitTrig_Kumoi01 takes nothing returns nothing
endfunction