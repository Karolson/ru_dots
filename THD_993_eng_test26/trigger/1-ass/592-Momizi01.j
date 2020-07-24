function Trig_Momizi01_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09U'
endfunction

function Momiji01_Check takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_ht, task, 0)
    local real a = GetUnitFacing(u)
    if udg_SK_Momizi01[0] != null and GetWidgetLife(udg_SK_Momizi01[0]) > 0.405 and not IsUnitInRange(u, udg_SK_Momizi01[0], 1000.0) then
        call SetUnitPosition(udg_SK_Momizi01[0], GetUnitX(u) - 150 * Cos((a - 20) * 0.017454), GetUnitY(u) - 150 * Sin((a - 20) * 0.017454))
    endif
    if udg_SK_Momizi01[1] != null and GetWidgetLife(udg_SK_Momizi01[1]) > 0.405 and not IsUnitInRange(u, udg_SK_Momizi01[1], 1000.0) then
        call SetUnitPosition(udg_SK_Momizi01[1], GetUnitX(u) - 150 * Cos((a - 20) * 0.017454), GetUnitY(u) - 150 * Sin((a - 20) * 0.017454))
    endif
    if (udg_SK_Momizi01[0] == null and udg_SK_Momizi01[1] == null) or (GetWidgetLife(udg_SK_Momizi01[0]) < 0.405 and GetWidgetLife(udg_SK_Momizi01[1]) < 0.405) then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        call RemoveSavedHandle(udg_sht, StringHash("Momiji01"), 0)
    endif
    set t = null
    set u = null
endfunction

function Trig_Momizi01_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, 'A09U')
    local real a = GetUnitFacing(caster)
    local real tx1 = GetUnitX(caster) + 100 * Cos((a - 20) * 0.017454)
    local real ty1 = GetUnitY(caster) + 100 * Sin((a - 20) * 0.017454)
    local real tx2 = GetUnitX(caster) + 100 * Cos((a + 20) * 0.017454)
    local real ty2 = GetUnitY(caster) + 100 * Sin((a + 20) * 0.017454)
    local integer uttype
    local timer t
    local integer task
    call AbilityCoolDownResetion(caster, 'A09U', 20)
    if udg_SK_Momizi01[0] != null then
        call KillUnit(udg_SK_Momizi01[0])
    endif
    if udg_SK_Momizi01[1] != null then
        call KillUnit(udg_SK_Momizi01[1])
    endif
    set uttype = 'o00E' + level
    set udg_SK_Momizi01[0] = CreateUnit(GetOwningPlayer(caster), uttype, tx1, ty1, a)
    set udg_SK_Momizi01[1] = CreateUnit(GetOwningPlayer(caster), uttype, tx2, ty2, a)
    call UnitAddMaxLife(udg_SK_Momizi01[0], R2I(GetHeroLevel(caster) * 45))
    call UnitAddMaxLife(udg_SK_Momizi01[1], R2I(GetHeroLevel(caster) * 45))
    if udg_GameMode / 100 != 3 and udg_NewMid == false then
        call UnitAddBonusDmg(udg_SK_Momizi01[0], R2I(GetHeroLevel(caster) * 2.5 + GetUnitAbilityLevel(caster, 'A09V') * 8))
        call UnitAddBonusDmg(udg_SK_Momizi01[1], R2I(GetHeroLevel(caster) * 2.5 + GetUnitAbilityLevel(caster, 'A09V') * 8))
    else
        call UnitAddBonusDmg(udg_SK_Momizi01[0], R2I(GetHeroLevel(caster) * 2.5 + GetUnitAbilityLevel(caster, 'A09V') * 12))
        call UnitAddBonusDmg(udg_SK_Momizi01[1], R2I(GetHeroLevel(caster) * 2.5 + GetUnitAbilityLevel(caster, 'A09V') * 12))
    endif
    call UnitAddAbility(udg_SK_Momizi01[0], 'A189')
    call SetUnitAbilityLevel(udg_SK_Momizi01[0], 'A189', R2I(GetHeroLevel(caster)))
    call UnitAddAbility(udg_SK_Momizi01[1], 'A189')
    call SetUnitAbilityLevel(udg_SK_Momizi01[1], 'A189', R2I(GetHeroLevel(caster)))
    if not HaveSavedHandle(udg_sht, StringHash("Momiji01"), 0) then
        set t = CreateTimer()
        set task = GetHandleId(t)
        call SaveUnitHandle(udg_ht, task, 0, caster)
        call TimerStart(t, 0.5, true, function Momiji01_Check)
        call SaveTimerHandle(udg_sht, StringHash("Momiji01"), 0, t)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_Momizi01 takes nothing returns nothing
endfunction