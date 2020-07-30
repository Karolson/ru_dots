function YUKARI04_SKILL1 takes nothing returns integer
    return 'A0IY'
endfunction

function YUKARI04_SKILL2 takes nothing returns integer
    return 'A0JH'
endfunction

function YUKARI04_PORTAL takes nothing returns integer
    return 'n04V'
endfunction

function YUKARI04_COOLDOWN_BASE takes nothing returns real
    return 120.0
endfunction

function YUKARI04_COOLDOWN_SCALE takes nothing returns real
    return -20.0
endfunction

function YUKARI04_WAIT_TIME takes nothing returns real
    return 0.3
endfunction

function YUKARI04_GATEWAY_DURATION takes nothing returns real
    return 7.0
endfunction

function YUKARI04_TRAIN takes nothing returns integer
    return 'e02W'
endfunction

function YUKARI04_TRAIN_LEAD_CARRIAGE takes nothing returns integer
    return 'e02V'
endfunction

function YUKARI04_TRAIN_NUMBER_OF_CARRIAGES takes nothing returns integer
    return 5
endfunction

function YUKARI04_TIMER_RATE takes nothing returns real
    return 0.03125
endfunction

function YUKARI04_TRAIN_DELAY takes nothing returns real
    return 1.0
endfunction

function YUKARI04_TRAIN_SPEED takes nothing returns real
    return 800.0
endfunction

function YUKARI04_TRAIN_COLLISION_RADIUS takes nothing returns real
    return 200.0
endfunction

function YUKARI04_KNOCKBACK_DISTANCE takes nothing returns real
    return 300.0
endfunction

function YUKARI04_KNOCKBACK_SPEED takes nothing returns real
    return 800.0
endfunction

function YUKARI04_EXPLOSION_RADIUS takes nothing returns real
    return 400.0
endfunction

function YUKARI04_EXPLOSION_DAMAGE_FACTOR takes nothing returns real
    return 0.6
endfunction

function YUKARI04_EXPLOSION_EFFECT takes nothing returns string
    return "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl"
endfunction

function YUKARI04_COLLISION_DAMAGE_BASE takes nothing returns real
    return 150.0
endfunction

function YUKARI04_COLLISION_DAMAGE_SCALE takes nothing returns real
    return 125.0
endfunction

function YUKARI04_COLLISION_DAMAGE_SCALE_FACTOR takes nothing returns real
    return 2.2
endfunction

function Trig_Yukari04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0IY' or GetSpellAbilityId() == 'A0JH'
endfunction

function Trig_Yukari04_Train_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    if IsUnitEnemy(u, bj_groupEnumOwningPlayer) and GetWidgetLife(u) > 0.405 and GetUnitAbilityLevel(u, 'Aloc') == 0 and not (GetUnitAbilityLevel(u, 'A0IL') > 0) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_ANCIENT) then
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Trig_Yukari04_Move_Carriage takes nothing returns nothing
    local unit carriage = GetEnumUnit()
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local real cx = GetUnitX(carriage)
    local real cy = GetUnitY(carriage)
    local real dx
    local real dy
    local real a
    local group g = LoadGroupHandle(udg_sht, task, 13)
    local real damage = LoadReal(udg_sht, task, 14)
    local boolexpr f = LoadBooleanExprHandle(udg_sht, task, 22)
    local unit v
    local unit firstcarriage
    local player p = GetOwningPlayer(caster)
    if IsUnitInGroup(carriage, LoadGroupHandle(udg_sht, task, 16)) then
        set firstcarriage = LoadUnitHandle(udg_sht, task, 19)
    elseif IsUnitInGroup(carriage, LoadGroupHandle(udg_sht, task, 17)) then
        set firstcarriage = LoadUnitHandle(udg_sht, task, 18)
    endif
    set a = Atan2(cy - GetUnitY(firstcarriage), cx - GetUnitX(firstcarriage)) - 3.14159
    call SetUnitFacing(carriage, a * 57.29578)
    set dx = 800.0 * 0.03125 * Cos(a)
    set dy = 800.0 * 0.03125 * Sin(a)
    set cx = cx + dx
    set cy = cy + dy
    if GetRectMinX(bj_mapInitialPlayableArea) <= cx and cx <= GetRectMaxX(bj_mapInitialPlayableArea) then
        call SetUnitX(carriage, cx)
    else
        call KillUnit(carriage)
    endif
    if GetRectMinY(bj_mapInitialPlayableArea) <= cy and cy <= GetRectMaxY(bj_mapInitialPlayableArea) then
        call SetUnitY(carriage, cy)
    else
        call KillUnit(carriage)
    endif
    call GroupEnumUnitsInRange(g, cx, cy, 200.0, null)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitEnemy(v, p) and GetWidgetLife(v) > 0.405 and GetUnitAbilityLevel(v, 'Aloc') == 0 and not (GetUnitAbilityLevel(v, 'A0IL') > 0) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and not IsUnitType(v, UNIT_TYPE_ANCIENT) then
            if not HaveSavedBoolean(udg_sht, StringHash("Yukari04Hit"), GetHandleId(v)) or not LoadBoolean(udg_sht, StringHash("Yukari04Hit"), GetHandleId(v)) then
                call SaveBoolean(udg_sht, StringHash("Yukari04Hit"), GetHandleId(v), true)
                call UnitMagicDamageTarget(caster, v, damage, 5)
                if not IsUnitType(v, UNIT_TYPE_ANCIENT) then
                    call Knockback(carriage, v, 300.0, 800.0, Atan2(GetUnitY(v) - cy, GetUnitX(v) - cx), "Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", true, false, false, true)
                endif
            endif
        endif
    endloop
    call GroupClear(g)
    set carriage = null
    set t = null
    set caster = null
    set g = null
    set f = null
    set v = null
    set firstcarriage = null
endfunction

function Trig_Yukari04_Destroy_Carriage takes nothing returns nothing
    local unit u = GetEnumUnit()
    local effect e = AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", GetUnitX(u), GetUnitY(u))
    call SetUnitFacing(u, GetUnitFacing(u) + GetRandomReal(-20.0, 20.0))
    call DestroyEffect(e)
    call KillUnit(u)
    set e = null
    set u = null
endfunction

function Trig_Yukari04_Train_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit portal1 = LoadUnitHandle(udg_sht, task, 1)
    local unit portal2 = LoadUnitHandle(udg_sht, task, 2)
    local real x1 = LoadReal(udg_sht, task, 3)
    local real y1 = LoadReal(udg_sht, task, 4)
    local real a1 = LoadReal(udg_sht, task, 5)
    local real x2 = LoadReal(udg_sht, task, 6)
    local real y2 = LoadReal(udg_sht, task, 7)
    local real a2 = LoadReal(udg_sht, task, 8)
    local player p = GetOwningPlayer(caster)
    local group g = LoadGroupHandle(udg_sht, task, 13)
    local real damage = LoadReal(udg_sht, task, 14)
    local integer i = LoadInteger(udg_sht, task, 15)
    local group traina = LoadGroupHandle(udg_sht, task, 16)
    local group trainb = LoadGroupHandle(udg_sht, task, 17)
    local unit atrain1 = LoadUnitHandle(udg_sht, task, 18)
    local unit btrain1 = LoadUnitHandle(udg_sht, task, 19)
    local unit v
    local boolexpr f
    call ForGroup(traina, function Trig_Yukari04_Move_Carriage)
    call ForGroup(trainb, function Trig_Yukari04_Move_Carriage)
    if i < 5 then
        if not IsUnitInRangeXY(atrain1, x1, y1, 350 * i) then
            set v = CreateUnit(Player(15), 'e02W', x1, y1, a1)
            call GroupAddUnit(traina, v)
            set v = CreateUnit(Player(15), 'e02W', x2, y2, a2)
            call GroupAddUnit(trainb, v)
            set i = i + 1
            call SaveInteger(udg_sht, task, 15, i)
        endif
    elseif GetWidgetLife(portal1) > 0.405 then
        call KillUnit(portal1)
        call KillUnit(portal2)
    endif
    if IsUnitInRange(atrain1, btrain1, 75) then
        call ForGroup(traina, function Trig_Yukari04_Destroy_Carriage)
        call ForGroup(trainb, function Trig_Yukari04_Destroy_Carriage)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", 0.5 * (GetUnitX(atrain1) + GetUnitX(btrain1)), 0.5 * (GetUnitY(atrain1) + GetUnitY(btrain1))))
        call UnitMagicDamageArea(caster, 0.5 * (GetUnitX(atrain1) + GetUnitX(btrain1)), 0.5 * (GetUnitY(atrain1) + GetUnitY(btrain1)), 400.0, damage * 0.6, 5)
        call KillUnit(portal1)
        call KillUnit(portal2)
        set f = LoadBooleanExprHandle(udg_sht, task, 22)
        call DestroyBoolExpr(f)
        call ReleaseTimer(t)
        call DestroyGroup(g)
        call DestroyGroup(traina)
        call DestroyGroup(trainb)
        call FlushChildHashtable(udg_sht, task)
        call FlushChildHashtable(udg_sht, StringHash("Yukari04Hit"))
    endif
    set t = null
    set caster = null
    set portal1 = null
    set portal2 = null
    set p = null
    set atrain1 = null
    set btrain1 = null
    set g = null
    set traina = null
    set trainb = null
    set v = null
    set f = null
endfunction

function Trig_Yukari04_Train_Start takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit portal1 = LoadUnitHandle(udg_sht, task, 1)
    local unit portal2 = LoadUnitHandle(udg_sht, task, 2)
    local real x1 = LoadReal(udg_sht, task, 3)
    local real y1 = LoadReal(udg_sht, task, 4)
    local real a1 = LoadReal(udg_sht, task, 5)
    local real x2 = LoadReal(udg_sht, task, 6)
    local real y2 = LoadReal(udg_sht, task, 7)
    local real a2 = LoadReal(udg_sht, task, 8)
    local player p = GetOwningPlayer(caster)
    local real dx1 = 800.0 * 0.03125 * Cos(a1 * 0.017454)
    local real dy1 = 800.0 * 0.03125 * Sin(a1 * 0.017454)
    local real dx2 = 800.0 * 0.03125 * Cos(a2 * 0.017454)
    local real dy2 = 800.0 * 0.03125 * Sin(a2 * 0.017454)
    local unit atrain1 = CreateUnit(Player(15), 'e02V', x1, y1, a1)
    local unit btrain1 = CreateUnit(Player(15), 'e02V', x2, y2, a2)
    local group g = CreateGroup()
    local group traina = CreateGroup()
    local group trainb = CreateGroup()
    local boolexpr f = Filter(function Trig_Yukari04_Train_Filter)
    local integer i = 1
    local real damage = 150.0 + (GetUnitAbilityLevel(caster, 'A0IY') - 1) * 125.0 + 2.2 * GetHeroInt(caster, true)
    call GroupAddUnit(traina, atrain1)
    call GroupAddUnit(trainb, btrain1)
    call PlaySoundOnUnitBJ(gg_snd_yukaritrain, 127, atrain1)
    call PlaySoundOnUnitBJ(gg_snd_yukaritrain, 127, btrain1)
    call SaveReal(udg_sht, task, 9, dx1)
    call SaveReal(udg_sht, task, 10, dy1)
    call SaveReal(udg_sht, task, 11, dx2)
    call SaveReal(udg_sht, task, 12, dy2)
    call SaveGroupHandle(udg_sht, task, 13, g)
    call SaveReal(udg_sht, task, 14, damage)
    call SaveInteger(udg_sht, task, 15, i)
    call SaveGroupHandle(udg_sht, task, 16, traina)
    call SaveGroupHandle(udg_sht, task, 17, trainb)
    call SaveUnitHandle(udg_sht, task, 18, atrain1)
    call SaveUnitHandle(udg_sht, task, 19, btrain1)
    call SaveBooleanExprHandle(udg_sht, task, 22, f)
    call TimerStart(t, 0.03125, true, function Trig_Yukari04_Train_Loop)
    set t = null
    set caster = null
    set portal1 = null
    set portal2 = null
    set p = null
    set atrain1 = null
    set btrain1 = null
    set g = null
    set traina = null
    set trainb = null
    set f = null
endfunction

function Trig_Yukari04_Clear_When_No_Cast takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    local unit u = LoadUnitHandle(udg_sht, task, 1)
    call KillUnit(u)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0JH', false)
    call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0IY', true)
    call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 150)
    call AbilityCoolDownResetion(caster, 'A0IY', 20)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_sht, task)
    set caster = null
    set t = null
    set u = null
endfunction

function Trig_Yukari04_Add_2nd_Ability takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_sht, task, 0)
    if GetUnitAbilityLevel(caster, 'A0JH') == 0 then
        call UnitAddAbility(caster, 'A0JH')
        call UnitMakeAbilityPermanent(caster, true, 'A0JH')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0JH', true)
    else
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0JH', true)
    endif
    call TimerStart(t, 7.0 - 0.3, false, function Trig_Yukari04_Clear_When_No_Cast)
    set t = null
    set caster = null
endfunction

function Trig_Yukari04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local player p = GetOwningPlayer(caster)
    local timer t
    local integer task
    local unit u
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local real a
    if GetSpellAbilityId() == 'A0IY' then
        call AbilityCoolDownResetion(caster, 'A0IY', 120.0 + (GetUnitAbilityLevel(caster, 'A0IY') - 1) * -20.0)
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_sht, task, 0, caster)
        call SaveReal(udg_sht, task, 3, x)
        call SaveReal(udg_sht, task, 4, y)
        set a = 57.29578 * Atan2(y - GetUnitY(caster), x - GetUnitX(caster)) - 180.0
        set u = CreateUnit(p, 'n04V', x, y, a)
        call SaveUnitHandle(udg_sht, task, 1, u)
        call SaveReal(udg_sht, task, 5, a)
        call SetPlayerAbilityAvailable(p, 'A0IY', false)
        call SaveTimerHandle(udg_sht, GetHandleId(caster), 0, t)
        call TimerStart(t, 0.3, false, function Trig_Yukari04_Add_2nd_Ability)
    elseif GetSpellAbilityId() == 'A0JH' then
        set t = LoadTimerHandle(udg_sht, GetHandleId(caster), 0)
        set task = GetHandleId(t)
        set u = LoadUnitHandle(udg_sht, task, 1)
        if IsUnitType(u, UNIT_TYPE_DEAD) or GetUnitTypeId(u) == 0 then
            call PauseUnit(caster, true)
            call IssueImmediateOrder(caster, "stop")
            call PauseUnit(caster, false)
        else
            call SaveReal(udg_sht, task, 6, x)
            call SaveReal(udg_sht, task, 7, y)
            set a = 57.29578 * Atan2(y - LoadReal(udg_sht, task, 4), x - LoadReal(udg_sht, task, 3)) - 180.0
            set u = CreateUnit(p, 'n04V', x, y, a)
            call SaveUnitHandle(udg_sht, task, 2, u)
            call SaveReal(udg_sht, task, 8, a)
            set a = 57.29578 * Atan2(LoadReal(udg_sht, task, 4) - y, LoadReal(udg_sht, task, 3) - x) - 180.0
            call SaveReal(udg_sht, task, 5, a)
            call TimerStart(t, 1.0, false, function Trig_Yukari04_Train_Start)
        endif
        call SetPlayerAbilityAvailable(p, 'A0JH', false)
        call SetPlayerAbilityAvailable(p, 'A0IY', true)
        call FlushChildHashtable(udg_sht, GetHandleId(caster))
    endif
    set caster = null
    set p = null
    set t = null
    set u = null
endfunction

function InitTrig_Yukari04 takes nothing returns nothing
endfunction