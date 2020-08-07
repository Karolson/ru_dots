function NewWeather_HW takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer cnt = LoadInteger(udg_ht, task, 2)
    if cnt == 0 then
        set udg_NewWeather_HWT[GetPlayerId(GetOwningPlayer(u))] = null
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    else
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetUnitX(u), GetUnitY(u)))
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) * (0.99 - GetUnitAbilityLevel(u, 'B08B') * 0.01))
        call SaveInteger(udg_ht, task, 2, cnt - 1)
    endif
    set u = null
    set t = null
endfunction

function NewWeather_HW_Init takes unit u returns nothing
    local timer t
    local integer task
    local integer id = GetPlayerId(GetOwningPlayer(u))
    if udg_NewWeather_HWT[id] == null then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 1, u)
        call SaveInteger(udg_ht, task, 2, 1 + GetUnitAbilityLevel(u, 'B08B'))
        call TimerStart(t, 1.0, true, function NewWeather_HW)
        set udg_NewWeather_HWT[id] = t
        set t = null
    else
        set t = udg_NewWeather_HWT[id]
        set task = GetHandleId(t)
        call SaveInteger(udg_ht, task, 2, 1 + GetUnitAbilityLevel(u, 'B08B'))
        set t = null
    endif
endfunction

function UnitManaingTarget takes unit caster, unit target, real damage returns nothing
    local real outcomedamage = damage
    local real buffingpercentage = 1.0
    set outcomedamage = outcomedamage * buffingpercentage
    call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) + outcomedamage)
    if GetUnitAbilityLevel(target, 'A0D1') != 0 then
        call UnitHealingTarget(caster, target, damage)
    endif
endfunction

function LunasaDamage takes unit caster returns boolean
    local integer critlevel = GetUnitAbilityLevel(caster, 'A0OG')
    local real h0 = GetUnitState(caster, UNIT_STATE_LIFE)
    local real h1 = GetUnitState(caster, UNIT_STATE_MAX_LIFE)
    local real c = 30 - critlevel * 4
    local real rmin = (1 - h0 / h1) * (100 / c) * 10
    return critlevel > 0 and GetRandomInt(0, 100) < rmin
endfunction

function UnitMagicDamageTarget takes unit caster, unit target, real damage, integer dtype returns real
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_MagicDamageUnit[k]
    local unit hero = GetPlayerCharacter(GetOwningPlayer(caster))
    local real alldam = damage
    local real resist = 0.0
    local real magictrate = 0.0
    local real demax = 0.0
    local real decdamoutput = 0.0
    local boolean lunasadamage = false
    local real decdamreduce = 0
    local group g
    local unit v
    local unit hina
    if IsUnitType(target, UNIT_TYPE_DEAD) then
        set damageunit = null
        set hero = null
        return 0.0
    endif
    if GetUnitAbilityLevel(target, 'Avul') != 0 then
        set damageunit = null
        set hero = null
        return 0.0
    endif
    set udg_A_DamagingUnit = caster
    if GetUnitAbilityLevel(target, 'B02K') != 0 then
        call UnitRemoveAbility(target, 'B02K')
    endif
    if dtype == 1 or dtype == 2 or dtype == 5 or dtype == 6 then
        set alldam = alldam + GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A15K') * 5
        if GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A15K') == 1 then
            call UnitSlowTarget(caster, target, 1.0, 'A15M', 'B06W')
        elseif GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A15K') == 2 then
            call UnitSlowTarget(caster, target, 1.0, 'A15N', 'B06W')
        elseif GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A15K') == 3 then
            call UnitSlowTarget(caster, target, 1.0, 'A15O', 'B06W')
        elseif GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A15K') == 4 then
            call UnitSlowTarget(caster, target, 1.0, 'A15P', 'B06W')
        endif
    endif
    if udg_NewWeather_InWeather then
        if GetUnitAbilityLevel(target, 'A0TW') != 0 then
            call UnitRemoveAbility(target, 'A0TW')
        elseif GetUnitAbilityLevel(caster, 'B08F') != 0 then
            set alldam = alldam * 1.3
        elseif GetUnitAbilityLevel(caster, 'B08H') != 0 then
            set alldam = alldam * (0.9 - 0.1 * GetUnitAbilityLevel(caster, 'B08H'))
        elseif GetUnitAbilityLevel(caster, 'B08G') != 0 then
            set alldam = alldam * (1.1 + 0.1 * GetUnitAbilityLevel(caster, 'B08G'))
        elseif damage > 2 and GetUnitAbilityLevel(target, 'B08A') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
            if GetUnitAbilityLevel(target, 'B08A') == 1 then
                call UnitSlowTarget(caster, target, 2.0, 'A0TP', 'B08J')
            endif
        elseif damage > 2 and GetUnitAbilityLevel(target, 'B08B') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
            call NewWeather_HW_Init(target)
        endif
    endif
    if dtype == 1 or dtype == 2 or dtype == 5 or dtype == 6 then
        if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I07X') and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and IsUnitEnemy(target, GetOwningPlayer(caster)) then
            if GetUnitAbilityLevel(target, 'B06V') == 0 or GetRandomReal(0, 100) < 10 then
                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", GetUnitX(target), GetUnitY(target)))
            endif
            call UnitSlowTarget(caster, target, 2.0, 'A15H', 'B06V')
        endif
    endif
    if GetUnitTypeId(target) == 'h00B' or GetUnitTypeId(target) == 'h00I' then
        if IsPointInAllyHome(GetUnitX(target), GetUnitY(target), target) then
            set alldam = 0
        endif
    endif
    if GetUnitAbilityLevel(target, 'A0UI') >= 1 and GetRandomReal(1, 100) <= 10 then
        set alldam = 0
    elseif GetUnitAbilityLevel(target, 'A18Q') >= 1 and GetRandomReal(1, 100) <= 10 then
        set alldam = 0
    endif
    set alldam = alldam * 1.0
    set alldam = alldam * BaseHeroReduction(target)
    if udg_GameMode / 100 == 3 and dtype == 5 or dtype == 6 then
        set alldam = alldam * 0.75
    endif
    if udg_smodestat or udg_OBBCheck then
        call Trig_BattleDetect_Actions(caster, target)
    endif
    if udg_smodestat then
        set alldam = alldam * CalcJieCaoRate(caster)
    endif
    if IsUnitType(caster, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(target, 'A0ZU') != 0 or IsUnitIllusion(target) then
        if GetUnitAbilityLevel(caster, 'A0ZD') > 0 then
            set alldam = alldam * 1.4
        else
            set alldam = alldam * 1.2
        endif
    endif
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set alldam = alldam * 1.2
    endif
    if GetUnitAbilityLevel(target, 'A0YP') >= 0 then
        call UnitRemoveAbility(target, 'A0YP')
    endif
    if GetUnitAbilityLevel(hero, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 + GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    if GetUnitAbilityLevel(target, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 - GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    set alldam = alldam * ReisenReduce(caster)
    if GetUnitAbilityLevel(target, 'A0MQ') != 0 then
        set alldam = 0
    endif
    if GetUnitAbilityLevel(target, 'A1HE') != 0 and GetUnitAbilityLevel(caster, 'A1HF') == 0 then
        set alldam = 0
    endif
    if dtype == 1 or dtype == 2 or dtype == 5 or dtype == 6 then
        if LunasaDamage(caster) then
            set alldam = alldam * 2.0
            set lunasadamage = true
        endif
        if GetUnitAbilityLevel(target, 'A082') >= 1 then
            call UnitSlowTarget(caster, target, 3.0, 'A082', 'B07C')
        endif
    endif
    if dtype == 1 or dtype == 2 or dtype == 3 or dtype == 4 then
        if GetUnitAbilityLevel(target, 'A03D') >= 1 then
            call UnitManaingTarget(target, target, alldam * 0.125)
            set alldam = alldam * 0.75
        endif
    elseif dtype == 5 or dtype == 6 or dtype == 7 or dtype == 8 then
        if GetUnitAbilityLevel(target, 'A03B') >= 1 then
            call UnitManaingTarget(target, target, alldam * 0.125)
            set alldam = alldam * 0.75
        endif
    endif
    set alldam = alldam * udg_DMG_AllMagicDamageOut[GetPlayerId(GetOwningPlayer(caster))] * udg_DMG_AllMagicDamage[GetPlayerId(GetOwningPlayer(target))]
    set demax = UnitTotalReduce(target, caster)
    set alldam = alldam * (1 - demax)
    if GetUnitTypeId(target) == 'h00H' or GetUnitTypeId(target) == 'h00F' or GetUnitTypeId(target) == 'h00G' or GetUnitTypeId(target) == 'h00E' then
        set resist = GetUnitAbilityResists(target, 'A18Y', 2.0 + R2I(udg_GameTime / 600))
    endif
    if GetUnitTypeId(target) == 'e00E' or GetUnitTypeId(target) == 'e00C' or GetUnitTypeId(target) == 'e00B' or GetUnitTypeId(target) == 'e00D' then
        set resist = GetUnitAbilityResists(target, 'A01X', 5.0) + GetUnitAbilityResists(target, 'A01X', R2I(udg_GameTime / 600))
    else
        set resist = GetUnitMagicResist(target)
    endif
    if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I08T') or YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I093') then
        set resist = resist - 4
    endif
    if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I06N') then
        if resist > 0 then
            set resist = resist * (1 - 0.4)
        endif
    endif
    if GetUnitAbilityLevel(GetPlayerCharacter(GetOwningPlayer(caster)), 'A10T') >= 1 then
        if resist > 0 then
            set resist = resist * (1 - 0.35)
        endif
    endif
    set resist = GetMagicResistTrueValue(resist)
    if GetUnitAbilityLevel(target, 'A0FY') > 0 then
        set resist = resist + (1 - resist) * (0.04 + GetUnitAbilityLevel(target, 'A0FY') * 0.03)
        if resist > 1.0 then
            set resist = 1.0
        endif
    endif
    if resist < 0 or GetUnitTypeId(target) == 'n006' then
        set magictrate = 0
    endif
    if magictrate > 1 then
        set magictrate = 1
    endif
    set alldam = alldam * (1 - resist * (1 - magictrate))
    if YDWEUnitHasItemOfTypeBJNull(target, 'I02W') and alldam > GetUnitState(target, UNIT_STATE_LIFE) then
        set alldam = alldam * 0.5
    endif
    if alldam < 0 then
        set alldam = 0
    endif
    set decdamoutput = UnitDefendsReduce(target, alldam)
    if udg_SK_Hina03_Broke then
        set udg_SK_Hina03_Broke = false
        set hina = LoadUnitHandle(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 350, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, GetOwningPlayer(hina)) == false then
                call UnitMagicDamageTarget(hina, v, 20 + GetUnitAbilityLevel(hina, 'A0IH') * 10 + GetUnitState(hina, UNIT_STATE_MAX_LIFE) * (0.02 + 0.01 * GetUnitAbilityLevel(hina, 'A0IH')), 6)
            endif
        endloop
        call DestroyGroup(g)
        if GetUnitAbilityLevel(target, 'A0JL') != 0 then
            call UnitManaingTarget(hina, hina, (3 + GetUnitAbilityLevel(hina, 'A0IH') * 7) * 3)
        else
            call UnitManaingTarget(hina, hina, 3 + GetUnitAbilityLevel(hina, 'A0IH') * 7)
        endif
        set g = null
        set hina = null
        set v = null
    endif
    if GetUnitAbilityLevel(target, 'A1DL') >= 1 and LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A1DL' * -10) > 0 and alldam > 0 then
        set decdamreduce = RMinBJ(LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A1DL' * -10), alldam)
        call DebugMsg("GreenDam Value=" + R2S(decdamreduce))
        call SaveReal(udg_Hashtable_Slow, GetHandleId(target), 'A1DL' * -10, LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A1DL' * -10) - decdamreduce)
        if LoadReal(udg_Hashtable_Slow, GetHandleId(target), 'A1DL' * -10) <= 0 then
            call UnitRemoveAbility(target, 'A1DL')
            call UnitRemoveAbility(target, 'Bam2')
        endif
        set decdamoutput = decdamoutput + decdamreduce
    endif
    call UnitDamageTarget(caster, target, 0, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    if alldam > decdamoutput then
        call UnitDamageTarget(damageunit, target, alldam - decdamoutput, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    endif
    if lunasadamage then
        call WordDamageInPurple(caster, target, alldam)
    else
        call WordDamageInNormal(caster, target, alldam)
    endif
    call UnitMagicLifeSteal(hero, alldam)
    call Stat_AddDamage(caster, target, alldam, udg_STATS_DTYPE_MAGIC)
    set damageunit = null
    set hero = null
    return alldam - decdamoutput
endfunction

function UnitAbsDamageTarget takes unit caster, unit target, real damage returns real
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_AbsDamageUnit[k]
    local unit hero = GetPlayerCharacter(GetOwningPlayer(caster))
    local real demax = 0.0
    local real alldam = 0.0
    local real decdamoutput = 0.0
    local group g
    local unit hina
    local unit v
    if IsUnitType(target, UNIT_TYPE_DEAD) then
        set damageunit = null
        return 0.0
    endif
    set udg_A_DamagingUnit = caster
    set alldam = damage * 1.0
    set alldam = alldam * BaseHeroReduction(target)
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set alldam = alldam * 1.2
    endif
    if udg_smodestat or udg_OBBCheck then
        call Trig_BattleDetect_Actions(caster, target)
    endif
    if udg_smodestat then
        set alldam = alldam * CalcJieCaoRate(caster)
    endif
    if IsUnitType(caster, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(target, 'A0ZU') != 0 or IsUnitIllusion(target) then
        if GetUnitAbilityLevel(caster, 'A0ZD') > 0 then
            set alldam = alldam * 1.4
        else
            set alldam = alldam * 1.2
        endif
    endif
    if GetUnitAbilityLevel(target, 'A0TW') != 0 then
        call UnitRemoveAbility(target, 'A0TW')
    endif
    if GetUnitAbilityLevel(caster, 'B08F') != 0 then
        set alldam = alldam * 1.3
    endif
    if GetUnitAbilityLevel(caster, 'B08H') != 0 then
        set alldam = alldam * (0.9 - 0.1 * GetUnitAbilityLevel(caster, 'B08H'))
    endif
    if GetUnitAbilityLevel(caster, 'B08G') != 0 then
        set alldam = alldam * (1.1 + 0.1 * GetUnitAbilityLevel(caster, 'B08G'))
    endif
    if damage > 2 and GetUnitAbilityLevel(target, 'B08A') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
        if GetUnitAbilityLevel(target, 'B08A') == 1 then
            call UnitSlowTarget(caster, target, 2.0, 'A0TP', 'B08J')
        endif
        if GetUnitAbilityLevel(target, 'B08A') == 2 then
            call UnitSlowTarget(caster, target, 3.0, 'A0TU', 'B08J')
        endif
    endif
    if damage > 2 and GetUnitAbilityLevel(target, 'B08B') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
        call NewWeather_HW_Init(target)
    endif
    if GetUnitTypeId(target) == 'n006' then
        set alldam = alldam * 0.5
    endif
    if GetUnitAbilityLevel(target, 'A0YP') >= 0 then
        call UnitRemoveAbility(target, 'A0YP')
    endif
    if GetUnitAbilityLevel(hero, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 + GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    if GetUnitAbilityLevel(target, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 - GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    if GetUnitAbilityLevel(target, 'A1HE') != 0 and GetUnitAbilityLevel(hero, 'A1HF') == 0 then
        set alldam = 0
    endif
    if GetUnitAbilityLevel(target, 'A0MQ') != 0 then
        set alldam = 0
    endif
    set demax = UnitTotalReduce(target, caster)
    set alldam = alldam * (1 - demax)
    set decdamoutput = UnitDefendsReduce(target, alldam)
    if udg_SK_Hina03_Broke then
        set udg_SK_Hina03_Broke = false
        set hina = LoadUnitHandle(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10)
        set g = CreateGroup()
        call DebugMsg("ArmorBroke")
        call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 350, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, GetOwningPlayer(hina)) == false then
                call UnitMagicDamageTarget(hina, v, 20 + GetUnitAbilityLevel(hina, 'A0IH') * 10 + GetUnitState(hina, UNIT_STATE_MAX_LIFE) * (0.02 + 0.01 * GetUnitAbilityLevel(hina, 'A0IH')), 6)
            endif
        endloop
        call DestroyGroup(g)
        if GetUnitAbilityLevel(target, 'A0JL') != 0 then
            call UnitManaingTarget(hina, hina, (3 + GetUnitAbilityLevel(hina, 'A0IH') * 7) * 3)
        else
            call UnitManaingTarget(hina, hina, 3 + GetUnitAbilityLevel(hina, 'A0IH') * 7)
        endif
        set g = null
        set hina = null
        set v = null
    endif
    call WordDamageInNormal(caster, target, alldam)
    call UnitDamageTarget(caster, target, 0, false, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    call UnitDamageTarget(damageunit, target, alldam - decdamoutput, false, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    call Stat_AddDamage(caster, target, alldam, udg_STATS_DTYPE_ABS)
    set damageunit = null
    set hero = null
    return alldam - decdamoutput
endfunction

function UnitDelDamageTarget takes unit caster, unit target, real damage returns real
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_DelDamageUnit[k]
    local unit hero = GetPlayerCharacter(GetOwningPlayer(caster))
    local real demax = 0.0
    local real alldam = 0.0
    local real decdamoutput = 0.0
    local group g
    local unit v
    local unit hina
    if IsUnitType(target, UNIT_TYPE_DEAD) then
        set damageunit = null
        set hero = null
        return 0.0
    endif
    set udg_A_DamagingUnit = caster
    set alldam = damage * 1.0
    set alldam = alldam * BaseHeroReduction(target)
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set alldam = alldam * 1.2
    endif
    if udg_smodestat or udg_OBBCheck then
        call Trig_BattleDetect_Actions(caster, target)
    endif
    if udg_smodestat then
        set alldam = alldam * CalcJieCaoRate(caster)
    endif
    if IsUnitType(caster, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(target, 'A0ZU') != 0 or IsUnitIllusion(target) then
        if GetUnitAbilityLevel(caster, 'A0ZD') > 0 then
            set alldam = alldam * 1.4
        else
            set alldam = alldam * 1.2
        endif
    endif
    if GetUnitAbilityLevel(target, 'A0TW') != 0 then
        call UnitRemoveAbility(target, 'A0TW')
    endif
    if GetUnitAbilityLevel(caster, 'B08F') != 0 then
        set alldam = alldam * 1.3
    endif
    if GetUnitAbilityLevel(caster, 'B08H') != 0 then
        set alldam = alldam * (0.9 - 0.1 * GetUnitAbilityLevel(caster, 'B08H'))
    endif
    if GetUnitAbilityLevel(caster, 'B08G') != 0 then
        set alldam = alldam * (1.1 + 0.1 * GetUnitAbilityLevel(caster, 'B08G'))
    endif
    if damage > 2 and GetUnitAbilityLevel(target, 'B08A') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
        if GetUnitAbilityLevel(target, 'B08A') == 1 then
            call UnitSlowTarget(caster, target, 2.0, 'A0TP', 'B08J')
        endif
        if GetUnitAbilityLevel(target, 'B08A') == 2 then
            call UnitSlowTarget(caster, target, 3.0, 'A0TU', 'B08J')
        endif
    endif
    if damage > 2 and GetUnitAbilityLevel(target, 'B08B') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
        call NewWeather_HW_Init(target)
    endif
    if GetUnitAbilityLevel(target, 'A0YP') >= 0 then
        call UnitRemoveAbility(target, 'A0YP')
    endif
    if GetUnitTypeId(target) == 'n006' then
        set alldam = alldam * 0.5
    endif
    if GetUnitAbilityLevel(hero, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 + GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    if GetUnitAbilityLevel(target, 'B058') >= 1 and GetRandomInt(0, 100) <= 36 then
        set alldam = alldam * (1 - GetUnitAbilityLevel(udg_SK_Twei04_Twei, 'A0N5') * 0.12)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GetUnitX(target), GetUnitY(target)))
    endif
    set alldam = alldam * ReisenReduce(caster)
    if GetUnitAbilityLevel(target, 'A1HE') != 0 and GetUnitAbilityLevel(caster, 'A1HF') == 0 then
        set alldam = 0
    endif
    if GetUnitAbilityLevel(target, 'A0MQ') != 0 then
        set alldam = 0
    endif
    set demax = UnitTotalReduce(target, caster)
    set alldam = alldam * (1 - demax)
    set decdamoutput = UnitDefendsReduce(target, alldam)
    if udg_SK_Hina03_Broke then
        set udg_SK_Hina03_Broke = false
        set hina = LoadUnitHandle(udg_Hashtable_Slow, GetHandleId(target), 'A070' * -10)
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), 350, null)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitAlly(v, GetOwningPlayer(hina)) == false then
                call UnitMagicDamageTarget(hina, v, 20 + GetUnitAbilityLevel(hina, 'A0IH') * 10 + GetUnitState(hina, UNIT_STATE_MAX_LIFE) * (0.02 + 0.01 * GetUnitAbilityLevel(hina, 'A0IH')), 6)
            endif
        endloop
        call DestroyGroup(g)
        if GetUnitAbilityLevel(target, 'A0JL') != 0 then
            call UnitManaingTarget(hina, hina, (3 + GetUnitAbilityLevel(hina, 'A0IH') * 7) * 3)
        else
            call UnitManaingTarget(hina, hina, 3 + GetUnitAbilityLevel(hina, 'A0IH') * 7)
        endif
        set g = null
        set hina = null
        set v = null
    endif
    call WordDamageInNormal(caster, target, alldam)
    call UnitDamageTarget(caster, target, 0, false, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    call UnitDamageTarget(damageunit, target, alldam - decdamoutput, false, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    call Stat_AddDamage(caster, target, alldam, udg_STATS_DTYPE_ABS)
    set damageunit = null
    set hero = null
    return alldam - decdamoutput
endfunction

function UnitAbsDamageArea takes unit caster, real x, real y, real range, real damage returns nothing
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitAbsDamageTarget(caster, v, damage)
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function UnitMagicDamageArea takes unit caster, real x, real y, real range, real damage, integer dtype returns nothing
    local unit v
    local group g = CreateGroup()
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    call GroupEnumUnitsInRange(g, x, y, range, iff)
    loop
        set v = FirstOfGroup(g)
    exitwhen v == null
        call GroupRemoveUnit(g, v)
        if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
            call UnitMagicDamageTarget(caster, v, damage, dtype)
        endif
    endloop
    call DestroyGroup(g)
    set v = null
    set g = null
    set iff = null
endfunction

function InstantKill takes unit caster, unit target returns nothing
    local real damage = GetUnitState(target, UNIT_STATE_LIFE) * 1.5
    local real hp
    if IsUnitType(target, UNIT_TYPE_GIANT) then
        set damage = 2000.0
    elseif GetUnitAbilityLevel(target, 'A0MQ') != 0 then
        set damage = 0.0
    elseif IsUnitUUZ(target) or GetUnitTypeId(target) == 'n006' then
        set damage = 300.0
    else
        set damage = GetUnitState(target, UNIT_STATE_LIFE) * 1.55 + 550
    endif
    set hp = GetUnitState(target, UNIT_STATE_LIFE)
    call UnitDelDamageTarget(caster, target, damage)
    if IsUnitType(target, UNIT_TYPE_DEAD) == false then
        call UnitAbsDamageTarget(caster, target, damage)
    endif
endfunction

function UnitDamageTargetHina takes unit caster, unit target, real damage, integer dtype, real dtime returns nothing
    local unit u = udg_SK_HinaUnit01
    call UnitAbsDamageTarget(u, target, damage)
endfunction

function UnitDamageTargetHinaII takes unit caster, unit target, real damage, integer dtype returns nothing
    local unit u = udg_SK_HinaUnit02
    call UnitAbsDamageTarget(u, target, damage)
endfunction

function InitTrig_OverAllDamageSystem takes nothing returns nothing
endfunction