function Trig_Kanako02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0F4'
endfunction

function Trig_Kanako02_Target takes nothing returns boolean
    local unit u = GetFilterUnit()
    if GetUnitAbilityLevel(u, 'Aloc') != 0 or IsUnitType(u, UNIT_TYPE_STRUCTURE) or IsUnitType(u, UNIT_TYPE_DEAD) or IsUnitType(u, UNIT_TYPE_MECHANICAL) or GetUnitAbilityLevel(u, 'Avul') != 0 or GetUnitAbilityLevel(u, 'A0IL') > 0 then
        set u = null
        return false
    endif
    set u = null
    return true
endfunction

function Trig_Kanako02_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer n = LoadInteger(udg_Hashtable, task, 0)
    local unit caster = LoadUnitHandle(udg_Hashtable, task, 1)
    local unit target
    local integer level = LoadInteger(udg_Hashtable, task, 2)
    local player PLY = LoadPlayerHandle(udg_Hashtable, task, 3)
    local real damage = LoadReal(udg_Hashtable, task, 4)
    local real cx = LoadReal(udg_Hashtable, task, 5)
    local real cy = LoadReal(udg_Hashtable, task, 6)
    local unit kanako = LoadUnitHandle(udg_Hashtable, task, 7)
    local real tx
    local real ty
    local group g = LoadGroupHandle(udg_Hashtable, task, 8)
    local boolexpr filter = LoadBooleanExprHandle(udg_Hashtable, task, 9)
    call GroupEnumUnitsInRange(g, cx, cy, 500.0, filter)
    call GroupRemoveUnit(g, caster)
    if n > 0 and CountUnitsInGroup(g) > 0 then
        call DebugMsg(I2S(n))
        set target = GroupPickRandomUnit(g)
        set tx = GetUnitX(target)
        set ty = GetUnitY(target)
        if IsUnitAlly(target, PLY) then
            call TimedLightning(AddLightning("HWSB", false, cx, cy, tx, ty), 0.6)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\HealingWave\\HealingWaveTarget.mdl", target, "origin"))
            call UnitHealingTarget(kanako, target, damage * 0.7)
        else
            call TimedLightning(AddLightning("CLSB", false, cx, cy, tx, ty), 0.6)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", target, "origin"))
            call UnitMagicDamageTarget(kanako, target, damage, 1)
        endif
        call SaveInteger(udg_Hashtable, task, 0, n - 1)
        call SaveUnitHandle(udg_Hashtable, task, 1, target)
        call SaveReal(udg_Hashtable, task, 5, tx)
        call SaveReal(udg_Hashtable, task, 6, ty)
    else
        call DebugMsg("End")
        call DestroyBoolExpr(filter)
        call DestroyGroup(g)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set filter = null
    set t = null
    set caster = null
    set target = null
    set g = null
endfunction

function Trig_Kanako02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local player PLY = GetOwningPlayer(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0F4')
    local real damage = ABCIAllInt(caster, 50 + level * 30, 1.1)
    local integer n = 3 + level
    local real cx = GetUnitX(caster)
    local real cy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local group g = CreateGroup()
    local boolexpr filter = Filter(function Trig_Kanako02_Target)
    call AbilityCoolDownResetion(caster, 'A0F4', 9)
    if IsUnitEnemy(target, PLY) and IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
        call Item_BLTalismanicRunningCD(target)
        call DebugMsg("Blocked")
        set caster = null
        set target = null
        set t = null
        return
    endif
    call DebugMsg(I2S(n))
    if IsUnitAlly(target, PLY) then
        call TimedLightning(AddLightning("HWPB", false, cx, cy, tx, ty), 0.6)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\HealingWave\\HealingWaveTarget.mdl", target, "origin"))
        call UnitHealingTarget(caster, target, damage * 0.7)
    else
        call TimedLightning(AddLightning("CLPB", false, cx, cy, tx, ty), 0.6)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", target, "origin"))
        call UnitMagicDamageTarget(caster, target, damage, 1)
    endif
    call SaveInteger(udg_Hashtable, task, 0, n - 1)
    call SaveUnitHandle(udg_Hashtable, task, 1, target)
    call SaveInteger(udg_Hashtable, task, 2, level)
    call SavePlayerHandle(udg_Hashtable, task, 3, PLY)
    call SaveReal(udg_Hashtable, task, 4, damage)
    call SaveReal(udg_Hashtable, task, 5, tx)
    call SaveReal(udg_Hashtable, task, 6, ty)
    call SaveUnitHandle(udg_Hashtable, task, 7, caster)
    call SaveGroupHandle(udg_Hashtable, task, 8, g)
    call SaveBooleanExprHandle(udg_Hashtable, task, 9, filter)
    call TimerStart(t, 0.2, true, function Trig_Kanako02_Main)
    set caster = null
    set target = null
    set t = null
    set g = null
    set filter = null
endfunction

function InitTrig_Kanako02 takes nothing returns nothing
endfunction