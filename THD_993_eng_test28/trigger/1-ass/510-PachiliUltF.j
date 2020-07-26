function Trig_PachiliUltF_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0XL'
endfunction

function Trig_PachiliUltF_Light takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local integer count = LoadInteger(udg_ht, task, 0)
    local real x = LoadReal(udg_ht, task, 1)
    local real y = LoadReal(udg_ht, task, 2)
    local player who = LoadPlayerHandle(udg_ht, task, 3)
    local integer threshold = LoadInteger(udg_ht, task, 4)
    local integer level = LoadInteger(udg_ht, task, 5)
    local unit u
    set count = count + 1
    call SaveInteger(udg_ht, task, 0, count)
    if count >= 4 and count <= threshold then
        set u = CreateUnit(who, 'e029', x, y, (count - 1) * (2 * level * level - 19 * level + 77))
    elseif count > threshold then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set u = null
    set t = null
    set who = null
endfunction

function Trig_PachiliUltF_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer j = LoadInteger(udg_ht, task, 4)
    local integer k = LoadInteger(udg_ht, task, 5)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real damage
    local group g
    local boolexpr iff
    local unit v
    local unit w
    if i < j then
        set i = i + 1
        call SaveInteger(udg_ht, task, 3, i)
        call SetUnitScale(u, 4 * i / j, 4 * i / j, 4 * i / j)
    elseif i < j + k then
        if i / 25 * 25 == i then
            call StopSoundBJ(gg_snd_BuildingDeathLargeOrc, false)
            call PlaySoundOnUnitBJ(gg_snd_BuildingDeathLargeOrc, 128, u)
        endif
        set i = i + 1
        call SaveInteger(udg_ht, task, 3, i)
        call SetUnitScale(u, 4, 4, 4)
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
            call GroupEnumUnitsInRange(g, ox, oy, 500, iff)
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
        call KillUnit(u)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set g = null
    set iff = null
    set v = null
    set w = null
endfunction

function Trig_PachiliUltF_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local integer level = GetUnitAbilityLevel(caster, 'A0XL')
    local unit u
    local timer t
    local timer t2
    local integer task
    call Public_PacQ_AbilityCoolDownRestore_ULT(caster, level, 'A0XL')
    call VE_Spellcast(caster)
    set u = CreateUnit(GetOwningPlayer(caster), 'e02T', ox, oy, 0)
    call SetUnitFlyHeight(u, 300.0, 0.0)
    call PlaySoundOnUnitBJ(gg_snd_AncientUprootDeath1, 128, u)
    call SetUnitScale(u, 0.1, 0.1, 0.1)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, 0)
    call SaveInteger(udg_ht, task, 4, 50)
    call SaveInteger(udg_ht, task, 5, 25 * level + 50)
    call TimerStart(t, 0.02, true, function Trig_PachiliUltF_Main)
    set t2 = CreateTimer()
    set task = GetHandleId(t2)
    call SaveInteger(udg_ht, task, 0, 0)
    call SaveReal(udg_ht, task, 1, GetUnitX(u))
    call SaveReal(udg_ht, task, 2, GetUnitY(u))
    call SavePlayerHandle(udg_ht, task, 3, GetOwningPlayer(caster))
    call SaveInteger(udg_ht, task, 4, 8 + level * 2)
    call SaveInteger(udg_ht, task, 5, level)
    call TimerStart(t2, 0.25, true, function Trig_PachiliUltF_Light)
    set t2 = null
    set caster = null
    set u = null
    set t = null
endfunction

function InitTrig_PachiliUltF takes nothing returns nothing
endfunction