function KaguyaX_Illusion_Property takes nothing returns nothing
    local integer i = 1
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(LoadTriggerHandle(udg_ht, GetHandleId(t), 0))
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer cnt = LoadInteger(udg_ht, task, -1)
    local unit ill
    local real delta
    loop
    exitwhen i > cnt
        set ill = LoadUnitHandle(udg_ht, task, i)
        set delta = (GetHeroInt(caster, true) - GetHeroInt(ill, false)) * 0.45 - LoadInteger(udg_ht, task, i + 100 + 10 * 1)
        if delta != 0 then
            call UnitAddBonusInt(ill, R2I(delta))
            call SaveInteger(udg_ht, task, i + 100 + 10 * 1, LoadInteger(udg_ht, task, i + 100 + 10 * 1) + R2I(delta))
            call DebugMsg("Int Delta:" + R2S(delta))
        endif
        set delta = (GetHeroStr(caster, true) - GetHeroStr(ill, false)) * 0.45 - LoadInteger(udg_ht, task, i + 100 + 10 * 2)
        if delta != 0 then
            call UnitAddBonusStr(ill, R2I(delta))
            call SaveInteger(udg_ht, task, i + 100 + 10 * 2, LoadInteger(udg_ht, task, i + 100 + 10 * 2) + R2I(delta))
            call DebugMsg("Str Delta:" + R2S(delta))
        endif
        set delta = I2R(R2I((GetHeroAgi(caster, true) - GetHeroAgi(ill, false)) * 0.45)) - LoadInteger(udg_ht, task, i + 100 + 10 * 3)
        if delta != 0 then
            call UnitAddBonusAgi(ill, R2I(delta))
            call SaveInteger(udg_ht, task, i + 100 + 10 * 3, LoadInteger(udg_ht, task, i + 100 + 10 * 3) + R2I(delta))
            call DebugMsg("Agi Delta:" + R2S(delta))
        endif
        if GetUnitAbilityLevel(caster, 'A1CO') > 0 then
            if GetUnitAbilityLevel(caster, 'A1BN') != 0 then
                if GetUnitAbilityLevel(ill, 'A1BN') == 0 then
                    call UnitAddAbility(ill, 'A1BN')
                endif
                call SetUnitAbilityLevel(ill, 'A1BN', GetUnitAbilityLevel(caster, 'A1BN'))
            endif
            if GetUnitAbilityLevel(caster, 'A1BO') != 0 then
                if GetUnitAbilityLevel(ill, 'A1BO') == 0 then
                    call UnitAddAbility(ill, 'A1BO')
                endif
                call SetUnitAbilityLevel(ill, 'A1BO', GetUnitAbilityLevel(caster, 'A1BO'))
            endif
            if GetUnitAbilityLevel(caster, 'A1BP') != 0 then
                if GetUnitAbilityLevel(ill, 'A1BP') == 0 then
                    call UnitAddAbility(ill, 'A1BP')
                endif
                call SetUnitAbilityLevel(ill, 'A1BP', GetUnitAbilityLevel(caster, 'A1BP'))
            endif
        endif
        if GetUnitAbilityLevel(caster, 'A1BQ') != 0 then
            if GetUnitAbilityLevel(ill, 'A1BQ') == 0 then
                call UnitAddAbility(ill, 'A1BQ')
            endif
            call SetUnitAbilityLevel(ill, 'A1BQ', GetUnitAbilityLevel(caster, 'A1BQ'))
        endif
        call SetUnitState(ill, UNIT_STATE_MANA, GetUnitState(ill, UNIT_STATE_MANA) + GetUnitMagicRegen(caster) * 0.5)
        call SetUnitState(ill, UNIT_STATE_LIFE, GetUnitState(ill, UNIT_STATE_LIFE) + GetUnitLifeRegen(caster) * 0.5)
        call AddHeroXP(caster, GetHeroXP(ill) - LoadInteger(udg_ht, task, i + 100 + 10 * 0), true)
        set i = i + 1
    endloop
    set i = 1
    loop
    exitwhen i > cnt
        set ill = LoadUnitHandle(udg_ht, task, i)
        call SetHeroXP(ill, GetHeroXP(caster), true)
        call SaveInteger(udg_ht, task, i + 100 + 10 * 0, GetHeroXP(ill))
        set i = i + 1
    endloop
    set caster = null
    set t = null
    set ill = null
endfunction

function KaguyaX_FindSpellUnit takes trigger trg, unit u, real rdis returns integer
    local integer cnt
    local integer i
    local integer tsk = GetHandleId(trg)
    local unit ill
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real ax
    local real ay
    local real dis
    set cnt = LoadInteger(udg_ht, tsk, -1)
    set i = 0
    loop
    exitwhen i > cnt
        set ill = LoadUnitHandle(udg_ht, tsk, i)
        if GetWidgetLife(ill) > 0.405 then
            set ax = GetUnitX(ill)
            set ay = GetUnitY(ill)
            set dis = SquareRoot((ox - ax) * (ox - ax) + (oy - ay) * (oy - ay))
            if dis < rdis then
                set ill = null
                return i
            endif
        endif
        set i = i + 1
    endloop
    set ill = null
    return -1
endfunction

function KaguyaX_IsSpellable takes unit caster, unit target, real mdis returns boolean
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real ax = GetUnitX(target)
    local real ay = GetUnitY(target)
    local real dis = SquareRoot((ox - ax) * (ox - ax) + (oy - ay) * (oy - ay))
    if dis < mdis then
        return true
    endif
    return false
endfunction

function KaguyaX02_Count takes unit u returns real
    local real i = -1
    set i = i + GetUnitAbilityLevel(u, 'A1BS' + 1) * 1.0
    set i = i + GetUnitAbilityLevel(u, 'A1BS' + 2) * 1.5
    set i = i + GetUnitAbilityLevel(u, 'A1BS' + 3) * 2.0
    set i = i + GetUnitAbilityLevel(u, 'A1BS' + 4) * 2.5
    return i
endfunction

function KaguyaX02_End takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer abi = LoadInteger(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local integer multi = LoadInteger(udg_ht, task, 2)
    local integer lvl
    if u != null then
        set lvl = GetUnitAbilityLevel(u, abi) - multi
        if lvl <= 0 then
            call UnitRemoveAbility(u, 'A1BX')
            call UnitRemoveAbility(u, abi)
        else
            call SetUnitAbilityLevel(u, abi, lvl)
        endif
    endif
    call DebugMsg("Kaguya02,Level Reduce " + I2S(multi) + " Current:" + I2S(GetUnitAbilityLevel(u, abi)))
    call PauseTimer(t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set u = null
endfunction

function KaguyaX02_Buff takes unit caster, unit u, integer multi returns nothing
    local integer abi = 'A1BS' + GetUnitAbilityLevel(caster, 'A1BO')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    if GetUnitAbilityLevel(u, abi) == 0 then
        call UnitAddAbility(u, abi)
    else
        call SetUnitAbilityLevel(u, abi, GetUnitAbilityLevel(u, abi) + multi)
    endif
    call DebugMsg("Kaguya02,Level Add " + I2S(multi) + " Current:" + I2S(GetUnitAbilityLevel(u, abi)))
    call SaveUnitHandle(udg_ht, task, 0, u)
    call SaveInteger(udg_ht, task, 1, abi)
    call SaveInteger(udg_ht, task, 2, multi)
    if GetUnitTypeId(u) == 'H02H' or GetUnitTypeId(u) == 'H02G' then
        call TimerStart(t, 5.0, false, function KaguyaX02_End)
    else
        call TimerStart(t, 5.0, false, function KaguyaX02_End)
    endif
    call UnitAddAbility(u, 'A1BX')
    set t = null
endfunction

function KaguyaX_Illusion_Init takes trigger trg, unit u returns nothing
    local integer task
    local integer i
    local unit caster = LoadUnitHandle(udg_ht, GetHandleId(trg), 0)
    set task = GetHandleId(trg)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
    set i = LoadInteger(udg_ht, task, -1) + 1
    call SaveInteger(udg_ht, task, -1, i)
    call SaveUnitHandle(udg_ht, task, i, u)
    call DebugMsg("NewIllusion Register in" + I2S(i))
    if GetUnitAbilityLevel(caster, 'A1CO') > 0 then
        call UnitAddAbility(u, 'A1BR')
        call UnitAddAbility(u, 'A1CO')
        call UnitAddAbility(u, 'A1BM')
        call UnitAddAbility(u, 'A1CP')
        call UnitAddAbility(u, 'A1CT')
    else
        call UnitAddBonusDmg(u, -2000)
        call UnitAddAbility(u, 'Avul')
    endif
    call UnitAddAbility(u, 'A1BQ')
    set caster = null
endfunction

function KaguyaX_Ability01_OnFunc takes nothing returns nothing
    local unit caster = udg_PS_Source
    local unit target = udg_PS_Target
    local integer level
    local real multi = 1.0
    if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
        if caster != GetPlayerCharacter(GetOwningPlayer(caster)) then
            set multi = 0.85
        endif
        set caster = GetPlayerCharacter(GetOwningPlayer(caster))
    endif
    set level = GetUnitAbilityLevel(caster, 'A1BN')
    if GetUnitTypeId(target) == 'H02H' or GetUnitTypeId(target) == 'H02G' then
        call UnitHealingTarget(caster, target, (20 + 10 * level + GetUnitState(caster, UNIT_STATE_MAX_MANA) * 0.03) * 1.75)
        if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
            call UnitCurseTarget(caster, target, (1.0 + 0.25 * level) * 1, 'A0X5', "antimagicshell")
        endif
    else
        call UnitManaingTarget(caster, target, 20 + 10 * level + GetUnitState(target, UNIT_STATE_MAX_MANA) * 0.03)
        call UnitCurseTarget(caster, target, 1.0 + 0.25 * level, 'A0OK', "drunkenhaze")
    endif
    if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
    endif
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", GetUnitX(target), GetUnitY(target)))
    set target = null
    set caster = null
endfunction

function KaguyaX04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1) + 1
    local real x = LoadReal(udg_ht, task, 2)
    local real y = LoadReal(udg_ht, task, 3)
    local trigger trg
    local integer tsk
    local integer cnt
    local integer j
    local unit ill
    local unit tu = null
    call SaveInteger(udg_ht, task, 1, i)
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", x, y))
    if GetUnitCurrentOrder(u) == OrderId("unloadall") and i < 36 then
        if i >= 35 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", GetUnitX(u), GetUnitY(u)))
            call DebugMsg("Kaguya04Effect")
            set trg = LoadTriggerHandle(udg_ht, task, 4)
            set tsk = GetHandleId(trg)
            set cnt = LoadInteger(udg_ht, tsk, -1)
            set j = 1
            set tu = null
            loop
            exitwhen j > cnt or tu != null
                set ill = LoadUnitHandle(udg_ht, tsk, j)
                if ill != null and GetOwningPlayer(ill) != GetOwningPlayer(u) then
                    set tu = ill
                endif
                set j = j + 1
            endloop
            if GetUnitTypeId(u) == 'H02H' then
                call SetUnitX(u, x)
                call SetUnitY(u, y)
                call DebugMsg("Kaguya04Effect-TelPort-Illusion")
                call AbilityCoolDownResetion(u, 'A1BQ', 40)
            elseif tu != null then
                call ShowUnit(ill, true)
                call ReviveHero(ill, x, y, false)
                call SetUnitX(ill, x)
                call SetUnitY(ill, y)
                call SetUnitOwner(ill, GetOwningPlayer(u), true)
                call ShowUnit(ill, true)
                call DebugMsg("Kaguya04Effect-ReviveHero")
                call AbilityCoolDownResetion(u, 'A1BQ', 25)
            elseif cnt < GetUnitAbilityLevel(u, 'A1BQ') - 1 then
                call DebugMsg("Kaguya04Effect-NewIllusion")
                set ill = CreateUnit(GetOwningPlayer(u), 'H02H', x, y, 0)
                call KaguyaX_Illusion_Init(trg, ill)
                call AbilityCoolDownResetion(u, 'A1BQ', 25)
            else
                call DebugMsg("Kaguya04Effect-Teleport")
                call SetUnitX(u, x)
                call SetUnitY(u, y)
            endif
        endif
    else
        call PauseTimer(t)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
    set trg = null
    set ill = null
    set tu = null
endfunction

function KaguyaX04_Effect takes unit caster, real x, real y, trigger trg returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveReal(udg_ht, task, 2, x)
    call SaveReal(udg_ht, task, 3, y)
    call SaveTriggerHandle(udg_ht, task, 4, trg)
    call TimerStart(t, 0.1, true, function KaguyaX04_Main)
    set t = null
endfunction

function KaguyaXEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local lightning l = LoadLightningHandle(udg_ht, task, 2)
    local real dis = LoadReal(udg_ht, task, 3)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz
    local real a = Atan2(ty - oy, tx - ox)
    local integer i = LoadInteger(udg_ht, task, 1)
    set oz = GetPositionZ(ox, oy) + GetUnitFlyHeight(caster) + 60
    set tz = GetPositionZ(tx, ty) + GetUnitFlyHeight(target) + 60
    if i > 0 then
        call MoveLightningEx(l, false, ox, oy, oz, tx, ty, tz)
        if not IsUnitInRange(caster, target, 1200.0) or GetUnitAbilityLevel(caster, 'A09Z') != 0 or GetUnitAbilityLevel(target, 'A09Z') != 0 or GetUnitAbilityLevel(caster, 'A1BZ') == 0 then
            set i = -1
        else
            if not IsUnitInRange(caster, target, dis) and IsMobileUnit(caster) then
                set ox = tx - dis * Cos(a)
                set oy = ty - dis * Sin(a)
                call SetUnitXYFly(caster, ox, oy)
            endif
        endif
        if GetWidgetLife(caster) < 0.405 then
            set i = -1
        endif
        call SaveInteger(udg_ht, task, 1, i)
    else
        call DestroyLightning(l)
        call SetUnitFlag(caster, 3, false)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set l = null
    set caster = null
    set target = null
endfunction

function KaguyaXEx_Effect takes unit caster, unit target returns nothing
    local timer t
    local integer task
    local lightning l
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real oz
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real tz
    local real dis = SquareRoot((ox - tx) * (ox - tx) + (oy - ty) * (oy - ty))
    set t = CreateTimer()
    set task = GetHandleId(t)
    set oz = GetPositionZ(ox, oy) + GetUnitFlyHeight(caster) + 60
    set tz = GetPositionZ(tx, ty) + GetUnitFlyHeight(target) + 60
    set l = AddLightningEx("LEAS", true, ox, oy, oz, tx, ty, tz)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveLightningHandle(udg_ht, task, 2, l)
    call SaveInteger(udg_ht, task, 1, 250)
    call SaveReal(udg_ht, task, 3, dis)
    call SetUnitFlag(caster, 3, true)
    call TimerStart(t, 0.02, true, function KaguyaXEx_Main)
    set t = null
    set l = null
endfunction

function KaguyaX_Ability takes nothing returns boolean
    local trigger trg = GetTriggeringTrigger()
    local integer tsk = GetHandleId(trg)
    local unit caster
    local unit target
    local integer i
    local integer cnt
    local unit ill
    local real x
    local integer level
    local real y
    local unit v
    local group g
    local unit spellu
    local integer spelluid
    local group hg
    if GetTriggerEventId() == EVENT_UNIT_DEATH then
        set target = GetKillingUnit()
        set cnt = LoadInteger(udg_ht, tsk, -1)
        call DebugMsg("ProgDeath")
        set i = 0
        loop
        exitwhen i > cnt
            set ill = LoadUnitHandle(udg_ht, tsk, i)
            if i != 0 then
                call SetUnitOwner(ill, Player(PLAYER_NEUTRAL_PASSIVE), true)
            endif
            if GetWidgetLife(ill) > 0.405 then
                call UnitAddAbility(ill, 'A0MS')
                call KillUnit(ill)
                call UnitRemoveAbility(ill, 'A0MS')
                call CreateUnit(GetOwningPlayer(ill), 'n01J', x, y, 270.0)
            endif
            set i = i + 1
        endloop
        set target = null
        set ill = null
    elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
        set caster = GetTriggerUnit()
        set level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        call DebugMsg("KaguyaAbility")
        if GetSpellAbilityId() == 'A1BN' then
            set target = GetSpellTargetUnit()
            if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
                set spelluid = KaguyaX_FindSpellUnit(trg, target, 800)
                if spelluid == -1 then
                    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff4444No suitable unit found|r")
                    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0.1)
                    set caster = null
                    set target = null
                    return false
                endif
                set spellu = LoadUnitHandle(udg_ht, tsk, spelluid)
                call SetUnitAnimation(caster, "spell")
            else
                set spellu = caster
                if KaguyaX_IsSpellable(caster, target, 800) == false then
                    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff4444Insufficient cast range|r")
                    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0.1)
                    set caster = null
                    set target = null
                    return false
                endif
            endif
            call DebugMsg("KaguyaX01")
            call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.05 + 20, 1)
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 8 - level * 1)
            if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
                if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
                    call Item_BLTalismanicRunningCD(target)
                    set target = null
                    set caster = null
                    return false
                endif
            endif
            if GetUnitAbilityLevel(caster, 'A1CL') > 0 then
                if caster == target then
                    set cnt = LoadInteger(udg_ht, tsk, -1)
                    set i = 0
                    loop
                    exitwhen i > cnt
                        set ill = LoadUnitHandle(udg_ht, tsk, i)
                        if GetWidgetLife(ill) > 0.405 then
                            call IssueTargetOrder(ill, "unburrow", ill)
                        endif
                        set i = i + 1
                    endloop
                    set ill = null
                else
                    set cnt = LoadInteger(udg_ht, tsk, -1)
                    set i = 0
                    loop
                    exitwhen i > cnt
                        set ill = LoadUnitHandle(udg_ht, tsk, i)
                        if GetWidgetLife(ill) > 0.405 then
                            call IssueTargetOrder(ill, "unburrow", target)
                        endif
                        set i = i + 1
                    endloop
                    set ill = null
                endif
            endif
            call LaunchProjectileToUnit("Abilities\\Spells\\Other\\StrongDrink\\BrewmasterMissile.mdl", 1.0, spellu, 1000, target, "KaguyaX_Ability01_OnFunc")
            set target = null
        elseif GetSpellAbilityId() == 'A1BO' then
            call DebugMsg("Kaguya02")
            set hg = CreateGroup()
            call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.02 + 50, 1)
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 20 - level * 2)
            if GetUnitAbilityLevel(caster, 'A1CO') != 0 then
                set x = GetUnitX(caster)
                set y = GetUnitY(caster)
                set g = CreateGroup()
                call KaguyaX02_Buff(caster, caster, 1)
                call GroupEnumUnitsInRange(g, x, y, 600.0, null)
                loop
                    set v = FirstOfGroup(g)
                exitwhen v == null
                    call GroupRemoveUnit(g, v)
                    if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and v != caster then
                        if GetUnitTypeId(v) == 'H02H' or GetUnitTypeId(v) == 'H02G' then
                        else
                            call KaguyaX02_Buff(caster, v, 1)
                        endif
                        if IsUnitType(v, UNIT_TYPE_HERO) and IsUnitInGroup(v, hg) == false then
                            call GroupAddUnit(hg, v)
                            call KaguyaX02_Buff(caster, caster, 1)
                            call LaunchProjectileToUnit("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", 1.0, v, 500, caster, "")
                        endif
                        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", GetUnitX(v), GetUnitY(v)))
                    elseif IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
                        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", GetUnitX(v), GetUnitY(v)))
                        if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
                            call UnitMagicDamageTarget(caster, v, (level * 40 + GetHeroInt(caster, true) * 1.6) * 1.0, 1)
                        else
                            call UnitMagicDamageTarget(caster, v, (level * 40 + GetHeroInt(caster, true) * 1.6) * 1.0 * 0.8, 1)
                        endif
                    endif
                endloop
                call DestroyGroup(g)
            else
                set cnt = LoadInteger(udg_ht, tsk, -1)
                set i = 0
                loop
                exitwhen i > cnt
                    call DebugMsg("Kaguya02Test: i = " + I2S(i))
                    set ill = LoadUnitHandle(udg_ht, tsk, i)
                    if GetWidgetLife(ill) > 0.405 then
                        set g = CreateGroup()
                        set x = GetUnitX(ill)
                        set y = GetUnitY(ill)
                        call GroupEnumUnitsInRange(g, x, y, 600.0, null)
                        loop
                            set v = FirstOfGroup(g)
                        exitwhen v == null
                            call GroupRemoveUnit(g, v)
                            if IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and v != caster then
                                if GetUnitTypeId(v) == 'H02H' or GetUnitTypeId(v) == 'H02G' then
                                else
                                    call KaguyaX02_Buff(caster, v, 1)
                                endif
                                if IsUnitType(v, UNIT_TYPE_HERO) and IsUnitInGroup(v, hg) == false then
                                    call GroupAddUnit(hg, v)
                                    call KaguyaX02_Buff(caster, caster, 1)
                                    call LaunchProjectileToUnit("Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl", 1.0, v, 500, ill, "")
                                endif
                                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", GetUnitX(v), GetUnitY(v)))
                            elseif IsUnitType(v, UNIT_TYPE_DEAD) == false and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and IsUnitAlly(caster, GetOwningPlayer(v)) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false then
                                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", GetUnitX(v), GetUnitY(v)))
                                if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
                                    call UnitMagicDamageTarget(caster, v, (level * 40 + GetHeroInt(caster, true) * 1.6) * 1.0, 1)
                                else
                                    call UnitMagicDamageTarget(caster, v, (level * 40 + GetHeroInt(caster, true) * 1.6) * 1.0 * 0.8, 1)
                                endif
                            endif
                        endloop
                        call DestroyGroup(g)
                    endif
                    set i = i + 1
                endloop
            endif
            call DestroyGroup(hg)
            if GetUnitAbilityLevel(caster, 'A1CL') > 0 then
                set cnt = LoadInteger(udg_ht, tsk, -1)
                set i = 0
                loop
                exitwhen i > cnt
                    set ill = LoadUnitHandle(udg_ht, tsk, i)
                    if GetWidgetLife(ill) > 0.405 then
                        call IssueImmediateOrder(ill, "undeadbuild")
                    endif
                    set i = i + 1
                endloop
                set ill = null
            endif
            set g = null
            set v = null
            set ill = null
            set hg = null
        elseif GetSpellAbilityId() == 'A1BP' then
            call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.05 + 20, 1)
            set target = GetSpellTargetUnit()
            if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
                set spelluid = KaguyaX_FindSpellUnit(trg, target, 800)
                if spelluid == -1 then
                    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff4444No suitable unit found|r")
                    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0.1)
                    set caster = null
                    set target = null
                    return false
                endif
                call SetUnitAnimation(caster, "spell")
            else
                if KaguyaX_IsSpellable(caster, target, 800) == false then
                    call DisplayTextToPlayer(GetOwningPlayer(caster), 0, 0, "|cffff4444Insufficient cast range|r")
                    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 0.1)
                    set caster = null
                    set target = null
                    return false
                endif
            endif
            call DebugMsg("udg_Kaguya03")
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 8 - level * 1)
            if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
                if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
                    call Item_BLTalismanicRunningCD(target)
                    set target = null
                    set caster = null
                    return false
                endif
            endif
            if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
                if GetUnitAbilityLevel(target, 'A1CV') == 0 then
                else
                endif
                call UnitBuffTarget(caster, target, 6, 'A1CV', 0)
            endif
            if GetUnitTypeId(target) == 'H02H' or GetUnitTypeId(target) == 'H02G' then
                if GetUnitAbilityLevel(caster, 'A1CO') == 0 then
                    call UnitBuffTarget(caster, target, (1 + level * 0.25) * 1, 'A1CG', 0)
                else
                    set v = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0)
                    call UnitAddAbility(v, 'A1BY')
                    call SetUnitAbilityLevel(v, 'A1BY', level)
                    call IssueTargetOrder(v, "banish", target)
                    call UnitRemoveAbility(v, 'A1BY')
                    call ReleaseDummy(v)
                endif
            else
                set v = NewDummy(GetOwningPlayer(caster), GetUnitX(caster), GetUnitY(caster), 0)
                call UnitAddAbility(v, 'A1BY')
                call SetUnitAbilityLevel(v, 'A1BY', level)
                call IssueTargetOrder(v, "banish", target)
                call UnitRemoveAbility(v, 'A1BY')
                call ReleaseDummy(v)
            endif
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\VengeanceMissile\\VengeanceMissile.mdl", GetUnitX(target), GetUnitY(target)))
            if GetUnitAbilityLevel(caster, 'A1CL') > 0 then
                if caster == target then
                    set cnt = LoadInteger(udg_ht, tsk, -1)
                    set i = 0
                    loop
                    exitwhen i > cnt
                        set ill = LoadUnitHandle(udg_ht, tsk, i)
                        if GetWidgetLife(ill) > 0.405 then
                            call IssueTargetOrder(ill, "unholyfrenzy", ill)
                        endif
                        set i = i + 1
                    endloop
                    set ill = null
                else
                    set cnt = LoadInteger(udg_ht, tsk, -1)
                    set i = 0
                    loop
                    exitwhen i > cnt
                        set ill = LoadUnitHandle(udg_ht, tsk, i)
                        if GetWidgetLife(ill) > 0.405 then
                            call IssueTargetOrder(ill, "unholyfrenzy", target)
                        endif
                        set i = i + 1
                    endloop
                    set ill = null
                endif
            endif
            set target = null
        elseif GetSpellAbilityId() == 'A1BQ' then
            call SetUnitAnimation(caster, "Spell Slam")
            call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.05 + 150, 1)
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 200 - 40 * level)
            call DebugMsg("Kaguya04")
            call KaguyaX04_Effect(caster, GetSpellTargetX(), GetSpellTargetY(), trg)
        elseif GetSpellAbilityId() == 'A1BR' then
            call DebugMsg("KaguyaX04Ex")
            call UnitMagicDamageTarget(caster, caster, GetWidgetLife(caster) * 0.05 + 50, 1)
            call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 60)
            set target = GetSpellTargetUnit()
            set x = GetUnitX(target)
            set y = GetUnitY(target)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", x, y))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", GetUnitX(caster), GetUnitY(caster)))
            call SetUnitX(target, GetUnitX(caster))
            call SetUnitY(target, GetUnitY(caster))
            call SetUnitX(caster, x)
            call SetUnitY(caster, y)
            set target = null
        elseif GetSpellAbilityId() == 'A1BM' then
            call UnitMagicDamageTarget(caster, caster, 40, 1)
            set target = GetSpellTargetUnit()
            call DebugMsg("KaguyaEx1")
            call UnitRemoveAbility(caster, 'A1BM')
            call UnitAddAbility(caster, 'A1BZ')
            if IsUnitAlly(target, GetOwningPlayer(caster)) == false then
                if IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
                    call Item_BLTalismanicRunningCD(target)
                    set target = null
                    set caster = null
                    return false
                endif
            endif
            call DebugMsg("KaguyaExMain")
            call KaguyaXEx_Effect(caster, target)
            set target = null
        elseif GetSpellAbilityId() == 'A1BZ' then
            call UnitRemoveAbility(caster, 'A1BZ')
            call UnitAddAbility(caster, 'A1BM')
        elseif GetSpellAbilityId() == 'A1CM' then
            call UnitAddAbility(caster, 'A1CO')
            call UnitAddAbility(caster, 'A1BR')
            call UnitRemoveAbility(caster, 'A1BS')
            call UnitAddAbility(caster, 'A1CT')
            call UnitRemoveAbility(caster, 'A1CN')
            call UnitRemoveAbility(caster, 'A1CM')
            call SetPlayerTechResearched(GetOwningPlayer(caster), 'R00C', 1)
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A1BQ', true)
        elseif GetSpellAbilityId() == 'A1CN' then
            call UnitRemoveAbility(caster, 'A1CN')
            call UnitRemoveAbility(caster, 'A1CM')
        endif
        set caster = null
    elseif false then
        set caster = GetPlayerCharacter(GetTriggerPlayer())
        if GetUnitAbilityLevel(caster, 'A1CL') == 0 then
            call UnitAddAbility(caster, 'A1CL')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "NEET Girl support casts!")
        else
            call UnitRemoveAbility(caster, 'A1CL')
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "NEET Girl support casts!")
        endif
    endif
    return false
endfunction

function KaguyaX_Init takes unit h returns nothing
    local integer task
    local integer task2
    local trigger trg = CreateTrigger()
    local timer t = CreateTimer()
    call SetHeroLifeIncreaseValue(h, 8)
    call SetHeroManaIncreaseValue(h, 0)
    call SetHeroManaBaseRegenValue(h, 0)
    set task2 = GetHandleId(trg)
    set task = GetHandleId(t)
    call SaveTriggerHandle(udg_ht, task, 0, trg)
    call SaveInteger(udg_ht, task2, -1, -1)
    call TriggerAddCondition(trg, Condition(function KaguyaX_Ability))
    call UnitAddAbility(h, 'A1CN')
    call UnitAddAbility(h, 'A1CM')
    call KaguyaX_Illusion_Init(trg, h)
    call UnitRemoveAbility(h, 'Avul')
    call UnitAddAbility(h, 'A1BS')
    call UnitAddAbility(h, 'A1BM')
    call UnitAddBonusDmg(h, 2000)
    call SetPlayerAbilityAvailable(GetOwningPlayer(h), 'A1BQ', false)
    call TimerStart(t, 0.5, true, function KaguyaX_Illusion_Property)
    set trg = null
    set t = null
endfunction

function Trig_Kaguya01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0D0'
endfunction

function Trig_Kaguya01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer level = LoadInteger(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer counter = LoadInteger(udg_ht, task, 11)
    local unit u
    local integer n = 0
    local real a = LoadReal(udg_ht, task, 10) + 2.0
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local integer R
    local integer G
    local integer B
    local unit v
    local group g
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local boolean k = false
    call SaveInteger(udg_ht, task, 11, counter + 1)
    loop
    exitwhen n > 6
        set u = LoadUnitHandle(udg_ht, task, n + 3)
        if GetWidgetLife(u) > 0.405 and GetWidgetLife(caster) > 0.405 then
            call SetUnitX(u, GetUnitX(caster) + 200 * Cos((a + n * 360 / 7) * 0.017454))
            call SetUnitY(u, GetUnitY(caster) + 200 * Sin((a + n * 360 / 7) * 0.017454))
        endif
        if GetWidgetLife(caster) <= 0.405 then
            call KillUnit(u)
        endif
        if GetWidgetLife(u) <= 0.405 then
        endif
        set n = n + 1
    endloop
    call SaveReal(udg_ht, task, 10, a)
    if ModuloInteger(counter, 25) == 0 and i < 7 and GetWidgetLife(caster) > 0.405 then
        call UnitMagicDamageTarget(caster, caster, (75 + 75 * level) / 7, 1)
        call KillUnit(LoadUnitHandle(udg_ht, task, i + 3))
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, ox, oy, 600.0, iff)
        loop
            set v = GroupPickRandomUnit(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_STRUCTURE) == false and GetUnitAbilityLevel(v, 'A0IL') > 0 == false and not IsUnitType(v, UNIT_TYPE_DEAD) then
                call UnitMagicDamageTarget(caster, v, (5 + 25 * level + 1.3 * GetHeroInt(caster, true)) * 1.0, 1)
                set k = true
            endif
        exitwhen k
        endloop
        call DestroyGroup(g)
        if k then
            set px = GetUnitX(v)
            set py = GetUnitY(v)
            set R = udg_SK_Kaguya01_RGB[i * 3 + 0]
            set G = udg_SK_Kaguya01_RGB[i * 3 + 1]
            set B = udg_SK_Kaguya01_RGB[i * 3 + 2]
            set u = CreateUnit(GetOwningPlayer(caster), 'n02Q', px, py, a)
            call SetUnitVertexColor(u, R, G, B, 255)
            call SetUnitTimeScale(u, 1.5)
            set u = CreateUnit(GetOwningPlayer(caster), 'n02Q', px, py, a)
            call SetUnitVertexColor(u, R, G, B, 255)
            call SetUnitTimeScale(u, 1.5)
            set u = CreateUnit(GetOwningPlayer(caster), 'n02Q', px, py, a + 180.0)
            call SetUnitVertexColor(u, R, G, B, 255)
            call SetUnitTimeScale(u, 1.5)
        endif
        call SaveInteger(udg_ht, task, 2, i + 1)
    endif
    if counter == 175 then
        set n = 0
        loop
        exitwhen n > 6
            set u = LoadUnitHandle(udg_ht, task, n + 3)
            call KillUnit(u)
            set n = n + 1
        endloop
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set u = null
    set caster = null
    set g = null
endfunction

function Trig_Kaguya01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit u
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real a = GetUnitFacing(caster)
    local integer n = 0
    local integer counter = 0
    local integer R
    local integer G
    local integer B
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, level)
    call SaveInteger(udg_ht, task, 2, 0)
    loop
    exitwhen n > 6
        set R = udg_SK_Kaguya01_RGB[n * 3 + 0]
        set G = udg_SK_Kaguya01_RGB[n * 3 + 1]
        set B = udg_SK_Kaguya01_RGB[n * 3 + 2]
        set u = CreateUnit(GetOwningPlayer(caster), 'e02R', ox + 200 * CosBJ(a + n * 360 / 7), oy + 200 * SinBJ(a + n * 360 / 7), a)
        call SetUnitVertexColor(u, R, G, B, 255)
        call SaveUnitHandle(udg_ht, task, n + 3, u)
        set n = n + 1
    endloop
    call SaveReal(udg_ht, task, 10, a)
    call SaveInteger(udg_ht, task, 11, counter)
    call TimerStart(t, 0.02, true, function Trig_Kaguya01_Main)
    set caster = null
    set t = null
    set u = null
endfunction

function InitTrig_Kaguya01 takes nothing returns nothing
endfunction