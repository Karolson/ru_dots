function Trig_Aya02_Conditions takes nothing returns boolean
    local unit target = GetTriggerUnit()
    local unit aya = GetEventDamageSource()
    if GetEventDamage() == 0 then
        set target = null
        set aya = null
        return false
    elseif IsUnitIllusion(aya) then
        set target = null
        set aya = null
        return false
    elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        set target = null
        set aya = null
        return false
    elseif IsDamageNotUnitAttack(aya) then
        set target = null
        set aya = null
        return false
    elseif GetUnitAbilityLevel(aya, 'A05L') > 0 and GetUnitAbilityLevel(target, 'B00Y') > 0 then
        set target = null
        set aya = null
        return true
    elseif GetUnitAbilityLevel(aya, 'A05S') > 0 then
        set target = null
        set aya = null
        return true
    endif
    set target = null
    set aya = null
    return false
endfunction

function Trig_Aya02_Filter takes nothing returns boolean
    local unit u = GetFilterUnit()
    if IsUnitEnemy(u, bj_groupEnumOwningPlayer) and GetUnitAbilityLevel(u, 'Aloc') == 0 then
        set u = null
        return true
    endif
    set u = null
    return false
endfunction

function Trig_Aya02_Actions takes nothing returns nothing
    local unit aya = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer task = GetHandleId(aya)
    local integer level2 = GetUnitAbilityLevel(aya, 'A05L')
    local integer level3 = GetUnitAbilityLevel(aya, 'A05S')
    local integer k = GetConvertedPlayerId(GetOwningPlayer(aya))
    local effect e
    local group g
    local unit v
    local unit u
    local real x
    local real y
    local real damage
    local real facing
    local filterfunc filter
    local player p
    if level2 > 0 and GetUnitAbilityLevel(target, 'B00Y') > 0 then
        if udg_GameMode / 100 != 3 and udg_NewMid == false then
            call UnitAbsDamageTarget(aya, target, level2 * 17.5)
        else
            call UnitAbsDamageTarget(aya, target, level2 * 17.5 * 1.5)
        endif
        set e = AddSpecialEffectTarget("Abilities\\Weapons\\SorceressMissile\\SorceressMissile.mdl", target, "chest")
        call DestroyEffect(e)
    endif
    if level3 > 0 then
        set udg_SK_Aya03_Count[k] = udg_SK_Aya03_Count[k] + 1
        if udg_SK_Aya03_Count[k] == 3 then
            set e = AddSpecialEffectTarget("Abilities\\Weapons\\SteamMissile\\SteamMissile.mdl", aya, "hand left")
            call SaveEffectHandle(udg_sht, task, 0, e)
        elseif udg_SK_Aya03_Count[k] >= 4 then
            set udg_SK_Aya03_Count[k] = 0
            set e = LoadEffectHandle(udg_sht, task, 0)
            call DestroyEffect(e)
            call FlushChildHashtable(udg_sht, task)
            set facing = GetUnitFacing(aya)
            set p = GetOwningPlayer(aya)
            set x = GetUnitX(aya) + 100 * Cos(facing * bj_DEGTORAD)
            set y = GetUnitY(aya) + 100 * Sin(facing * bj_DEGTORAD)
            set damage = level3 * 15 + RMaxBJ(0.4 * (GetUnitAttack(aya) - GetUnitBaseAttack(aya)), 1.4 * (GetHeroInt(aya, true) - GetHeroInt(aya, false)))
            set u = CreateUnit(p, 'n010', x, y, facing)
            call SetUnitScale(u, 0.5, 0.5, 0.5)
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, x, y, 300, null)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if GetWidgetLife(v) > 0.405 and IsUnitEnemy(v, p) and GetUnitAbilityLevel(v, 'Aloc') == 0 and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                    if v == target then
                        call UnitMagicDamageTarget(aya, v, damage * 2.0, 2)
                    else
                        call UnitMagicDamageTarget(aya, v, damage, 6)
                    endif
                    if udg_NewDebuffSys then
                        call UnitSlowTargetMspd(aya, v, 30, 2.5, 3, 0)
                    else
                        call UnitSlowTarget(aya, v, 1.0 + level3 * 0.5, 'A05N', 'B00Z')
                    endif
                endif
            endloop
            call DestroyGroup(g)
        endif
    endif
    set filter = null
    set aya = null
    set target = null
    set e = null
    set u = null
    set v = null
    set g = null
endfunction

function InitTrig_Aya02 takes nothing returns nothing
endfunction