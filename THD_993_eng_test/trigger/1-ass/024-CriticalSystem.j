function CalcJieCaoRate takes unit caster returns real
    local integer level = 0
    local integer rid = GetPlayerId(GetOwningPlayer(caster))
    if udg_smode_jc[rid] < 200 then
        set level = 1
    elseif udg_smode_jc[rid] < 500 then
        set level = 2
    elseif udg_smode_jc[rid] < 800 then
        set level = 3
    elseif udg_smode_jc[rid] < 1300 then
        set level = 4
    else
        set level = 5
    endif
    if rid == GetPlayerId(GetOwningPlayer(udg_smode_jcu)) then
        set level = level + 1
    endif
    if level == 1 then
        return 1.3
    elseif level == 2 then
        return 1.15
    elseif level == 3 then
        return 1.0
    elseif level == 4 then
        return 0.85
    elseif level == 5 then
        return 0.7
    elseif level == 6 then
        return 0.6
    else
        return 1.0
    endif
endfunction

function BattleDetectEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(udg_ht, GetHandleId(t), 1)
    call GroupRemoveUnit(udg_smodehs, u)
    call FlushChildHashtable(udg_ht, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

function Trig_BattleDetect_Actions takes unit caster, unit target returns nothing
    local unit hero = target
    local timer t
    if GetOwningPlayer(caster) == udg_PlayerA[0] or GetOwningPlayer(caster) == udg_PlayerB[0] or GetOwningPlayer(target) == udg_PlayerA[0] or GetOwningPlayer(target) == udg_PlayerB[0] then
        set hero = null
        set t = null
        return
    endif
    if IsUnitType(caster, UNIT_TYPE_HERO) and IsUnitType(target, UNIT_TYPE_HERO) and IsUnitInGroup(target, udg_smodehs) == false and udg_smodestat or udg_OBBCheck then
        set t = CreateTimer()
        call GroupAddUnit(udg_smodehs, target)
        call SaveUnitHandle(udg_ht, GetHandleId(t), 1, hero)
        if udg_smodestat == false and udg_OBBCheck then
            call TimerStart(t, 10, false, function BattleDetectEnd)
            if GetLocalPlayer() == udg_PlayerA[0] or GetLocalPlayer() == udg_PlayerB[0] then
                call PingMinimap(GetUnitX(hero), GetUnitY(hero), 2.0)
            endif
        else
            call TimerStart(t, 5, false, function BattleDetectEnd)
            call PingMinimap(GetUnitX(hero), GetUnitY(hero), 2.0)
        endif
        set t = null
    endif
    set hero = null
endfunction

function UnitHealingTarget takes unit caster, unit target, real damage returns nothing
    local real outcomedamage = damage
    local real buffingpercentage = 1.0
    set outcomedamage = outcomedamage * buffingpercentage
    if GetUnitAbilityLevel(target, 'A0YY') >= 1 then
        set outcomedamage = 0
    endif
    if GetUnitAbilityLevel(target, 'A0I9') >= 1 then
        set outcomedamage = outcomedamage * 0.5
    endif
    if GetUnitAbilityLevel(target, 'A0CW') != 0 then
        set outcomedamage = outcomedamage * 0.5
    endif
    if YDWEUnitHasItemOfTypeBJNull(target, 'I039') then
        set outcomedamage = outcomedamage * 1.2
    endif
    if GetUnitAbilityLevel(target, 'B09U') != 0 then
        set outcomedamage = outcomedamage * 0.01 * (50 - GetUnitState(target, UNIT_STATE_MAX_LIFE) * 0.2 * 0.01)
    endif
    if GetUnitTypeId(target) == 'h01O' then
        set outcomedamage = outcomedamage * 0.5
    endif
    call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + outcomedamage)
    call WordHealInNormal(caster, target, outcomedamage)
endfunction

function UnitPhysIncreaseValue takes unit caster, unit target returns real
    local real incdam = 1.0
    if GetUnitAbilityLevel(caster, 'A14L') >= 1 and GetUnitAbilityLevel(caster, 'A14L') <= 3 then
        set incdam = incdam * (1.1 + 0.1 * GetUnitAbilityLevel(caster, 'A14L'))
    elseif GetUnitAbilityLevel(caster, 'A14L') >= 4 and GetUnitAbilityLevel(caster, 'A14L') <= 6 then
        set incdam = incdam * (1.15 + 0.15 * (GetUnitAbilityLevel(caster, 'A14L') - 3))
    endif
    if GetUnitAbilityLevel(caster, 'A19K') > 0 and IsUnitType(target, UNIT_TYPE_HERO) then
        set incdam = incdam * (1.05 + 0.05 * GetUnitAbilityLevel(caster, 'A19K'))
    endif
    return incdam - 1
endfunction

function UnitDefendsReduce takes unit target, real alldam returns real
    local real decdam = alldam
    local real decdamreduce = 0.0
    local real decdamoutput = 0.0
    local integer i = 0
    if udg_SK_Hina01_Unit == target then
        set i = 1
        loop
            if udg_SK_Hina01_Item[i] != null and GetUnitState(udg_SK_Hina01_Item[i], UNIT_STATE_LIFE) > 0 and decdam > 0 then
                set decdamreduce = RMinBJ(GetUnitState(udg_SK_Hina01_Item[i], UNIT_STATE_LIFE), decdam)
                call SetUnitState(udg_SK_Hina01_Item[i], UNIT_STATE_LIFE, GetUnitState(udg_SK_Hina01_Item[i], UNIT_STATE_LIFE) - decdamreduce)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", udg_SK_Hina01_Item[i], "chest"))
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl", target, "origin"))
                set decdam = decdam - decdamreduce
                set decdamoutput = decdamoutput + decdamreduce
            endif
            set i = i + 1
        exitwhen i > 6
        endloop
    endif
    if GetUnitAbilityLevel(target, 'A0RA') >= 1 and udg_SK_Kisume03_Count > 0 and decdam > 0 then
        set decdamreduce = RMinBJ(udg_SK_Kisume03_Count, decdam)
        set udg_SK_Kisume03_Count = udg_SK_Kisume03_Count - decdamreduce
        if udg_SK_Kisume03_Count <= 0 then
            call DestroyEffect(udg_SK_Kisume03_Effect)
        endif
        set decdam = decdam - decdamreduce
        set decdamoutput = decdamoutput + decdamreduce
    endif
    if GetUnitAbilityLevel(target, 'A058') >= 1 and udg_SK_Cirno03Cast_Armor > 0 and decdam > 0 then
        set decdamreduce = RMinBJ(udg_SK_Cirno03Cast_Armor, decdam)
        set udg_SK_Cirno03Cast_Armor = udg_SK_Cirno03Cast_Armor - decdamreduce
        if udg_SK_Cirno03Cast_Armor <= 0 then
            call UnitRemoveAbility(target, 'A058')
            call UnitRemoveAbility(target, 'B05J')
        endif
        set decdam = decdam - decdamreduce
        set decdamoutput = decdamoutput + decdamreduce
    endif
    if GetUnitAbilityLevel(target, 'A070') >= 1 and LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10) > 0 and decdam > 0 then
        set decdamreduce = RMinBJ(LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10), decdam)
        call SaveReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10, LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10) - decdamreduce)
        if LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10) <= 0 then
            call UnitRemoveAbility(target, 'A070')
            call UnitRemoveAbility(target, 'B07B')
            set udg_SK_Hina03_Broke = true
        endif
        set decdam = decdam - decdamreduce
        set decdamoutput = decdamoutput + decdamreduce
    endif
    if GetUnitAbilityLevel(target, 'A0UG') >= 1 and HaveSavedReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(target)) then
        set decdamreduce = LoadReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(target))
        if decdam >= decdamreduce then
            set decdam = decdam - decdamreduce
            set decdamoutput = decdamoutput + decdamreduce
            if HaveSavedHandle(udg_ht, StringHash("Futo03_Protect_Timer"), GetHandleId(target)) then
                call TimerStart(LoadTimerHandle(udg_ht, StringHash("Futo03_Protect_Timer"), GetHandleId(target)), 0.0, false, function sc__Futo03_ClearProtect)
            else
                call RemoveSavedReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(target))
            endif
        else
            set decdamreduce = decdamreduce - decdam
            set decdamoutput = decdamoutput + decdam
            set decdam = 0.0
            call SaveReal(udg_ht, StringHash("Futo03_Protect"), GetHandleId(target), decdamreduce)
        endif
    endif
    return decdamoutput
endfunction

function UnitPhysicalReduce takes unit target returns real
    local real phyduce = 1.0
    if GetUnitAbilityLevel(target, 'A0TQ') >= 1 then
        set phyduce = phyduce * (1 - 0.45)
    endif
    if GetUnitAbilityLevel(target, 'A0XB') >= 1 then
        set phyduce = phyduce * (1 - 0.25 * (GetUnitAbilityLevel(target, 'A0XB') - 1))
    endif
    if GetUnitAbilityLevel(target, 'A0HG') >= 1 then
        set phyduce = phyduce * (1 - (0.12 + 0.06 * (GetUnitAbilityLevel(target, 'A0HG') - 1)))
    endif
    if GetUnitTypeId(target) == 'n006' then
        set phyduce = phyduce * (1 - 0.5)
    endif
    set phyduce = phyduce * udg_DMG_AllPhyscialDamage[GetPlayerId(GetOwningPlayer(target))] * udg_DMG_AllUnitDamageReduce[GetPlayerId(GetOwningPlayer(target))]
    return phyduce
endfunction

function ReisenReduce takes unit target returns real
    local integer i = 0
    local real k = 1.0
    local real ox = GetUnitX(target)
    local real oy = GetUnitY(target)
    local real tx
    local real ty
    if udg_SK_Reisen04_On > 0 then
        loop
            if udg_SK_Reisen04_Light[i] != null then
                set tx = GetUnitX(udg_SK_Reisen04_Light[i])
                set ty = GetUnitY(udg_SK_Reisen04_Light[i])
                if SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty)) <= 450 and IsUnitAlly(target, GetOwningPlayer(udg_SK_Reisen04_Light[i])) == false then
                    set k = udg_SK_Reisen04_value
                endif
            endif
            set i = i + 1
        exitwhen i >= udg_SK_Reisen04_On
        endloop
    endif
    return k
endfunction

function UnitTotalReduce takes unit target, unit caster returns real
    local real demax = 1.0
    local integer i = 0
    local group g = CreateGroup()
    local unit v
    local boolean backdoor = true
    if GetUnitAbilityLevel(target, 'A0RA') >= 1 then
        set demax = demax * (1.0 - (0.03 + 0.03 * GetUnitAbilityLevel(target, 'A0RA')))
    endif
    if GetUnitAbilityLevel(caster, 'A0PA') >= 1 then
        set demax = demax * (1.0 - 0.25)
    endif
    if GetUnitAbilityLevel(target, 'A0D1') >= 1 then
        set demax = demax * (1.0 - 0.6 * (GetUnitState(target, UNIT_STATE_MAX_LIFE) - GetUnitState(target, UNIT_STATE_LIFE)) / GetUnitState(target, UNIT_STATE_MAX_LIFE))
    endif
    if GetUnitAbilityLevel(target, 'A0UJ') >= 1 then
        set demax = 0
    endif
    if GetUnitAbilityLevel(target, 'A0Z9') >= 1 then
        set demax = 0
    endif
    if GetUnitAbilityLevel(target, 'A0I9') >= 1 then
        set demax = demax * (1.0 - 0.5)
    endif
    if GetUnitTypeId(caster) == 'E03M' then
        set demax = demax * (1.0 + 0.25)
    endif
    if udg_GameModeIsTurbo and IsUnitType(caster, UNIT_TYPE_STRUCTURE) and IsUnitType(target, UNIT_TYPE_HERO) then
        set demax = demax * (1.0 - 0.35)
    endif
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 1000.0, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitEnemy(v, GetOwningPlayer(target)) and (GetUnitAbilityLevel(v, 'A18Y') > 0 or GetUnitAbilityLevel(v, 'A02F') > 0) then
                set backdoor = false
                exitwhen true
            endif
        endloop
        if backdoor then
            set demax = demax * (1.0 - 0.8)
        endif
    endif
    call DestroyGroup(g)
    set demax = demax * udg_DMG_AllDamage[GetPlayerId(GetOwningPlayer(target))]
    set g = null
    set v = null
    return 1.0 - demax
endfunction

function UnitLifeSteal takes unit caster, real damage returns nothing
    local real drink = 1.0
    if IsUnitType(caster, UNIT_TYPE_HERO) then
        set drink = drink * udg_DMG_AllItemPhysicalDrink[GetPlayerId(GetOwningPlayer(caster))]
    endif
    if GetUnitAbilityLevel(caster, 'B03Z') >= 1 then
        set drink = drink * (1 - 0.3)
    endif
    if GetUnitAbilityLevel(caster, 'A14K') >= 1 then
        set drink = drink * (1 - 0.4)
    endif
    if GetUnitAbilityLevel(caster, 'A0PC') >= 1 then
        set drink = drink * (1 - 0.22)
    endif
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set drink = drink * (1 - 0.15)
    endif
    set drink = 1 - drink
    call UnitHealingTarget(caster, caster, damage * drink)
endfunction

function UnitMagicLifeSteal takes unit caster, real damage returns nothing
    local real drink = 1.0
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set drink = drink * (1 - 0.1)
    endif
    if GetUnitAbilityLevel(caster, 'A0XE') >= 1 then
        set drink = drink * (1 - 0.22)
    endif
    set drink = 1 - drink
    call UnitHealingTarget(caster, caster, damage * drink)
endfunction

function HeroCriticalValue takes unit caster returns real
    local real critp = 0.0
    local real critx = 1.0
    local integer i = 0
    set critx = 4.0
    set critp = 0.0
    if GetUnitAbilityLevel(caster, 'A0HX') == 4 then
        set critp = 15
    endif
    if GetRandomInt(1, 100) <= critp then
        return critx
    endif
    set critx = 3.5
    set critp = 0.0
    if GetUnitAbilityLevel(caster, 'A0HX') == 3 then
        set critp = 15
    endif
    if GetRandomInt(1, 100) <= critp then
        return critx
    endif
    set critx = 3.0
    set critp = 0.0
    if GetUnitAbilityLevel(caster, 'A0HX') == 2 then
        set critp = 15
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    set critx = 2.5
    set critp = 0.0
    set i = 0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(caster, i)) == 'I008' then
            set critp = 23
            if GetRandomInt(1, 100) <= critp then
                return critx
            endif
        endif
    exitwhen i == 6
    endloop
    if GetUnitAbilityLevel(caster, 'A0HX') == 1 then
        set critp = 15
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    set critx = 2.0
    set critp = 0.0
    set i = 0
    if GetUnitAbilityLevel(caster, 'A0QB') >= 1 then
        set critp = 15 + GetUnitAbilityLevel(caster, 'A0QB') * 5
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    if GetUnitAbilityLevel(caster, 'A0SX') >= 1 then
        set critp = 15
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    if GetUnitAbilityLevel(caster, 'A07E') == 4 then
        set critp = 10
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    if GetUnitAbilityLevel(caster, 'A0ZC') >= 1 then
        set critp = GetUnitAbilityLevel(caster, 'A0ZC') * 10
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    if GetUnitAbilityLevel(caster, 'A14M') >= 1 then
        set critp = 25
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    set critx = 1.8
    set critp = 0.0
    set i = 0
    if GetUnitAbilityLevel(caster, 'A07E') == 3 then
        set critp = 10
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    set critx = 1.6
    set critp = 0.0
    set i = 0
    if GetUnitAbilityLevel(caster, 'A07E') == 2 then
        set critp = 10
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    set critx = 1.5
    set critp = 0.0
    set i = 0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(caster, i)) == 'I00Q' then
            set critp = 20
            if GetRandomInt(1, 100) <= critp then
                return critx
            endif
        endif
    exitwhen i == 6
    endloop
    if GetUnitAbilityLevel(caster, 'A09X') >= 1 then
        set critp = 20
        if GetRandomInt(1, 100) <= critp then
            return critx
        endif
    endif
    return 1.0
endfunction

function GetUnitItemArmor takes unit v, integer itemr, real k returns real
    local integer i = 0
    local real armor = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set armor = armor + k
        endif
    exitwhen i == 6
    endloop
    return armor
endfunction

function GetUnitAbilityArmor takes unit v, integer abilyr, real k returns real
    local real armor = 0.0
    if GetUnitAbilityLevel(v, abilyr) >= 1 then
        set armor = armor + k
    endif
    return armor
endfunction

function GetUnitTypeArmor takes unit v, integer utyper, real k returns real
    local real armor = 0.0
    if GetUnitTypeId(v) == utyper then
        set armor = armor + k
    endif
    return armor
endfunction

function GetUnitArmor takes unit v returns real
    local real armor = 0.0
    if IsUnitType(v, UNIT_TYPE_HERO) then
        set armor = armor + LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAR') / 100 + 1.0
        set armor = armor + LoadInteger(udg_HeroDatabase, GetUnitTypeId(v), 'BSAI') / 100 * (GetHeroLevel(v) - 1)
        set armor = armor + GetHeroAgi(v, true) * 0.12
        set armor = armor + udg_DMG_AllItemArmor[GetPlayerId(GetOwningPlayer(v))]
        if GetUnitAbilityLevel(v, 'B09D') > 0 then
            set armor = armor - 5
        endif
        if GetUnitAbilityLevel(v, 'A175') > 0 then
            set armor = armor - 6
        endif
        if GetUnitAbilityLevel(v, 'A0RM') == 1 then
            set armor = armor + 8
        elseif GetUnitAbilityLevel(v, 'A0RM') == 2 then
            set armor = armor + 4
        endif
        set armor = armor + GetUnitAbilityArmor(v, 'A19C', 3)
        set armor = armor + GetUnitAbilityArmor(v, 'A19D', 6)
        if GetUnitAbilityLevel(v, 'A0FA') >= 1 then
            set armor = armor + 20
        endif
        if GetUnitAbilityLevel(v, 'A04T') >= 1 then
            set armor = armor + 10 + 5 * GetUnitAbilityLevel(v, 'A04T')
        endif
        set armor = armor + GetUnitAbilityArmor(v, 'A0C6', 50)
        if GetUnitAbilityLevel(v, 'A0XC') >= 1 then
            set armor = armor + 3 * GetUnitAbilityLevel(v, 'A0XC')
        endif
        if GetUnitAbilityLevel(v, 'A0ST') >= 1 then
            set armor = armor + 5 + 5 * GetUnitAbilityLevel(v, 'A0ST')
        endif
        set armor = armor + GetUnitAbilityArmor(v, 'A14J', 12)
    else
        set armor = armor + GetUnitTypeArmor(v, 'h01C', 5)
    endif
    if GetUnitAbilityLevel(v, 'A0CY') >= 1 then
        set armor = armor + 2 * GetUnitAbilityLevel(v, 'A0CY')
    endif
    set armor = armor + GetUnitAbilityArmor(v, 'A089', 10)
    if GetUnitAbilityLevel(v, 'A0SE') >= 1 then
        set armor = armor - 2 * (GetUnitAbilityLevel(v, 'A0SE') + 1)
    endif
    if GetUnitAbilityLevel(v, 'A0RV') >= 1 then
        if ModuloInteger(GetUnitAbilityLevel(v, 'A0RV'), 4) == 3 then
            set armor = armor - GetUnitAbilityLevel(v, 'A0RV') * 0.75 - ModuloInteger(GetUnitAbilityLevel(v, 'A0RV'), 4) * 0.25 - 1
        else
            set armor = armor - GetUnitAbilityLevel(v, 'A0RV') * 0.75 - ModuloInteger(GetUnitAbilityLevel(v, 'A0RV'), 4) * 0.25
        endif
    endif
    set armor = armor - GetUnitAbilityArmor(v, 'A08E', 2)
    set armor = armor - GetUnitAbilityArmor(v, 'A12B', 3)
    set armor = armor - GetUnitAbilityArmor(v, 'A12C', 4)
    set armor = armor - GetUnitAbilityArmor(v, 'A12D', 5)
    if GetUnitAbilityLevel(v, 'B02J') >= 1 then
        set armor = armor - 1 - GetUnitAbilityLevel(udg_SK_Kogasa, 'A0C4')
    endif
    if GetUnitAbilityLevel(v, 'A0I6') >= 1 then
        set armor = armor + 6 + 3 * GetUnitAbilityLevel(v, 'A0I6')
    endif
    set armor = armor - GetUnitAbilityArmor(v, 'A14G', 5)
    return armor
endfunction

function GetArmorResistTrueValue takes real k returns real
    local real resist = 0.0
    local real res = 1.0
    local integer i = 0
    if k == 0 then
        set resist = 0.0
    elseif k > 0 then
        set resist = k * 0.05 / (k * 0.05 + 1)
    else
        set i = 0
        loop
        exitwhen i == R2I(-k)
            set i = i + 1
            set res = res * 0.95
        endloop
        set resist = -1 + res
    endif
    return resist
endfunction

function UnitPhysicalDamageTarget takes unit caster, unit u, real damage returns nothing
    local real tredam = damage
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_PhysicalAbilityDamageUnit[k]
    set udg_A_DamagingUnit = caster
    if GetUnitAbilityLevel(u, 'A0IL') == 0 then
        call UnitDamageTarget(caster, u, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        call UnitDamageTarget(damageunit, u, tredam, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        call Stat_AddDamage(caster, u, tredam, udg_STATS_DTYPE_PHYS)
    endif
    set damageunit = null
endfunction

function UnitPhysicalDamageArea takes unit caster, real x, real y, real range, real damage returns nothing
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        call UnitPhysicalDamageTarget(caster, v, damage)
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function UnitPhysicalDamageTarget_Item takes unit caster, unit u, real damage returns nothing
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_PhysicalItemDamageUnit[k]
    local real tredam = damage
    set udg_A_DamagingUnit = caster
    call UnitDamageTarget(caster, u, 0, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    call UnitDamageTarget(damageunit, u, tredam, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    call Stat_AddDamage(caster, u, tredam, udg_STATS_DTYPE_PHYS)
    set damageunit = null
endfunction

function Trig_CriticalSystem_Actions takes nothing returns nothing
endfunction

function InitTrig_CriticalSystem takes nothing returns nothing
endfunction