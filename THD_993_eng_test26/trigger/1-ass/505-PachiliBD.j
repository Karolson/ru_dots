function Trig_PachiliBD_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0WG'
endfunction

function Trig_PachiliBD_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit u = LoadUnitHandle(udg_ht, task, 1)
    local unit u2 = LoadUnitHandle(udg_ht, task, 6)
    local unit v
    local integer level = LoadInteger(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local real ox = GetUnitX(u)
    local real oy = GetUnitY(u)
    local real px
    local real py
    local real a = LoadReal(udg_ht, task, 4)
    local real d = LoadReal(udg_ht, task, 5)
    local group g
    local boolexpr iff
    if i > 0 then
        set px = ox + d * Cos(a)
        set py = oy + d * Sin(a)
        call SetUnitXY(u, px, py)
        call SetUnitXY(u2, px, py)
        call SaveInteger(udg_ht, task, 3, i - 1)
    else
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", GetUnitX(u), GetUnitY(u)))
        set g = CreateGroup()
        set iff = udg_FLIFF[GetPlayerId(GetOwningPlayer(caster))]
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 225, iff)
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            if IsUnitType(v, UNIT_TYPE_STRUCTURE) == false then
                call Public_PacQ_MagicDamage(caster, v, 53 + level * 53 + 2.3 * GetHeroInt(caster, true), 5)
            endif
        endloop
        call StopSound(gg_snd_TrollBatriderLiquidFire1, false, false)
        call DestroyGroup(g)
        call KillUnit(u)
        call KillUnit(u2)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set u2 = null
    set v = null
    set g = null
    set iff = null
endfunction

function Trig_PachiliBD_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit u
    local unit u2
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetSpellTargetX()
    local real ty = GetSpellTargetY()
    local real a = Atan2(ty - oy, tx - ox)
    local real dis
    local real dis2
    local integer level = GetUnitAbilityLevel(caster, 'A0WG')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    call Public_PacQ_AbilityCoolDownRestore(caster, level, 'A0WG')
    set dis = SquareRoot((tx - ox) * (tx - ox) + (ty - oy) * (ty - oy))
    set dis2 = 20
    set u = CreateUnit(GetOwningPlayer(caster), 'h01U', ox, oy, bj_RADTODEG * a)
    set u2 = CreateUnit(GetOwningPlayer(caster), 'h01V', ox, oy, bj_RADTODEG * a)
    call PlaySoundOnUnitBJ(gg_snd_TrollBatriderLiquidFire1, 128, u)
    call SetUnitPathing(u, false)
    call EnableHeight(u)
    call SetUnitPathing(u2, false)
    call EnableHeight(u2)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, u)
    call SaveInteger(udg_ht, task, 2, level)
    call SaveInteger(udg_ht, task, 3, R2I(RMaxBJ(dis / dis2, 1)))
    call SaveReal(udg_ht, task, 4, a)
    call SaveReal(udg_ht, task, 5, dis2)
    call SaveUnitHandle(udg_ht, task, 6, u2)
    call TimerStart(t, 0.02, true, function Trig_PachiliBD_Main)
    set caster = null
    set u = null
    set u2 = null
    set t = null
endfunction

function InitTrig_PachiliBD takes nothing returns nothing
endfunction