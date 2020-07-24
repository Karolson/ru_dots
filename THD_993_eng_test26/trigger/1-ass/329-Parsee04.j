function Trig_Parsee04_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0PO'
endfunction

function Trig_Parsee04_Main takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local unit target = LoadUnitHandle(udg_ht, task, 1)
    local unit u = LoadUnitHandle(udg_ht, task, 2)
    local integer i = LoadInteger(udg_ht, task, 3)
    local integer j
    local integer k
    local lightning e1 = LoadLightningHandle(udg_ht, task, 4)
    local lightning e2 = LoadLightningHandle(udg_ht, task, 5)
    local integer level = LoadInteger(udg_ht, task, 6)
    local integer threshold = 400 + level * 200
    local real ltx1
    local real lty1
    local real ltz1
    local real ltx2
    local real lty2
    local real ltz2
    local boolean endkill = false
    local texttag tt1 = LoadTextTagHandle(udg_ht, task, 7)
    local texttag tt2 = LoadTextTagHandle(udg_ht, task, 8)
    local real ox = GetUnitX(caster)
    local real oy = GetUnitY(caster)
    local real tx = GetUnitX(target)
    local real ty = GetUnitY(target)
    local real distance1 = (ox - GetUnitX(u)) * (ox - GetUnitX(u)) + (oy - GetUnitY(u)) * (oy - GetUnitY(u))
    local real distance2 = (tx - GetUnitX(u)) * (tx - GetUnitX(u)) + (ty - GetUnitY(u)) * (ty - GetUnitY(u))
    if IsUnitType(caster, UNIT_TYPE_DEAD) or IsUnitType(target, UNIT_TYPE_DEAD) or GetWidgetLife(u) < 0.405 or not IsUnitInRange(caster, u, threshold) or not IsUnitInRange(target, u, threshold) then
        set endkill = true
    endif
    call SetTextTagText(tt1, R2SW(400 + level * 200 - SquareRoot(distance1), 3, 1), 0.0276)
    call SetTextTagPosUnit(tt1, caster, 100.0)
    call SetTextTagText(tt2, R2SW(400 + level * 200 - SquareRoot(distance2), 3, 1), 0.0276)
    call SetTextTagPosUnit(tt2, target, 100.0)
    if IsVisibleToPlayer(ox, oy, GetLocalPlayer()) == false and IsUnitVisible(caster, GetLocalPlayer()) == false then
        call SetTextTagVisibility(tt1, false)
    else
        call SetTextTagVisibility(tt1, true)
    endif
    if IsVisibleToPlayer(tx, ty, GetLocalPlayer()) == false and IsUnitVisible(target, GetLocalPlayer()) == false then
        call SetTextTagVisibility(tt2, false)
    else
        call SetTextTagVisibility(tt2, true)
    endif
    if endkill == false then
        set ltx1 = GetUnitX(u)
        set lty1 = GetUnitY(u)
        set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
        set ltx2 = GetUnitX(target)
        set lty2 = GetUnitY(target)
        set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
        call MoveLightningEx(e1, false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
        set ltx1 = GetUnitX(u)
        set lty1 = GetUnitY(u)
        set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
        set ltx2 = GetUnitX(caster)
        set lty2 = GetUnitY(caster)
        set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
        call MoveLightningEx(e2, false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
        set i = i - 1
        call SaveInteger(udg_ht, task, 3, i)
        if i == 0 then
            if IsUnitType(target, UNIT_TYPE_DEAD) == false then
                call UnitStunTarget(caster, target, 4.0, 0, 0)
                call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 50 + level * 150, 2.5) * 1.5, 1)
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", GetUnitX(target), GetUnitY(target)))
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl", GetUnitX(target), GetUnitY(target)))
                set j = 0
                loop
                    set j = j + 1
                    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", GetUnitX(target) + 210 * CosBJ(j * 360 / 7), GetUnitY(target) + 210 * SinBJ(j * 360 / 7)))
                exitwhen j == 7
                endloop
            endif
            set udg_AIParsee04_Target = null
            call DestroyTextTag(tt1)
            call DestroyTextTag(tt2)
            call DestroyLightning(e1)
            call DestroyLightning(e2)
            call KillUnit(u)
            call ReleaseTimer(t)
            call FlushChildHashtable(udg_ht, task)
        endif
    else
        if IsUnitType(target, UNIT_TYPE_DEAD) == false then
            call UnitMagicDamageTarget(caster, target, ABCIAllInt(caster, 50 + level * 150, 2.5), 1)
            set j = 0
            set k = R2I(i / 20)
            if k != 0 then
                loop
                    set j = j + 1
                    call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", GetUnitX(target) + 210 * CosBJ(j * 360 / 7), GetUnitY(target) + 210 * SinBJ(j * 360 / 7)))
                exitwhen j == k
                endloop
            endif
        endif
        set udg_AIParsee04_Target = null
        call DestroyTextTag(tt1)
        call DestroyTextTag(tt2)
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", GetUnitX(target), GetUnitY(target)))
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UDeathMedium\\UDeath.mdl", GetUnitX(target), GetUnitY(target)))
        call KillUnit(u)
        call ReleaseTimer(t)
        call DestroyLightning(e1)
        call DestroyLightning(e2)
        call FlushChildHashtable(udg_ht, task)
    endif
    set tt1 = null
    set tt2 = null
    set caster = null
    set target = null
    set u = null
    set t = null
    set e1 = null
    set e2 = null
endfunction

function Trig_Parsee04_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local unit u
    local integer level = GetUnitAbilityLevel(caster, 'A0PO')
    local timer t
    local integer task
    local lightning e1
    local lightning e2
    local real ltx1
    local real lty1
    local real ltz1
    local real ltx2
    local real lty2
    local real ltz2
    local texttag tt1
    local texttag tt2
    call AbilityCoolDownResetion(caster, GetSpellAbilityId(), 70 - 10 * level)
    call VE_Spellcast(caster)
    call CE_Input(caster, target, 150)
    set u = CreateUnit(GetOwningPlayer(caster), 'n00Y', GetUnitX(target) + CosBJ(GetRandomInt(0, 360)) * 130, GetUnitY(target) + SinBJ(GetRandomInt(0, 360)) * 130, GetRandomInt(0, 360))
    call addlife(u, level * 150)
    set ltx1 = GetUnitX(u)
    set lty1 = GetUnitY(u)
    set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
    set ltx2 = GetUnitX(target)
    set lty2 = GetUnitY(target)
    set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
    set e1 = AddLightningEx("DRAL", false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
    set ltx1 = GetUnitX(u)
    set lty1 = GetUnitY(u)
    set ltz1 = GetPositionZ(ltx1, lty1) + 80.0
    set ltx2 = GetUnitX(caster)
    set lty2 = GetUnitY(caster)
    set ltz2 = GetPositionZ(ltx2, lty2) + 80.0
    set e2 = AddLightningEx("DRAL", false, ltx1, lty1, ltz1, ltx2, lty2, ltz2)
    set tt1 = CreateTextTag()
    call SetTextTagText(tt1, R2SW(400 + level * 200, 3, 1), 0.0276)
    call SetTextTagColor(tt1, 0, 255, 255, 255)
    call SetTextTagPosUnit(tt1, caster, 100.0)
    set tt2 = CreateTextTag()
    call SetTextTagText(tt2, R2SW(400 + level * 200, 3, 1), 0.0276)
    call SetTextTagColor(tt2, 0, 255, 255, 255)
    call SetTextTagPosUnit(tt2, target, 100.0)
    set t = CreateTimer()
    set task = GetHandleId(t)
    call SaveUnitHandle(udg_ht, task, 0, caster)
    call SaveUnitHandle(udg_ht, task, 1, target)
    call SaveUnitHandle(udg_ht, task, 2, u)
    call SaveInteger(udg_ht, task, 3, 98)
    call SaveLightningHandle(udg_ht, task, 4, e1)
    call SaveLightningHandle(udg_ht, task, 5, e2)
    call SaveInteger(udg_ht, task, 6, level)
    call SaveTextTagHandle(udg_ht, task, 7, tt1)
    call SaveTextTagHandle(udg_ht, task, 8, tt2)
    call TimerStart(t, 0.05, true, function Trig_Parsee04_Main)
    set tt1 = null
    set tt2 = null
    set caster = null
    set target = null
    set u = null
    set t = null
    set e1 = null
    set e2 = null
endfunction

function InitTrig_Parsee04 takes nothing returns nothing
endfunction