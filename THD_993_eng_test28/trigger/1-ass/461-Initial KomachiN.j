function KomachiN03_Damage_Basic takes nothing returns real
return 15.0
endfunction

function KomachiN03_Damage_Income takes nothing returns real
return 40.0
endfunction

function KomachiN03_Damage_IntScale takes nothing returns real
return 1.8
endfunction

function KomachiN03_Damage_AtkScale takes nothing returns real
return 0.8
endfunction

function KomachiN02_Soul_Basic takes nothing returns integer
return 0
endfunction

function KomachiN02_Soul_Income takes nothing returns integer
return 1
endfunction

function KomachiN01_Time_Basic takes nothing returns integer
return 6
endfunction

function KomachiN01_Time_Income takes nothing returns integer
return - 1
endfunction

function KomachiNex_Speed takes nothing returns real
return 10.0
endfunction

function KomachiNEx_Damage_Lifepercent takes nothing returns real
return 0.03
endfunction

function KomachiNEx_Damage_Stun takes nothing returns real
return 0.2
endfunction

function KomachiNEx_Damage_StunFlag takes nothing returns integer
return 'A1EG'
endfunction

function KomachiNEx_Damage_Deltapercent takes nothing returns real
return 0.4
endfunction

function KomachiNEx_Heal_Deltapercent takes nothing returns real
return 0.4
endfunction

function KomachiNEx_Range takes nothing returns real
return 300.0
endfunction

function KomachiNEx_Damage_IntIncome takes nothing returns real
return 0.45
endfunction

function KomachiNEx_Stun takes unit caster, unit target returns nothing
local integer i = GetUnitAbilityLevel(target, 'A1EG')
if i == 0 then
call UnitBuffTarget(caster, target, 2, 'A1EG', 0)
endif
set i = i + 1
call SetUnitAbilityLevel(target, 'A1EG', i)
call UnitStunTarget(caster, target, i * (0.2), 0, 0)
endfunction

function KomachiNEx_SoulExplosion takes unit caster, unit u returns nothing
local real ox = GetUnitX(u)
local real oy = GetUnitY(u)
local group g = CreateGroup()
local unit eu
local unit v
local integer tid = GetUnitTypeId(u)
local boolexpr iff = (udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))])
local player PLY = GetOwningPlayer(caster)
call KillUnit(u)
call RemoveUnit(u)
set eu = CreateUnit(GetOwningPlayer(caster), 'n055', GetUnitX(u), GetUnitY(u), 0.0)
call UnitApplyTimedLife(eu, 'BTLF', 2.00)
call GroupEnumUnitsInRange(g, ox, oy, (300.0), null)
loop
set v = FirstOfGroup(g)
exitwhen v == null
call GroupRemoveUnit(g, v)
if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and (GetWidgetLife(v) >= 0.405) and not (GetUnitAbilityLevel((v), 'A0IL') > 0) and IsUnitAlly(v, PLY) == false and v != caster then
call UnitMagicDamageTarget(caster, v, (0.03) * GetUnitState(v, UNIT_STATE_MAX_LIFE), 5)
if tid == 'n056' then
call UnitMagicDamageTarget(caster, v, GetHeroInt(caster, true) * (0.45), 5)
endif
if tid == 'n05E' then
call KomachiNEx_Stun(caster, v)
endif
if tid == 'n05H' then
call UnitMagicDamageTarget(caster, v, (GetUnitState(u, UNIT_STATE_MAX_LIFE) - 600) * (0.4), 5)
endif
endif
if tid == 'n05G' and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and (GetWidgetLife((v)) >= 0.405)and not((GetUnitAbilityLevel((v), 'A0IL') > 0)) and IsUnitAlly(v, PLY) then
call UnitHealingTarget(caster, v, (GetUnitState(u, UNIT_STATE_MAX_LIFE) - 600) * (0.4))
endif
endloop
call DestroyGroup(g)
set v = null
set PLY = null
set g = null
set iff = null
set eu = null
endfunction

function Komachi_Sickle_Main takes nothing returns nothing
local timer t = GetExpiredTimer()
local integer task = GetHandleId(t)
local unit caster = LoadUnitHandle(udg_ht, task, 0)
local unit u = LoadUnitHandle(udg_ht, task, 2)
local unit target = LoadUnitHandle(udg_ht, task, 3)
local integer level = LoadInteger(udg_ht, task, 1)
local real ox = GetUnitX(u)
local real oy = GetUnitY(u)
local real tx = GetUnitX(caster)
local real ty = GetUnitY(caster)
local real dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
local real anglea = bj_RADTODEG * Atan2(ty - oy, tx - ox)
local real angle = LoadReal(udg_ht, task, 6)
local real v = LoadReal(udg_ht, task, 4)
local real a = LoadReal(udg_ht, task, 5) + 0.0004
local real ax = v * CosBJ(angle)
local real ay = v * SinBJ(angle)
local group g = CreateGroup()
local integer cnt = LoadInteger(udg_ht, task, 7) - 1
local unit tv
local real damage = (15.0) + GetUnitAbilityLevel(caster, 'A1E9') * (40.0) + RMaxBJ(GetHeroInt(caster, true) * (1.8), GetUnitAttack(caster) * (0.8))
call SaveInteger(udg_ht, task, 7, cnt)
call SaveReal(udg_ht, task, 5, a)
if cnt < 0 then
set a = a * 2
endif
if anglea < 0 then
set anglea = anglea + 360
endif
set ax = ax + a * CosBJ(anglea)
set ay = ay + a * SinBJ(anglea)
set angle = bj_RADTODEG * Atan2(ay, ax)
if angle < 0 then
set angle = angle + 360
endif
set v = SquareRoot(ax * ax + ay * ay)
call SaveReal(udg_ht, task, 4, v)
call SaveReal(udg_ht, task, 6, angle)
call SetUnitX(u, ox + v * CosBJ(angle))
call SetUnitY(u, oy + v * SinBJ(angle))
call GroupEnumUnitsInRange(g, ox, oy, 160, null)
loop
set tv = FirstOfGroup(g)
exitwhen tv == null
call GroupRemoveUnit(g, tv)
if IsUnitType(tv, UNIT_TYPE_STRUCTURE) == false and(GetWidgetLife(tv) >= 0.405)and not((GetUnitAbilityLevel((tv), 'A0IL') > 0))and IsUnitAlly(tv, GetOwningPlayer(caster)) == false then
if GetUnitAbilityLevel(tv, 'A00A') == 0 then
call UnitBuffTarget(caster, tv, 5, 'A00A', 0)
call UnitPhysicalDamageTarget(caster, tv, damage)
call Komachi_Soul(caster, tv, 2)
call Komachi_Soul(caster, tv, 2)
endif
endif
endloop
if(GetWidgetLife(u) >= 0.405) == false or(GetWidgetLife(caster) >= 0.405) == false or(dis <= 100 and cnt < 0)or cnt < -400 then
call DebugMsg("End")
call KillUnit(u)
call RemoveUnit(u)
call AddUnitAnimationProperties(caster, "defend", false)
call UnitRemoveAbility(caster, 'A1E5')
call ReleaseTimer(t)
call FlushChildHashtable(udg_ht, task)
endif
call DestroyGroup(g)
set tv = null
set g = null
set u = null
set t = null
set caster = null
set target = null
endfunction

function Komachi_Sickle takes unit caster, real ang, real distance returns nothing
local timer t
local integer i = 0
local integer task
local unit u
local real ox = GetUnitX(caster)
local real oy = GetUnitY(caster)
local real a = GetRandomInt(0, 360)
set t = CreateTimer()
set task = GetHandleId(t)
set u = CreateUnit(GetOwningPlayer(caster), 'h014', ox, oy, 0)
call SetUnitPathing(u, false)
call SaveUnitHandle(udg_ht, task, 0, caster)
call SaveInteger(udg_ht, task, 1, GetRandomInt(1, 12))
call SaveUnitHandle(udg_ht, task, 2, u)
call SaveUnitHandle(udg_ht, task, 3, caster)
call SaveReal(udg_ht, task, 4, SquareRoot(2 * 0.55 * distance) * 1.2)
call SaveReal(udg_ht, task, 5, 0.55)
call SaveReal(udg_ht, task, 6, ang)
call SaveInteger(udg_ht, task, 7, 15)
call TimerStart(t, 0.02, true, function Komachi_Sickle_Main)
endfunction

function KomachiX01_CallBack takes nothing returns nothing
local timer t = GetExpiredTimer()
local integer task = GetHandleId(t)
local unit caster = LoadUnitHandle(udg_ht, task, 0)
local integer i = LoadInteger(udg_ht, task, 1)
local unit target = LoadUnitHandle(udg_ht, task, 2)
local real ox
local real oy
local real tx
local real ty
if GetUnitCurrentOrder(caster) != OrderId("ensnare")then
call UnitRemoveAbility(caster, 'A1E3')
call UnitRemoveAbility(target, 'A1E3')
call FlushChildHashtable(udg_ht, task)
call PauseTimer(t)
call ReleaseTimer(t)
set t = null
set caster = null
set target = null
return
elseif i == 0 then
set ox = GetUnitX(caster)
set oy = GetUnitY(caster)
set tx = GetUnitX(target)
set ty = GetUnitY(target)
call SetUnitX(caster, tx)
call SetUnitY(caster, ty)
call SetUnitX(target, ox)
call SetUnitY(target, oy)
call UnitRemoveAbility(caster, 'A1E3')
call UnitRemoveAbility(target, 'A1E3')
call IssueImmediateOrder(caster, "stop")
call FlushChildHashtable(udg_ht, task)
call PauseTimer(t)
call ReleaseTimer(t)
set t = null
set caster = null
set target = null
return
endif
call SaveInteger(udg_ht, task, 1, i - 1)
set t = null
set caster = null
set target = null
endfunction

function KomachiXEx_CallBack takes nothing returns nothing
local timer t = GetExpiredTimer()
local integer task = GetHandleId(t)
local unit caster = LoadUnitHandle(udg_ht, task, 0)
local real ox
local real oy
local real tx
local real ty
local real dis
local real ang
local group g
local unit v
set g = CreateGroup()
set ox = GetUnitX(caster)
set oy = GetUnitY(caster)
call GroupAddGroup(LoadGroupHandle(udg_ht, GetHandleId(caster), 66), g)
if GetUnitCurrentOrder(caster) != OrderId("eattree")then
loop
set v = FirstOfGroup(g)
exitwhen v == null
call GroupRemoveUnit(g, v)
if GetOwningPlayer(v) == GetOwningPlayer(caster)then
call KomachiNEx_SoulExplosion(caster, v)
endif
endloop
call DestroyGroup(g)
set v = CreateUnit(GetOwningPlayer(caster), 'n054', GetUnitX(caster), GetUnitY(caster), 0.0)
call UnitApplyTimedLife(v, 'BTLF', 2.00)
call FlushChildHashtable(udg_ht, task)
call PauseTimer(t)
call ReleaseTimer(t)
set t = null
set caster = null
set g = null
set v = null
return
endif
loop
set v = FirstOfGroup(g)
exitwhen v == null
call GroupRemoveUnit(g, v)
if GetOwningPlayer(v) == GetOwningPlayer(caster)then
set tx = GetUnitX(v)
set ty = GetUnitY(v)
set ang = Atan2(ty - oy, tx - ox)
set dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox)) - 10
if dis > 10 then
call SetUnitX(v, tx - (10.0) * Cos(ang))
call SetUnitY(v, ty - (10.0) * Sin(ang))
else
if(GetWidgetLife(v) >= 0.405)then
call KillUnit(v)
call RemoveUnit(v)
call UnitHealingTarget(caster, caster, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.02)
endif
endif
endif
endloop
call DestroyGroup(g)
set t = null
set g = null
set v = null
set caster = null
endfunction

function KomachiN_Ability takes nothing returns boolean
local unit caster = GetTriggerUnit()
local integer aid = GetSpellAbilityId()
local integer level = GetUnitAbilityLevel(caster, aid)
local unit target
local timer t
local integer task
local integer i
local real ox
local real oy
local real tx
local real ty
local real dis
local real ang
local real lifeper1
local real lifeper2
local real lifeper
if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST then
if aid == 'A1E2' then
call AbilityCoolDownResetion(caster, 'A1E2', 22 - level * 2)
set target = GetSpellTargetUnit()
set t = CreateTimer()
set task = GetHandleId(t)
call SaveUnitHandle(udg_ht, task, 0, caster)
call SaveInteger(udg_ht, task, 1, (6) + level * (-1))
call SaveUnitHandle(udg_ht, task, 2, target)
call TimerStart(t, 0.5, true, function KomachiX01_CallBack)
call UnitAddAbility(caster, 'A1E3')
call UnitAddAbility(target, 'A1E3')
set target = null
set t = null
endif
if aid == 'A1ED' then
set t = CreateTimer()
set task = GetHandleId(t)
call SaveUnitHandle(udg_ht, task, 0, caster)
call TimerStart(t, 0.04, true, function KomachiXEx_CallBack)
set t = null
endif
elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
if aid == 'A1E4' then
call AbilityCoolDownResetion(caster, 'A1E4', 10)
set target = GetSpellTargetUnit()
set i = (0) + level * (1)
loop
exitwhen i <= 0
set i = i - 1
call Komachi_Soul(caster, target, 4)
endloop
endif
if aid == 'A1E9' then
call AbilityCoolDownResetion(caster, 'A1E9', 8)
set ox = GetUnitX(caster)
set oy = GetUnitY(caster)
set tx = GetSpellTargetX()
set ty = GetSpellTargetY()
set ang = Atan2(ty - oy, tx - ox) * bj_RADTODEG
set dis = SquareRoot((ty - oy) * (ty - oy) + (tx - ox) * (tx - ox))
call UnitAddAbility(caster, 'A1E5')
call AddUnitAnimationProperties(caster, "defend", true)
call Komachi_Sickle(caster, ang, dis)
endif
if aid == 'A1EC' and(GetWidgetLife(caster) >= 0.405) then
call AbilityCoolDownResetion(caster, 'A1EC', 130 - level * 10)
set target = GetSpellTargetUnit()
set lifeper1 = GetUnitState(caster, UNIT_STATE_LIFE) / GetUnitState(caster, UNIT_STATE_MAX_LIFE)
set lifeper2 = GetUnitState(target, UNIT_STATE_LIFE) / GetUnitState(target, UNIT_STATE_MAX_LIFE)
set lifeper = lifeper1 - lifeper2
set lifeper = lifeper / (8)
set i = (8)
loop
exitwhen i <= 0
set i = i - 1
call Komachi_Soul_Trans(caster, Komachi_Soul(caster, target, 5), target, lifeper, i * 360 / (8))
call Komachi_Soul_Trans(target, Komachi_Soul(caster, target, 6), caster, lifeper * (-1), i * 360 / (8))
endloop
set target = null
endif
endif
set caster = null
return false
endfunction

function Trig_Initial_KomachiN_Actions takes nothing returns nothing
local unit h = GetCharacterHandle('U013')
if h == null then
return
endif
call DebugMsg(GetHeroProperName(h) + " 技能初始化完成")
call SetHeroLifeIncreaseValue(h, 19)
call SetHeroManaIncreaseValue(h, 6)
call SetHeroManaBaseRegenValue(h, 0.4)
call UnitAddAbility(h, 'A1ED')
set gg_trg_KomachiX = CreateTrigger()
call TriggerRegisterUnitEvent(gg_trg_KomachiX, h, EVENT_UNIT_SPELL_CAST)
call TriggerRegisterUnitEvent(gg_trg_KomachiX, h, EVENT_UNIT_SPELL_EFFECT)
call TriggerAddCondition(gg_trg_KomachiX, Condition(function KomachiN_Ability))
set h = null
endfunction

function InitTrig_Initial_KomachiN takes nothing returns nothing
set gg_trg_Initial_KomachiN = CreateTrigger()
call TriggerAddAction(gg_trg_Initial_KomachiN, function Trig_Initial_KomachiN_Actions)
endfunction