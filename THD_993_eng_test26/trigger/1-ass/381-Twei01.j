function Trig_Twei01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0N2'
endfunction

function Trig_Twei01_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local item fakeitem = LoadItemHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 2)
    local integer l = LoadInteger(udg_ht, task, 3)
    local lightning e = LoadLightningHandle(udg_ht, task, 4)
    local real itemx = GetItemX(fakeitem)
    local real itemy = GetItemY(fakeitem)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
    local group g
    local unit v
    local unit u
    call SaveInteger(udg_ht, task, 2, i - 1)
    if l > 0 then
        call SaveInteger(udg_ht, task, 3, l - 1)
    endif
    set g = CreateGroup()
    call GroupEnumUnitsInRange(g, itemx, itemy, 125.0, iff)
    if i > 0 then
        if l <= 0 then
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if GetWidgetLife(v) > 0.405 and IsUnitType(v, UNIT_TYPE_HERO) and IsUnitEnemy(v, GetOwningPlayer(caster)) then
                    set i = 0
                endif
            endloop
        endif
        if GetWidgetLife(fakeitem) < 0.405 then
            set i = 0
        endif
    endif
    if i <= 0 and l <= 0 then
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", itemx, itemy))
        call GroupEnumUnitsInRange(g, itemx, itemy, 260.0, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if GetWidgetLife(v) > 0.405 and IsUnitAlly(v, GetOwningPlayer(caster)) == false then
                call UnitMagicDamageTarget(caster, v, 60 * GetUnitAbilityLevel(caster, 'A0N2') + 1.8 * GetHeroInt(caster, true), 5)
                call UnitStunTarget(caster, v, 0.5 * GetUnitAbilityLevel(caster, 'A0N2'), 0, 0)
            endif
        endloop
        call RemoveItem(fakeitem)
        call DestroyLightning(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    elseif i <= 0 and l > 0 then
        call RemoveItem(fakeitem)
        call DestroyLightning(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    call DestroyGroup(g)
    set t = null
    set caster = null
    set fakeitem = null
    set e = null
    set iff = null
    set g = null
    set v = null
    set u = null
endfunction

function Trig_Twei01_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local item fakeitem
    local integer fakeitemtype
    local real itemx
    local real itemy
    local real itemz1
    local real itemz2
    local lightning e
    local integer a
    local real k
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 15)
    set a = GetRandomInt(1, 100)
    if a <= 45 then
        set fakeitemtype = 'I054'
    elseif a <= 90 then
        set fakeitemtype = 'I055'
    elseif a <= 99 then
        set fakeitemtype = 'I059'
    elseif a <= 100 then
        set a = GetRandomInt(1, 33)
        if a <= 1 then
            set fakeitemtype = 'I05N'
        elseif a <= 2 then
            set fakeitemtype = 'I05M'
        elseif a <= 3 then
            set fakeitemtype = 'I05L'
        elseif a <= 4 then
            set fakeitemtype = 'I05K'
        elseif a <= 5 then
            set fakeitemtype = 'I05J'
        elseif a <= 6 then
            set fakeitemtype = 'I05I'
        elseif a <= 7 then
            set fakeitemtype = 'I05H'
        elseif a <= 8 then
            set fakeitemtype = 'I05G'
        elseif a <= 9 then
            set fakeitemtype = 'I05F'
        elseif a <= 10 then
            set fakeitemtype = 'I05E'
        elseif a <= 11 then
            set fakeitemtype = 'I05D'
        elseif a <= 12 then
            set fakeitemtype = 'I05C'
        elseif a <= 13 then
            set fakeitemtype = 'I056'
        elseif a <= 14 then
            set fakeitemtype = 'I058'
        elseif a <= 15 then
            set fakeitemtype = 'I057'
        elseif a <= 16 then
            set fakeitemtype = 'I05A'
        elseif a <= 17 then
            set fakeitemtype = 'I05O'
        elseif a <= 18 then
            set fakeitemtype = 'I05P'
        elseif a <= 19 then
            set fakeitemtype = 'I05Q'
        elseif a <= 20 then
            set fakeitemtype = 'I053'
        elseif a <= 21 then
            set fakeitemtype = 'I05R'
        elseif a <= 22 then
            set fakeitemtype = 'I05S'
        elseif a <= 23 then
            set fakeitemtype = 'I063'
        elseif a <= 24 then
            set fakeitemtype = 'I06E'
        elseif a <= 25 then
            set fakeitemtype = 'I06D'
        elseif a <= 26 then
            set fakeitemtype = 'I06B'
        elseif a <= 27 then
            set fakeitemtype = 'I06C'
        elseif a <= 28 then
            set fakeitemtype = 'I06G'
        elseif a <= 29 then
            set fakeitemtype = 'I06F'
        elseif a <= 30 then
            set fakeitemtype = 'I06H'
        elseif a <= 31 then
            set fakeitemtype = 'I06I'
        elseif a <= 32 then
            set fakeitemtype = 'I06J'
        elseif a <= 33 then
            set fakeitemtype = 'I08L'
        endif
    endif
    set k = GetRandomInt(0, 360)
    set itemx = GetUnitX(caster) + 50 * CosBJ(k)
    set itemy = GetUnitY(caster) + 50 * SinBJ(k)
    set fakeitem = CreateItem(fakeitemtype, itemx, itemy)
    set itemz1 = GetPositionZ(itemx, itemy) + 0.0
    set itemz2 = GetPositionZ(itemx, itemy) + 200.0
    set e = AddLightningEx("TCLE", false, itemx, itemy, itemz1, itemx, itemy, itemz2)
    if IsUnitAlly(caster, GetLocalPlayer()) then
        call SetLightningColor(e, 1.0, 0.0, 0.0, 1.0)
    else
        call SetLightningColor(e, 0.0, 0.0, 0.0, 0.0)
    endif
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveItemHandle(udg_ht, task, 1, fakeitem)
    call SaveInteger(udg_ht, task, 2, 1200)
    call SaveInteger(udg_ht, task, 3, 10)
    call SaveLightningHandle(udg_ht, task, 4, e)
    call TimerStart(t, 0.2, true, function Trig_Twei01_Main)
    set t = null
    set caster = null
    set fakeitem = null
    set e = null
endfunction

function InitTrig_Twei01 takes nothing returns nothing
endfunction