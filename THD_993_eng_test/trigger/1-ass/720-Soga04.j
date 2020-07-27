function Trig_Soga04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A1A0'
endfunction

function Trig_Soga04_Effect_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local real tx = LoadReal(udg_ht, task, 0)
    local real ty = LoadReal(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer j
    local real px
    local real py
    set j = 0
    loop
        set j = j + 1
    exitwhen j > 4
        set px = tx + i * 16 * Cos((90 * j - 45 + i * 19.2) * 0.017454) * 4 / 3
        set py = ty + i * 16 * Sin((90 * j - 45 + i * 19.2) * 0.017454) * 4 / 3
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\ChimaeraLightningMissile\\ChimaeraLightningMissile.mdl", px, py))
    endloop
    call SaveInteger(udg_ht, task, 2, i - 1)
    if i == 0 then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
endfunction

function Trig_Soga04_Effect_Start takes real tx, real ty returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveReal(udg_ht, task, 0, tx)
    call SaveReal(udg_ht, task, 1, ty)
    call SaveInteger(udg_ht, task, 2, 18)
    call TimerStart(t, 0.16 * 2.5 / 3, true, function Trig_Soga04_Effect_Main)
    set t = null
endfunction

function Trig_Soga04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local real tx
    local real ty
    local real tx2 = LoadReal(udg_ht, task, 2)
    local real ty2 = LoadReal(udg_ht, task, 3)
    local unit u
    local unit v
    local real px
    local real py
    local group g
    local integer i
    local real damage
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local boolean k = false
    set damage = ABCIAllInt(caster, 25 + level * 125, 2.2)
    if udg_SK_Soga04efgroup != null then
        set tx = udg_SK_Soga04tx
        set ty = udg_SK_Soga04ty
        set i = 1
        loop
        exitwhen i > 4
            set px = tx + 100 * Cos(i * 1.570796)
            set py = ty + 100 * Sin(i * 1.570796)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 9
            set px = tx + 200 * Cos(i * 0.69816)
            set py = ty + 200 * Sin(i * 0.69816)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 16
            set px = tx + 300 * Cos(i * 0.392715)
            set py = ty + 300 * Sin(i * 0.392715)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 25
            set px = tx + 400 * Cos(i * 0.392715)
            set py = ty + 400 * Sin(i * 0.392715)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
            set i = i + 1
        endloop
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, tx, ty, 350.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call UnitMagicDamageTarget(caster, v, damage + RMinBJ(GetUnitArmor(v), 50) * 30.0, 5)
                if IsUnitType(v, UNIT_TYPE_HERO) then
                    set k = true
                endif
            endif
        endloop
        call DestroyGroup(g)
        loop
            set v = FirstOfGroup(udg_SK_Soga04efgroup)
        exitwhen v == null
            call GroupRemoveUnit(udg_SK_Soga04efgroup, v)
            call KillUnit(v)
        endloop
        call DestroyGroup(udg_SK_Soga04efgroup)
        set udg_SK_Soga04efgroup = null
        if k then
            call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 200)
        endif
    endif
    set k = false
    set tx = tx2
    set ty = ty2
    set udg_SK_Soga04tx = tx
    set udg_SK_Soga04ty = ty
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", tx, ty))
    set udg_SK_Soga04efgroup = CreateGroup()
    set i = 1
    loop
    exitwhen i > 4
        set px = tx + 100 * Cos(i * 1.570796)
        set py = ty + 100 * Sin(i * 1.570796)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
        set i = i + 1
    endloop
    set i = 1
    loop
    exitwhen i > 9
        set px = tx + 200 * Cos(i * 0.69816)
        set py = ty + 200 * Sin(i * 0.69816)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
        set i = i + 1
    endloop
    set i = 1
    loop
    exitwhen i > 16
        set px = tx + 300 * Cos(i * 0.392715)
        set py = ty + 300 * Sin(i * 0.392715)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
        set u = CreateUnit(GetOwningPlayer(caster), 'e02P', px, py, 0)
        call SetUnitVertexColor(u, 255, 255, 255, 155)
        call GroupAddUnit(udg_SK_Soga04efgroup, u)
        set i = i + 1
    endloop
    set i = 1
    loop
    exitwhen i > 25
        set px = tx + 400 * Cos(i * 0.392715)
        set py = ty + 400 * Sin(i * 0.392715)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\SteamTank\\SteamTankImpact.mdl", px, py))
        set u = CreateUnit(GetOwningPlayer(caster), 'e02P', px, py, 0)
        call SetUnitVertexColor(u, 255, 255, 255, 155)
        call GroupAddUnit(udg_SK_Soga04efgroup, u)
        set i = i + 1
    endloop
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, tx, ty, 400.0, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, damage + RMinBJ(GetUnitArmor(v), 50) * 40.0, 5)
            if IsUnitType(v, UNIT_TYPE_HERO) then
                set k = true
            endif
        endif
    endloop
    call DestroyGroup(g)
    if k then
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 200)
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set caster = null
    set u = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_Soga04_Actions takes nothing returns nothing
    local timer t
    local integer task
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A1A0')
    local real tx
    local real ty
    local integer abstyle
    call VE_Spellcast(caster)
    call AbilityCoolDownResetion(caster, 'A1A0', 110 - 10 * level)
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    if IsPointInEnemyHome(tx, ty, caster) then
        call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff0000The hot springs are guarded by the power of faith and cannot be used as a casting target|r")
        set abstyle = GetSpellAbilityId()
        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + 200)
        call UnitRemoveAbility(caster, abstyle)
        call UnitAddAbility(caster, abstyle)
        call SetUnitAbilityLevel(caster, abstyle, level)
        set t = null
        set caster = null
    endif
    if udg_SK_Soga04efgroup != null then
        set tx = udg_SK_Soga04tx
        set ty = udg_SK_Soga04ty
        call Trig_Soga04_Effect_Start(tx, ty)
    endif
    set tx = GetSpellTargetX()
    set ty = GetSpellTargetY()
    call Trig_Soga04_Effect_Start(tx, ty)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveReal(udg_ht, task, 2, tx)
    call SaveReal(udg_ht, task, 3, ty)
    call TimerStart(t, 2.5, false, function Trig_Soga04_Main)
    set t = null
    set caster = null
endfunction

function InitTrig_Soga04 takes nothing returns nothing
endfunction