function Item_BLTalismanicRunningCD_Resolve takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit target = LoadUnitHandle(udg_Hashtable, task, 0)
    local integer k = GetConvertedPlayerId(GetOwningPlayer(target))
    set udg_SK_BLTalismanicCoolDown[k] = false
    if YDWEUnitHasItemOfTypeBJNull(target, 'I00E') then
        set udg_SK_BLTalismanicAvaliable[k] = true
        call UnitAddAbility(target, 'A0QL')
    endif
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_ht, task)
    set t = null
    set target = null
endfunction

function Item_BLTalismanicRunningCD takes unit target returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local integer k = GetConvertedPlayerId(GetOwningPlayer(target))
    set udg_SK_BLTalismanicAvaliable[k] = false
    set udg_SK_BLTalismanicCoolDown[k] = true
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", GetUnitX(target), GetUnitY(target)))
    call UnitRemoveAbility(target, 'A0QL')
    call SaveUnitHandle(udg_ht, task, 0, target)
    call SaveTimerHandle(udg_ht, task, 99, t)
    call TimerStart(t, 20.0, false, function Item_BLTalismanicRunningCD_Resolve)
    set t = null
endfunction

function BlockingSpell takes unit caster, unit target returns boolean
    if IsUnitAlly(caster, GetOwningPlayer(target)) == false and IsUnitType(target, UNIT_TYPE_HERO) and udg_SK_BLTalismanicAvaliable[GetConvertedPlayerId(GetOwningPlayer(target))] and IsUnitIllusionBJ(target) == false then
        call Item_BLTalismanicRunningCD(target)
        return true
    endif
    return false
endfunction

function PreMorphReset takes unit h returns nothing
    call UnitRemoveAbility(h, 'B019')
    call UnitRemoveAbility(h, 'B035')
    call UnitRemoveAbility(h, 'Bspe')
    call UnitRemoveAbility(h, 'B00G')
    call UnitRemoveAbility(h, 'B02T')
    call UnitRemoveAbility(h, 'B049')
    call SetUnitMoveSpeed(h, GetUnitDefaultMoveSpeed(h))
endfunction

function CastSpell takes unit caster, string name returns texttag
    local real ox = GetUnitX(caster) - 8.0 * StringLength(name)
    local real oy = GetUnitY(caster)
    local texttag e = CreateTextTag()
    call SetTextTagTextBJ(e, name, 16.0)
    call SetTextTagPos(e, ox, oy, 80.0)
    call SetTextTagColor(e, 255, 240, 40, 240)
    call SetTextTagVelocityBJ(e, 64, 90)
    call SetTextTagPermanent(e, false)
    call SetTextTagLifespan(e, 2.0)
    set bj_lastCreatedTextTag = e
    set e = null
    return bj_lastCreatedTextTag
endfunction

function addlife takes unit u, integer life returns nothing
    local integer a
    local integer b = 2
    loop
    exitwhen life == 0
        set a = life - life / 10 * 10
        loop
        exitwhen a == 0
            set a = a - 1
            call UnitAddAbility(u, 'A07D')
            call SetUnitAbilityLevel(u, 'A07D', b)
            call UnitRemoveAbility(u, 'A07D')
        endloop
        set life = life / 10
        set b = b + 1
    endloop
endfunction

function decreaselife takes unit u, integer life returns nothing
    local integer a
    local integer b = 2
    loop
    exitwhen life == 0
        set a = life - life / 10 * 10
        loop
        exitwhen a == 0
            set a = a - 1
            call UnitAddAbility(u, 'A0CX')
            call SetUnitAbilityLevel(u, 'A0CX', b)
            call UnitRemoveAbility(u, 'A0CX')
        endloop
        set life = life / 10
        set b = b + 1
    endloop
endfunction

function AddUnitMaxLife takes unit u, integer amount returns nothing
    call addlife(u, amount)
endfunction

function JumpTimerLoop takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit hero = LoadUnitHandle(udg_Hashtable, task, StringHash("Hero"))
    local real angle = LoadReal(udg_Hashtable, task, StringHash("Angle"))
    local integer steeps = LoadInteger(udg_Hashtable, task, StringHash("steeps"))
    local integer steepsMax = LoadInteger(udg_Hashtable, task, StringHash("steepsMax"))
    local real heightMax = LoadReal(udg_Hashtable, task, StringHash("heightMax"))
    local real dist = LoadReal(udg_Hashtable, task, StringHash("dist"))
    local real dheig = LoadReal(udg_Hashtable, task, StringHash("dheig"))
    local real OriginHeight = LoadReal(udg_Hashtable, task, StringHash("OriginHeight"))
    local real x = LoadReal(udg_Hashtable, task, StringHash("X"))
    local real y = LoadReal(udg_Hashtable, task, StringHash("Y"))
    local real x1 = 0
    local real y1 = 0
    local real height = 0
    if steeps < steepsMax then
        set x1 = x + steeps * dist * Cos(angle * 3.14159 / 180.0)
        set y1 = y + steeps * dist * Sin(angle * 3.14159 / 180.0)
        call SetUnitX(hero, x1)
        call SetUnitY(hero, y1)
        call SetUnitFacing(hero, angle)
        set steeps = steeps + 1
        call SaveInteger(udg_Hashtable, task, StringHash("steeps"), steeps)
        set height = (-(2 * I2R(steeps) * dheig - 1) * (2 * I2R(steeps) * dheig - 1) + 1) * heightMax + OriginHeight
        call SetUnitFlyHeight(hero, height, 0)
        call SetUnitFacingTimed(hero, angle, 0)
    else
        call SetUnitFlyHeight(hero, GetUnitDefaultFlyHeight(hero), 0)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set hero = null
endfunction

function JumpTimer takes unit hero, real angle, real distance, real lasttime, real timeout, real heightMax returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real x = GetUnitX(hero)
    local real y = GetUnitY(hero)
    local integer steepsMax = R2I(lasttime / timeout)
    local integer steeps = 0
    local real dist = distance / steepsMax
    local real dheig = 1.0 / steepsMax
    local real OriginHeight = GetUnitFlyHeight(hero)
    call UnitAddAbility(hero, 'Amrf')
    call UnitRemoveAbility(hero, 'Amrf')
    call SaveTimerHandle(udg_Hashtable, task, StringHash("Timer"), t)
    call SaveUnitHandle(udg_Hashtable, task, StringHash("Hero"), hero)
    call SaveReal(udg_Hashtable, task, StringHash("OriginHeight"), OriginHeight)
    call SaveReal(udg_Hashtable, task, StringHash("Angle"), angle)
    call SaveReal(udg_Hashtable, task, StringHash("dist"), dist)
    call SaveReal(udg_Hashtable, task, StringHash("heightMax"), heightMax)
    call SaveReal(udg_Hashtable, task, StringHash("dheig"), dheig)
    call SaveReal(udg_Hashtable, task, StringHash("X"), x)
    call SaveReal(udg_Hashtable, task, StringHash("Y"), y)
    call SaveInteger(udg_Hashtable, task, StringHash("steeps"), steeps)
    call SaveInteger(udg_Hashtable, task, StringHash("steepsMax"), steepsMax)
    call TimerStart(t, timeout, true, function JumpTimerLoop)
    set t = null
endfunction

function UnitFade_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, task, 1)
    local integer i = LoadInteger(udg_Hashtable, task, 2)
    local boolean killornot = LoadBoolean(udg_Hashtable, task, 4)
    local boolean fadeorappear = LoadBoolean(udg_Hashtable, task, 5)
    local integer j
    if i > 0 then
        if fadeorappear then
            set j = i
        else
            set j = 11 - i
        endif
        call SetUnitVertexColor(u, 5 + j * 25, 5 + j * 25, 5 + j * 25, 5 + j * 25)
        set i = i - 1
        call SaveInteger(udg_Hashtable, task, 2, i)
    else
        if killornot then
            call KillUnit(u)
            call RemoveUnit(u)
        endif
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_Hashtable, task)
    endif
    set t = null
    set u = null
endfunction

function UnitFade takes unit u, boolean killornot, boolean fadeorappear, real speedperiod returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_Hashtable, task, 1, u)
    call SaveInteger(udg_Hashtable, task, 2, 10)
    call SaveTimerHandle(udg_Hashtable, task, 3, t)
    call SaveBoolean(udg_Hashtable, task, 4, killornot)
    call SaveBoolean(udg_Hashtable, task, 5, fadeorappear)
    call TimerStart(t, speedperiod, true, function UnitFade_Main)
    set t = null
endfunction

function GetInventoryIndexOfItemType takes unit u, integer ID returns integer
    local integer i
    local item w
    set i = 0
    loop
        set w = UnitItemInSlot(u, i)
        if w != null and GetItemTypeId(w) == ID then
            set w = null
            return i + 1
        endif
        set i = i + 1
    exitwhen i >= bj_MAX_INVENTORY
    endloop
    set w = null
    return 0
endfunction

function PlayerColorText takes string s, player q returns string
    return udg_PlayerColors[GetPlayerId(q)] + s + "|r"
endfunction

function UnitGainMana takes unit whichUnit, real gain returns nothing
    local real manaMax = GetUnitState(whichUnit, UNIT_STATE_MAX_MANA)
    local real mana = GetUnitState(whichUnit, UNIT_STATE_MANA)
    if mana + gain > manaMax then
        call SetUnitState(whichUnit, UNIT_STATE_MANA, manaMax)
    else
        call SetUnitState(whichUnit, UNIT_STATE_MANA, mana + gain)
    endif
endfunction

function UnitGainLife takes unit whichUnit, real gain returns nothing
    local real lifeMax = GetUnitState(whichUnit, UNIT_STATE_MAX_LIFE)
    local real life = GetUnitState(whichUnit, UNIT_STATE_LIFE)
    if life + gain > lifeMax then
        call SetUnitState(whichUnit, UNIT_STATE_LIFE, lifeMax)
    else
        call SetUnitState(whichUnit, UNIT_STATE_LIFE, life + gain)
    endif
endfunction

function InitACSII takes nothing returns nothing
    local string chars = " !.#$%&'()*+,-./0123456789:;<=>.@ABCDEFGHIJKLMNOPQRSTUVWXYZ[.]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    local integer i = 0
    loop
    exitwhen i >= 128
        if i >= 32 and i <= 126 then
            set udg_ACSII[i] = SubString(chars, i - 32, i - 31)
        else
            set udg_ACSII[i] = "NAC"
        endif
        set i = i + 1
    endloop
endfunction

function StringToID takes string str returns integer
    local integer i
    local integer c
    local integer d = 0
    local string b
    set i = 0
    loop
        set b = SubString(str, i, i + 1)
        set c = 48
        loop
        exitwhen udg_ACSII[c] == b
            set c = c + 1
        exitwhen c > 122
        endloop
        set d = d * 256 + c
        set i = i + 1
    exitwhen i == 4
    endloop
    set b = null
    return d
endfunction

function PlayUnitAnimeTimedEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    call SetUnitAnimation(u, "stand")
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set u = null
endfunction

function PlayUnitAnimeTimedStart takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer t2id = GetHandleId(t2)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local string animename = LoadStr(udg_Hashtable, tid, 2)
    local real lasttime = LoadReal(udg_Hashtable, tid, 3)
    call SetUnitAnimation(u, animename)
    call TimerStart(t2, lasttime, false, function PlayUnitAnimeTimedEnd)
    call SaveUnitHandle(udg_Hashtable, t2id, 1, u)
    call SaveTimerHandle(udg_Hashtable, t2id, 99, t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set t2 = null
    set u = null
endfunction

function PlayUnitAnimeTimed takes unit u, string animename, real lasttime returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 0.01, false, function PlayUnitAnimeTimedStart)
    call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 1, u)
    call SaveStr(udg_Hashtable, GetHandleId(t), 2, animename)
    call SaveReal(udg_Hashtable, GetHandleId(t), 3, lasttime)
    call SaveTimerHandle(udg_Hashtable, GetHandleId(t), 99, t)
    set t = null
endfunction

function PlayUnitAnimeNoLoopStart takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local string animename = LoadStr(udg_Hashtable, tid, 2)
    call SetUnitAnimation(u, animename)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set u = null
endfunction

function PlayUnitAnimeNoLoop takes unit u, string animename returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 0.01, false, function PlayUnitAnimeNoLoopStart)
    call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 1, u)
    call SaveStr(udg_Hashtable, GetHandleId(t), 2, animename)
    call SaveTimerHandle(udg_Hashtable, GetHandleId(t), 99, t)
    set t = null
endfunction

function PlayUnitAnimeTimedByIndexEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    call SetUnitAnimation(u, "stand")
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set u = null
endfunction

function PlayUnitAnimeTimedByIndexStart takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tid = GetHandleId(t)
    local timer t2 = CreateTimer()
    local integer t2id = GetHandleId(t2)
    local unit u = LoadUnitHandle(udg_Hashtable, tid, 1)
    local integer animeindex = LoadInteger(udg_Hashtable, tid, 2)
    local real lasttime = LoadReal(udg_Hashtable, tid, 3)
    call SetUnitAnimationByIndex(u, animeindex)
    call TimerStart(t2, lasttime, false, function PlayUnitAnimeTimedByIndexEnd)
    call SaveUnitHandle(udg_Hashtable, t2id, 1, u)
    call SaveTimerHandle(udg_Hashtable, t2id, 99, t)
    call ReleaseTimer(t)
    call FlushChildHashtable(udg_Hashtable, tid)
    set t = null
    set t2 = null
    set u = null
endfunction

function PlayUnitAnimeTimedByIndex takes unit u, integer animeindex, real lasttime returns nothing
    local timer t = CreateTimer()
    call TimerStart(t, 0.01, false, function PlayUnitAnimeTimedByIndexStart)
    call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 1, u)
    call SaveInteger(udg_Hashtable, GetHandleId(t), 2, animeindex)
    call SaveReal(udg_Hashtable, GetHandleId(t), 3, lasttime)
    call SaveTimerHandle(udg_Hashtable, GetHandleId(t), 99, t)
    set t = null
endfunction

function NueResetCD takes unit killer, unit dyer returns nothing
    local integer level = GetUnitAbilityLevel(killer, 'A0M3')
    local integer ab01lv = GetUnitAbilityLevel(killer, 'A0M1')
    local integer ab02lv = GetUnitAbilityLevel(killer, 'A0M2')
    local integer ab04lv = GetUnitAbilityLevel(killer, 'A0M4')
    if level >= 1 then
        if udg_GameMode / 100 == 3 then
            call AddHeroXP(killer, 12 + level * 6, true)
        else
            call AddHeroXP(killer, 10 + level * 5, true)
        endif
        if IsUnitType(dyer, UNIT_TYPE_HERO) and IsUnitIllusion(dyer) == false then
            if level != 4 then
                call UnitRemoveAbility(killer, 'A0LZ')
                call UnitAddAbility(killer, 'A0LZ')
            endif
            if ab01lv >= 1 and level != 4 then
                call UnitRemoveAbility(killer, 'A0M1')
                call UnitAddAbility(killer, 'A0M1')
                call SetUnitAbilityLevel(killer, 'A0M1', ab01lv)
            endif
            if level >= 2 and level != 4 and ab02lv >= 1 then
                call UnitRemoveAbility(killer, 'A0M2')
                call UnitAddAbility(killer, 'A0M2')
                call SetUnitAbilityLevel(killer, 'A0M2', ab02lv)
            endif
            if level == 3 and ab04lv >= 1 then
                call UnitRemoveAbility(killer, 'A0M4')
                call UnitAddAbility(killer, 'A0M4')
                call SetUnitAbilityLevel(killer, 'A0M4', ab04lv)
            endif
            if level == 4 then
                call UnitResetCooldown(killer)
            endif
        endif
    endif
endfunction

function NueDamageCounting takes unit caster returns real
    local real nmdamage = 0.0
    local real nmbased = 12.5
    local integer nmlevel = GetUnitAbilityLevel(caster, 'A0M1')
    if nmlevel >= 1 then
        set nmdamage = nmbased * nmlevel * (1.0 + udg_SK_nue_nightmare_buff)
    else
        set nmdamage = 0.0
    endif
    return nmdamage
endfunction

function ChangeUnitItem takes unit whichunit, integer slotnum, item item1, item item2 returns boolean
    local integer i = 0
    local integer targetindex = 0
    local boolean flag = false
    local real x = GetUnitX(whichunit)
    local real y = GetUnitY(whichunit)
    loop
    exitwhen i > slotnum - 1
        if UnitItemInSlot(whichunit, i) == item1 then
            set targetindex = i
            set flag = true
        endif
        set i = i + 1
    endloop
    if not flag then
        return false
    endif
    set i = 0
    call RemoveItem(item1)
    loop
    exitwhen i > targetindex - 1
        if UnitItemInSlot(whichunit, i) == null then
            call UnitAddItem(whichunit, CreateItem('ches', x, y))
        endif
        set i = i + 1
    endloop
    call UnitAddItem(whichunit, item2)
    set i = 0
    loop
    exitwhen i > targetindex - 1
        if GetItemTypeId(UnitItemInSlot(whichunit, i)) == 'ches' then
            call RemoveItem(UnitItemInSlot(whichunit, i))
        endif
        set i = i + 1
    endloop
    return true
endfunction

function IsUnitOwnedItem takes unit whichunit, item whichitem returns boolean
    local integer i = 0
    if whichitem == null then
        return false
    endif
    loop
    exitwhen i > 5
        if UnitItemInSlot(whichunit, i) == whichitem then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function GetUnitItemLifeRegen_Single takes unit v, integer itemr, real mrvalue returns real
    local integer i = 0
    local real rg = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set rg = rg + mrvalue
        endif
    exitwhen i == 6
    endloop
    return rg
endfunction

function GetUnitItemMagicRegen_Single takes unit v, integer itemr, real mrvalue returns real
    local integer i = 0
    local real rg = 0.0
    loop
        set i = i + 1
        if GetItemTypeId(UnitItemInSlotBJ(v, i)) == itemr then
            set rg = rg + mrvalue
        endif
    exitwhen i == 6
    endloop
    return rg
endfunction

function GetUnitMagicRegen takes unit v returns real
    local real regen = 0.0
    local real regenmana = 0.0
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I01G', 1.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I01S', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I00P', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I02X', 5.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I06V', 1.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I04L', 1.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I00V', 3.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I02Z', 1.25)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I00H', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I05W', 2.5)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I00E', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I00B', 6.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I08H', 1.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I08J', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I04A', 2.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I07Z', 1.0)
    set regen = regen + GetUnitItemMagicRegen_Single(v, 'I04X', 3.0)
    if GetUnitAbilityLevel(v, 'B070') >= 1 then
        set regen = regen + 1
    endif
    if GetUnitAbilityLevel(v, 'B000') >= 1 then
        set regen = regen + GetUnitAbilityLevel(v, 'B000') * 3
    endif
    if GetUnitAbilityLevel(v, 'A1GH') >= 1 then
        set regen = regen + GetUnitAbilityLevel(v, 'A1GH') * 1
    endif
    if GetUnitAbilityLevel(v, 'A1F7') >= 1 then
        set regen = regen + 30
    endif
    if GetUnitAbilityLevel(v, 'BIrm') >= 1 then
        set regen = regen + 6
        if YDWEUnitHasItemOfTypeBJNull(v, 'I032') then
            set regen = regen + 6 * 0.3
        endif
        if udg_GameMode / 100 == 3 then
            set regen = regen + 6
            if YDWEUnitHasItemOfTypeBJNull(v, 'I032') then
                set regen = regen + 6 * 0.3
            endif
        endif
    endif
    if GetUnitAbilityLevel(v, 'A0AC') >= 1 then
        set regen = regen + 0.75 * GetUnitAbilityLevel(v, 'A0AC')
    endif
    set regenmana = 0.25 + GetHeroInt(v, true) * 0.04
    set regenmana = regenmana + regen
    if YDWEUnitHasItemOfTypeBJNull(v, 'I03B') then
        set regenmana = regenmana + regenmana * 0.3
    endif
    if GetUnitAbilityLevel(v, 'B075') >= 1 and IsUnitAlly(v, GetOwningPlayer(udg_SK_Neet)) == false then
        set regenmana = regenmana * (1 - (0.25 + 0.15 * GetUnitAbilityLevel(udg_SK_Neet, 'A17V')))
    endif
    return regenmana
endfunction

function GetUnitLifeRegen takes unit v returns real
    local real regen = 1.5
    local real multiplier = 1.0
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I07P', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I07N', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I07O', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I07M', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I02V', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I02Z', 2.5)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I00E', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I08E', 2.5)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I00H', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I04D', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I05W', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I00B', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I012', 5.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I01I', 2.5)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I00X', 3.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I073', 2.5)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I07L', 6.0)
    set regen = regen + GetUnitItemLifeRegen_Single(v, 'I04X', 3.0)
    if GetUnitAbilityLevel(v, 'B06Z') >= 1 then
        set regen = regen + 2.5
    endif
    if GetUnitAbilityLevel(v, 'A054') >= 1 then
        set regen = regen + (30 + 20 * (GetUnitAbilityLevel(v, 'A054') - 1))
    endif
    if GetUnitAbilityLevel(v, 'BCtc') >= 1 then
        if YDWEUnitHasItemOfTypeBJNull(v, 'I032') == false then
            set regen = regen + 10
        else
            set regen = regen + 13
        endif
        if udg_GameMode / 100 == 3 then
            if YDWEUnitHasItemOfTypeBJNull(v, 'I032') == false then
                set regen = regen + 10
            else
                set regen = regen + 13
            endif
        endif
    endif
    if GetUnitAbilityLevel(v, 'BIrl') >= 1 then
        if YDWEUnitHasItemOfTypeBJNull(v, 'I032') == false then
            set regen = regen + 40
        else
            set regen = regen + 52
        endif
        if udg_GameMode / 100 == 3 then
            if YDWEUnitHasItemOfTypeBJNull(v, 'I032') == false then
                set regen = regen + 40
            else
                set regen = regen + 52
            endif
        endif
    endif
    if GetUnitAbilityLevel(v, 'A0RM') >= 1 then
        if GetUnitAbilityLevel(v, 'A0RM') == 1 then
            set regen = regen + 4
        else
            set regen = regen + 2
        endif
    endif
    if GetUnitAbilityLevel(v, 'A18T') >= 1 then
        set regen = regen + (5 + 5 * (GetUnitAbilityLevel(v, 'A18T') - 1))
    endif
    if GetUnitAbilityLevel(v, 'B054') >= 1 then
        set regen = regen + 5.0
    endif
    if GetUnitAbilityLevel(v, 'A1F7') >= 1 then
        set regen = regen + 40
    endif
    if GetUnitAbilityLevel(v, 'A0OV') >= 1 then
        set regen = regen + 3.0 * (1 + udg_SK_MeirinStar * 1)
    endif
    if GetUnitAbilityLevel(v, 'A1CW') >= 1 then
        set regen = regen + 2.0
    endif
    if GetUnitAbilityLevel(v, 'A1CX') >= 1 then
        set regen = regen + 4.0
    endif
    if GetUnitAbilityLevel(v, 'A1CY') >= 1 then
        set regen = regen + 6.0
    endif
    if GetUnitAbilityLevel(v, 'A1CZ') >= 1 then
        set regen = regen + 8.0
    endif
    if GetUnitAbilityLevel(v, 'B08K') >= 1 then
        set regen = regen + 5 * GetUnitAbilityLevel(v, 'B08K') + 1
    endif
    if GetUnitAbilityLevel(v, 'A0D1') >= 1 or GetUnitAbilityLevel(v, 'A1BM') >= 1 or GetUnitAbilityLevel(v, 'A1BZ') >= 1 or GetUnitAbilityLevel(v, 'A052') >= 1 or GetUnitAbilityLevel(v, 'A0OU') >= 1 then
        set regen = regen + 1.0 * GetUnitMagicRegen(v)
    endif
    set regen = regen + GetHeroStr(v, true) * 0.04
    if YDWEUnitHasItemOfTypeBJNull(v, 'I039') then
        set multiplier = multiplier * 1.2
    endif
    if GetUnitAbilityLevel(v, 'A0CW') != 0 then
        set multiplier = multiplier * 0.5
    endif
    if GetUnitAbilityLevel(v, 'A0I9') != 0 then
        set multiplier = multiplier * 0.5
    endif
    return regen * multiplier
endfunction

function Trig_Regeneration_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = 0
    local unit v
    loop
    exitwhen i >= 12
        set v = udg_PlayerHeroes[i]
        if v != null then
            call SetUnitState(v, UNIT_STATE_MANA, GetUnitState(v, UNIT_STATE_MANA) + GetUnitMagicRegen(v) * 1)
            call SetUnitState(v, UNIT_STATE_LIFE, GetUnitState(v, UNIT_STATE_LIFE) + GetUnitLifeRegen(v) * 1)
            call WordHealInNormal(v, v, GetUnitLifeRegen(v) * 1)
        endif
        set i = i + 1
    endloop
    set v = null
    set t = null
endfunction

function Trig_Regeneration_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    set task = GetHandleId(t)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call TimerStart(t, 1, true, function Trig_Regeneration_Main)
    set t = null
endfunction

function InitTrig_Regeneration takes nothing returns nothing
endfunction