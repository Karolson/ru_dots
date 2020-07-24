function Trig_KanakoThunder_Effect takes unit caster, integer level, real px, real py returns nothing
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", px, py))
    call UnitStunArea(caster, 0.75 + 0.25 * level, px, py, 220, 0, 0)
    call UnitMagicDamageArea(caster, px, py, 220, 60 + 30 * level, 6)
endfunction

function Trig_KanakoThunder_Actions takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer task = GetHandleId(t)
    local unit caster = LoadUnitHandle(udg_ht, task, 0)
    local real px
    local real py
    local real angle
    local real dist
    if caster == null then
        call ReleaseTimer(t)
        call FlushChildHashtable(udg_ht, task)
        set t = null
        set caster = null
        return
    elseif IsUnitDead_Test(caster) == false then
        if GetUnitTypeId(caster) == 'U00L' then
            set px = GetRandomInt(0, 15000) - 1000
            set py = GetRandomInt(0, 15000) - 17000
        elseif GetUnitTypeId(caster) == 'U00M' then
            set angle = GetRandomReal(0, 360)
            set dist = GetRandomReal(0, 800)
            set px = GetUnitX(caster) + dist * CosBJ(angle)
            set py = GetUnitY(caster) + dist * SinBJ(angle)
        else
            call BJDebugMsg("bug! KanakoThunder")
            set px = GetUnitX(caster)
            set py = GetUnitY(caster)
        endif
        call Trig_KanakoThunder_Effect(caster, GetUnitAbilityLevel(caster, 'A0F7'), px, py)
    endif
    set t = null
    set caster = null
endfunction

function InitTrig_KanakoThunder takes nothing returns nothing
endfunction