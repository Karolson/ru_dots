function Trig_Rune_Conditions takes nothing returns boolean
    local item i = GetManipulatedItem()
    local unit u = GetTriggerUnit()
    if GetItemTypeId(i) == 'I000' and IsUnitType(u, UNIT_TYPE_HERO) then
        set i = null
        set u = null
        return true
    else
        set i = null
        set u = null
        return false
    endif
endfunction

function Rune07damage takes nothing returns nothing
    local unit target = GetEnumUnit()
    local unit u = LoadUnitHandle(udg_Hashtable, StringHash("Rune07"), 1)
    call UnitAbsDamageTarget(u, target, 400.0)
    set target = null
    set u = null
endfunction

function PoisonRune takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real x = GetUnitX(caster)
    local real y = GetUnitY(caster)
    local integer count = LoadInteger(udg_ht, task, 1)
    local real dur = LoadReal(udg_ht, task, 2)
    local texttag e
    if count < (dur / 3.0) then
        call UnitMagicDamageTarget(caster, caster, 60, 4)
        set e = CreateTextTag()
        call SetTextTagTextBJ(e, "60", 10.0)
        call SetTextTagPos(e, x, y, 100.0)
        if IsVisibleToPlayer(x, y, GetLocalPlayer()) == false then
            call SetTextTagVisibility(e, false)
        else
            call SetTextTagVisibility(e, true)
        endif
        call SetTextTagColor(e, 23, 209, 7, 240)
        call SetTextTagVelocityBJ(e, 100, 90)
        call SetTextTagPermanent(e, false)
        call SetTextTagLifespan(e, 1.5)
        set count = count + 1
        call SaveInteger(udg_ht, task, 1, count)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set e = null
endfunction

function Trig_Rune_Actions takes nothing returns nothing
    local integer i
    local integer j
    local timer t
    local unit caster = GetTriggerUnit()
    local player PLY = GetOwningPlayer(caster)
    local unit u = NewDummy(PLY, GetUnitX(caster), GetUnitY(caster), 0)
    local group grp
    local item Rune = GetManipulatedItem()
    local effect e
    set i = GetRandomInt(1, 100)
    set j = 60
    if udg_SK_TweiEx and IsUnitAlly(udg_SK_Twei04_Twei, GetOwningPlayer(caster)) then
        set j = 80
    endif
    if GetUnitAbilityLevel(caster, 'A0PP') != 0 then
        set j = 100
    endif
    if udg_GameMode / 100 == 3 and (udg_SK_TweiEx and IsUnitAlly(udg_SK_Twei04_Twei, GetOwningPlayer(caster))) == false then
        set i = 0
        if udg_smodestat == false then
            call UnitStunTarget(caster, caster, 4.0, 0, 0)
        else
            call UnitStunTarget(caster, caster, 2.0, 0, 0)
        endif
    endif
    if i <= j then
        set i = GetRandomInt(1, 8)
        if i == 1 then
            call UnitAddAbility(u, 'A0C5')
            call IssueTargetOrder(u, "invisibility", caster)
            call UnitRemoveAbility(u, 'A0C5')
            call ReleaseDummy(u)
            call DebugMsg("Invisibility")
        elseif i == 2 then
            call UnitAddAbility(u, 'A0DJ')
            call IssueImmediateOrderById(u, 852285)
            call UnitRemoveAbility(u, 'A0DJ')
            call ReleaseDummy(u)
            call DebugMsg("Haste")
        elseif i == 3 then
            call UnitAddAbility(u, 'A0DK')
            call IssueImmediateOrder(u, "roar")
            call UnitRemoveAbility(u, 'A0DK')
            call ReleaseDummy(u)
            call DebugMsg("Double damage")
        elseif i == 4 then
            call UnitAddAbility(u, 'A0DL')
            call IssueImmediateOrderById(u, 852269)
            call UnitRemoveAbility(u, 'A0DL')
            call ReleaseDummy(u)
            call DebugMsg("Defence up")
        elseif i == 5 then
            call UnitAddAbility(u, 'A0EX')
            call IssueTargetOrder(u, "rejuvination", caster)
            call UnitRemoveAbility(u, 'A0EX')
            call ReleaseDummy(u)
            call DebugMsg("Regeneration")
        elseif i == 6 then
            call UnitAddAbility(u, 'A0SM')
            call IssueTargetOrderById(u, 852274, caster)
            call UnitRemoveAbility(u, 'A0SM')
            call ReleaseDummy(u)
            call DebugMsg("Illusion")
        elseif i == 7 then
            call UnitBuffTarget(caster, caster, 60, 'A1E0', 0)
            call UnitBuffTarget(caster, caster, 60, 'A1FE', 0)
            call DebugMsg("Attack speed")
        elseif i == 8 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Transmute\\GoldBottleMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
            call ReleaseDummy(u)
            call THD_AddCredit(PLY, 250)
            call DebugMsg("Gold")
        elseif i == 9 and false then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", GetUnitX(caster), GetUnitY(caster)))
            call SetHeroStr(caster, GetHeroStr(caster, false) + 1, true)
            call SetHeroAgi(caster, GetHeroAgi(caster, false) + 1, true)
            call SetHeroInt(caster, GetHeroInt(caster, false) + 1, true)
            call ReleaseDummy(u)
            call DebugMsg("Increase Power")
        endif
    else
        set i = GetRandomInt(1, 5)
        if false then
            set t = CreateTimer()
            call SaveUnitHandle(udg_ht, GetHandleId(t), 0, caster)
            call SaveInteger(udg_ht, GetHandleId(t), 1, 1)
            call SaveReal(udg_ht, GetHandleId(t), 2, DebuffDuration(caster, 18.0))
            call TimerStart(t, 3.0, true, function PoisonRune)
            call ReleaseDummy(u)
            call DebugMsg("Poison")
        elseif i == 2 or i == 1 then
            set grp = CreateGroup()
            call GroupEnumUnitsInRange(grp, GetUnitX(caster), GetUnitY(caster), 350, null)
            call SaveUnitHandle(udg_Hashtable, StringHash("Rune07"), 1, u)
            call ForGroup(grp, function Rune07damage)
            call FlushChildHashtable(udg_Hashtable, StringHash("Rune07"))
            set e = AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", GetUnitX(u), GetUnitY(u))
            call DestroyEffect(e)
            set u = CreateUnit(GetOwningPlayer(caster), 'n01H', GetUnitX(caster), GetUnitY(caster), 0)
            call UnitApplyTimedLife(u, 'BTLF', 15.0)
            call SetUnitTimeScale(u, 3.0)
            call SetUnitVertexColor(u, 255, 255, 255, 255)
            set u = CreateUnit(GetOwningPlayer(caster), 'n01I', GetUnitX(caster), GetUnitY(caster), 0)
            call UnitApplyTimedLife(u, 'BTLF', 15.0)
            call SetUnitTimeScale(u, 0.2)
            call SetUnitVertexColor(u, 255, 255, 255, 255)
            call DestroyGroup(grp)
            call DebugMsg("Explosion")
            set i = GetRandomInt(1, 5)
            if i == 1 then
                call CastSpell(caster, "O_O")
            elseif i == 2 then
                call CastSpell(caster, "rekt")
            elseif i == 3 then
                call CastSpell(caster, "6a6ax")
            elseif i == 4 then
                call CastSpell(caster, "bombanulo")
            elseif i == 5 then
                call CastSpell(caster, "kaboom")
            endif
        elseif i == 3 then
            call UnitDebuffTargetImmidiate(u, caster, 30.0, 1, true, 'A0SL', 1, 'B016', 852269, 0, "")
            call CCSystem_textshow("Armor Reduction", caster, DebuffDuration(caster, 30.0))
            call ReleaseDummy(u)
            call DebugMsg("Armor Reduction")
        elseif i == 4 then
            set i = GetRandomInt(1, 7)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", GetUnitX(caster), GetUnitY(caster)))
            if i == 1 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport01))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport01))
            elseif i == 2 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport02))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport02))
            elseif i == 3 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport03))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport03))
            elseif i == 4 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport04))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport04))
            elseif i == 5 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport05))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport05))
            elseif i == 6 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport06))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport06))
            elseif i == 7 then
                call SetUnitX(caster, GetRectCenterX(gg_rct_RunesTeleport07))
                call SetUnitY(caster, GetRectCenterY(gg_rct_RunesTeleport07))
            endif
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", GetUnitX(caster), GetUnitY(caster)))
            call ReleaseDummy(u)
            call DebugMsg("Random teleport")
        elseif i == 5 then
            call UnitStunTarget(u, caster, 5.0, 0, 0)
            call ReleaseDummy(u)
            call DebugMsg("Stun")
        elseif i == 6 and false then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Transmute\\GoldBottleMissile.mdl", GetUnitX(caster), GetUnitY(caster)))
            call THD_AddCredit(PLY, -250)
            if GetPlayerState(PLY, PLAYER_STATE_RESOURCE_GOLD) > 250 then
                set udg_PlayerNonItemGoldLoss[GetPlayerId(PLY)] = udg_PlayerNonItemGoldLoss[GetPlayerId(PLY)] + 250
            else
                set udg_PlayerNonItemGoldLoss[GetPlayerId(PLY)] = GetPlayerState(PLY, PLAYER_STATE_RESOURCE_GOLD)
            endif
            call ReleaseDummy(u)
            call DebugMsg("Decrease Gold")
        endif
    endif
    call RemoveItem(Rune)
    set e = null
    set caster = null
    set PLY = null
    set u = null
    set grp = null
    set Rune = null
    set t = null
endfunction

function InitTrig_Rune takes nothing returns nothing
    set gg_trg_Rune = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Rune, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Rune, Condition(function Trig_Rune_Conditions))
    call TriggerAddAction(gg_trg_Rune, function Trig_Rune_Actions)
endfunction