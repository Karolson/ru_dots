function Trig_Utsuho03_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A079'
endfunction

function Trig_Utsuho03_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local integer i = LoadInteger(udg_ht, task, 1)
    local integer c = LoadInteger(udg_ht, task, 2)
    local real d = LoadReal(udg_ht, task, 0)
    local real h = LoadReal(udg_ht, task, 1)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real px
    local real py
    local unit u
    local texttag e = LoadTextTagHandle(udg_ht, task, 13)
    local integer j
    local real damageA
    local real damageB
    if IsUnitType(caster, UNIT_TYPE_DEAD) == false and h < 5000.0 then
        if h > c * 500.0 then
            set u = CreateUnit(GetOwningPlayer(caster), 'h00R', ox, oy, 270.0)
            set px = 3.2 + c * 0.2
            call SetUnitScale(u, px, px, px)
            set udg_SK_Utsuho03_Units[c] = u
            call SaveInteger(udg_ht, task, 2, c + 1)
        endif
        loop
        exitwhen c == 0
            set c = c - 1
            call SetUnitX(udg_SK_Utsuho03_Units[c], ox)
            call SetUnitY(udg_SK_Utsuho03_Units[c], oy)
        endloop
        call SaveReal(udg_ht, task, 1, h + d)
        call SetTextTagTextBJ(e, R2SW((5000 - h - d) / d / 50, 3, 1), 14.0)
        call SetTextTagPos(e, ox, oy, 200.0)
        if IsVisibleToPlayer(ox, oy, GetLocalPlayer()) == false or IsUnitAlly(caster, GetLocalPlayer()) == false then
            call SetTextTagVisibility(e, false)
        else
            call SetTextTagVisibility(e, true)
        endif
    elseif 5000.0 <= h and i < 5 then
        if i == 0 then
            call SaveReal(udg_ht, task, 2, ox)
            call SaveReal(udg_ht, task, 3, oy)
        else
            set ox = LoadReal(udg_ht, task, 2)
            set oy = LoadReal(udg_ht, task, 3)
        endif
        if i == 1 then
            set damageA = 425 + 0.09 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)
            set damageB = 425 + 3.0 * GetHeroInt(caster, true)
            call UnitMagicDamageArea(caster, ox, oy, 475, damageB, 5)
            call UnitInjureArea(caster, ox, oy, 475, 4.0)
        endif
        if i == 4 then
            set j = 0
            loop
                set d = j * 12.0 + 0.0
                set px = ox + 80.0 * (i + 1) * CosBJ(d)
                set py = oy + 80.0 * (i + 1) * SinBJ(d)
                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", px, py))
                set d = j * 12.0 + 120.0
                set px = ox + 80.0 * (i + 1) * CosBJ(d)
                set py = oy + 80.0 * (i + 1) * SinBJ(d)
                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", px, py))
                set d = j * 12.0 + 240.0
                set px = ox + 80.0 * (i + 1) * CosBJ(d)
                set py = oy + 80.0 * (i + 1) * SinBJ(d)
                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", px, py))
                set j = j + 1
            exitwhen j > 5
            endloop
        else
            set j = 0
            loop
                set px = ox + 80.0 * (i + 1) * CosBJ(j * 60.0)
                set py = oy + 80.0 * (i + 1) * SinBJ(j * 60.0)
                call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", px, py))
                set j = j + 1
            exitwhen j > 5
            endloop
        endif
        call SaveInteger(udg_ht, task, 1, i + 1)
        call TimerStart(t, 0.1, false, function Trig_Utsuho03_Main)
    else
        loop
        exitwhen c == 0
            set c = c - 1
            call KillUnit(udg_SK_Utsuho03_Units[c])
        endloop
        call DestroyTextTag(e)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set u = null
    set e = null
endfunction

function Trig_Utsuho03_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A079')
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local real d = 100.0 / (25.0 - level * 5.0)
    local texttag e
    call AbilityCoolDownResetion(caster, 'A079', (27 - 3 * level) * Trig_UtsuhoCD(caster))
    set e = CreateTextTag()
    call SetTextTagTextBJ(e, R2SW(0, 3, 1), 14.0)
    call SetTextTagColor(e, 0, 255, 255, 255)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveInteger(udg_ht, task, 1, 0)
    call SaveInteger(udg_ht, task, 2, 0)
    call SaveReal(udg_ht, task, 0, d)
    call SaveReal(udg_ht, task, 1, 0.0)
    call SaveTextTagHandle(udg_ht, task, 13, e)
    call TimerStart(t, 0.02, true, function Trig_Utsuho03_Main)
    set caster = null
    set t = null
    set e = null
endfunction

function InitTrig_Utsuho03 takes nothing returns nothing
endfunction