function Trig_WriggleEx_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09N' and GetUnitAbilityLevel(GetTriggerUnit(), 'A09O') == 0
endfunction

function Trig_WriggleEx_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local fogmodifier v = LoadFogModifierHandle(udg_ht, task, 1)
    local integer i = LoadInteger(udg_ht, task, 1)
    local real r = LoadReal(udg_ht, task, 0)
    if GetWidgetLife(caster) > 0.405 and i > 0 then
        call DestroyFogModifier(v)
        set v = CreateFogModifierRadius(GetOwningPlayer(caster), FOG_OF_WAR_VISIBLE, GetUnitX(caster), GetUnitY(caster), r, true, false)
        call FogModifierStart(v)
        call SaveFogModifierHandle(udg_ht, task, 1, v)
        call SaveInteger(udg_ht, task, 1, i - 1)
    else
        call DestroyFogModifier(v)
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
    endif
    set t = null
    set caster = null
    set v = null
endfunction

function Trig_WriggleEx_Actions takes nothing returns nothing
    local timer t = CreateTimer()
    local integer task = GetHandleId(t)
    local unit caster = GetTriggerUnit()
    local fogmodifier v
    local real r
    local real abilitycooldownlv01 = 70
    if YDWEUnitHasItemOfTypeBJNull(caster, 'I00B') then
        if GetUnitAbilityLevel(caster, GetSpellAbilityId()) == 1 then
            call Item_HeroAbilityCoolDownReset(caster, GetSpellAbilityId(), abilitycooldownlv01)
        endif
    endif
    set r = 1800.0
    set v = CreateFogModifierRadius(GetOwningPlayer(caster), FOG_OF_WAR_VISIBLE, GetUnitX(caster), GetUnitY(caster), r, true, false)
    call FogModifierStart(v)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveFogModifierHandle(udg_ht, task, 1, v)
    call SaveInteger(udg_ht, task, 1, 150)
    call SaveReal(udg_ht, task, 0, r)
    call TimerStart(t, 0.1, true, function Trig_WriggleEx_Main)
    set t = null
    set caster = null
    set v = null
endfunction

function InitTrig_WriggleEx takes nothing returns nothing
endfunction