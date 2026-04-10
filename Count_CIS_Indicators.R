DATAFLOW <- "ESTAT:CIS_OM4_2(2.2)"
FREQ <- "A"
TIME_PERIOD <- "2024"
REF_AREA <- "HU"
OBS_STATUS <- ""
OBS_STATUS_1 <- ""	
CONF_STATUS <- ""
COMMENT_OBS <- ""

ACTIVITY_LIST <- c("A01", "A02", "A03", "B05", "B06", "B07", "B08", "B09", 
                   "C10", "C11", "C12", "C13", "C14", "C15", "C16", "C17", 
                   "C18", "C19", "C20", "C21", "C22", "C23", "C24", "C25", 
                   "C26", "C27", "C28", "C29", "C30", "C31", "C32", "C33",
                   "D351", "D352", "D353", "E36", "E37", "E38", "E39", 
                   "F41", "F42", "F43", "G45", "G46", "G47", 
                   "H49", "H50", "H51", "H52", "H53", "I55", "I56", 
                   "J58", "J59", "J60", "J61", "J62", "J63", 
                   "K64", "K65", "K66", "L", 
                   "M69", "M70", "M71", "M72", "M73", "M74", "M75", 
                   "N77", "N78", "N79", "N80", "N81", "N82")

NUMBER_EMPL_LIST <- c("E_GE250", "E50T249", "E10T49", "_T")

INDICATOR_LIST <- c("ENT", "EMPL", "TOVT")

#For profiling
filter_M065_RETEG1 <- c("M065_RETEG1 == 'KI'", "M065_RETEG1 == 'KO'", "M065_RETEG1 == 'BI'", "",
                        "(M0691 == 'B' | M0691 == 'C' | M0691 == 'D' | M0691 == 'E') & M065_RETEG1 == 'KI'",
                        "(M0691 == 'B' | M0691 == 'C' | M0691 == 'D' | M0691 == 'E') & M065_RETEG1 == 'KO'",
                        "(M0691 == 'B' | M0691 == 'C' | M0691 == 'D' | M0691 == 'E') & M065_RETEG1 == 'BI'",
                        "(M0691 == 'B' | M0691 == 'C' | M0691 == 'D' | M0691 == 'E')",
                        "(M0691 != 'B' & M0691 != 'C' & M0691 != 'D' & M0691 != 'E') & M065_RETEG1 == 'KI'",
                        "(M0691 != 'B' & M0691 != 'C' & M0691 != 'D' & M0691 != 'E') & M065_RETEG1 == 'KO'",
                        "(M0691 != 'B' & M0691 != 'C' & M0691 != 'D' & M0691 != 'E') & M065_RETEG1 == 'BI'",
                        "(M0691 != 'B' & M0691 != 'C' & M0691 != 'D' & M0691 != 'E')")

#For profiling
first_rows <- c(3, 2, 1, 4)
middle_rows <- c(7, 6, 5, 8)
last_rows <- c(11, 10, 9, 12)
profile_rows <- c(3, 2, 1, 4, 7, 6, 5, 8, 11, 10, 9, 12)

#For profiling
ACTIVITY_PROFILE_LIST <- c("_T", "BTE", "G46TM73_INN")

#For regional
REF_AREA_LIST <- c("HU", "HU1", "HU2", "HU3", "HU11", "HU12", "HU21", "HU22", "HU23", "HU31", "HU32", "HU33", "HUZ", "HUZZ")

#4 - INN
INN <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PRD_GD == 1 | INNO_PRD_SERV == 1 | INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1 | INNA_COMPL == 1 | INNA_ONGO == 1 | INNA_ABDN == 1 | INNA_IH_RND == 1 | INNA_RND_CONTR_OUT == 1)
dim(INN) # 3033 sor és 322 oszlop

#5 - PRD_ONL
PRD_ONL <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) & (INNO_PCS_PRD != 1 & INNO_PCS_LOG != 1 & INNO_PCS_COMM != 1 & INNO_PCS_ACCT != 1 & INNO_PCS_OPROC_EXTREL != 1 & INNO_PCS_WR_DEC_HRM != 1 & INNO_PCS_SLS_SERV != 1))
dim(PRD_ONL) # 567 sor és 322 oszlop

#6 - BPCS_ONL
BPCS_ONL <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD != 1 & INNO_PRD_SERV != 1) & (INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1))
dim(BPCS_ONL) # 1005 sor és 322 oszlop

#7 - PRD_BPCS_ONL
PRD_BPCS_ONL <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) & (INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1))
dim(PRD_BPCS_ONL) # 1202 sor és 322 oszlop

#9 - NINN
NINN <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD != 1 & INNO_PRD_SERV != 1 & INNO_PCS_PRD != 1 & INNO_PCS_LOG != 1 & INNO_PCS_COMM != 1 & INNO_PCS_ACCT != 1 & INNO_PCS_OPROC_EXTREL != 1 & INNO_PCS_WR_DEC_HRM != 1 & INNO_PCS_SLS_SERV != 1) & (INNA_COMPL != 1 & INNA_ONGO != 1 & INNA_ABDN != 1 & INNA_IH_RND != 1 & INNA_RND_CONTR_OUT != 1))
dim(NINN) # 4756 sor és 322 oszlop

#10 - INNO_PRD
INNO_PRD <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PRD_GD == 1 | INNO_PRD_SERV == 1)
dim(INNO_PRD) # 1769 sor és 322 oszlop

#11
INNO_BPCS <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1)
dim(INNO_BPCS) # 2207 sor és 322 oszlop

#12
PRD_NEW_MKT <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) & INNO_PRD_NEW_MKT == 1)
dim(PRD_NEW_MKT) # 685 sor és 322 oszlop

#13
PRD_NEW_ENT <-subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) & INNO_PRD_NEW_ENT == 1)
dim(PRD_NEW_ENT) # 1554 sor és 322 oszlop

#58
INNA_RND_OUT_N_IH <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_IH_RND == 0 & INNA_RND_CONTR_OUT == 1)
dim(INNA_RND_OUT_N_IH) # 75 sor és 322 oszlop

#82 - INN_X_RND
INN_X_RND <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1 | INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1 | INNA_COMPL == 1 | INNA_ONGO == 1 | INNA_ABDN == 1) & (INNA_IH_RND != 1 & INNA_RND_CONTR_OUT != 1))
dim(INN_X_RND) # 1881 sor és 322 oszlop

#83
PRD_NEW_ENT_ONL <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) & (INNO_PRD_NEW_ENT == 1 & INNO_PRD_NEW_MKT == 0))
dim(PRD_NEW_ENT_ONL) # 1084 sor és 322 oszlop

PRDBPCS_COMPL <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PRD_GD == 1 | INNO_PRD_SERV == 1 | INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1 | INNA_COMPL == 1)
dim(PRDBPCS_COMPL) # 2812 sor és 322 oszlop

INNA_COMPL_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_COMPL == 1)
dim(INNA_COMPL_NOT_ZERO) # 191 sor és 322 oszlop

INNA_ONGO_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_ONGO == 1)
dim(INNA_ONGO_NOT_ZERO) # 751 sor és 322 oszlop

INNA_ABDN_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_ABDN == 1)
dim(INNA_ABDN_NOT_ZERO) # 301 sor és 322 oszlop

INNA_IH_RND_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_IH_RND == 1)
dim(INNA_IH_RND_NOT_ZERO) # 1077 sor és 322 oszlop

INNA_IH_RND_CONT_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_IH_RND_CONT == 1)
dim(INNA_IH_RND_CONT_NOT_ZERO) # 669 sor és 322 oszlop

INNA_IH_RND_OCC_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_IH_RND_OCC == 1)
dim(INNA_IH_RND_OCC_NOT_ZERO) # 408 sor és 322 oszlop

INNA_RND_CONTR_OUT_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNA_RND_CONTR_OUT == 1)
dim(INNA_RND_CONTR_OUT_NOT_ZERO) # 306 sor és 322 oszlop

INNO_PRD_GD_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PRD_GD == 1)
dim(INNO_PRD_GD_NOT_ZERO) # 1375 sor és 322 oszlop

INNO_PRD_SERV_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PRD_SERV == 1)
dim(INNO_PRD_SERV_NOT_ZERO) # 858 sor és 322 oszlop

INNO_PCS_PRD_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_PRD == 1)
dim(INNO_PCS_PRD_NOT_ZERO) # 1116 sor és 322 oszlop

INNO_PCS_LOG_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_LOG == 1)
dim(INNO_PCS_LOG_NOT_ZERO) # 624 sor és 322 oszlop

INNO_PCS_COMM_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_COMM == 1)
dim(INNO_PCS_COMM_NOT_ZERO) # 1231 sor és 322 oszlop

INNO_PCS_ACCT_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_ACCT == 1)
dim(INNO_PCS_ACCT_NOT_ZERO) # 1039 sor és 322 oszlop

INNO_PCS_OPROC_EXTREL_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_OPROC_EXTREL == 1)
dim(INNO_PCS_OPROC_EXTREL_NOT_ZERO) # 833 sor és 322 oszlop

INNO_PCS_WR_DEC_HRM_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_WR_DEC_HRM == 1)
dim(INNO_PCS_WR_DEC_HRM_NOT_ZERO) # 823 sor és 322 oszlop

INNO_PCS_SLS_SERV_NOT_ZERO <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], INNO_PCS_SLS_SERV == 1)
dim(INNO_PCS_SLS_SERV_NOT_ZERO) # 850 sor és 322 oszlop

#T10
#55
# TUR24 csere
TUR_PRD_NEW_MKT <- subset(worksheet_01, INNO_PRD_NEW_MKT == 1, c("M092", "INNO_PRD_NEW_MKT", "TUR_PRD_NEW_MKT", "TOVT", "VGMA001_SULY"))
dim(TUR_PRD_NEW_MKT) # 685 sor és 5 oszlop

#56
# TUR24 csere
TUR_PRD_NEW_ENT <- subset(worksheet_01, INNO_PRD_NEW_ENT == 1, c("M092", "INNO_PRD_NEW_ENT", "TUR_PRD_NEW_ENT", "TOVT", "VGMA001_SULY"))
dim(TUR_PRD_NEW_ENT) # 1554 sor és 5 oszlop

#T11
#80
DEVE_PRD_BPCS <- subset(worksheet_01, DEVE_PRD_ENT == 1 | DEVE_PRD_ENT_OTH == 1 | DEVE_PCS_ENT == 1 | DEVE_PCS_ENT_OTH == 1, c("M092", "DEVE_PRD_ENT", "DEVE_PRD_ENT_OTH", "DEVE_PCS_ENT", "DEVE_PCS_ENT_OTH"))
dim(DEVE_PRD_BPCS) # 2248 sor és 5 oszlop

#T14
#57
EXP_INNO_RND <- subset(worksheet_01, (EXP_INNO_RND_IH != 0 | EXP_INNO_RND_CONTR_OUT != 0), c("M092", "EXP_INNO_RND_IH", "EXP_INNO_RND_CONTR_OUT"))
dim(EXP_INNO_RND) # 940 sor és 3 oszlop

#59
EXP_INNO_TOTAL <- subset(worksheet_01, (EXP_INNO_RND_IH != 0 | EXP_INNO_RND_CONTR_OUT != 0 | EXP_INNO_INN_XRND != 0), c("M092", "EXP_INNO_RND_IH", "EXP_INNO_RND_CONTR_OUT", "EXP_INNO_INN_XRND"))
dim(EXP_INNO_TOTAL) # 1368 sor és 4 oszlop

#64
ENT_INNO_RND_IH <- subset(worksheet_01, EXP_INNO_RND_IH != 0, c("M092", "EXP_INNO_RND_IH"))
dim(ENT_INNO_RND_IH) # 900 sor és 2 oszlop

#65
ENT_INNO_RND_CONTR_OUT <- subset(worksheet_01, EXP_INNO_RND_CONTR_OUT != 0, c("M092", "EXP_INNO_RND_CONTR_OUT"))
dim(ENT_INNO_RND_CONTR_OUT) # 171 sor és 2 oszlop

#66
ENT_INNO_INN_XRND <- subset(worksheet_01, EXP_INNO_INN_XRND != 0, c("M092", "EXP_INNO_INN_XRND"))
dim(ENT_INNO_INN_XRND) # 699 sor és 2 oszlop

#67
ENT_INNO_TOTAL <- subset(worksheet_01, EXP_INNO_RND_IH != 0 | EXP_INNO_RND_CONTR_OUT != 0 | EXP_INNO_INN_XRND != 0, c("M092", "EXP_INNO_RND_IH", "EXP_INNO_RND_CONTR_OUT", "EXP_INNO_INN_XRND"))
dim(ENT_INNO_TOTAL) # 1368 sor és 4 oszlop

#68
ENT_INNO_RND <- subset(worksheet_01, EXP_INNO_RND_IH != 0 | EXP_INNO_RND_CONTR_OUT != 0, c("M092", "EXP_INNO_RND_IH", "EXP_INNO_RND_CONTR_OUT"))
dim(ENT_INNO_RND) # 940 sor és 3 oszlop

#T16
#52
FUND_SOURCE <- subset(worksheet_01, FUND_AUT_LOC_REG == 1 | FUND_GOV_CTL == 1 | FUND_EU_HP == 1 | FUND_EU_OTH == 1, c("M092", "FUND_AUT_LOC_REG", "FUND_GOV_CTL", "FUND_EU_HP", "FUND_EU_OTH"))
# FUND_EU_HP2020
dim(FUND_SOURCE) # 2114 sor és 5 oszlop

#53
FUND_FOR_RNDINN <- subset(worksheet_01, FUND_AUT_LOC_REG_RNDINN == 1 | FUND_GOV_CTL_RNDINN == 1 | FUND_EU_HP_RNDINN == 1 | FUND_EU_OTH_RNDINN == 1, c("M092", "FUND_AUT_LOC_REG_RNDINN", "FUND_GOV_CTL_RNDINN", "FUND_EU_HP_RNDINN", "FUND_EU_OTH_RNDINN"))
# FUND_EU_HP2020_RNDINN
dim(FUND_FOR_RNDINN) # 568 sor és 5 oszlop

#T18
#31
COOP_RNDINN <- subset(worksheet_01, COOP_RND == 1 | COOP_INN_XRND == 1, c("M092", "COOP_RND", "COOP_INN_XRND"))
dim(COOP_RNDINN) # 914 sor és 3 oszlop

#32
COOP_ALL <- subset(worksheet_01, COOP_RND == 1 | COOP_INN_XRND == 1 | COOP_OTH == 1, c("M092", "COOP_RND", "COOP_INN_XRND", "COOP_OTH"))
dim(COOP_ALL) # 1956 sor és 4 oszlop

#33
COOP_PRV <- subset(worksheet_01, COOP_PRV_CN_NAT == 1 | COOP_PRV_CN_EU_EFTA == 1 | COOP_PRV_CN_NEU_NEFTA == 1 | COOP_PRV_SUPPL_NAT == 1 | COOP_PRV_SUPPL_EU_EFTA == 1 | COOP_PRV_SUPPL_NEU_NEFTA == 1 | COOP_PRV_CLCU_NAT == 1 | COOP_PRV_CLCU_EU_EFTA == 1 | COOP_PRV_CLCU_NEU_NEFTA == 1 | COOP_PRV_COMP_NAT == 1 | COOP_PRV_COMP_EU_EFTA == 1 | COOP_PRV_COMP_NEU_NEFTA == 1 | COOP_PRV_OTH_NAT == 1 | COOP_PRV_OTH_EU_EFTA == 1 | COOP_PRV_OTH_NEU_NEFTA == 1 | COOP_PRV_EG_NAT == 1 | COOP_PRV_EG_EU_EFTA == 1 | COOP_PRV_EG_NEU_NEFTA == 1, c("M092", "COOP_PRV_CN_NAT", "COOP_PRV_CN_EU_EFTA", "COOP_PRV_CN_NEU_NEFTA", "COOP_PRV_SUPPL_NAT", "COOP_PRV_SUPPL_EU_EFTA", "COOP_PRV_SUPPL_NEU_NEFTA", "COOP_PRV_CLCU_NAT", "COOP_PRV_CLCU_EU_EFTA", "COOP_PRV_CLCU_NEU_NEFTA", "COOP_PRV_COMP_NAT", "COOP_PRV_COMP_EU_EFTA", "COOP_PRV_COMP_NEU_NEFTA", "COOP_PRV_OTH_NAT", "COOP_PRV_OTH_EU_EFTA", "COOP_PRV_OTH_NEU_NEFTA", "COOP_PRV_EG_NAT", "COOP_PRV_EG_EU_EFTA", "COOP_PRV_EG_NEU_NEFTA"))
dim(COOP_PRV) # 879 sor és 16 oszlop

#34
COOP_PRV_CN <- subset(worksheet_01, COOP_PRV_CN_NAT == 1 | COOP_PRV_CN_EU_EFTA == 1 | COOP_PRV_CN_NEU_NEFTA == 1, c("M092", "COOP_PRV_CN_NAT", "COOP_PRV_CN_EU_EFTA", "COOP_PRV_CN_NEU_NEFTA"))
dim(COOP_PRV_CN) # 450 sor és 4 oszlop

#35
COOP_PRV_SUPPL <- subset(worksheet_01, COOP_PRV_SUPPL_NAT == 1 | COOP_PRV_SUPPL_EU_EFTA == 1 | COOP_PRV_SUPPL_NEU_NEFTA == 1, c("M092", "COOP_PRV_SUPPL_NAT", "COOP_PRV_SUPPL_EU_EFTA", "COOP_PRV_SUPPL_NEU_NEFTA"))
dim(COOP_PRV_SUPPL) # 498 sor és 4 oszlop

#36
COOP_PRV_CLCU <- subset(worksheet_01, COOP_PRV_CLCU_NAT == 1 | COOP_PRV_CLCU_EU_EFTA == 1 | COOP_PRV_CLCU_NEU_NEFTA == 1, c("M092", "COOP_PRV_CLCU_NAT", "COOP_PRV_CLCU_EU_EFTA", "COOP_PRV_CLCU_NEU_NEFTA"))
dim(COOP_PRV_CLCU) # 309 sor és 4 oszlop

#37
COOP_PRV_COMP <- subset(worksheet_01, COOP_PRV_COMP_NAT == 1 | COOP_PRV_COMP_EU_EFTA == 1 | COOP_PRV_COMP_NEU_NEFTA == 1, c("M092", "COOP_PRV_COMP_NAT", "COOP_PRV_COMP_EU_EFTA", "COOP_PRV_COMP_NEU_NEFTA"))
dim(COOP_PRV_COMP) # 110 sor és 4 oszlop

#38
COOP_PRV_OTH <- subset(worksheet_01, COOP_PRV_OTH_NAT == 1 | COOP_PRV_OTH_EU_EFTA == 1 | COOP_PRV_OTH_NEU_NEFTA == 1, c("M092", "COOP_PRV_OTH_NAT", "COOP_PRV_OTH_EU_EFTA", "COOP_PRV_OTH_NEU_NEFTA"))
dim(COOP_PRV_OTH) # 325 sor és 4 oszlop

#39
COOP_EG <- subset(worksheet_01, COOP_PRV_EG_NAT == 1 | COOP_PRV_EG_EU_EFTA == 1 | COOP_PRV_EG_NEU_NEFTA == 1, c("M092", "COOP_PRV_EG_NAT", "COOP_PRV_EG_EU_EFTA", "COOP_PRV_EG_NEU_NEFTA"))
# COOP_EG_NAT == 1 | COOP_EG_EU_EFTA == 1 | COOP_EG_NEU_NEFTA == 1, c("M092", "COOP_EG_NAT", "COOP_EG_EU_EFTA", "COOP_EG_NEU_NEFTA")
dim(COOP_EG) # 295 sor és 4 oszlop

#40
COOP_UNIV <- subset(worksheet_01, COOP_UNIV_NAT == 1 | COOP_UNIV_EU_EFTA == 1 | COOP_UNIV_NEU_NEFTA == 1, c("M092", "COOP_UNIV_NAT", "COOP_UNIV_EU_EFTA", "COOP_UNIV_NEU_NEFTA"))
dim(COOP_UNIV) # 340 sor és 4 oszlop

#41
COOP_GOV_RI <- subset(worksheet_01, COOP_GOV_RI_NAT == 1 | COOP_GOV_RI_EU_EFTA == 1 | COOP_GOV_RI_NEU_NEFTA == 1, c("M092", "COOP_GOV_RI_NAT", "COOP_GOV_RI_EU_EFTA", "COOP_GOV_RI_NEU_NEFTA"))
dim(COOP_GOV_RI) # 71 sor és 4 oszlop

#42
COOP_PUB_CLCU <- subset(worksheet_01, COOP_PUB_CLCU_NAT == 1 | COOP_PUB_CLCU_EU_EFTA == 1 | COOP_PUB_CLCU_NEU_NEFTA == 1, c("M092", "COOP_PUB_CLCU_NAT", "COOP_PUB_CLCU_EU_EFTA", "COOP_PUB_CLCU_NEU_NEFTA"))
dim(COOP_PUB_CLCU) # 77 sor és 4 oszlop

#43
COOP_NPO <- subset(worksheet_01, COOP_NPO_NAT == 1 | COOP_NPO_EU_EFTA == 1 | COOP_NPO_NEU_NEFTA == 1, c("M092", "COOP_NPO_NAT", "COOP_NPO_EU_EFTA", "COOP_NPO_NEU_NEFTA"))
dim(COOP_NPO) # 56 sor és 4 oszlop

# Nem sikerült, mert 
# COOP_EG_NAT == 1 volt _PRV hiányzott
#60
COOP_NAT <- subset(worksheet_01, COOP_PRV_CN_NAT == 1 | COOP_PRV_SUPPL_NAT == 1 | COOP_PRV_CLCU_NAT == 1 | COOP_PRV_COMP_NAT == 1 | COOP_PRV_OTH_NAT == 1 | COOP_PRV_EG_NAT == 1 | COOP_UNIV_NAT == 1 | COOP_GOV_RI_NAT == 1 | COOP_PUB_CLCU_NAT == 1 | COOP_NPO_NAT == 1, c("M092", "COOP_PRV_CN_NAT", "COOP_PRV_SUPPL_NAT", "COOP_PRV_CLCU_NAT", "COOP_PRV_COMP_NAT", "COOP_PRV_OTH_NAT", "COOP_PRV_EG_NAT", "COOP_UNIV_NAT", "COOP_GOV_RI_NAT", "COOP_PUB_CLCU_NAT", "COOP_NPO_NAT"))
dim(COOP_NAT) # 814 sor és 11 oszlop

#44
COOP_NNAT <- subset(worksheet_01, COOP_PRV_CN_EU_EFTA == 1 | COOP_PRV_CN_NEU_NEFTA == 1 | COOP_PRV_SUPPL_EU_EFTA == 1 | COOP_PRV_SUPPL_NEU_NEFTA == 1 | COOP_PRV_CLCU_EU_EFTA == 1 | COOP_PRV_CLCU_NEU_NEFTA == 1 | COOP_PRV_COMP_EU_EFTA == 1 | COOP_PRV_COMP_NEU_NEFTA == 1 | COOP_PRV_OTH_EU_EFTA == 1 | COOP_PRV_OTH_NEU_NEFTA == 1 | COOP_PRV_EG_EU_EFTA == 1 | COOP_UNIV_EU_EFTA == 1 | COOP_GOV_RI_EU_EFTA == 1 | COOP_PUB_CLCU_EU_EFTA == 1 | COOP_NPO_EU_EFTA == 1 | COOP_PRV_EG_NEU_NEFTA == 1 | COOP_UNIV_NEU_NEFTA == 1 | COOP_GOV_RI_NEU_NEFTA == 1 | COOP_PUB_CLCU_NEU_NEFTA == 1 |  COOP_NPO_NEU_NEFTA == 1, c("M092", "COOP_PRV_CN_EU_EFTA", "COOP_PRV_CN_NEU_NEFTA", "COOP_PRV_SUPPL_EU_EFTA", "COOP_PRV_SUPPL_NEU_NEFTA", "COOP_PRV_CLCU_EU_EFTA", "COOP_PRV_CLCU_NEU_NEFTA", "COOP_PRV_COMP_EU_EFTA", "COOP_PRV_COMP_NEU_NEFTA", "COOP_PRV_OTH_EU_EFTA", "COOP_PRV_OTH_NEU_NEFTA", "COOP_PRV_EG_EU_EFTA", "COOP_PRV_EG_NEU_NEFTA", "COOP_UNIV_EU_EFTA", "COOP_UNIV_NEU_NEFTA", "COOP_GOV_RI_EU_EFTA", "COOP_GOV_RI_NEU_NEFTA", "COOP_PUB_CLCU_EU_EFTA", "COOP_PUB_CLCU_NEU_NEFTA", "COOP_NPO_EU_EFTA", "COOP_NPO_NEU_NEFTA"))
dim(COOP_NNAT) # 478 sor és 21 oszlop

#45
COOP_PRV_EU_EFTA <- subset(worksheet_01, COOP_PRV_CN_EU_EFTA == 1 | COOP_PRV_SUPPL_EU_EFTA == 1 | COOP_PRV_CLCU_EU_EFTA == 1 | COOP_PRV_COMP_EU_EFTA == 1 | COOP_PRV_OTH_EU_EFTA == 1 | COOP_PRV_EG_EU_EFTA == 1, c("M092", "COOP_PRV_CN_EU_EFTA", "COOP_PRV_SUPPL_EU_EFTA", "COOP_PRV_CLCU_EU_EFTA", "COOP_PRV_COMP_EU_EFTA", "COOP_PRV_OTH_EU_EFTA", "COOP_PRV_EG_EU_EFTA"))
# COOP_EU_EFTA        | COOP_UNIV_EU_EFTA == 1 | COOP_GOV_RI_EU_EFTA == 1 | COOP_PUB_CLCU_EU_EFTA == 1 | COOP_NPO_EU_EFTA == 1      , "COOP_UNIV_EU_EFTA", "COOP_GOV_RI_EU_EFTA", "COOP_PUB_CLCU_EU_EFTA", "COOP_NPO_EU_EFTA"
dim(COOP_PRV_EU_EFTA) # 437 sor és 11 oszlop

COOP_EU_EFTA <- subset(worksheet_01, COOP_PRV_CN_EU_EFTA == 1 | COOP_PRV_SUPPL_EU_EFTA == 1 | COOP_PRV_CLCU_EU_EFTA == 1 | COOP_PRV_COMP_EU_EFTA == 1 | COOP_PRV_OTH_EU_EFTA == 1 | COOP_PRV_EG_EU_EFTA == 1 | COOP_UNIV_EU_EFTA == 1 | COOP_GOV_RI_EU_EFTA == 1 | COOP_PUB_CLCU_EU_EFTA == 1 | COOP_NPO_EU_EFTA == 1, c("M092", "COOP_PRV_CN_EU_EFTA", "COOP_PRV_SUPPL_EU_EFTA", "COOP_PRV_CLCU_EU_EFTA", "COOP_PRV_COMP_EU_EFTA", "COOP_PRV_OTH_EU_EFTA", "COOP_PRV_EG_EU_EFTA", "COOP_UNIV_EU_EFTA", "COOP_GOV_RI_EU_EFTA", "COOP_PUB_CLCU_EU_EFTA", "COOP_NPO_EU_EFTA"))
dim(COOP_EU_EFTA) # 443 sor és 11 oszlop

#46 
COOP_PRV_NEU_NEFTA <- subset(worksheet_01, COOP_PRV_CN_NEU_NEFTA == 1 | COOP_PRV_SUPPL_NEU_NEFTA == 1 | COOP_PRV_CLCU_NEU_NEFTA == 1 | COOP_PRV_COMP_NEU_NEFTA == 1 | COOP_PRV_OTH_NEU_NEFTA == 1 | COOP_PRV_EG_NEU_NEFTA == 1, c("M092", "COOP_PRV_CN_NEU_NEFTA", "COOP_PRV_SUPPL_NEU_NEFTA", "COOP_PRV_CLCU_NEU_NEFTA", "COOP_PRV_COMP_NEU_NEFTA", "COOP_PRV_OTH_NEU_NEFTA", "COOP_PRV_EG_NEU_NEFTA"))
# COOP_NEU_NEFTA      | COOP_UNIV_NEU_NEFTA == 1 | COOP_GOV_RI_NEU_NEFTA == 1 | COOP_PUB_CLCU_NEU_NEFTA == 1 | COOP_NPO_NEU_NEFTA == 1      , "COOP_UNIV_NEU_NEFTA", "COOP_GOV_RI_NEU_NEFTA", "COOP_PUB_CLCU_NEU_NEFTA", "COOP_NPO_NEU_NEFTA"
dim(COOP_PRV_NEU_NEFTA) # 185 sor és 7 oszlop

COOP_NEU_NEFTA <- subset(worksheet_01, COOP_PRV_CN_NEU_NEFTA == 1 | COOP_PRV_SUPPL_NEU_NEFTA == 1 | COOP_PRV_CLCU_NEU_NEFTA == 1 | COOP_PRV_COMP_NEU_NEFTA == 1 | COOP_PRV_OTH_NEU_NEFTA == 1 | COOP_PRV_EG_NEU_NEFTA == 1 | COOP_UNIV_NEU_NEFTA == 1 | COOP_GOV_RI_NEU_NEFTA == 1 | COOP_PUB_CLCU_NEU_NEFTA == 1 | COOP_NPO_NEU_NEFTA == 1, c("M092", "COOP_PRV_CN_NEU_NEFTA", "COOP_PRV_SUPPL_NEU_NEFTA", "COOP_PRV_CLCU_NEU_NEFTA", "COOP_PRV_COMP_NEU_NEFTA", "COOP_PRV_OTH_NEU_NEFTA", "COOP_PRV_EG_NEU_NEFTA", "COOP_UNIV_NEU_NEFTA", "COOP_GOV_RI_NEU_NEFTA", "COOP_PUB_CLCU_NEU_NEFTA", "COOP_NPO_NEU_NEFTA"))
dim(COOP_NEU_NEFTA) # 189 sor és 11 oszlop

COOP_PRV_NAT <- subset(worksheet_01, COOP_PRV_CN_NAT == 1 | COOP_PRV_SUPPL_NAT == 1 | COOP_PRV_CLCU_NAT == 1 | COOP_PRV_COMP_NAT == 1 | COOP_PRV_OTH_NAT == 1 | COOP_PRV_EG_NAT == 1, c("M092", "COOP_PRV_CN_NAT", "COOP_PRV_SUPPL_NAT", "COOP_PRV_CLCU_NAT", "COOP_PRV_COMP_NAT", "COOP_PRV_OTH_NAT", "COOP_PRV_EG_NAT"))
dim(COOP_PRV_NAT) # 761 sor és 7 oszlop

COOP_NPRV <- subset(worksheet_01, COOP_UNIV_NAT == 1 | COOP_UNIV_EU_EFTA == 1 | COOP_UNIV_NEU_NEFTA == 1 | COOP_GOV_RI_NAT == 1 | COOP_GOV_RI_EU_EFTA == 1 | COOP_GOV_RI_NEU_NEFTA == 1 | COOP_PUB_CLCU_NAT == 1 | COOP_PUB_CLCU_EU_EFTA == 1 | COOP_PUB_CLCU_NEU_NEFTA == 1 | COOP_NPO_NAT == 1 | COOP_NPO_EU_EFTA == 1 | COOP_NPO_NEU_NEFTA == 1, c("M092", "COOP_UNIV_NAT", "COOP_UNIV_EU_EFTA", "COOP_UNIV_NEU_NEFTA", "COOP_GOV_RI_NAT",  "COOP_GOV_RI_EU_EFTA", "COOP_GOV_RI_NEU_NEFTA", "COOP_PUB_CLCU_NAT", "COOP_PUB_CLCU_EU_EFTA", "COOP_PUB_CLCU_NEU_NEFTA", "COOP_NPO_NAT", "COOP_NPO_EU_EFTA", "COOP_NPO_NEU_NEFTA"))
dim(COOP_NPRV) # 391 sor és 13 oszlop

#T22
#17
TUR_EU_EFTA_NOT_ZERO <- subset(worksheet_01, TUR_EU_EFTA != 0, c("M092", "TUR_EU_EFTA"))
dim(TUR_EU_EFTA_NOT_ZERO) # 5012 sor és 2 oszlop

#18
TUR_NEU_NEFTA_NOT_ZERO <- subset(worksheet_01, TUR_NEU_NEFTA != 0, c("M092", "TUR_NEU_NEFTA"))
dim(TUR_NEU_NEFTA_NOT_ZERO) # 1595 sor és 2 oszlop

#19
TUR_NNAT <- subset(worksheet_01, TUR_EU_EFTA != 0 | TUR_NEU_NEFTA != 0, c("M092", "TUR_EU_EFTA", "TUR_NEU_NEFTA"))
dim(TUR_NNAT) # 5148 sor és 3 oszlop

#20
TUR_NAT_NOT_ZERO <- subset(worksheet_01, TUR_NAT != 0, c("M092", "TUR_NAT"))
dim(TUR_NAT_NOT_ZERO) # 7352 sor és 2 oszlop

#21
TUR_ONAT <- subset(worksheet_01, TUR_NAT != 0 & TUR_EU_EFTA == 0 & TUR_NEU_NEFTA == 0, c("M092", "TUR_NAT", "TUR_EU_EFTA", "TUR_NEU_NEFTA"))
dim(TUR_ONAT) # 2641 sor és 4 oszlop

#69
ENT_EU_EFTA <- subset(worksheet_01, TUR_EU_EFTA != 0, c("M092", "TUR_EU_EFTA"))
dim(ENT_EU_EFTA) # 5012 sor és 2 oszlop

#70
ENT_NEU_NEFTA <- subset(worksheet_01, TUR_NEU_NEFTA != 0, c("M092", "TUR_NEU_NEFTA"))
dim(ENT_NEU_NEFTA) # 1595 sor és 2 oszlop

#71
ENT_NNAT <- subset(worksheet_01, TUR_EU_EFTA != 0 | TUR_NEU_NEFTA != 0, c("M092", "TUR_EU_EFTA", "TUR_NEU_NEFTA"))
dim(ENT_NNAT) # 5148 sor és 3 oszlop

#72
ENT_NAT <- subset(worksheet_01, TUR_NAT != 0, c("M092", "TUR_NAT"))
dim(ENT_NAT) # 7352 sor és 2 oszlop

#73
ENT_ONAT <- subset(worksheet_01, TUR_EU_EFTA == 0 & TUR_NEU_NEFTA == 0, c("M092", "TUR_NAT", "TUR_EU_EFTA", "TUR_NEU_NEFTA"))
# TUR_NAT != 0 & 
dim(ENT_ONAT) # 2641 sor és 4 oszlop

#T24
#74
ENT_TOT_ACQ_MEBTA <- subset(worksheet_01, EXP_TOT_ACQ_MEBTA != 0, c("M092", "EXP_TOT_ACQ_MEBTA"))
dim(ENT_TOT_ACQ_MEBTA) # 6899 sor és 2 oszlop

#75
ENT_TOT_MKT <- subset(worksheet_01, EXP_TOT_MKT != 0, c("M092", "EXP_TOT_MKT"))
dim(ENT_TOT_MKT) # 4139 sor és 2 oszlop

#76
ENT_TOT_TNG <- subset(worksheet_01, EXP_TOT_TNG != 0, c("M092", "EXP_TOT_TNG"))
dim(ENT_TOT_TNG) # 4338 sor és 2 oszlop

#77
ENT_TOT_PRD_DESG <- subset(worksheet_01, EXP_TOT_PRD_DESG != 0, c("M092", "EXP_TOT_PRD_DESG"))
dim(ENT_TOT_PRD_DESG) # 740 sor és 2 oszlop

#78
ENT_TOT_SOFT_DBA <- subset(worksheet_01, EXP_TOT_SOFT_DBA != 0, c("M092", "EXP_TOT_SOFT_DBA"))
dim(ENT_TOT_SOFT_DBA) # 2420 sor és 2 oszlop

#79
ENT_TOT_IPR <- subset(worksheet_01, EXP_TOT_IPR != 0, c("M092", "EXP_TOT_IPR"))
dim(ENT_TOT_IPR) # 757 sor és 2 oszlop

#T26
#23
INFL_TKNOW <- subset(worksheet_01, INFL_TKNOW_NAT == 1 | INFL_TKNOW_FOR == 1, c("M092", "INFL_TKNOW_NAT", "INFL_TKNOW_FOR"))
dim(INFL_TKNOW) # 2288 sor és 3 oszlop

#24
INFL_FINRES <- subset(worksheet_01, INFL_FINRES_NAT == 1 | INFL_FINRES_FOR == 1, c("M092", "INFL_FINRES_NAT", "INFL_FINRES_FOR"))
dim(INFL_FINRES) # 2239 sor és 3 oszlop

#25
INFL_PER <- subset(worksheet_01, INFL_PER_NAT == 1 | INFL_PER_FOR == 1, c("M092", "INFL_PER_NAT", "INFL_PER_FOR"))
dim(INFL_PER) # 2278 sor és 3 oszlop

#26
INFL_SOURC <- subset(worksheet_01, INFL_SOURC_NAT == 1 | INFL_SOURC_FOR == 1, c("M092", "INFL_SOURC_NAT", "INFL_SOURC_FOR"))
dim(INFL_SOURC) # 2293 sor és 3 oszlop

#27
OUTFL_TKNOW <- subset(worksheet_01, OUTFL_TKNOW_NAT == 1 | OUTFL_TKNOW_FOR == 1, c("M092", "OUTFL_TKNOW_NAT", "OUTFL_TKNOW_FOR"))
dim(OUTFL_TKNOW) # 2297 sor és 3 oszlop

#28
OUTFL_FINRES <- subset(worksheet_01, OUTFL_FINRES_NAT == 1 | OUTFL_FINRES_FOR == 1, c("M092", "OUTFL_FINRES_NAT", "OUTFL_FINRES_FOR"))
dim(OUTFL_FINRES) # 2296 sor és 3 oszlop

#29
OUTFL_PER <- subset(worksheet_01, OUTFL_PER_NAT == 1 | OUTFL_PER_FOR == 1, c("M092", "OUTFL_PER_NAT", "OUTFL_PER_FOR"))
dim(OUTFL_PER) # 2304 sor és 3 oszlop

#30
OUTFL_SOURC <- subset(worksheet_01, OUTFL_SOURC_NAT == 1 | OUTFL_SOURC_FOR == 1, c("M092", "OUTFL_SOURC_NAT", "OUTFL_SOURC_FOR"))
dim(OUTFL_SOURC) # 2313 sor és 3 oszlop

#T32
REAS_NMINN_RESC_OTH <- subset(worksheet_01, REAS_NMINN_RESC == 1 | REAS_NMINN_OTH == 1, c("M092", "REAS_NMINN_RESC", "REAS_NMINN_OTH"))
dim(REAS_NMINN_RESC_OTH) # 1881 sor és 3 oszlop

REAS_NINN_RESC_OTH <- subset(worksheet_01, REAS_NINN_RESC == 1 | REAS_NINN_OTH == 1, c("M092", "REAS_NINN_RESC", "REAS_NINN_OTH"))
dim(REAS_NINN_RESC_OTH) # 1607 sor és 3 oszlop

#T1 pót
INN_ITR <- subset(worksheet_01[order(worksheet_01$M065_RETEG1, worksheet_01$M0581_2J), ], (INNO_PRD_GD == 1 | INNO_PRD_SERV == 1) | (INNO_PCS_PRD == 1 | INNO_PCS_LOG == 1 | INNO_PCS_COMM == 1 | INNO_PCS_ACCT == 1 | INNO_PCS_OPROC_EXTREL == 1 | INNO_PCS_WR_DEC_HRM == 1 | INNO_PCS_SLS_SERV == 1))
dim(INN_ITR) # 2769 sor és 321 oszlop


