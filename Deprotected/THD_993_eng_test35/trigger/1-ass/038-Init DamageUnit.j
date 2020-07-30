function Trig_Game_Intro_Actions takes nothing returns nothing
    local integer i = 0
    local location l = Location(GetRectCenterX(gg_rct_BackStage), GetRectCenterY(gg_rct_BackStage))
    loop
        set udg_A_AbsDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_DelDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_MagicDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_PhysicalAbilityDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_PhysicalDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_PhysicalItemDamageUnit[i] = CreateUnitAtLoc(Player(i), 'n00X', l, 0)
        set udg_A_SpellNormalBannedUnit[i] = CreateUnitAtLoc(Player(i), 'etoa', l, 0)
        set udg_A_SpellMoveBannedUnit[i] = CreateUnitAtLoc(Player(i), 'edob', l, 0)
        set i = i + 1
    exitwhen i > 15
    endloop
    call RemoveLocation(l)
    set l = null
endfunction

function InitTrig_Init_DamageUnit takes nothing returns nothing
    set gg_trg_Init_DamageUnit = CreateTrigger()
    call TriggerAddAction(gg_trg_Init_DamageUnit, function Trig_Game_Intro_Actions)
endfunction