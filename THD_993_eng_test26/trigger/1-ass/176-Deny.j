function Trig_Deny_Conditions takes nothing returns boolean
    return IsUnitAlly(GetKillingUnit(), GetTriggerPlayer())
endfunction

function Hero_Filter takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsUnitEnemy(GetFilterUnit(), bj_groupEnumOwningPlayer) and GetWidgetLife(GetFilterUnit()) > 0.405
endfunction

function Trig_Deny_Actions takes nothing returns nothing
    local texttag tag = CreateTextTag()
    local unit u = GetTriggerUnit()
    local integer lvl = GetUnitLevel(u)
    local boolean ishero = IsUnitType(u, UNIT_TYPE_HERO)
    local group g = CreateGroup()
    local filterfunc f = Filter(function Hero_Filter)
    local integer xp
    local integer i
    local unit v
    set bj_groupEnumOwningPlayer = GetTriggerPlayer()
    call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 1000.0, f)
    set bj_wantDestroyGroup = false
    set i = CountUnitsInGroup(g)
    if i > 0 then
        if ishero then
            if lvl == 1 then
                set xp = 50
            elseif lvl == 2 then
                set xp = 60
            elseif lvl == 3 then
                set xp = 80
            elseif lvl == 4 then
                set xp = 110
            else
                set xp = 50 * (lvl - 2)
            endif
            set xp = R2I(xp / i)
        else
            set xp = R2I((1.3 * lvl * lvl + 4.3 * lvl + 10.9) / i)
        endif
        loop
            set v = FirstOfGroup(g)
        exitwhen v == null
            call GroupRemoveUnit(g, v)
            call AddHeroXP(v, xp, true)
        endloop
    endif
    call SetTextTagText(tag, "!", 0.03)
    call SetTextTagPosUnit(tag, u, 0)
    call SetTextTagColorBJ(tag, 255, 255, 255, 15)
    call SetTextTagVelocity(tag, 0, 0.035)
    call SetTextTagFadepoint(tag, 3)
    call SetTextTagLifespan(tag, 1.5)
    call SetTextTagPermanent(tag, false)
    call SetTextTagVisibility(tag, true)
    call DestroyGroup(g)
    call DestroyFilter(f)
    set f = null
    set g = null
    set tag = null
    set u = null
endfunction

function InitTrig_Deny takes nothing returns nothing
    set gg_trg_Deny = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Deny, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Deny, Condition(function Trig_Deny_Conditions))
    call TriggerAddAction(gg_trg_Deny, function Trig_Deny_Actions)
endfunction