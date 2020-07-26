function RecHeroBasicArmorValue takes unit h, real k returns nothing
    call SaveInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAR', R2I(k * 100))
endfunction

function RecHeroIncreArmorValue takes unit h, real k returns nothing
    call SaveInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAI', R2I(k * 100))
endfunction

function RecHeroAttackBaseValue takes unit h, integer k returns nothing
    call SaveInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAB', k)
endfunction

function RecHeroAttackUppeValue takes unit h, integer k returns nothing
    call SaveInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAU', k)
endfunction

function RecHeroStaterTypeValue takes unit h, integer k returns nothing
    call SaveInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAU', k)
endfunction

function SqSaveAbilityId takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 0, a)
endfunction

function SqSaveHasCastRa takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 1, a)
endfunction

function SqSaveBaseRange takes unit h, integer i, real a returns nothing
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 2, a)
endfunction

function SqSaveIncrRange takes unit h, integer i, real a returns nothing
    call SaveReal(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 3, a)
endfunction

function SqSaveCircleTyp takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 4, a)
endfunction

function SqSaveCircleRed takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 5, a)
endfunction

function SqSaveCircleGre takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 6, a)
endfunction

function SqSaveCircleBlu takes unit h, integer i, integer a returns nothing
    call SaveInteger(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 7, a)
endfunction

function SqSaveUnitCircl takes unit h, integer i, integer a returns nothing
    call SaveUnitHandle(udg_Hashtable_CastSq_Id, GetHandleId(h), i * 10 + 8, null)
endfunction

function ABCIAllAtk takes unit caster, real base, real ince returns real
    return base + ince * GetUnitAttack(caster)
endfunction

function ABCIAllLife takes unit caster, real base, real ince returns real
    return base + ince * GetUnitState(caster, UNIT_STATE_MAX_LIFE)
endfunction

function ABCIAllStr takes unit caster, real base, real ince returns real
    return base + ince * GetHeroStr(caster, true)
endfunction

function ABCIAllAgi takes unit caster, real base, real ince returns real
    return base + ince * GetHeroAgi(caster, true)
endfunction

function ABCIAllInt takes unit caster, real base, real ince returns real
    return base + ince * GetHeroInt(caster, true)
endfunction

function ABCIExtraAtk takes unit caster, real base, real ince returns real
    return base + ince * (GetUnitAttack(caster) - GetUnitBaseAttack(caster))
endfunction

function ABCIExtraStr takes unit caster, real base, real ince returns real
    return base + ince * (GetHeroStr(caster, true) - GetHeroStr(caster, false))
endfunction

function ABCIExtraAgi takes unit caster, real base, real ince returns real
    return base + ince * (GetHeroAgi(caster, true) - GetHeroAgi(caster, false))
endfunction

function ABCIExtraInt takes unit caster, real base, real ince returns real
    return base + ince * (GetHeroInt(caster, true) - GetHeroInt(caster, false))
endfunction

function Trig_AbilityCageIn_Actions takes nothing returns nothing
endfunction

function InitTrig_AbilityCageIn takes nothing returns nothing
endfunction