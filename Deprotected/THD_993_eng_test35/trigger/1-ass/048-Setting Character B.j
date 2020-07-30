function Trig_Setting_Character_B_Actions takes nothing returns nothing
    local integer i = 100
    local hashtable db = udg_HeroDatabase
    set i = i + 1
    set udg_HeroType[i] = 'H009'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_sanae.blp"
    set udg_HeroButton[i] = 'B01E'
    set udg_HeroBrief[i] = "|cffffcc00Kochiya Sanae|r\n|cff00aaff|r Mage, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    set udg_HeroCloth01[i] = 'H01W'
    call AI_HeroSkill(i, 'A06U', 'A06V', 'A06W', 'A03Y', 'A06Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 32)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 32)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Sanae
    set i = i + 1
    set udg_HeroType[i] = 'U00L'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNkanako.blp"
    set udg_HeroButton[i] = 'B01K'
    set udg_HeroBrief[i] = "|cffffcc00Yasaka Kanako|r\n|cffffffff|r Mage, pusher, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0F6', 'A0F1', 'A0F4', 'A03Y', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'U00M', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'U00M', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'U00M', 'BSAB', 28)
    call SaveInteger(udg_HeroDatabase, 'U00M', 'BSAU', 30)
    call SaveInteger(udg_HeroDatabase, 'U00M', 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Kanako
    set i = i + 1
    set udg_HeroType[i] = 'H012'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNsuwako.blp"
    set udg_HeroButton[i] = 'B01U'
    set udg_HeroBrief[i] = "|cffffcc00Moriya Suwako|r\n|cffaaaaff|r Mage, tank, melee (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    set udg_HeroCloth01[i] = 'H01X'
    call AI_HeroSkill(i, 'A0FI', 'A0FJ', 'A0FK', 'A03Y', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -80)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', -80)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth02[i], 'BSAR', -80)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth02[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth02[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth02[i], 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth02[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'H024', 'BSAR', -60)
    call SaveInteger(udg_HeroDatabase, 'H024', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'H024', 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, 'H024', 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, 'H024', 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'H025', 'BSAR', -60)
    call SaveInteger(udg_HeroDatabase, 'H025', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'H025', 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, 'H025', 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, 'H025', 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'H02B', 'BSAR', -60)
    call SaveInteger(udg_HeroDatabase, 'H02B', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'H02B', 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, 'H02B', 'BSAU', 47)
    call SaveInteger(udg_HeroDatabase, 'H02B', 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Suwako
    set i = i + 1
    set udg_HeroType[i] = 'H00X'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNHina.blp"
    set udg_HeroButton[i] = 'B01S'
    set udg_HeroBrief[i] = "|cffffcc00Kagiyama Hina|r\n|cff00ff00|r Tank, ranged (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0E9', 'A0E4', 'A0DZ', 'A03Y', 'A0E8')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 32)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Hina
    set i = i + 1
    set udg_HeroType[i] = 'H01H'
    set udg_HeroCloth01[i] = 'H02F'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Shizuha.blp"
    set udg_HeroButton[i] = 'B023'
    set udg_HeroBrief[i] = "|cffffcc00Aki Shizuha|r\n|cffcccccc|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0G8', 'A0XD', 'A0J8', 'A03Y', 'A0JC')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Shizuha
    set i = i + 1
    set udg_HeroType[i] = 'H01I'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNminoriko.blp"
    set udg_HeroButton[i] = 'B024'
    set udg_HeroBrief[i] = "|cffffcc00Aki Minoriko|r\n|cff00ff00|r Support, ranged (STR)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    set udg_HeroCloth01[i] = 'H01Y'
    call AI_HeroSkill(i, 'A0JF', 'A0JJ', 'A06A', 'A0JI', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Init_Minoriko
    set i = i + 1
    set udg_HeroType[i] = 'E008'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_aya.blp"
    set udg_HeroButton[i] = 'B01D'
    set udg_HeroBrief[i] = "|cffffcc00Shameimaru Aya|r\n|cffffaacc|r Fighter, carry, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A05O', 'A05L', 'A05S', 'A03Y', 'A05K')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 18)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Aya
    set i = i + 1
    set udg_HeroType[i] = 'O00V'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNHatate.blp"
    set udg_HeroButton[i] = 'B02Q'
    set udg_HeroBrief[i] = "|cffffcc00Himekaidou Hatate|r\n|cffffaacc|r Fighter, carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A08N', 'A0D9', 'A09B', 'A0E6', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 29)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initialing_Hatate
    set i = i + 1
    set udg_HeroType[i] = 'O00A'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_momizi.blp"
    set udg_HeroButton[i] = 'B00V'
    set udg_HeroBrief[i] = "|cffffcc00Inubashiri Momiji|r\n|cffffff00|r Fighter, pusher, melee (AGI)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A09W', 'A09U', 'A09V', 'A0QO', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Momizi
    set i = i + 1
    set udg_HeroType[i] = 'H00M'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Nitori.blp"
    set udg_HeroButton[i] = 'B01H'
    set udg_HeroBrief[i] = "|cffffcc00Kawashiro Nitori|r\n|cffff0000|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A094', 'A095', 'A03Y', 'A0GF', 'A0LK')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 22)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'H00S', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'H00S', 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, 'H00S', 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, 'H00S', 'BSAU', 43)
    call SaveInteger(udg_HeroDatabase, 'H00S', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Nitori
    set i = i + 1
    set udg_HeroType[i] = 'H002'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_tensi.blp"
    set udg_HeroButton[i] = 'B015'
    set udg_HeroBrief[i] = "|cffffcc00Hinanawi Tenshi|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0AJ', 'A070', 'A071', 'A073', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 43)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Init_Tensi
    set i = i + 1
    set udg_HeroType[i] = 'U003'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_iku.blp"
    set udg_HeroButton[i] = 'B00H'
    set udg_HeroBrief[i] = "|cffffcc00Nagae Iku|r\n|cffaaaa00|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A04S', 'A05M', 'A04O', 'A03Y', 'A0A4')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Iku
    set i = i + 1
    set udg_HeroType[i] = 'O006'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNeirin.blp"
    set udg_HeroButton[i] = 'B00Q'
    set udg_HeroBrief[i] = "|cffffcc00Yagokoro Eirin|r\n|cff99ffff|r Assassin, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A088', 'A083', 'A082', 'A03Y', 'A086')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 21)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Eirin
    set i = i + 1
    set udg_HeroType[i] = 'H00W'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNkaguya.blp"
    set udg_HeroButton[i] = 'B01Q'
    set udg_HeroBrief[i] = "|cffffcc00Houraisan Kaguya|r\n|cffaaaa00|r Tank, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    set udg_HeroCloth01[i] = 'H02G'
    call AI_HeroSkill(i, 'A0D0', 'A0SP', 'A0D2', 'A0SQ', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Kaguya
    set udg_HeroCloth01Init[i] = gg_trg_Init_Kaguya
    set i = i + 1
    set udg_HeroType[i] = 'O007'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_reisen.blp"
    set udg_HeroButton[i] = 'B00X'
    set udg_HeroBrief[i] = "|cffffcc00Reisen Udongein Inaba|r\n|cffffffcc|r Carry, pusher, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A069', 'A0GT', 'A066', 'A06D', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Reisen
    set i = i + 1
    set udg_HeroType[i] = 'O00N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Twei.blp"
    set udg_HeroButton[i] = 'B02I'
    set udg_HeroBrief[i] = "|cffffcc00Inaba Tewi|r\n|cffcccccc|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0N2', 'A0N3', 'A0N5', 'A0N4', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 31)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Twei
    set i = i + 1
    set udg_HeroType[i] = 'E02S'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Reisen_2.blp"
    set udg_HeroButton[i] = 'B032'
    set udg_HeroBrief[i] = "|cffffcc00Reisen|r\n|cffff0000|r Fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A06I', 'A068', 'A07Q', 'A0DA', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 50)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initialing_Reisen2
    set i = i + 1
    set udg_HeroType[i] = 'H00L'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_suika.blp"
    set udg_HeroButton[i] = 'B00Y'
    set udg_HeroBrief[i] = "|cffffcc00Ibuki Suika|r\n|cffaaaa00|r Tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A05W', 'A05V', 'A02I', 'A03Y', 'A05R')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    call SaveInteger(udg_HeroDatabase, 'H00Q', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'H00Q', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'H00Q', 'BSAB', 38)
    call SaveInteger(udg_HeroDatabase, 'H00Q', 'BSAU', 44)
    call SaveInteger(udg_HeroDatabase, 'H00Q', 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Suika
    set i = i + 1
    set udg_HeroType[i] = 'U00K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNnazrin.blp"
    set udg_HeroButton[i] = 'B01R'
    set udg_HeroBrief[i] = "|cffffcc00Nazrin|r\n|cffffaacc|r Fighter, carry, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0D7', 'A0D8', 'A03Y', 'A0ED', 'A0D4')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 43)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'U00R', 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, 'U00R', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'U00R', 'BSAB', 37)
    call SaveInteger(udg_HeroDatabase, 'U00R', 'BSAU', 43)
    call SaveInteger(udg_HeroDatabase, 'U00R', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Nazrin
    set i = i + 1
    set udg_HeroType[i] = 'H01N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Toramaru.blp"
    set udg_HeroButton[i] = 'B02N'
    set udg_HeroBrief[i] = "|cffffcc00Toramaru Shou|r\n|cffaaaaff|r Mage, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0P2', 'A0P1', 'A0P3', 'A0P4', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Toramaru
    set i = i + 1
    set udg_HeroType[i] = 'E00Q'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Captain.blp"
    set udg_HeroButton[i] = 'B01F'
    set udg_HeroBrief[i] = "|cffffcc00Minamitsu Murasa|r\n|cffffaa00|r Fighter, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0AA', 'A0A6', 'A03Y', 'A0AB', 'A0AC')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 42)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Captain
    set i = i + 1
    set udg_HeroType[i] = 'E03K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNKumoi.blp"
    set udg_HeroButton[i] = 'B036'
    set udg_HeroBrief[i] = "|cffffcc00Kumoi Ichirin|r\n|cffaaaaff|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A10C', 'A10D', 'A10E', 'A0ND', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'E03M', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'E03M', 'BSAI', 10)
    call SaveInteger(udg_HeroDatabase, 'E03M', 'BSAB', 36)
    call SaveInteger(udg_HeroDatabase, 'E03M', 'BSAU', 38)
    call SaveInteger(udg_HeroDatabase, 'E03M', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Kumoi
    set i = i + 1
    set udg_HeroType[i] = 'H01K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_byakuren.blp"
    set udg_HeroButton[i] = 'B02H'
    set udg_HeroBrief[i] = "|cffffcc00Hijiri Byakuren|r\n|cffaaaaff|r Mage, tank, melee (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0NZ', 'A0O0', 'A0O1', 'A0O2', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 45)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initial_Byakuren
    set i = i + 1
    set udg_HeroType[i] = 'H01J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Houjuu Nue.blp"
    set udg_HeroButton[i] = 'B02F'
    set udg_HeroBrief[i] = "|cffffcc00Houjuu Nue|r\n|cffff00ff|r Mage, fighter, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A0M1', 'A0M4', 'A0M2', 'A0M3', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 45)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Nue
    set i = i + 1
    set udg_HeroType[i] = 'E00I'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Rumia.blp"
    set udg_HeroButton[i] = 'B01T'
    set udg_HeroBrief[i] = "|cffffcc00Rumia|r\n|cff333366|r Assassin, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A07C', 'A07E', 'A07G', 'A03Y', 'A07J')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    call SaveInteger(udg_HeroDatabase, 'E00J', 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, 'E00J', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E00J', 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, 'E00J', 'BSAU', 41)
    call SaveInteger(udg_HeroDatabase, 'E00J', 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Rumia
    set i = i + 1
    set udg_HeroType[i] = 'E00A'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Wriggle.blp"
    set udg_HeroButton[i] = 'B010'
    set udg_HeroBrief[i] = "|cffffcc00Wriggle Nightbug|r\n|cff99cc66|r Assassin, pusher, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A09R', 'A09K', 'A03Y', 'A09N', 'A09M')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 29)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Wriggle
    set i = i + 1
    set udg_HeroType[i] = 'E00Z'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Mystia.blp"
    set udg_HeroButton[i] = 'B00W'
    set udg_HeroBrief[i] = "|cffffcc00Mystia Lorelei|r\n|cff99cc66|r Fighter, support, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    set udg_HeroCloth01[i] = 'E02B'
    set udg_HeroCloth03[i] = 'EMNN'
    call AI_HeroSkill(i, 'A0DE', 'A0DI', 'A0DH', 'A0DN', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth01[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, udg_HeroCloth03[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'E01T', 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, 'E01T', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E01T', 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, 'E01T', 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, 'E01T', 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'E02C', 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, 'E02C', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E02C', 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, 'E02C', 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, 'E02C', 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'E041', 'BSAR', 150)
    call SaveInteger(udg_HeroDatabase, 'E041', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E041', 'BSAB', 43)
    call SaveInteger(udg_HeroDatabase, 'E041', 'BSAU', 48)
    call SaveInteger(udg_HeroDatabase, 'E041', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Mystia
    set i = i + 1
    set udg_HeroType[i] = 'E023'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Lily.blp"
    set udg_HeroButton[i] = 'B02U'
    set udg_HeroBrief[i] = "|cffffcc00Lily White|r\n|cff00aaff|r Mage, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0WK', 'A0WL', 'A0X3', 'A0X6', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 15)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 58)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    call SaveInteger(udg_HeroDatabase, 'E024', 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, 'E024', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'E024', 'BSAB', 15)
    call SaveInteger(udg_HeroDatabase, 'E024', 'BSAU', 58)
    call SaveInteger(udg_HeroDatabase, 'E024', 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Lily
    set i = i + 1
    set udg_HeroType[i] = 'N00L'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_yuka.blp"
    set udg_HeroButton[i] = 'B01B'
    set udg_HeroBrief[i] = "|cffffcc00Kazami Yuuka|r\n|cffffbb33|r Pusher, tank, melee (STR)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A06I', 'A068', 'A07Q', 'A0DA', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 23)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 28)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Yuka
    set i = i + 1
    set udg_HeroType[i] = 'N00K'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_medi.blp"
    set udg_HeroButton[i] = 'B01G'
    set udg_HeroBrief[i] = "|cffffcc00Medicine Melancholy|r\n|cffccffcc|r Tank, support, ranged (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A07W', 'A0DO', 'A07V', 'A03Y', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 29)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 39)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Medi
    set i = i + 1
    set udg_HeroType[i] = 'H01A'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNalice.blp"
    set udg_HeroButton[i] = 'B00M'
    set udg_HeroBrief[i] = "|cffffcc00Alice Margatroid|r\n|cffffffcc|r Carry, pusher, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●●●|r"
    call AI_HeroSkill(i, 'A0GY', 'A0GV', 'A0GW', 'A0GX', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Alice
    set i = i + 1
    set udg_HeroType[i] = 'E01D'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Sunny.blp"
    set udg_HeroButton[i] = 'B02J'
    set udg_HeroBrief[i] = "|cffffcc00Sunny Milk|r\n|cff6666ff|r Mage, assassin, melee (STR)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A0N2', 'A0N3', 'A0N4', 'A03Y', 'A0N5')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Init_Sunny
    set i = i + 1
    set udg_HeroType[i] = 'E00O'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Lunar.blp"
    set udg_HeroButton[i] = 'B030'
    set udg_HeroBrief[i] = "|cffffcc00Luna Child|r\n|cffcccccc|r Carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A06L', 'A0TF', 'A19S', 'A0FX', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Init_Lunar
    set i = i + 1
    set udg_HeroType[i] = 'E03L'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNStar.blp"
    set udg_HeroButton[i] = 'B037'
    set udg_HeroBrief[i] = "|cffffcc00Star Sapphire|r\n|cffcccccc|r Mage, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A10M', 'A10F', 'A10N', 'A10S', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Init_Start
    set i = i + 1
    set udg_HeroType[i] = 'H02J'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNShinki.blp"
    set udg_HeroButton[i] = 'B039'
    set udg_HeroBrief[i] = "|cffffcc00Shinki|r\n|cffffffcc|r Mage, support, ranged (INT)\n|cffccccccDifficulty for newbies: ●●○○○|r"
    call AI_HeroSkill(i, 'A1EZ', 'A1DX', 'A1DV', 'A1DZ', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 26)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 3)
    set udg_HeroInit[i] = gg_trg_Initialing_Shinki
    set i = i + 1
    set udg_HeroType[i] = 'E03N'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTNKulumi.blp"
    set udg_HeroButton[i] = 'B038'
    set udg_HeroBrief[i] = "|cffffcc00Kurumi|r\n|cffffaacc|r Fighter, carry, melee (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 'A112', 'A113', 'A11E', 'A11H', 'A11J')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 30)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Kulumi
    set i = i + 1
    set udg_HeroType[i] = 'E037'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN-huanyue.blp"
    set udg_HeroButton[i] = 'B034'
    set udg_HeroBrief[i] = "|cffffcc00Mugetsu|r\n|cffffaacc|r Fighter, carry, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A0UC', 'A0UB', 'A0UG', 'A03Y', 'A0UH')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Mugetsu
    set i = i + 1
    set udg_HeroType[i] = 'O01C'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN-Kagerou.blp"
    set udg_HeroButton[i] = 'B03C'
    set udg_HeroBrief[i] = "|cffffcc00Imaizumi Kagerou|r\n|cffffaacc|r Assassin, melee (AGI)\n|cffccccccDifficulty for newbies: ●●●●○|r"
    call AI_HeroSkill(i, 'A1HO', 'A1HP', 'A1HQ', 'A1HR', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 32)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    call SaveInteger(udg_HeroDatabase, 'O01D', 'BSAR', 0)
    call SaveInteger(udg_HeroDatabase, 'O01D', 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, 'O01D', 'BSAB', 32)
    call SaveInteger(udg_HeroDatabase, 'O01D', 'BSAU', 33)
    call SaveInteger(udg_HeroDatabase, 'O01D', 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Kagerou
    set i = i + 1
    set udg_HeroType[i] = 'O016'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Herange.blp"
    set udg_HeroButton[i] = 'B028'
    set udg_HeroBrief[i] = "|cffffcc00Reisen Herange|r\n|cffffffcc|r Mage, pusher, ranged (AGI)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 'A069', 'A0GT', 'A066', 'A06D', 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', -200)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 27)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 35)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_ReisenN
    set i = i + 1
    set udg_HeroType[i] = 'E03W'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_BlackChina.blp"
    set udg_HeroButton[i] = 'B02B'
    set udg_HeroBrief[i] = "|cffffcc00Hei Meiling|r\n|cffaaaa00|r Tank, mage, melee (STR)\n|cffccccccDifficulty for newbies: ●●●○○|r"
    call AI_HeroSkill(i, 0, 0, 0, 0, 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 20)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 40)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 1)
    set udg_HeroInit[i] = gg_trg_Initial_Black_Meiling
    set i = i + 1
    set udg_HeroType[i] = 'U00W'
    set udg_HeroIcon[i] = "ReplaceableTextures\\CommandButtons\\BTN_Flan2.blp"
    set udg_HeroButton[i] = 'B02C'
    set udg_HeroBrief[i] = "|cffffcc00Flandre (Komajou Densetsu Ver.)|r\n|cffaaaa00|r Fighter, carry, melee (AGI)\n|cffccccccDifficulty for newbies: ●○○○○|r"
    call AI_HeroSkill(i, 0, 0, 0, 0, 'A03Y')
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAR', 100)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAI', 0)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAB', 33)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'BSAU', 34)
    call SaveInteger(udg_HeroDatabase, udg_HeroType[i], 'PRIM', 2)
    set udg_HeroInit[i] = gg_trg_Initial_Flandre2
    set udg_HeroType[100] = i - 100
    set db = null
endfunction

function InitTrig_Setting_Character_B takes nothing returns nothing
    set gg_trg_Setting_Character_B = CreateTrigger()
    call TriggerAddAction(gg_trg_Setting_Character_B, function Trig_Setting_Character_B_Actions)
endfunction