function DelayZeroSecondHealing takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local real heal = LoadReal(udg_ht, task, 2)
    call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + heal)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Trig_AttackcountSystem_Actions takes nothing returns nothing
    local unit caster = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local unit hero = GetPlayerCharacter(GetOwningPlayer(caster))
    local unit thero = GetPlayerCharacter(GetOwningPlayer(target))
    local real damage = GetEventDamage()
    local real alldam = 0.0
    local real tredam = damage
    local real incdam = 0.0
    local real critx = 0.0
    local real demax = 0.0
    local real decdamoutput = 0.0
    local integer k = GetPlayerId(GetOwningPlayer(caster))
    local unit damageunit = udg_A_PhysicalDamageUnit[k]
    local integer physicimmune = 0
    local timer t
    local integer task
    local boolean nitorid = false
    local real targetarmor = 0
    local real returnturedamage = 0
    local real armorpenetrateamount = 0
    local real newtargetarmor = 0
    local group g
    local unit hina
    local unit v
    if not IsDamageNotUnitAttack(caster) then
        call Stat_AddDamage(caster, target, damage, udg_STATS_DTYPE_PHYS)
    endif
    if damage == 0 or IsDamagePhsyicalAttack(caster) then
        set caster = null
        set target = null
        set hero = null
        set damageunit = null
        return
    endif
    if GetUnitAbilityLevel(target, 'Avul') != 0 then
        set caster = null
        set target = null
        set hero = null
        set damageunit = null
        return
    endif
    set udg_A_DamagingUnit = caster
    set alldam = tredam * 1.0
    set alldam = alldam * BaseHeroReduction(target)
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
    if IsUnitType(target, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(caster, 'A0WJ') != 0 then
        set alldam = alldam * 0.5
    endif
    if udg_NewWeather_InWeather then
        if GetUnitAbilityLevel(target, 'A0TW') != 0 then
            call UnitRemoveAbility(target, 'A0TW')
        elseif GetUnitAbilityLevel(caster, 'B08F') != 0 then
            set alldam = alldam * 1.3
        elseif GetUnitAbilityLevel(caster, 'B08H') != 0 then
            set alldam = alldam * 0.7
        elseif GetUnitAbilityLevel(caster, 'B08G') != 0 then
            set alldam = alldam * 1.3
        elseif damage > 2 and GetUnitAbilityLevel(target, 'B08A') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
            if GetUnitAbilityLevel(target, 'B08A') == 1 then
                call UnitSlowTarget(caster, target, 2.0, 'A0TP', 'B08J')
            endif
        elseif damage > 2 and GetUnitAbilityLevel(target, 'B08B') > 0 and IsUnitType(caster, UNIT_TYPE_HERO) then
            call NewWeather_HW_Init(target)
        endif
    endif
    if GetUnitTypeId(target) == 'h00B' or GetUnitTypeId(target) == 'h00I' then
        if IsPointInAllyHome(GetUnitX(target), GetUnitY(target), target) then
            set alldam = 0
            set physicimmune = 1
        endif
    endif
    if GetUnitAbilityLevel(target, 'A01T') >= 1 then
        set alldam = 0
        set physicimmune = 1
    endif
    if GetUnitAbilityLevel(target, 'A1HE') != 0 and GetUnitAbilityLevel(caster, 'A1HF') == 0 then
        set alldam = 0
    endif
    if GetUnitAbilityLevel(target, 'A0EA') >= 1 then
        set alldam = 0
        set physicimmune = 1
    endif
    if GetUnitAbilityLevel(caster, 'B09M') > 0 then
        call DebugMsg("weaken Physical Damage ")
        set alldam = alldam * (1 - (0.08 + 0.04 * GetUnitAbilityLevel(caster, 'B09M')))
    endif
    if GetUnitAbilityLevel(target, 'A155') >= 1 then
        set alldam = 0
        set physicimmune = 1
    elseif GetUnitAbilityLevel(target, 'A1CF') >= 1 then
        set alldam = 0
        set physicimmune = 1
    endif
    if GetUnitAbilityLevel(caster, 'A0ZD') == 0 then
        if IsUnitType(caster, UNIT_TYPE_STRUCTURE) or GetUnitTypeId(caster) == 'n006' or IsUnitUUZ(caster) or GetUnitAbilityLevel(caster, 'A0ZU') > 0 then
            set alldam = alldam * (1 - (1 - UnitPhysicalReduce(target)) * 0.5)
        elseif IsUnitType(caster, UNIT_TYPE_HERO) == false and IsDamagePhsyicalAbilityDamage(caster) == false and IsDamagePhsyicalItemDamage(caster) == false then
            set alldam = alldam * UnitPhysicalReduce(target)
        endif
    endif
    set incdam = UnitPhysIncreaseValue(hero, target)
    set alldam = alldam * (1 + incdam)
    if IsUnitType(caster, UNIT_TYPE_STRUCTURE) and IsUnitType(target, UNIT_TYPE_HERO) then
        if GetUnitAbilityLevel(caster, 'A0FE') == 0 then
            set alldam = alldam * 1.5
        endif
    elseif IsUnitType(caster, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(target, 'A0ZU') > 0 then
        if GetUnitAbilityLevel(caster, 'A0FE') == 0 then
            set alldam = alldam * 1.5
        endif
    endif
    if GetUnitAbilityLevel(caster, 'B06L') >= 1 then
        set alldam = alldam * 1.2
    endif
    if GetUnitAbilityLevel(target, 'A182') >= 1 then
        set alldam = alldam * (1 + GetUnitAbilityLevel(target, 'A182') * 0.1 + 0.1)
    endif
    if GetUnitAbilityLevel(target, 'B02K') != 0 then
        call UnitRemoveAbility(target, 'B02K')
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
    if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I06Y') then
        set alldam = alldam * 1.12
    endif
    set demax = UnitTotalReduce(target, hero)
    if GetUnitAbilityLevel(target, 'A08V') >= 1 and IsUnitType(caster, UNIT_TYPE_STRUCTURE) == false then
        set demax = 1.0
    endif
    set alldam = alldam * (1 - demax)
    if GetUnitTypeId(caster) == 'n006' and GetUnitTypeId(target) == 'E011' then
        set critx = 4.0
    elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) or IsDamagePhsyicalItemDamage(caster) then
        set critx = 1.0
    elseif GetUnitAbilityLevel(caster, 'A06R') > 0 and not IsUnitInGroup(target, LoadGroupHandle(udg_sht, StringHash("Flandre04"), GetHandleId(caster))) then
        set critx = 1.0
        set alldam = alldam * (2.5 + 1.5 * GetUnitAbilityLevel(caster, 'A06R'))
    elseif GetUnitAbilityLevel(caster, 'A0ZU') > 0 then
        set critx = HeroCriticalValue(caster)
    elseif IsUnitIllusion(caster) then
        set critx = HeroCriticalValue(caster)
    else
        set critx = HeroCriticalValue(hero)
    endif
    if GetUnitAbilityLevel(caster, 'A0LL') >= 1 then
        set nitorid = true
    endif
    if nitorid and critx > 1.0 then
        set critx = critx + 0.5
    elseif nitorid then
        set critx = 1.5
    endif
    if GetUnitAbilityLevel(thero, 'A0Q8') > 0 then
        if critx > 1.0 then
            if GetRandomInt(0, 100) <= 20 then
                set critx = 1.0
                call WordDamageCriticalBlock(caster, target)
            else
                set critx = critx * 0.75
            endif
        else
            if GetRandomInt(0, 100) <= 20 then
                set alldam = 0
                call WordDamagePhysicGraze(caster, target)
            endif
        endif
    endif
    if critx > 1.0 then
        set alldam = alldam * critx
    endif
    set targetarmor = GetUnitArmor(target)
    set returnturedamage = alldam / (1 - GetArmorResistTrueValue(targetarmor))
    set armorpenetrateamount = 0
    if YDWEUnitHasItemOfTypeBJNull(GetPlayerCharacter(GetOwningPlayer(caster)), 'I026') and not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        set armorpenetrateamount = armorpenetrateamount + targetarmor * 0.4
    endif
    if GetUnitAbilityLevel(caster, 'A10T') > 0 and not IsUnitType(target, UNIT_TYPE_STRUCTURE) then
        set armorpenetrateamount = armorpenetrateamount + targetarmor * 0.35
    endif
    if GetUnitAbilityLevel(caster, 'A08U') > 0 then
        if targetarmor > 16 then
            set armorpenetrateamount = armorpenetrateamount + (targetarmor - 16) * 0.25
        endif
        if targetarmor > 12 then
            set armorpenetrateamount = armorpenetrateamount + (targetarmor - 12) * 0.25
        endif
        if targetarmor > 8 then
            set armorpenetrateamount = armorpenetrateamount + (targetarmor - 8) * 0.25
        endif
        if targetarmor > 4 then
            set armorpenetrateamount = armorpenetrateamount + (targetarmor - 4) * 0.25
        endif
    endif
    if armorpenetrateamount > 0 then
        set newtargetarmor = targetarmor - armorpenetrateamount
        set alldam = returnturedamage * (1 - GetArmorResistTrueValue(newtargetarmor))
    endif
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
    if alldam - decdamoutput > tredam then
        call UnitDamageTarget(damageunit, target, alldam - decdamoutput - tredam, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_DEMOLITION, WEAPON_TYPE_WHOKNOWS)
    elseif alldam - decdamoutput < tredam then
        if GetUnitState(target, UNIT_STATE_LIFE) - damage <= 0 then
            call SetUnitState(target, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE) + tredam - (alldam - decdamoutput))
        else
            set t = CreateTimer()
            set task = GetHandleId(t)
            call SaveTimerHandle(udg_ht, task, 0, t)
            call SaveUnitHandle(udg_ht, task, 1, target)
            call SaveReal(udg_ht, task, 2, tredam - (alldam - decdamoutput))
            call TimerStart(t, 0, false, function DelayZeroSecondHealing)
        endif
    endif
    if critx > 1.0 then
        call WordDamageInRed(caster, target, alldam)
    else
        call WordDamageInNormal(caster, target, alldam)
    endif
    if physicimmune == 1 then
        call WordDamagePhysicImmune(caster, target)
    endif
    if IsDamagePhsyicalItemDamage(caster) or IsDamagePhsyicalAbilityDamage(caster) then
        call UnitLifeSteal(hero, alldam * 0.5)
    elseif GetUnitTypeId(target) == 'n006' then
        call UnitLifeSteal(hero, alldam * 0.75)
    elseif IsUnitType(target, UNIT_TYPE_STRUCTURE) == false then
        call UnitLifeSteal(hero, alldam)
    endif
    set caster = null
    set target = null
    set hero = null
    set thero = null
    set damageunit = null
    set t = null
endfunction

function InitTrig_AttackcountSystem takes nothing returns nothing
    set gg_trg_AttackcountSystem = CreateTrigger()
    call RegisterAnyUnitDamage(gg_trg_AttackcountSystem)
    call TriggerAddAction(gg_trg_AttackcountSystem, function Trig_AttackcountSystem_Actions)
endfunction