concrete CustomLexEng of CustomLex = CatEng ** open ParadigmsEng, NounEng in {
  lin
    Tiananmen_PN = mkPN "Tiananmen" ;
    China_PN = mkPN "China" ;
    Communist_A = mkA "Communist" ;
    relaunch_V = mkV "relaunch" ;
    '79_Card' = NumPl ** {s,sp = \\_,_ => "79"} ;
    '1989_Card' = NumPl ** {s,sp = \\_,_ => "1989"} ;
    
}