function GetCharacterString takes integer u returns string
    if u == 'E00F' then
        return "Yukari"
    elseif u == 'E000' or u == 'E02D' then
        return "PAD"
    elseif u == 'U007' then
        return "Flandre"
    elseif u == 'H00L' then
        return "Suika"
    elseif u == 'E01A' then
        return "Keine"
    elseif u == 'E02J' then
        return "Miko"
    elseif u == 'E00G' then
        return "Ran"
    elseif u == 'E02Y' then
        return "Akyuu"
    elseif u == 'H001' or u == 'H02D' then
        return "Reimu"
    elseif u == 'H02E' then
        return "ReimuMother"
    elseif u == 'E010' then
        return "Koishi"
    elseif u == 'E015' then
        return "Satori"
    elseif u == 'H029' then
        return "Daiyousei"
    elseif u == 'U00K' then
        return "Nazrin"
    elseif u == 'U00J' then
        return "Komachi"
    elseif u == 'E02E' then
        return "Tokiko"
    elseif u == 'E00Q' then
        return "Captain"
    elseif u == 'E01D' then
        return "Sunny"
    elseif u == 'N00K' then
        return "Medicine"
    elseif u == 'E01W' then
        return "Merlin"
    elseif u == 'E037' then
        return "Mugetsu"
    elseif u == 'E01I' then
        return "Chen"
    elseif u == 'E01U' then
        return "Parsee"
    elseif u == 'E00W' then
        return "Rin"
    elseif u == 'O009' then
        return "Utsuho"
    elseif u == 'H01A' then
        return "Alice"
    elseif u == 'E01V' then
        return "Kisume"
    elseif u == 'H026' then
        return "Soga"
    elseif u == 'E020' then
        return "Lyrica"
    elseif u == 'E023' then
        return "Lily"
    elseif u == 'N00J' or u == 'N04L' then
        return "Mokou"
    elseif u == 'U006' then
        return "Yuyuko"
    elseif u == 'H000' then
        return "Marisa"
    elseif u == 'E00O' then
        return "Lunar"
    elseif u == 'E01N' then
        return "Lunasa"
    elseif u == 'E00I' then
        return "Rumia"
    elseif u == 'O00B' or u == 'O019' then
        return "Youmu"
    elseif u == 'O008' then
        return "Yamame"
    elseif u == 'E02S' then
        return "Reisen2"
    elseif u == 'U00L' then
        return "Kanako"
    elseif u == 'H009' or u == 'H01W' then
        return "Sanae"
    elseif u == 'O006' then
        return "Eirin"
    elseif u == 'E00V' then
        return "Shiki"
    elseif u == 'O00N' then
        return "Twei"
    elseif u == 'H01K' then
        return "Byakuren"
    elseif u == 'E00X' then
        return "Kogasa"
    elseif u == 'E03D' then
        return "Demacia"
    elseif u == 'O00V' then
        return "Hatate"
    elseif u == 'H01Z' then
        return "Renko"
    elseif u == 'H01N' then
        return "Syou"
    elseif u == 'H01J' then
        return "Houjuu"
    elseif u == 'E008' then
        return "Aya"
    elseif u == 'H00K' then
        return "Yuugi"
    elseif u == 'H012' or u == 'H02A' or u == 'H01X' then
        return "Suwako"
    elseif u == 'H002' then
        return "Tensi"
    elseif u == 'U003' then
        return "Iku"
    elseif u == 'H00M' then
        return "Nitori"
    elseif u == 'O00A' then
        return "Momizi"
    elseif u == 'E009' then
        return "Crino"
    elseif u == 'H01I' or u == 'H01Y' then
        return "Minoriko"
    elseif u == 'H01H' then
        return "Shizuha"
    elseif u == 'E00A' then
        return "Wriggle"
    elseif u == 'H00W' then
        return "Kaguya"
    elseif u == 'H00N' then
        return "Letty"
    elseif u == 'E00Z' or u == 'E02B' then
        return "Mystia"
    elseif u == 'O007' or u == 'O016' then
        return "Reisen"
    elseif u == 'H00X' then
        return "Hina"
    elseif u == 'N00L' then
        return "Yuuka"
    elseif u == 'E03K' then
        return "Kumoi"
    elseif u == 'E01E' then
        return "Koakuma"
    elseif u == 'U00N' then
        return "Patchouli"
    elseif u == 'E03L' then
        return "Star"
    elseif u == 'H02I' then
        return "Futo"
    elseif u == 'E013' or u == 'E03J' then
        return "Meirin"
    elseif u == 'O00J' then
        return "Remilia"
    elseif u == 'E03N' then
        return "Kulumi"
    elseif u == 'H02K' then
        return "Seiga"
    elseif u == 'O01C' or u == 'O01C' then
        return "Kagerou"
    endif
    return null
endfunction

function GetCharacterIndex takes unit u1 returns integer
    local integer u = GetUnitTypeId(u1)
    if u == 'E00F' then
        return 1
    elseif u == 'E000' or u == 'E02D' then
        return 2
    elseif u == 'U007' then
        return 3
    elseif u == 'H00L' then
        return 4
    elseif u == 'E01A' then
        return 5
    elseif u == 'E02J' then
        return 6
    elseif u == 'E00G' then
        return 7
    elseif u == 'E02Y' then
        return 8
    elseif u == 'H001' or u == 'H02D' then
        return 9
    elseif u == 'H02E' then
        return 10
    elseif u == 'E010' then
        return 11
    elseif u == 'E015' then
        return 12
    elseif u == 'H029' then
        return 13
    elseif u == 'U00K' then
        return 14
    elseif u == 'U00J' then
        return 16
    elseif u == 'E02E' then
        return 16
    elseif u == 'E00Q' then
        return 17
    elseif u == 'E01D' then
        return 18
    elseif u == 'N00K' then
        return 19
    elseif u == 'E01W' then
        return 20
    elseif u == 'E037' then
        return 21
    elseif u == 'E01I' then
        return 22
    elseif u == 'E01U' then
        return 23
    elseif u == 'E00W' then
        return 24
    elseif u == 'O009' then
        return 25
    elseif u == 'H01A' then
        return 26
    elseif u == 'E01V' then
        return 27
    elseif u == 'H026' then
        return 28
    elseif u == 'E020' then
        return 29
    elseif u == 'E023' then
        return 30
    elseif u == 'N00J' or u == 'N04L' then
        return 31
    elseif u == 'U006' then
        return 32
    elseif u == 'H000' then
        return 33
    elseif u == 'E00O' then
        return 34
    elseif u == 'E01N' then
        return 35
    elseif u == 'E00I' then
        return 36
    elseif u == 'O00B' or u == 'O019' then
        return 37
    elseif u == 'O008' then
        return 38
    elseif u == 'E02S' then
        return 39
    elseif u == 'U00L' then
        return 40
    elseif u == 'H009' or u == 'H01W' then
        return 41
    elseif u == 'O006' then
        return 42
    elseif u == 'E00V' then
        return 43
    elseif u == 'O00N' then
        return 44
    elseif u == 'H01K' then
        return 45
    elseif u == 'E00X' then
        return 46
    elseif u == 'E03D' then
        return 47
    elseif u == 'O00V' then
        return 48
    elseif u == 'H01Z' then
        return 49
    elseif u == 'H01N' then
        return 50
    elseif u == 'H01J' then
        return 51
    elseif u == 'E008' then
        return 52
    elseif u == 'H00K' then
        return 53
    elseif u == 'H012' or u == 'H02A' or u == 'H01X' then
        return 54
    elseif u == 'H002' then
        return 55
    elseif u == 'U003' then
        return 56
    elseif u == 'H00M' then
        return 57
    elseif u == 'O00A' then
        return 58
    elseif u == 'E009' then
        return 59
    elseif u == 'H01I' or u == 'H01Y' then
        return 60
    elseif u == 'H01H' then
        return 61
    elseif u == 'E00A' then
        return 62
    elseif u == 'H00W' then
        return 63
    elseif u == 'H00N' then
        return 64
    elseif u == 'E00Z' or u == 'E02B' then
        return 65
    elseif u == 'O007' or u == 'O016' then
        return 66
    elseif u == 'H00X' then
        return 67
    elseif u == 'N00L' then
        return 68
    elseif u == 'E03K' then
        return 69
    elseif u == 'E01E' then
        return 70
    elseif u == 'U00N' then
        return 71
    elseif u == 'E03L' then
        return 72
    elseif u == 'H02I' then
        return 73
    elseif u == 'E013' or u == 'E03J' then
        return 74
    elseif u == 'O00J' then
        return 75
    elseif u == 'E03N' then
        return 76
    elseif u == 'H02K' then
        return 77
    elseif u == 'O01C' or u == 'O01C' then
        return 78
    endif
    return 0
endfunction

function GetCharacterSkillString takes integer skill returns string
    if skill == 'A0QT' then
        return "PADEX"
    elseif skill == 'A04H' then
        return "PAD01"
    elseif skill == 'A099' then
        return "PAD02"
    elseif skill == 'A09A' then
        return "PAD03"
    elseif skill == 'A03P' then
        return "PAD04"
    elseif skill == 'A03F' then
        return "Yukari01"
    elseif skill == 'A07W' then
        return "Yukari01New"
    elseif skill == 'A04L' then
        return "Yukari02"
    elseif skill == 'A0IQ' then
        return "Yukari03"
    elseif skill == 'A0IY' then
        return "Yukari04"
    elseif skill == 'A0GL' then
        return "YukariEx"
    elseif skill == 'A05R' then
        return "Suika01"
    elseif skill == 'A02I' then
        return "Suika02"
    elseif skill == 'A05V' then
        return "Suika03"
    elseif skill == 'A05W' then
        return "Suika04"
    elseif skill == 'A06J' then
        return "Flandre01"
    elseif skill == 'A19I' then
        return "Flandre02"
    elseif skill == 'A0FV' then
        return "Flandre03"
    elseif skill == 'A06M' then
        return "Flandre04"
    elseif skill == 'A0P1' then
        return "Akyu01"
    elseif skill == 'A0P5' then
        return "Akyu02"
    elseif skill == 'A0P0' then
        return "Akyu03"
    elseif skill == 'A0P6' then
        return "Akyu04"
    elseif skill == 'A0GV' then
        return "Alice01"
    elseif skill == 'A0GW' then
        return "Alice02"
    elseif skill == 'A0GX' then
        return "Alice03"
    elseif skill == 'A0HU' then
        return "AliceEx"
    elseif skill == 'A0LP' then
        return "Chen01"
    elseif skill == 'A0TM' then
        return "Chen02"
    elseif skill == 'A0Z3' then
        return "Chen03"
    elseif skill == 'A0TO' then
        return "Chen04"
    elseif skill == 'A0R8' then
        return "Kusume01"
    endif
    if skill == 'A0R9' then
        return "Kusume02"
    elseif skill == 'A0RA' then
        return "Kusume03"
    elseif skill == 'A0RB' then
        return "Kusume04"
    elseif skill == 'A0GT' then
        return "Koishi01"
    elseif skill == 'A0DY' then
        return "Koishi04"
    elseif skill == 'A112' then
        return "Kulumi01"
    elseif skill == 'A11E' then
        return "Kulumi02"
    elseif skill == 'A08W' then
        return "Letty01"
    elseif skill == 'A0UL' then
        return "Letty02"
    elseif skill == 'A08P' then
        return "Letty04"
    elseif skill == 'A0WK' then
        return "Lily01"
    elseif skill == 'A0WL' then
        return "Lily02"
    elseif skill == 'A0X3' then
        return "Lily03"
    elseif skill == 'A0X6' then
        return "Lily04"
    elseif skill == 'A0WQ' then
        return "LilyEx"
    elseif skill == 'A0LM' then
        return "Lunasa01"
    elseif skill == 'A0V2' then
        return "Lunasa04"
    elseif skill == 'A0TR' then
        return "Lyrica01"
    elseif skill == 'A0TS' then
        return "Lyrica02"
    elseif skill == 'A0UK' then
        return "Lyrica04"
    elseif skill == 'A040' then
        return "Marisa01"
    elseif skill == 'A041' then
        return "Marisa02"
    elseif skill == 'A03Z' then
        return "Marisa03"
    elseif skill == 'A042' then
        return "Marisa04"
    elseif skill == 'A003' then
        return "Meilin01"
    elseif skill == 'A0RS' then
        return "Meilin02"
    elseif skill == 'A0RY' then
        return "Meilin04"
    elseif skill == 'A03Q' then
        return "Parsee01"
    elseif skill == 'A0PM' then
        return "Parsee02"
    elseif skill == 'A0R0' then
        return "Parsee03"
    elseif skill == 'A0P0' then
        return "Parsee04"
    endif
    if skill == 'A0TH' then
        return "Ran01"
    elseif skill == 'A08M' then
        return "Ran02"
    elseif skill == 'A0EG' then
        return "Ran03"
    elseif skill == 'A0EH' then
        return "Ran04"
    elseif skill == 'A0NW' then
        return "RanEx"
    elseif skill == 'A048' then
        return "Reimu01"
    elseif skill == 'A049' then
        return "Reimu02"
    elseif skill == 'A04A' then
        return "Reimu03"
    elseif skill == 'A04B' then
        return "Reimu04"
    elseif skill == 'A0BH' then
        return "Rin01"
    elseif skill == 'A0BM' then
        return "Rin02"
    elseif skill == 'A0B0' then
        return "Rin03"
    elseif skill == 'A0BP' then
        return "Rin04"
    elseif skill == 'A0IW' then
        return "Satori01"
    elseif skill == 'A0IX' then
        return "Satori02"
    elseif skill == 'A0VX' then
        return "Satori03"
    elseif skill == 'A0IZ' then
        return "Satori04"
    elseif skill == 'A0QN' then
        return "Utsuho01"
    elseif skill == 'A076' then
        return "Utsuho02"
    elseif skill == 'A079' then
        return "Utsuho03"
    elseif skill == 'A07B' then
        return "Utsuho04"
    elseif skill == 'A08F' then
        return "Yamame01"
    elseif skill == 'A0JW' then
        return "Yamame02"
    elseif skill == 'A0FF' then
        return "Yamame03"
    elseif skill == 'A0RJ' then
        return "Yamame04"
    elseif skill == 'A05X' then
        return "Youmu01"
    elseif skill == 'A064' then
        return "Youmu03"
    elseif skill == 'A065' then
        return "Youmu04"
    elseif skill == 'A11C' then
        return "Yuugi01"
    elseif skill == 'A08B' then
        return "Yuugi02"
    elseif skill == 'A08D' then
        return "Yuugi04"
    elseif skill == 'A05D' then
        return "Yuyuko01"
    elseif skill == 'A0QM' then
        return "Yuyuko02"
    elseif skill == 'A05C' then
        return "Yuyuko04"
    endif
    if skill == 'A0B7' then
        return "Shiki01"
    elseif skill == 'A0I4' then
        return "Shiki02"
    elseif skill == 'A00K' then
        return "Shiki04"
    elseif skill == 'A083' then
        return "Eirin02"
    elseif skill == 'A00T' then
        return "Eirin01"
    elseif skill == 'A086' then
        return "Eirin03"
    elseif skill == 'A088' then
        return "Eirin04"
    elseif skill == 'A040' then
        return "Iku01"
    elseif skill == 'A04S' then
        return "Iku02"
    elseif skill == 'A0A4' then
        return "Iku04"
    elseif skill == 'A0M5' then
        return "Keine01"
    elseif skill == 'A0M6' then
        return "Keine02"
    elseif skill == 'A0M7' then
        return "Keine03"
    elseif skill == 'A0MB' then
        return "Keine04"
    elseif skill == 'A0CK' then
        return "Komachi01"
    elseif skill == 'A0JK' then
        return "Komachi02"
    elseif skill == 'A0CN' then
        return "Komachi03"
    elseif skill == 'A0CM' then
        return "Komachi04"
    elseif skill == 'A0EF' then
        return "Medicine02"
    elseif skill == 'A0F0' then
        return "Medicine03"
    elseif skill == 'A04C' then
        return "Medicine04"
    elseif skill == 'A04U' then
        return "Mokou01"
    elseif skill == 'A00G' then
        return "Mokou02"
    elseif skill == 'A00B' then
        return "Mokou03"
    elseif skill == 'A059' then
        return "Mokou04"
    elseif skill == 'A052' then
        return "MokouEx"
    elseif skill == 'A0DE' then
        return "Mystia01"
    elseif skill == 'A0DI' then
        return "Mystia02"
    elseif skill == 'A0DN' then
        return "Mystia04"
    elseif skill == 'A0D0' then
        return "Kaguya01"
    elseif skill == 'A0D2' then
        return "Kaguya02"
    elseif skill == 'A0SQ' then
        return "Kaguya04"
    endif
    if skill == 'A1B2' then
        return "Reisen01"
    elseif skill == 'A0PJ' then
        return "Reisen02"
    elseif skill == 'A18G' then
        return "Reisen03"
    elseif skill == 'A16Z' then
        return "Reisen04"
    elseif skill == 'A0P8' then
        return "TensiEx"
    elseif skill == 'A0T6' then
        return "Tensi01"
    elseif skill == 'A0AJ' then
        return "Tensi04"
    elseif skill == 'A0N2' then
        return "Twei01"
    elseif skill == 'A03T' then
        return "Twei02"
    elseif skill == 'A0N4' then
        return "Twei03"
    elseif skill == 'A0FW' then
        return "Wriggle01"
    elseif skill == 'A09R' then
        return "Wriggle02"
    elseif skill == 'A09M' then
        return "Wriggle03"
    elseif skill == 'A0FZ' then
        return "Wriggle04"
    elseif skill == 'A09N' then
        return "WriggleEx"
    elseif skill == 'A086' then
        return "Yuuka01"
    elseif skill == 'A06I' then
        return "Yuuka02"
    elseif skill == 'A0DA' then
        return "Yuuka04"
    elseif skill == 'A07P' then
        return "YuukaEx"
    elseif skill == 'A03W' then
        return "Crino01"
    elseif skill == 'A03X' then
        return "Crino02"
    elseif skill == 'A056' then
        return "Crino03"
    elseif skill == 'A0MW' then
        return "Crino04"
    elseif skill == 'A0MT' then
        return "Koakuma01"
    elseif skill == 'A0NH' then
        return "Koakuma02"
    elseif skill == 'A05A' then
        return "Koakuma03"
    elseif skill == 'A0NI' then
        return "Koakuma04"
    elseif skill == 'A10C' then
        return "Kumoi01"
    elseif skill == 'A10D' then
        return "Kumoi02"
    elseif skill == 'A111' then
        return "Kumoi04"
    elseif skill == 'A19S' then
        return "Lunar01"
    elseif skill == 'A0FX' then
        return "Lunar02"
    elseif skill == 'A0TF' then
        return "Lunar04"
    elseif skill == 'A0GB' then
        return "Meirin01"
    elseif skill == 'A0GC' then
        return "Meirin02~1"
    endif
    if skill == 'A0GD' then
        return "Meirin04"
    elseif skill == 'A0GD' then
        return "Meirin04"
    elseif skill == 'A0W9' then
        return "PatchouliAB"
    elseif skill == 'A0WC' then
        return "PatchouliAC"
    elseif skill == 'A0WE' then
        return "PatchouliAD"
    elseif skill == 'A0WF' then
        return "PatchouliAE"
    elseif skill == 'A0WH' then
        return "PatchouliBC"
    elseif skill == 'A0WG' then
        return "PatchouliBD"
    elseif skill == 'A0XG' then
        return "PatchouliBE"
    elseif skill == 'A0XH' then
        return "PatchouliCD"
    elseif skill == 'A0XI' then
        return "PatchouliCE"
    elseif skill == 'A0XJ' then
        return "PatchouliDE"
    elseif skill == 'A0XL' then
        return "PatchouliUltF"
    elseif skill == 'A0XK' then
        return "PatchouliUltG"
    elseif skill == 'A0CD' then
        return "Remilia01"
    elseif skill == 'A0CG' then
        return "Remilia02"
    elseif skill == 'A0RK' then
        return "Remilia03"
    elseif skill == 'A0CI' then
        return "Remilia04"
    elseif skill == 'A07C' then
        return "Rumia01"
    elseif skill == 'A11N' then
        return "Rumia02"
    elseif skill == 'A07J' then
        return "Rumia04"
    elseif skill == 'A10M' then
        return "Star01"
    elseif skill == 'A10N' then
        return "Star02"
    elseif skill == 'A10S' then
        return "Star03"
    elseif skill == 'A0NB' then
        return "Sunny01"
    elseif skill == 'A0VA' then
        return "Sunny02"
    elseif skill == 'A0VY' then
        return "Sunny03"
    elseif skill == 'A1IH' then
        return "Sunny04"
    elseif skill == 'A05K' then
        return "Aya01"
    elseif skill == 'A05L' then
        return "Aya02"
    elseif skill == 'A05O' then
        return "Aya04"
    elseif skill == 'A0FJ' then
        return "Daiyousei01"
    elseif skill == 'A0FN' then
        return "Daiyousei02"
    endif
    if skill == 'A0FP' then
        return "Daiyousei03"
    elseif skill == 'A0FS' then
        return "Daiyousei04"
    elseif skill == 'A08N' then
        return "Hatate01"
    elseif skill == 'A09B' then
        return "Hatate02"
    elseif skill == 'A0D9' then
        return "Hatate03"
    elseif skill == 'A0E6' then
        return "Hatate04"
    elseif skill == 'A0I2' then
        return "HatateEx"
    elseif skill == 'A0E4' then
        return "Hina01"
    elseif skill == 'A0DZ' then
        return "Hina02"
    elseif skill == 'A0E8' then
        return "Hina03"
    elseif skill == 'A0E9' then
        return "Hina04"
    elseif skill == 'A0F1' then
        return "Kanako01"
    elseif skill == 'A0F4' then
        return "Kanako02"
    elseif skill == 'A0F6' then
        return "Kanako03"
    elseif skill == 'A0F7' then
        return "Kanako04"
    elseif skill == 'A0FE' then
        return "Kanako04-01"
    elseif skill == 'A0F8' then
        return "Kanako04-02"
    elseif skill == 'A0FC' then
        return "Kanako04-03"
    elseif skill == 'A0JF' then
        return "Mino01"
    elseif skill == 'A0JI' then
        return "Mino02"
    elseif skill == 'A06A' then
        return "Mino04"
    elseif skill == 'A09U' then
        return "Momizi01"
    elseif skill == 'A09V' then
        return "Momizi02"
    elseif skill == 'A0Q0' then
        return "Momizi03"
    elseif skill == 'A0G1' then
        return "Mugetsu01"
    elseif skill == 'A0G2' then
        return "Mugetsu02"
    elseif skill == 'A0G3' then
        return "Mugetsu03"
    elseif skill == 'A0GK' then
        return "Mugetsu04"
    elseif skill == 'A094' then
        return "Nitori01"
    elseif skill == 'A0GF' then
        return "Nitori02"
    elseif skill == 'A17F' then
        return "Nitori03"
    elseif skill == 'A0LK' then
        return "Nitori04"
    elseif skill == 'A0RC' then
        return "Sanae01"
    endif
    if skill == 'A06V' then
        return "Sanae02"
    elseif skill == 'A06Y' then
        return "Sanae04"
    elseif skill == 'A0J8' then
        return "Shizuha01"
    elseif skill == 'A0JC' then
        return "Shizuha02"
    elseif skill == 'A0G8' then
        return "Shizuha03"
    elseif skill == 'A0J6' then
        return "Shizuha04"
    elseif skill == 'A0FI' then
        return "Suwako01"
    elseif skill == 'A17Q' or skill == 'A0X7' or skill == 'A17R' then
        return "Suwako02"
    elseif skill == 'A0FK' then
        return "Suwako03"
    elseif skill == 'A0FL' then
        return "Suwako04"
    elseif skill == 'A0NZ' then
        return "Byakuren01"
    elseif skill == 'A11W' then
        return "Byakuren02"
    elseif skill == 'A000' then
        return "Byakuren03"
    elseif skill == 'A002' then
        return "Byakuren04"
    elseif skill == 'A0AB' then
        return "Captain01"
    elseif skill == 'A0AA' then
        return "Captain02"
    elseif skill == 'A0A6' then
        return "Captain03"
    elseif skill == 'A0C3' then
        return "Kogasa01"
    elseif skill == 'A0LS' then
        return "Kogasa02"
    elseif skill == 'A0C8' then
        return "Kogasa03"
    elseif skill == 'A0C7' then
        return "Kogasa04"
    elseif skill == 'A0W7' then
        return "Kumoi01"
    elseif skill == 'A000' then
        return "Nazrin01"
    elseif skill == 'A0D8' then
        return "Nazrin02"
    elseif skill == 'A17T' then
        return "Nazrin04"
    elseif skill == 'A0M1' then
        return "Houjuu01"
    elseif skill == 'A0M2' then
        return "Houjuu02"
    elseif skill == 'A0M4' then
        return "Houjuu04"
    elseif skill == 'A0LZ' then
        return "HoujuuEx"
    elseif skill == 'A0P2' then
        return "Syou01"
    elseif skill == 'A0R3' or skill == 'A0SU' then
        return "Syou02"
    endif
    if skill == 'A0SR' then
        return "Syou04"
    elseif skill == 'A0UB' then
        return "Futo01"
    elseif skill == 'A0UC' then
        return "Futo02"
    elseif skill == 'A0UG' then
        return "Futo03"
    elseif skill == 'A0ND' then
        return "Futo04"
    elseif skill == 'A183' then
        return "Miko01"
    elseif skill == 'A185' then
        return "Miko02"
    elseif skill == 'A186' then
        return "Miko03"
    elseif skill == 'A187' then
        return "Miko04"
    elseif skill == 'A08Z' then
        return "Reisen201"
    elseif skill == 'A091' then
        return "Reisen202"
    elseif skill == 'A095' then
        return "Reisen204"
    elseif skill == 'A12Q' then
        return "Renko01"
    elseif skill == 'A12R' then
        return "Renko02"
    elseif skill == 'A12S' then
        return "Renko03"
    elseif skill == 'A12D' then
        return "Renko04"
    elseif skill == 'A19X' then
        return "Soga01"
    elseif skill == 'A19Y' then
        return "Soga02"
    elseif skill == 'A00M' then
        return "Soga03"
    elseif skill == 'A1A0' then
        return "Soga01"
    elseif skill == 'A0ZK' then
        return "Tokiko01"
    elseif skill == 'A0ZL' then
        return "Tokiko02"
    elseif skill == 'A0ZN' then
        return "Tokiko04"
    endif
    return null
endfunction

function IsPointInAllyHome takes real x, real y, unit u returns boolean
    local location loc = Location(x, y)
    local boolean ret
    if IsUnitAlly(u, udg_PlayerA[0]) then
        set ret = RectContainsLoc(gg_rct_BArea1, loc) or RectContainsLoc(gg_rct_BaseAC, loc)
    else
        set ret = RectContainsLoc(gg_rct_BArea2, loc) or RectContainsLoc(gg_rct_BaseBC, loc)
    endif
    call RemoveLocation(loc)
    return ret
endfunction

function IsPointInEnemyHome takes real x, real y, unit u returns boolean
    local location loc = Location(x, y)
    local boolean ret
    if not IsUnitAlly(u, udg_PlayerA[0]) then
        set ret = RectContainsLoc(gg_rct_BArea1, loc) or RectContainsLoc(gg_rct_BaseAC, loc)
    else
        set ret = RectContainsLoc(gg_rct_BArea2, loc) or RectContainsLoc(gg_rct_BaseBC, loc)
    endif
    call RemoveLocation(loc)
    return ret
endfunction

function DB_SetHeroTypeData takes integer ID, integer field, integer value returns nothing
    call SaveInteger(udg_HeroDatabase, ID, field, value)
endfunction

function DB_GetHeroTypeData takes integer ID, integer field returns integer
    return LoadInteger(udg_HeroDatabase, ID, field)
endfunction

function DB_HERO_BASIC_ARMOR_BASE takes nothing returns integer
    return 'BSAR'
endfunction

function DB_HERO_BASIC_ARMOR_INC takes nothing returns integer
    return 'BSAI'
endfunction

function DB_HERO_BASIC_ATTACK_B takes nothing returns integer
    return 'BSAB'
endfunction

function DB_HERO_BASIC_ATTACK_U takes nothing returns integer
    return 'BSAU'
endfunction

function DB_HERO_PRIMARY_TYPE takes nothing returns integer
    return 'PRIM'
endfunction

function DB_ENUM_STR takes nothing returns integer
    return 1
endfunction

function DB_ENUM_AGI takes nothing returns integer
    return 2
endfunction

function DB_ENUM_INT takes nothing returns integer
    return 3
endfunction

function HERO_TYPE_STR takes nothing returns integer
    return 1
endfunction

function HERO_TYPE_AGI takes nothing returns integer
    return 2
endfunction

function HERO_TYPE_INT takes nothing returns integer
    return 3
endfunction

function GetHeroMainProperty takes unit h returns integer
    return LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'PRIM')
endfunction

function GetHeroBasicArmor takes unit h returns integer
    return LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAR')
endfunction

function GetHeroIncArmor takes unit h returns integer
    return LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAI')
endfunction

function GetHeroBasicAttackB takes unit h returns integer
    return LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAB')
endfunction

function GetHeroBasicAttackU takes unit h returns integer
    return LoadInteger(udg_HeroDatabase, GetUnitTypeId(h), 'BSAU')
endfunction

function DB_HERO_ATTACK_RANGE takes nothing returns integer
    return 'ARNG'
endfunction

function DB_ENUM_MELEE takes nothing returns integer
    return 100
endfunction

function DB_ENUM_MID takes nothing returns integer
    return 450
endfunction

function DB_ENUM_LONG takes nothing returns integer
    return 600
endfunction

function DB_ENUM_SUPER takes nothing returns integer
    return 700
endfunction

function DB_HERO_ITEMS_TYPE_ID takes nothing returns integer
    return 'ITI0'
endfunction

function DB_HERO_ITEMS_TRIGGER_VALUE takes nothing returns integer
    return 'ITV0'
endfunction

function DB_GetHeroSystemItemType takes integer ID, integer which returns integer
    return LoadInteger(udg_HeroDatabase, ID, 'ITI0' + which)
endfunction

function DB_GetHeroSystemItemTime takes integer ID, integer which returns integer
    return LoadInteger(udg_HeroDatabase, ID, 'ITV0' + which)
endfunction

function DBxSetHeroItemsA takes integer ID, integer i1, integer v1, integer i2, integer v2, integer i3, integer v3 returns nothing
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 0, i1)
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 1, i2)
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 2, i3)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 0, v1)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 1, v2)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 2, v3)
endfunction

function DBxSetHeroItemsB takes integer ID, integer i4, integer v4, integer i5, integer v5, integer i6, integer v6 returns nothing
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 3, i4)
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 4, i5)
    call SaveInteger(udg_HeroDatabase, ID, 'ITI0' + 5, i6)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 3, v4)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 4, v5)
    call SaveInteger(udg_HeroDatabase, ID, 'ITV0' + 5, v6)
endfunction

function IsBanModeAvailable takes nothing returns boolean
    if GetPlayerSlotState(udg_PlayerA[1]) != PLAYER_SLOT_STATE_PLAYING then
        return false
    endif
    if GetPlayerSlotState(udg_PlayerB[1]) != PLAYER_SLOT_STATE_PLAYING then
        return false
    endif
    if GetPlayerController(udg_PlayerA[1]) != MAP_CONTROL_USER then
        return false
    endif
    if GetPlayerController(udg_PlayerB[1]) != MAP_CONTROL_USER then
        return false
    endif
    return true
endfunction

function IsSoloModeAvailable takes nothing returns boolean
    if GetPlayerSlotState(udg_PlayerA[1]) != PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerB[1]) != PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerController(udg_PlayerA[1]) != MAP_CONTROL_USER then
        return false
    elseif GetPlayerController(udg_PlayerB[1]) != MAP_CONTROL_USER then
        return false
    elseif GetPlayerSlotState(udg_PlayerA[2]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerA[3]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerA[4]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerA[5]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerB[2]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerB[3]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerB[4]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    elseif GetPlayerSlotState(udg_PlayerB[5]) == PLAYER_SLOT_STATE_PLAYING then
        return false
    endif
    return true
endfunction

function IsDraftModeAvailable takes nothing returns boolean
    local integer i = 0
    local boolean b = true
    loop
    exitwhen i > 4
        if GetPlayerSlotState(Player(i)) != PLAYER_SLOT_STATE_PLAYING or GetPlayerSlotState(Player(i + 6)) != PLAYER_SLOT_STATE_PLAYING then
            set b = false
        endif
        set i = i + 1
    endloop
    return b
endfunction

function BroadcastMessage takes string message returns nothing
    local integer i = 0
    loop
        call DisplayTimedTextToPlayer(Player(i), 0, 0, 6.0, message)
        set i = i + 1
    exitwhen i >= 12
    endloop
endfunction

function BroadcastMessageFriend takes string message, player p returns nothing
    local integer i = 0
    loop
        if IsPlayerAlly(Player(i), p) then
            call DisplayTimedTextToPlayer(Player(i), 0, 0, 6.0, message)
        endif
        set i = i + 1
    exitwhen i >= 12
    endloop
endfunction

function PlayerName takes player who returns string
    return udg_PN[GetPlayerId(who)]
endfunction

function GetHeroIndex takes integer ID returns integer
    local integer i = 0
    loop
    exitwhen udg_HeroType[i] == ID or udg_HeroCloth01[i] == ID or udg_HeroCloth02[i] == ID or udg_HeroCloth03[i] == ID
        set i = i + 1
    exitwhen i >= 300
    endloop
    return i
endfunction

function ShareGold takes player p, integer amount returns nothing
    local player who
    local integer sum = 0
    local integer i = 0
    loop
        set who = Player(i)
        if GetPlayerSlotState(who) == PLAYER_SLOT_STATE_PLAYING and IsPlayerAlly(who, p) then
            set sum = sum + 1
        endif
        set i = i + 1
    exitwhen i > 15
    endloop
    set amount = amount / sum
    set i = 0
    loop
        set who = Player(i)
        if GetPlayerSlotState(who) == PLAYER_SLOT_STATE_PLAYING and IsPlayerAlly(who, p) then
            call AdjustPlayerStateBJ(amount, who, PLAYER_STATE_RESOURCE_GOLD)
        endif
        set i = i + 1
    exitwhen i > 15
    endloop
endfunction

function GetSortedPlayerId takes player who returns integer
    local integer n = 0
    loop
    exitwhen n > 4
        if udg_PlayerA[n + 1] == who then
            return n
        endif
        set n = n + 1
    endloop
    set n = 0
    loop
    exitwhen n > 4
        if udg_PlayerB[n + 1] == who then
            return n + 5
        endif
        set n = n + 1
    endloop
    if who == udg_PlayerA[0] then
        return 10
    elseif who == udg_PlayerB[0] then
        return 11
    endif
    return 15
endfunction

function GetSortedPlayer takes integer id returns player
    if 0 <= id and id <= 4 then
        return udg_PlayerA[id + 1]
    elseif 5 <= id and id <= 9 then
        return udg_PlayerB[id - 4]
    elseif id == 10 then
        return udg_PlayerA[0]
    elseif id == 11 then
        return udg_PlayerB[0]
    endif
    return Player(15)
endfunction

function GetPlayerCharacter takes player who returns unit
    local integer i = GetPlayerId(who)
    if who == null then
        return null
    endif
    return udg_PlayerHeroes[i]
endfunction

function IsPlayerUser takes player who returns boolean
    if GetPlayerController(who) == MAP_CONTROL_COMPUTER then
        return false
    endif
    return GetPlayerSlotState(who) == PLAYER_SLOT_STATE_PLAYING
endfunction

function HostPlayerTest takes nothing returns nothing
    local gamecache gc = InitGameCache("test.w3v")
    local integer c = GetPlayerId(GetLocalPlayer())
    call StoreInteger(gc, "test", "host", c + 1)
    call TriggerSyncStart()
    call SyncStoredInteger(gc, "test", "host")
    call TriggerSyncReady()
    set c = GetStoredInteger(gc, "test", "host")
    set udg_HostPlayerId = c
    call FlushGameCache(gc)
    set gc = null
endfunction

function DecideHostPlayer takes nothing returns player
    local integer i = 0
    loop
    exitwhen i > 11
        if IsPlayerUser(Player(i)) then
        exitwhen IsPlayerInForce(Player(i), udg_TeamA)
        exitwhen IsPlayerInForce(Player(i), udg_TeamB)
        endif
        set i = i + 1
    endloop
    if i > 11 then
        set udg_HostPlayer = null
    else
        set udg_HostPlayer = Player(i)
    endif
    return udg_HostPlayer
endfunction

function IsPlayerOpponent takes player A, player B returns boolean
    if IsPlayerObserver(A) or IsPlayerObserver(B) then
        return false
    endif
    if A == udg_PlayerA[0] and IsPlayerInForce(B, udg_TeamB) then
        return true
    elseif B == udg_PlayerA[0] and IsPlayerInForce(A, udg_TeamB) then
        return true
    elseif A == udg_PlayerB[0] and IsPlayerInForce(B, udg_TeamA) then
        return true
    elseif B == udg_PlayerB[0] and IsPlayerInForce(A, udg_TeamA) then
        return true
    endif
    return IsPlayerEnemy(A, B)
endfunction

function GetPlayerBase takes player who returns rect
    if IsPlayerInForce(who, udg_TeamA) then
        return gg_rct_BaseA
    elseif IsPlayerInForce(who, udg_TeamB) then
        return gg_rct_BaseB
    endif
    return gg_rct_CommonArea
endfunction

function GetPlayerShelter takes player who returns location
    if IsPlayerInForce(who, udg_TeamA) then
        return udg_RecoverPoint[0]
    elseif IsPlayerInForce(who, udg_TeamB) then
        return udg_RecoverPoint[1]
    endif
    return udg_CommonPoint
endfunction

function GetPlayerRevivePoint takes player who returns location
    if IsPlayerInForce(who, udg_TeamA) then
        return udg_RevivePoint[0]
    elseif IsPlayerInForce(who, udg_TeamB) then
        return udg_RevivePoint[1]
    endif
    return udg_CommonPoint
endfunction

function GetPlayerForceId takes player w returns integer
    if IsPlayerInForce(w, udg_TeamA) then
        return 0
    endif
    if IsPlayerInForce(w, udg_TeamB) then
        return 1
    endif
    if w == udg_PlayerA[0] or w == udg_PlayerA[6] then
        return 0
    endif
    if w == udg_PlayerB[0] or w == udg_PlayerB[6] then
        return 1
    endif
    return 0
endfunction

function CreateGroupOfAllHeroes takes nothing returns group
    local group g = CreateGroup()
    local unit h
    local integer i = 0
    loop
    exitwhen i >= 12
        set h = udg_PlayerHeroes[i]
        if h != null then
            call GroupAddUnit(g, h)
        endif
        set i = i + 1
    endloop
    set bj_lastCreatedGroup = g
    set g = null
    set h = null
    return bj_lastCreatedGroup
endfunction

function InitTrig_Systems takes nothing returns nothing
endfunction