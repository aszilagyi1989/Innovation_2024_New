source("Functions_Standard.R")
source("Profile_ENT.R")
library("rlang")
library("tidytable")

T35_SDMX_FINAL_RESULT <- "T35_SDMX_ALL_FINAL_RESULT.txt"

TABLENAME <- "T35"
REF_AREA <- "HU"
TYPE_ENT <- "INN"
INN_PF <- "_T"
INDICATOR <- "ENT"

UNIT_MEASURE <- "PN"
UNIT_MULT <- "0"
DECIMALS <- "0"

expression <- c("is.na(INN$RISKS_IT_MAJ) == FALSE & INN$RISKS_IT_MAJ == 1", 
                "is.na(INN$RISKS_IT_MIN) == FALSE & INN$RISKS_IT_MIN == 1", 
                "is.na(INN$RISKS_IT_NR) == FALSE & INN$RISKS_IT_NR == 1", 
                "is.na(INN$RISKS_IT_MITI) == FALSE & INN$RISKS_IT_MITI == 1", 
                "is.na(INN$RISKS_ENG_MAJ) == FALSE & INN$RISKS_ENG_MAJ == 1", 
                "is.na(INN$RISKS_ENG_MIN) == FALSE & INN$RISKS_ENG_MIN == 1", 
                "is.na(INN$RISKS_ENG_NR) == FALSE & INN$RISKS_ENG_NR == 1", 
                "is.na(INN$RISKS_ENG_MITI) == FALSE & INN$RISKS_ENG_MITI == 1", 
                "is.na(INN$RISKS_SUPCH_MAJ) == FALSE & INN$RISKS_SUPCH_MAJ == 1", 
                "is.na(INN$RISKS_SUPCH_MIN) == FALSE & INN$RISKS_SUPCH_MIN == 1", 
                "is.na(INN$RISKS_SUPCH_NR) == FALSE & INN$RISKS_SUPCH_NR == 1", 
                "is.na(INN$RISKS_SUPCH_MITI) == FALSE & INN$RISKS_SUPCH_MITI == 1", 
                "is.na(INN$RISKS_DEPE_MAJ) == FALSE & INN$RISKS_DEPE_MAJ == 1", 
                "is.na(INN$RISKS_DEPE_MIN) == FALSE & INN$RISKS_DEPE_MIN == 1", 
                "is.na(INN$RISKS_DEPE_NR) == FALSE & INN$RISKS_DEPE_NR == 1", 
                "is.na(INN$RISKS_DEPE_MITI) == FALSE & INN$RISKS_DEPE_MITI == 1", 
                "is.na(INN$RISKS_ACC_MAJ) == FALSE & INN$RISKS_ACC_MAJ == 1", 
                "is.na(INN$RISKS_ACC_MIN) == FALSE & INN$RISKS_ACC_MIN == 1", 
                "is.na(INN$RISKS_ACC_NR) == FALSE & INN$RISKS_ACC_NR == 1", 
                "is.na(INN$RISKS_ACC_MITI) == FALSE & INN$RISKS_ACC_MITI == 1", 
                "is.na(INN$RISKS_NATU_MAJ) == FALSE & INN$RISKS_NATU_MAJ == 1", 
                "is.na(INN$RISKS_NATU_MIN) == FALSE & INN$RISKS_NATU_MIN == 1", 
                "is.na(INN$RISKS_NATU_NR) == FALSE & INN$RISKS_NATU_NR == 1", 
                "is.na(INN$RISKS_NATU_MITI) == FALSE & INN$RISKS_NATU_MITI == 1", 
                "is.na(INN$RISKS_OTH_MAJ) == FALSE & INN$RISKS_OTH_MAJ == 1", 
                "is.na(INN$RISKS_OTH_MIN) == FALSE & INN$RISKS_OTH_MIN == 1", 
                "is.na(INN$RISKS_OTH_NR) == FALSE & INN$RISKS_OTH_NR == 1", 
                "is.na(INN$RISKS_OTH_MITI) == FALSE & INN$RISKS_OTH_MITI == 1", 
                "is.na(INN$RISKS_DEPNEU) == FALSE & INN$RISKS_DEPNEU == 1", 
                "is.na(INN$RISKS_DEPNEU_MITI) == FALSE & INN$RISKS_DEPNEU_MITI == 1")

expression2 <- c("RISKS_IT_MAJ", 
                 "RISKS_IT_MIN", 
                 "RISKS_IT_NR", 
                 "RISKS_IT_MITI", 
                 "RISKS_ENG_MAJ", 
                 "RISKS_ENG_MIN", 
                 "RISKS_ENG_NR", 
                 "RISKS_ENG_MITI", 
                 "RISKS_SUPCH_MAJ", 
                 "RISKS_SUPCH_MIN", 
                 "RISKS_SUPCH_NR", 
                 "RISKS_SUPCH_MITI", 
                 "RISKS_DEPE_MAJ", 
                 "RISKS_DEPE_MIN", 
                 "RISKS_DEPE_NR", 
                 "RISKS_DEPE_MITI", 
                 "RISKS_ACC_MAJ", 
                 "RISKS_ACC_MIN", 
                 "RISKS_ACC_NR", 
                 "RISKS_ACC_MITI", 
                 "RISKS_NATU_MAJ", 
                 "RISKS_NATU_MIN", 
                 "RISKS_NATU_NR", 
                 "RISKS_NATU_MITI", 
                 "RISKS_OTH_MAJ", 
                 "RISKS_OTH_MIN", 
                 "RISKS_OTH_NR", 
                 "RISKS_OTH_MITI", 
                 "RISKS_DEPNEU",
                 "RISKS_DEPNEU_MITI")

Aggregate <- data.table(matrix(ncol = 19, nrow = 0))
names(Aggregate) <- c("DATAFLOW", "FREQ", "TIME_PERIOD", "REF_AREA", "TABLENAME", "ACTIVITY", "NUMBER_EMPL", "TYPE_ENT", "INN_PF", "INDICATOR", "CIS_INDICATOR",	"OBS_VALUE", "UNIT_MEASURE", "UNIT_MULT", "DECIMALS",	"OBS_STATUS",	"OBS_STATUS_1",	"CONF_STATUS", "COMMENT_OBS")
for(num in 1:length(expression)){
  
  INN_DT <- data.table(INN[eval_tidy(parse_expr(expression[num])), ])
  
  if(nrow(INN_DT) != 0){
    
    INN_DT %>% group_by(M065_RETEG1, M0581_2J) %>% summarise(ENT22_SULYOZOTT = sum(VGMA001_SULY)) %>% arrange(M065_RETEG1, M0581_2J) -> INN_Ordered
    CIS_INDICATOR <- expression2[num]
    
    for(i in 1:nrow(INN_Ordered)){
      
      if(INN_Ordered[i, 1] == "KI"){
        
        NUMBER_EMPL <- "E10T49"
        
      } else if(INN_Ordered[i, 1] == "KO"){
        
        NUMBER_EMPL <- "E50T249"
        
      } else{
        
        NUMBER_EMPL <- "E_GE250"   
        
      }
      
      ACTIVITY <- get_NACE(INN_Ordered[i, 2])
      OBS_VALUE <- INN_Ordered[i, 3]
      Aggregate <- rbind(Aggregate, list(DATAFLOW, FREQ, TIME_PERIOD, REF_AREA, TABLENAME, ACTIVITY, NUMBER_EMPL, TYPE_ENT, INN_PF, INDICATOR, CIS_INDICATOR,	OBS_VALUE, UNIT_MEASURE, UNIT_MULT, DECIMALS,	OBS_STATUS,	OBS_STATUS_1,	CONF_STATUS, COMMENT_OBS), ignore.attr = TRUE)
      
    }
  }
}

NUMBER_EMPL <- "_T"
for(num in 1:length(expression)){
  
  CIS_INDICATOR <- expression2[num]
  
  for(j in 1:length(ACTIVITY_LIST)){
    
    ACTIVITY <- ACTIVITY_LIST[j]
    insert_Total(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  #Összetett értékek számítása több ACTIVITY kód alapján az összes vállalatcsoportra
  ACTIVITY <- "A"
  NUMBER_EMPL <- "_T"
  insert_A(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "B"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_B(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "C"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_C(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "C10T12"
  insert_C10T12(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C13T15"
  insert_C13T15(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C16T18"
  insert_C16T18(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C19_20"
  #insert_C19T20(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C19T21"
  insert_C19T21(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C19T22"
  #insert_C19T22(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C22_23"
  insert_C22T23(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C24_25"
  insert_C24T25(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C26T28"
  insert_C26T28(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C29_30"
  insert_C29T30(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C25T30"
  #insert_C25T30(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C31T33"
  insert_C31T33(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "D"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_D(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "E"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_E(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "E36_37"
  insert_E36T37(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "E38_39"
  insert_E38T39(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "E37T39"
  #insert_E37T39(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "G"
  insert_G(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "G46"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    if (nrow(Aggregate %>% filter(ACTIVITY == "G46" & NUMBER_EMPL == NUMBER_EMPL_LIST[j] & CIS_INDICATOR == expression2[num])) != 0)
      next
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_G46(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "H"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_H(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "F"
  insert_F(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "H49T51"
  insert_H49T51(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "H52_53"
  insert_H52T53(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "I"
  insert_I(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "J"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_J(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "J58T60"
  insert_J58T60(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "J61T63"
  insert_J61T63(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "J62_63"
  #insert_J62T63(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "K"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_K(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "M"
  insert_M(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "M71T73"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_M71T73(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "N"
  insert_N(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "BTE"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_BTE(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "GTN"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_GTN(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "G46TM73_INN"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_G46TM73_INN(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "_T"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert__T(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
}

Aggregate$OBS_VALUE <- as.numeric(Aggregate$OBS_VALUE)
Aggregate_INN <- Aggregate

expression <- c("is.na(NINN$RISKS_IT_MAJ) == FALSE & NINN$RISKS_IT_MAJ == 1", 
                "is.na(NINN$RISKS_IT_MIN) == FALSE & NINN$RISKS_IT_MIN == 1", 
                "is.na(NINN$RISKS_IT_NR) == FALSE & NINN$RISKS_IT_NR == 1", 
                "is.na(NINN$RISKS_IT_MITI) == FALSE & NINN$RISKS_IT_MITI == 1", 
                "is.na(NINN$RISKS_ENG_MAJ) == FALSE & NINN$RISKS_ENG_MAJ == 1", 
                "is.na(NINN$RISKS_ENG_MIN) == FALSE & NINN$RISKS_ENG_MIN == 1", 
                "is.na(NINN$RISKS_ENG_NR) == FALSE & NINN$RISKS_ENG_NR == 1", 
                "is.na(NINN$RISKS_ENG_MITI) == FALSE & NINN$RISKS_ENG_MITI == 1", 
                "is.na(NINN$RISKS_SUPCH_MAJ) == FALSE & NINN$RISKS_SUPCH_MAJ == 1", 
                "is.na(NINN$RISKS_SUPCH_MIN) == FALSE & NINN$RISKS_SUPCH_MIN == 1", 
                "is.na(NINN$RISKS_SUPCH_NR) == FALSE & NINN$RISKS_SUPCH_NR == 1", 
                "is.na(NINN$RISKS_SUPCH_MITI) == FALSE & NINN$RISKS_SUPCH_MITI == 1", 
                "is.na(NINN$RISKS_DEPE_MAJ) == FALSE & NINN$RISKS_DEPE_MAJ == 1", 
                "is.na(NINN$RISKS_DEPE_MIN) == FALSE & NINN$RISKS_DEPE_MIN == 1", 
                "is.na(NINN$RISKS_DEPE_NR) == FALSE & NINN$RISKS_DEPE_NR == 1", 
                "is.na(NINN$RISKS_DEPE_MITI) == FALSE & NINN$RISKS_DEPE_MITI == 1", 
                "is.na(NINN$RISKS_ACC_MAJ) == FALSE & NINN$RISKS_ACC_MAJ == 1", 
                "is.na(NINN$RISKS_ACC_MIN) == FALSE & NINN$RISKS_ACC_MIN == 1", 
                "is.na(NINN$RISKS_ACC_NR) == FALSE & NINN$RISKS_ACC_NR == 1", 
                "is.na(NINN$RISKS_ACC_MITI) == FALSE & NINN$RISKS_ACC_MITI == 1", 
                "is.na(NINN$RISKS_NATU_MAJ) == FALSE & NINN$RISKS_NATU_MAJ == 1", 
                "is.na(NINN$RISKS_NATU_MIN) == FALSE & NINN$RISKS_NATU_MIN == 1", 
                "is.na(NINN$RISKS_NATU_NR) == FALSE & NINN$RISKS_NATU_NR == 1", 
                "is.na(NINN$RISKS_NATU_MITI) == FALSE & NINN$RISKS_NATU_MITI == 1", 
                "is.na(NINN$RISKS_OTH_MAJ) == FALSE & NINN$RISKS_OTH_MAJ == 1", 
                "is.na(NINN$RISKS_OTH_MIN) == FALSE & NINN$RISKS_OTH_MIN == 1", 
                "is.na(NINN$RISKS_OTH_NR) == FALSE & NINN$RISKS_OTH_NR == 1", 
                "is.na(NINN$RISKS_OTH_MITI) == FALSE & NINN$RISKS_OTH_MITI == 1", 
                "is.na(NINN$RISKS_DEPNEU) == FALSE & NINN$RISKS_DEPNEU == 1", 
                "is.na(NINN$RISKS_DEPNEU_MITI) == FALSE & NINN$RISKS_DEPNEU_MITI == 1")

TYPE_ENT <- "NINN"

Aggregate <- data.table(matrix(ncol = 19, nrow = 0))
names(Aggregate) <- c("DATAFLOW", "FREQ", "TIME_PERIOD", "REF_AREA", "TABLENAME", "ACTIVITY", "NUMBER_EMPL", "TYPE_ENT", "INN_PF", "INDICATOR", "CIS_INDICATOR",	"OBS_VALUE", "UNIT_MEASURE", "UNIT_MULT", "DECIMALS",	"OBS_STATUS",	"OBS_STATUS_1",	"CONF_STATUS", "COMMENT_OBS")
for(num in 1:length(expression)){
  
  NINN_DT <- data.table(NINN[eval_tidy(parse_expr(expression[num])), ])
  
  if(nrow(NINN_DT) != 0){
    
    NINN_DT %>% group_by(M065_RETEG1, M0581_2J) %>% summarise(ENT22_SULYOZOTT = sum(VGMA001_SULY)) %>% arrange(M065_RETEG1, M0581_2J) -> NINN_Ordered
    CIS_INDICATOR <- expression2[num]
    
    for(i in 1:nrow(NINN_Ordered)){
      
      if(NINN_Ordered[i, 1] == "KI"){
        
        NUMBER_EMPL <- "E10T49"
        
      } else if(NINN_Ordered[i, 1] == "KO"){
        
        NUMBER_EMPL <- "E50T249"
        
      } else{
        
        NUMBER_EMPL <- "E_GE250"   
        
      }
      
      ACTIVITY <- get_NACE(NINN_Ordered[i, 2])
      OBS_VALUE <- NINN_Ordered[i, 3]
      Aggregate <- rbind(Aggregate, list(DATAFLOW, FREQ, TIME_PERIOD, REF_AREA, TABLENAME, ACTIVITY, NUMBER_EMPL, TYPE_ENT, INN_PF, INDICATOR, CIS_INDICATOR,	OBS_VALUE, UNIT_MEASURE, UNIT_MULT, DECIMALS,	OBS_STATUS,	OBS_STATUS_1,	CONF_STATUS, COMMENT_OBS), ignore.attr = TRUE)
      
    }
  }
}

NUMBER_EMPL <- "_T"
for(num in 1:length(expression)){
  
  CIS_INDICATOR <- expression2[num]
  
  for(j in 1:length(ACTIVITY_LIST)){
    
    ACTIVITY <- ACTIVITY_LIST[j]
    insert_Total(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  #Összetett értékek számítása több ACTIVITY kód alapján az összes vállalatcsoportra
  ACTIVITY <- "A"
  NUMBER_EMPL <- "_T"
  insert_A(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "B"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_B(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "C"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_C(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "C10T12"
  insert_C10T12(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C13T15"
  insert_C13T15(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C16T18"
  insert_C16T18(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C19_20"
  #insert_C19T20(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C19T21"
  insert_C19T21(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C19T22"
  #insert_C19T22(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C22_23"
  insert_C22T23(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C24_25"
  insert_C24T25(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C26T28"
  insert_C26T28(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C29_30"
  insert_C29T30(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "C25T30"
  #insert_C25T30(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "C31T33"
  insert_C31T33(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "D"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_D(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "E"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_E(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "E36_37"
  insert_E36T37(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "E38_39"
  insert_E38T39(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "E37T39"
  #insert_E37T39(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "G"
  insert_G(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "G46"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    if (nrow(Aggregate %>% filter(ACTIVITY == "G46" & NUMBER_EMPL == NUMBER_EMPL_LIST[j] & CIS_INDICATOR == expression2[num])) != 0)
      next
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_G46(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "H"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_H(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "F"
  insert_F(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "H49T51"
  insert_H49T51(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "H52_53"
  insert_H52T53(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "I"
  insert_I(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "J"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_J(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "J58T60"
  insert_J58T60(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "J61T63"
  insert_J61T63(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  #ACTIVITY <- "J62_63"
  #insert_J62T63(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "K"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_K(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "M"
  insert_M(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "M71T73"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_M71T73(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "N"
  insert_N(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
  
  ACTIVITY <- "BTE"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_BTE(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "GTN"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_GTN(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "G46TM73_INN"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert_G46TM73_INN(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
  
  ACTIVITY <- "_T"
  for(j in 1:length(NUMBER_EMPL_LIST)){
    
    NUMBER_EMPL <- NUMBER_EMPL_LIST[j]
    insert__T(TYPE_ENT, ACTIVITY, NUMBER_EMPL, UNIT_MEASURE, INDICATOR, CIS_INDICATOR)
    
  }
}

Aggregate$OBS_VALUE <- as.numeric(Aggregate$OBS_VALUE)
Aggregate_NINN <- Aggregate

Aggregate_INN <- Aggregate_INN[(Aggregate_INN$ACTIVITY != "F41" & Aggregate_INN$ACTIVITY != "F42" & Aggregate_INN$ACTIVITY != "F43" & Aggregate_INN$ACTIVITY != "I55" & Aggregate_INN$ACTIVITY != "I56") & (Aggregate_INN$NUMBER_EMPL == "_T" | Aggregate_INN$ACTIVITY == "M71T73" | Aggregate_INN$ACTIVITY == "K" | Aggregate_INN$ACTIVITY == "J" | Aggregate_INN$ACTIVITY == "H" | Aggregate_INN$ACTIVITY == "G46" | Aggregate_INN$ACTIVITY == "A" | Aggregate_INN$ACTIVITY == "B" | Aggregate_INN$ACTIVITY == "C" | Aggregate_INN$ACTIVITY == "D" | Aggregate_INN$ACTIVITY == "E" | Aggregate_INN$ACTIVITY == "I" | Aggregate_INN$ACTIVITY == "BTE" | Aggregate_INN$ACTIVITY == "GTN" | Aggregate_INN$ACTIVITY == "G46TM73_INN" | Aggregate_INN$ACTIVITY == "_T"), ]
Aggregate_NINN <- Aggregate_NINN[(Aggregate_NINN$ACTIVITY != "F41" & Aggregate_NINN$ACTIVITY != "F42" & Aggregate_NINN$ACTIVITY != "F43" & Aggregate_NINN$ACTIVITY != "I55" & Aggregate_NINN$ACTIVITY != "I56") & (Aggregate_NINN$NUMBER_EMPL == "_T" | Aggregate_NINN$ACTIVITY == "M71T73" | Aggregate_NINN$ACTIVITY == "K" | Aggregate_NINN$ACTIVITY == "J" | Aggregate_NINN$ACTIVITY == "H" | Aggregate_NINN$ACTIVITY == "G46" | Aggregate_NINN$ACTIVITY == "A" | Aggregate_NINN$ACTIVITY == "B" | Aggregate_NINN$ACTIVITY == "C" | Aggregate_NINN$ACTIVITY == "D" | Aggregate_NINN$ACTIVITY == "E" | Aggregate_NINN$ACTIVITY == "I" | Aggregate_NINN$ACTIVITY == "BTE" | Aggregate_NINN$ACTIVITY == "GTN" | Aggregate_NINN$ACTIVITY == "G46TM73_INN" | Aggregate_NINN$ACTIVITY == "_T"), ]

result_T35_DT <- rbind(Aggregate_INN, Aggregate_NINN)
result_T35_DT %>% group_by(DATAFLOW, FREQ, TIME_PERIOD, REF_AREA, TABLENAME, ACTIVITY, NUMBER_EMPL, INN_PF, INDICATOR, CIS_INDICATOR, UNIT_MEASURE, UNIT_MULT, DECIMALS) %>% summarise(OBS_VALUE = sum(OBS_VALUE)) -> result_T35_DT
# result_T35_DT <- result_T35_DT[, .(SUM_OBS_VALUE=sum(OBS_VALUE)), by = "DATAFLOW,FREQ,TIME_PERIOD,REF_AREA,TABLENAME,ACTIVITY,NUMBER_EMPL,INN_PF,INDICATOR,CIS_INDICATOR,UNIT_MEASURE,UNIT_MULT,DECIMALS"]
colnames(result_T35_DT)[14] <- "OBS_VALUE"

result_T35_DT_FINAL <- cbind(result_T35_DT[, 1:7], stringsAsFactors = FALSE)
result_T35_DT_FINAL$TYPE_ENT <- "_T"
result_T35_DT_FINAL <- cbind(result_T35_DT_FINAL, result_T35_DT[, c(8:10, 14, 11:13)], stringsAsFactors = FALSE)
result_T35_DT_FINAL$OBS_STATUS <- ""
result_T35_DT_FINAL$OBS_STATUS_1 <- ""
result_T35_DT_FINAL$CONF_STATUS <- ""
result_T35_DT_FINAL$COMMENT_OBS <- ""
result_T35_DT_FINAL <- as.data.frame(result_T35_DT_FINAL)
result_T35_DT_FINAL$OBS_VALUE <- as.character(result_T35_DT_FINAL$OBS_VALUE)
result_T35_DT_FINAL[, "OBS_VALUE"] <- gsub("\\.", ",", result_T35_DT_FINAL[, "OBS_VALUE"])

result_T35_DT_FINAL[result_T35_DT_FINAL$ACTIVITY == "A" | result_T35_DT_FINAL$ACTIVITY == "A01" | result_T35_DT_FINAL$ACTIVITY == "A02" | result_T35_DT_FINAL$ACTIVITY == "A03" | result_T35_DT_FINAL$ACTIVITY == "F" | result_T35_DT_FINAL$ACTIVITY == "G45" | result_T35_DT_FINAL$ACTIVITY == "G47" | result_T35_DT_FINAL$ACTIVITY == "I" | result_T35_DT_FINAL$ACTIVITY == "L" | result_T35_DT_FINAL$ACTIVITY == "M69" | result_T35_DT_FINAL$ACTIVITY == "M70" | result_T35_DT_FINAL$ACTIVITY == "M74" | result_T35_DT_FINAL$ACTIVITY == "M75" | result_T35_DT_FINAL$ACTIVITY == "N" | result_T35_DT_FINAL$ACTIVITY == "N77" | result_T35_DT_FINAL$ACTIVITY == "N78" | result_T35_DT_FINAL$ACTIVITY == "N79" | result_T35_DT_FINAL$ACTIVITY == "N80" | result_T35_DT_FINAL$ACTIVITY == "N81" | result_T35_DT_FINAL$ACTIVITY == "N82", "OBS_VALUE"] <- ""
result_T35_DT_FINAL <- subset(result_T35_DT_FINAL, ACTIVITY != "GTN" | (ACTIVITY == "GTN" & (NUMBER_EMPL == "_T")))
# result_T35_DT_FINAL <- subset(result_T35_DT_FINAL, ACTIVITY != "G" & ACTIVITY != "M")

result_T35_DT_FINAL <- subset(result_T35_DT_FINAL, TYPE_ENT == "_T")

Aggregate_INN[Aggregate_INN$ACTIVITY == "A" | Aggregate_INN$ACTIVITY == "A01" | Aggregate_INN$ACTIVITY == "A02" | Aggregate_INN$ACTIVITY == "A03" | Aggregate_INN$ACTIVITY == "F" | Aggregate_INN$ACTIVITY == "G45" | Aggregate_INN$ACTIVITY == "G47" | Aggregate_INN$ACTIVITY == "I" | Aggregate_INN$ACTIVITY == "L" | Aggregate_INN$ACTIVITY == "M69" | Aggregate_INN$ACTIVITY == "M70" | Aggregate_INN$ACTIVITY == "M74" | Aggregate_INN$ACTIVITY == "M75" | Aggregate_INN$ACTIVITY == "N" | Aggregate_INN$ACTIVITY == "N77" | Aggregate_INN$ACTIVITY == "N78" | Aggregate_INN$ACTIVITY == "N79" | Aggregate_INN$ACTIVITY == "N80" | Aggregate_INN$ACTIVITY == "N81" | Aggregate_INN$ACTIVITY == "N82", "OBS_VALUE"] <- ""
Aggregate_INN <- subset(Aggregate_INN, ACTIVITY != "GTN" | (ACTIVITY == "GTN" & (NUMBER_EMPL == "_T")))
# Aggregate_INN <- subset(Aggregate_INN, ACTIVITY != "G" & ACTIVITY != "M")
Aggregate_NINN[Aggregate_NINN$ACTIVITY == "A" | Aggregate_NINN$ACTIVITY == "A01" | Aggregate_NINN$ACTIVITY == "A02" | Aggregate_NINN$ACTIVITY == "A03" | Aggregate_NINN$ACTIVITY == "F" | Aggregate_NINN$ACTIVITY == "G45" | Aggregate_NINN$ACTIVITY == "G47" | Aggregate_NINN$ACTIVITY == "I" | Aggregate_NINN$ACTIVITY == "L" | Aggregate_NINN$ACTIVITY == "M69" | Aggregate_NINN$ACTIVITY == "M70" | Aggregate_NINN$ACTIVITY == "M74" | Aggregate_NINN$ACTIVITY == "M75" | Aggregate_NINN$ACTIVITY == "N" | Aggregate_NINN$ACTIVITY == "N77" | Aggregate_NINN$ACTIVITY == "N78" | Aggregate_NINN$ACTIVITY == "N79" | Aggregate_NINN$ACTIVITY == "N80" | Aggregate_NINN$ACTIVITY == "N81" | Aggregate_NINN$ACTIVITY == "N82", "OBS_VALUE"] <- ""
Aggregate_NINN <- subset(Aggregate_NINN, ACTIVITY != "GTN" | (ACTIVITY == "GTN" & (NUMBER_EMPL == "_T")))
# Aggregate_NINN <- subset(Aggregate_NINN, ACTIVITY != "G" & ACTIVITY != "M")

Aggregate_INN <- as.data.frame(Aggregate_INN)
Aggregate_INN$OBS_VALUE <- as.character(Aggregate_INN$OBS_VALUE)
Aggregate_INN[, "OBS_VALUE"] <- gsub("\\.", ",", Aggregate_INN[, "OBS_VALUE"])
Aggregate_INN$OBS_VALUE[is.na(Aggregate_INN$OBS_VALUE)] <- ""

Aggregate_NINN <- as.data.frame(Aggregate_NINN)
Aggregate_NINN$OBS_VALUE <- as.character(Aggregate_NINN$OBS_VALUE)
Aggregate_NINN[, "OBS_VALUE"] <- gsub("\\.", ",", Aggregate_NINN[, "OBS_VALUE"])
Aggregate_NINN$OBS_VALUE[is.na(Aggregate_NINN$OBS_VALUE)] <- ""

result_T35_DT_FINAL[result_T35_DT_FINAL$ACTIVITY == "G" | result_T35_DT_FINAL$ACTIVITY == "M", "OBS_VALUE"] <- ""
Aggregate_INN[Aggregate_INN$ACTIVITY == "G" | Aggregate_INN$ACTIVITY == "M", "OBS_VALUE"] <- ""
Aggregate_NINN[Aggregate_NINN$ACTIVITY == "G" | Aggregate_NINN$ACTIVITY == "M", "OBS_VALUE"] <- ""

write.table(rbind(result_T35_DT_FINAL, Aggregate_INN, Aggregate_NINN), T35_SDMX_FINAL_RESULT, sep = ";", quote = FALSE, row.names = FALSE, append = FALSE)

set_ENT_Profile("as.numeric(RISKS_IT_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_IT_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_IT_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_IT_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ENG_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ENG_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ENG_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ENG_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_SUPCH_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_SUPCH_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_SUPCH_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_SUPCH_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPE_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPE_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPE_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPE_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ACC_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ACC_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ACC_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_ACC_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_NATU_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_NATU_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_NATU_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_NATU_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_OTH_MAJ)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_OTH_MIN)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_OTH_NR)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_OTH_MITI)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPNEU)", "T35", T35_SDMX_FINAL_RESULT)
set_ENT_Profile("as.numeric(RISKS_DEPNEU_MITI)", "T35", T35_SDMX_FINAL_RESULT)