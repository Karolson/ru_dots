function Ran03_Create takes integer count, unit caster, real damage, real tx, real ty, real range, unit target, player p returns integer
    local integer this = udg_Ran03_Allocate
    if this != 0 then
        set udg_Ran03_Allocate = udg_Ran03_Stack[this]
    else
        set udg_Ran03_Instance = udg_Ran03_Instance + 1
        set this = udg_Ran03_Instance
    endif
    if this > 8190 then
        return 0
    endif
    set udg_Ran03_Stack[this] = -1
    set udg_Ran03_Struct_Count[this] = count
    set udg_Ran03_Struct_Caster[this] = caster
    set udg_Ran03_Struct_Damage[this] = damage
    set udg_Ran03_Struct_tx[this] = tx
    set udg_Ran03_Struct_ty[this] = ty
    set udg_Ran03_Struct_Range[this] = range
    set udg_Ran03_Struct_Target[this] = target
    set udg_Ran03_Struct_Player[this] = p
    set udg_Ran03_Struct_Group[this] = CreateGroup()
    set udg_Ran03_Struct_ToDestroy[this] = false
    return this
endfunction

function Ran03_Struct_Destroy takes integer this returns nothing
    if this == null then
        return
    elseif udg_Ran03_Stack[this] != -1 then
        return
    endif
    call DebugMsg("End")
    set udg_Ran03_Struct_Count[this] = 0
    set udg_Ran03_Struct_Caster[this] = null
    set udg_Ran03_Struct_Damage[this] = 0.0
    set udg_Ran03_Struct_tx[this] = 0.0
    set udg_Ran03_Struct_ty[this] = 0.0
    set udg_Ran03_Struct_Range[this] = 0.0
    set udg_Ran03_Struct_Target[this] = null
    set udg_Ran03_Struct_Player[this] = null
    call DestroyGroup(udg_Ran03_Struct_Group[this])
    set udg_Ran03_Struct_Group[this] = null
    set udg_Ran03_Struct_ToDestroy[this] = false
    set udg_Ran03_Stack[this] = udg_Ran03_Allocate
    set udg_Ran03_Allocate = this
endfunction

function Ran03_Next takes integer this returns nothing
    local unit v = null
    local unit w = null
    local real tx = 0.0
    local real ty = 0.0
    local integer i = 1
    set udg_Ran03_Struct_Count[this] = udg_Ran03_Struct_Count[this] - 1
    if udg_Ran03_Struct_Count[this] == 0 then
        set udg_Ran03_Struct_ToDestroy[this] = true
    endif
    call GroupEnumUnitsInRange(udg_Ran03_Struct_Group[this], udg_Ran03_Struct_tx[this], udg_Ran03_Struct_ty[this], udg_Ran03_Struct_Range[this], null)
    loop
        set v = FirstOfGroup(udg_Ran03_Struct_Group[this])
    exitwhen v == null
        call GroupRemoveUnit(udg_Ran03_Struct_Group[this], v)
        if not IsUnitType(v, UNIT_TYPE_MECHANICAL) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) and GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, udg_Ran03_Struct_Player[this]) and GetUnitAbilityLevel(v, 'Avul') == 0 and v != udg_Ran03_Struct_Target[this] then
            if GetRandomInt(1, i) == 1 then
                set w = v
            endif
            set i = i + 1
        endif
    endloop
    if w == null then
        set udg_Ran03_Struct_ToDestroy[this] = true
    else
        set tx = GetUnitX(w)
        set ty = GetUnitY(w)
        if udg_Ran03_Struct_Count[this] / 2 * 2 == udg_Ran03_Struct_Count[this] then
            call DebugMsg(I2S(udg_Ran03_Struct_Count[this]))
            call TimedLightning(AddLightning("TCL2", false, udg_Ran03_Struct_tx[this], udg_Ran03_Struct_ty[this], tx, ty), 0.4)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", w, "origin"))
        else
            call DebugMsg(I2S(udg_Ran03_Struct_Count[this]))
            call TimedLightning(AddLightning("TCLE", false, udg_Ran03_Struct_tx[this], udg_Ran03_Struct_ty[this], tx, ty), 0.4)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", w, "origin"))
        endif
        if IsUnitType(w, UNIT_TYPE_HERO) == false then
            call UnitMagicDamageTarget(udg_Ran03_Struct_Caster[this], w, udg_Ran03_Struct_Damage[this], 1)
        else
            call UnitMagicDamageTarget(udg_Ran03_Struct_Caster[this], w, udg_Ran03_Struct_Damage[this], 1)
        endif
        set udg_Ran03_Struct_tx[this] = tx
        set udg_Ran03_Struct_ty[this] = ty
        set udg_Ran03_Struct_Target[this] = w
    endif
    set v = null
    set w = null
endfunction

function Ran03_Loop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer ran03 = LoadInteger(udg_sht, task, 0)
    if udg_Ran03_Struct_ToDestroy[ran03] then
        call Ran03_Struct_Destroy(ran03)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_sht, task)
    else
        call Ran03_Next(ran03)
    endif
    set t = null
endfunction

function Ran03_Condition takes nothing returns boolean
    local unit caster
    local unit target
    local integer level
    local real damage
    local integer range
    local unit u
    local real tx
    local real ty
    local timer t
    local player PLY
    local integer ran03
    if GetSpellAbilityId() == 'A0EG' then
        set caster = GetTriggerUnit()
        set target = GetSpellTargetUnit()
        set level = GetUnitAbilityLevel(caster, 'A0EG')
        set damage = ABCIAllInt(caster, 10 + level * 50 + GetHeroInt(caster, true) * 0.3, 0)
        set range = 450
        set tx = GetUnitX(target)
        set ty = GetUnitY(target)
        set PLY = GetOwningPlayer(caster)
        call AbilityCoolDownResetion(caster, 'A0EG', 11 - level)
        if IsUnitEnemy(target, PLY) and IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusion(target) == false then
            call Item_BLTalismanicRunningCD(target)
            set caster = null
            set target = null
            set u = null
            set t = null
            return false
        endif
        call TimedLightning(AddLightning("TCLE", true, GetUnitX(caster), GetUnitY(caster), tx, ty), 0.4)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", target, "origin"))
        call DebugMsg("9")
        call UnitMagicDamageTarget(caster, target, damage, 1)
        set ran03 = Ran03_Create(9, caster, damage, tx, ty, range, target, PLY)
        set t = CreateTimer()
        call SaveInteger(udg_sht, GetHandleId(t), 0, ran03)
        call TimerStart(t, 0.35, true, function Ran03_Loop)
    endif
    set t = null
    set u = null
    set caster = null
    set target = null
    return false
endfunction

function InitTrig_Ran03New takes nothing returns nothing
endfunction