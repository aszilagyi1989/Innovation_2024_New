library("openxlsx")
library("tidytable")

worksheet_01 <- read.xlsx(paste0(getwd(), "/Excel_Files/", "VEGTABLA_CIS2024_v2_marc26.xlsx"), sheet = "Munka1") # Teszt állomány/ VEGTABLA_CIS2024_v1.xlsx
dim(worksheet_01) # 7779 sor és 321 oszlop
#View(worksheet_01)

nrow(worksheet_01 %>% filter(M065_RETEG1 == "BI")) # 656
nrow(worksheet_01 %>% filter(M065_RETEG1 == "KO")) # 1965
nrow(worksheet_01 %>% filter(M065_RETEG1 == "KI")) # 5158

colnames(worksheet_01) <- trimws(colnames(worksheet_01)) # Szóközök eltűntetése az oszlopnevek elejéről és végéről
colnames(worksheet_01) <- gsub(" ", "", colnames(worksheet_01)) # Szóközök eltűntetése az oszlopnevek közepéről pl.: COND_GOUT _AF és ECO_ENO _NSG
#Utóbbi nem sikerült, mert pont lett, ezért:
#colnames(worksheet_01)[41] <- "COND_GOUT_AF"


unique(worksheet_01$M065_RETEG1)
unique(worksheet_01$M0581_2J)
#str(worksheet_01, list.len = 100)
options(max.print = 7779)
unique(worksheet_01$M092)

nrow(worksheet_01 %>% filter(is.na(TOVT) == TRUE)) # 0 cég üres TOVT értékkel szerepelt
nrow(worksheet_01 %>% filter(is.na(EMPL) == TRUE))
nrow(worksheet_01 %>% filter(is.na(VGMA001_SULY) == TRUE))
