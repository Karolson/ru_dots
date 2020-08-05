function VE_Sword takes unit target returns nothing
    call DestroyEffect(AddSpecialEffect("THDotS\\VisualEffect\\AttackBa.mdl", GetUnitX(target), GetUnitY(target)))
endfunction

function VE_SwordCharge takes unit target returns nothing
    call DestroyEffect(AddSpecialEffect("THDotS\\VisualEffect\\AttackBb.mdl", GetUnitX(target), GetUnitY(target)))
endfunction

function VE_Sword_Special takes unit target, integer id returns nothing
    if id == 0 then
        set id = GetRandomInt(1, 2)
    endif
    if id == 1 then
        call CreateUnit(GetOwningPlayer(target), 'u010', GetUnitX(target), GetUnitY(target), GetRandomInt(0, 360))
    elseif id == 2 then
        call CreateUnit(GetOwningPlayer(target), 'u011', GetUnitX(target), GetUnitY(target), GetRandomInt(0, 360))
    endif
endfunction

function VE_Spellcast takes unit caster returns nothing
    call CreateUnit(GetOwningPlayer(caster), 'u012', GetUnitX(caster), GetUnitY(caster), GetRandomInt(0, 360))
endfunction

function InitTrig_VisualEffectSys takes nothing returns nothing
endfunction