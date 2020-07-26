function Trig_Nitori02_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0GF'
endfunction

function Trig_Nitori02_Bullet takes nothing returns nothing
    local timer t2 = GetExpiredTimer()
    local integer task2 = GetHandleId(t2)
    local unit u = LoadUnitHandle(udg_ht, task2, 1)
    local real a = bj_DEGTORAD * LoadReal(udg_ht, task2, 2)
    local real i = LoadReal(udg_ht, task2, 3)
    local lightning lt = LoadLightningHandle(udg_ht, task2, 4)
    local group grp1 = LoadGroupHandle(udg_ht, task2, 5)
    local group grp2 = LoadGroupHandle(udg_ht, task2, 6)
    local real damage = LoadReal(udg_ht, task2, 7)
    local real d = 80
    local real x = GetUnitX(u) + d * Cos(a)
    local real y = GetUnitY(u) + d * Sin(a)
    local boolexpr iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(u))]
    local unit v
    if i >= 0 then
        call SetUnitXY(u, x, y)
        call DestroyEffect(AddSpecialEffect("NewDirtEX.mdx", x, y))
        call SaveReal(udg_ht, task2, 3, i - d)
        call SetLightningColor(lt, 0.0, 1, 0.0, i / 1500)
        call GroupEnumUnitsInRange(grp1, x, y, 150, iff)
        loop
            set v = FirstOfGroup(grp1)
        exitwhen v == null
            if IsUnitInGroup(v, grp2) then
                call GroupRemoveUnit(grp1, v)
            else
                call GroupRemoveUnit(grp1, v)
                call GroupAddUnit(grp2, v)
                call UnitDebuffTarget(u, v, 2.0, 1, true, 'A0GH', 1, 'B053', "slow", 0, "")
                if IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                    call UnitMagicDamageTarget(u, v, damage * 0.25, 5)
                else
                    call UnitMagicDamageTarget(u, v, damage, 5)
                    call CCSystem_textshow("Slow", v, DebuffDuration(v, 2.0))
                endif
                set damage = damage * 0.9
            endif
        endloop
        call SaveReal(udg_ht, task2, 7, damage)
    else
        call UnitRemoveAbility(u, 'A0GH')
        call ReleaseDummy(u)
        call DestroyGroup(grp1)
        call DestroyGroup(grp2)
        call DestroyLightning(lt)
        call ReleaseTimer(t2)
        call FlushChildHashtable(udg_ht, task2)
    endif
    set t2 = null
    set u = null
    set lt = null
    set grp1 = null
    set grp2 = null
    set iff = null
    set v = null
endfunction

function Trig_Nitori02_Frame takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local real a = LoadReal(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local timer t2
    local integer task2
    local unit u
    local lightning lt
    local real ox
    local real oy
    local real oz
    local real px
    local real py
    local real pz
    local group grp1
    local group grp2
    local real damage = level * 75 + udg_Nitori_RealInt * 2.0
    if i < 10 and GetUnitCurrentOrder(caster) == OrderId("clusterrockets") then
        if i == 0 then
            call SetUnitFacing(caster, a)
            call DestroyEffect(AddSpecialEffectTarget("GreenShotExplod.mdx", caster, "sprite first"))
            call DestroyEffect(AddSpecialEffectTarget("GreenShotExplod.mdx", caster, "sprite first"))
            call AttachSoundToUnit(gg_snd_GetPower, caster)
            call SetSoundVolume(gg_snd_GetPower, 127)
            call StartSound(gg_snd_GetPower)
        elseif i == 7 then
            set ox = GetUnitX(caster) + 80 * Cos(bj_DEGTORAD * a)
            set oy = GetUnitY(caster) + 80 * Sin(bj_DEGTORAD * a)
            set oz = GetPositionZ(ox, oy) + 60
            set px = GetUnitX(caster) + 2000 * Cos(bj_DEGTORAD * a)
            set py = GetUnitY(caster) + 2000 * Sin(bj_DEGTORAD * a)
            set pz = GetPositionZ(px, py) + 60
            set u = NewDummy(GetOwningPlayer(caster), ox, oy, a)
            call UnitAddAbility(u, 'A0GH')
            set lt = AddLightningEx("TCLE", true, ox, oy, oz, px, py, pz)
            call SetLightningColor(lt, 0.0, 1, 0.0, 1)
            set grp1 = CreateGroup()
            set grp2 = CreateGroup()
            set t2 = CreateTimer()
            set task2 = GetHandleId(t2)
            call SaveTimerHandle(udg_ht, task2, 0, t2)
            call SaveUnitHandle(udg_ht, task2, 1, u)
            call SaveReal(udg_ht, task2, 2, a)
            call SaveReal(udg_ht, task2, 3, 1200)
            call SaveLightningHandle(udg_ht, task2, 4, lt)
            call SaveGroupHandle(udg_ht, task2, 5, grp1)
            call SaveGroupHandle(udg_ht, task2, 6, grp2)
            call SaveReal(udg_ht, task2, 7, damage)
            call TimerStart(t2, 0.02, true, function Trig_Nitori02_Bullet)
            call StopSound(gg_snd_GetPower, false, true)
        endif
        call SaveInteger(udg_ht, task, 4, i + 1)
    else
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set t2 = null
    set u = null
    set caster = null
    set lt = null
    set grp1 = null
    set grp2 = null
endfunction

function Trig_Nitori02_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = bj_RADTODEG * Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0GF')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call AbilityCoolDownResetion(caster, 'A0GF', 7)
    call SaveTimerHandle(udg_ht, task, 0, t)
    call SaveUnitHandle(udg_ht, task, 1, caster)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveReal(udg_ht, task, 3, a)
    call SaveInteger(udg_ht, task, 4, 0)
    call TimerStart(t, 0.1, true, function Trig_Nitori02_Frame)
    set caster = null
    set t = null
endfunction

function InitTrig_Nitori02 takes nothing returns nothing
endfunction