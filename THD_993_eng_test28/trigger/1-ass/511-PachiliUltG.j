function Trig_PachiliUltG_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XK'
endfunction

function Trig_PachiliUltG_Light_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit w = LoadUnitHandle(udg_ht, task, 0)
    local real ox = LoadReal(udg_ht, task, 1)
    local real oy = LoadReal(udg_ht, task, 2)
    local real px
    local real py
    local real q = LoadReal(udg_ht, task, 3)
    local real s = LoadReal(udg_ht, task, 4)
    local integer k = LoadInteger(udg_ht, task, 5)
    local real z = LoadReal(udg_ht, task, 6)
    set k = k - 1
    call SaveInteger(udg_ht, task, 5, k)
    set px = ox + q * Cos(s + 4.8 * k * 0.017454 * z)
    set py = oy + q * Sin(s + 4.8 * k * 0.017454 * z)
    call SetUnitXY(w, px, py)
    if k == 0 then
        call KillUnit(w)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set w = null
endfunction

function Trig_PachiliUltG_Light_Start takes unit w, real ox, real oy, real q, real s, integer k, real z returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, w)
    call SaveReal(udg_ht, task, 1, ox)
    call SaveReal(udg_ht, task, 2, oy)
    call SaveReal(udg_ht, task, 3, q)
    call SaveReal(udg_ht, task, 4, s)
    call SaveInteger(udg_ht, task, 5, k)
    call SaveReal(udg_ht, task, 6, z)
    call TimerStart(t, 0.02, true, function Trig_PachiliUltG_Light_Main)
    set t = null
endfunction

function Trig_PachiliUltG_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u1 = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 2)
    local integer level = LoadInteger(udg_ht, task, 3)
    local integer i = LoadInteger(udg_ht, task, 4)
    local integer j = LoadInteger(udg_ht, task, 5)
    local real a = LoadReal(udg_ht, task, 6)
    local integer k = LoadInteger(udg_ht, task, 7)
    local real ox = GetUnitX(u1)
    local real oy = GetUnitY(u1)
    local real px
    local real py
    local real damage
    local group g
    local boolexpr iff
    local unit v
    local integer m
    local integer n
    local real q
    local real s
    local real z
    local unit w
    if i < j then
        set i = i + 1
        call SaveInteger(udg_ht, task, 4, i)
        call SetUnitFacing(u1, 57.29578 * a + i * 4)
        call SetUnitFacing(u2, 57.29578 * a - i * 4)
        call SetUnitFlyHeight(u2, GetUnitFlyHeight(u2) + 16, 0)
    elseif i < j + k then
        if i == j then
            set m = 0
            loop
                set m = m + 1
                set n = 0
                loop
                    set n = n + 1
                    set q = 55 * m
                    set s = a + (36 * m + 180 * n - 180) * 0.017454
                    set px = ox + q * Cos(s)
                    set py = oy + q * Sin(s)
                    set w = CreateUnit(GetOwningPlayer(caster), 'e028', px, py, 0)
                    if m == 1 or m == 3 or m == 5 then
                        set z = 1
                    elseif m == 2 or m == 4 then
                        set z = -1
                    endif
                    call Trig_PachiliUltG_Light_Start(w, ox, oy, q, s, k, z)
                exitwhen n == 2
                endloop
            exitwhen m == 5
            endloop
        endif
        if i / 13 * 13 == i then
            call StopSoundBJ(gg_snd_LightningBolt, false)
            call PlaySoundOnUnitBJ(gg_snd_LightningBolt, 128, u1)
        endif
        set i = i + 1
        call SaveInteger(udg_ht, task, 4, i)
        call SetUnitFacing(u1, bj_RADTODEG * a + i * 4)
        call SetUnitFacing(u2, bj_RADTODEG * a - i * 4)
        call SetUnitFlyHeight(u2, 800, 0)
        if i / 25 * 25 == i then
            if level == 1 then
                set damage = (210 + 1.5 * GetHeroInt(caster, true)) / 2
            elseif level == 2 then
                set damage = (280 + 1.5 * GetHeroInt(caster, true)) / 2.4
            else
                set damage = (350 + 1.5 * GetHeroInt(caster, true)) / 3
            endif
            set g = CreateGroup()
            set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
            call GroupEnumUnitsInRange(g, ox, oy, 300, iff)
            loop
                set v = FirstOfGroup(g)
            exitwhen v == null
                call GroupRemoveUnit(g, v)
                if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                    call Public_PacQ_MagicDamage(caster, v, damage, 5)
                    call UnitStunTarget(caster, v, 0.7, 0, 0)
                endif
            endloop
            call DestroyGroup(g)
        endif
    else
        call KillUnit(u1)
        call KillUnit(u2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u1 = null
    set u2 = null
    set g = null
    set iff = null
    set v = null
    set w = null
endfunction

function Trig_PachiliUltG_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local integer level = GetUnitAbilityLevel(caster, 'A0XK')
    local unit u1
    local unit u2
    local timer t
    local integer task
    call Public_PacQ_AbilityCoolDownRestore_ULT(caster, level, 'A0XK')
    call VE_Spellcast(caster)
    set u1 = CreateUnit(GetOwningPlayer(caster), 'e026', tx, ty, a * 57.29578)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'e027', tx, ty, a * 57.29578 + 180)
    call PlaySoundOnUnitBJ(gg_snd_NightElvesSmallFireLoop1, 128, u1)
    call SetUnitFlyHeight(u2, 0, 0)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u1)
    call SaveUnitHandle(udg_ht, task, 2, u2)
    call SaveInteger(udg_ht, task, 3, level)
    call SaveInteger(udg_ht, task, 4, 0)
    call SaveInteger(udg_ht, task, 5, 50)
    call SaveReal(udg_ht, task, 6, a)
    call SaveInteger(udg_ht, task, 7, 25 * level + 50)
    call TimerStart(t, 0.02, true, function Trig_PachiliUltG_Main)
    set caster = null
    set u1 = null
    set u2 = null
    set t = null
endfunction

function InitTrig_PachiliUltG takes nothing returns nothing
endfunction