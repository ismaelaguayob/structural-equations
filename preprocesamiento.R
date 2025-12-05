# Because of the GitHub size limit, preprocessing of the PISA database was conducted. The code is bellow.
# This code would be reproducible if you download the database in SPSS format from the OECD webpage 
# (https://www.oecd.org/en/data/datasets/pisa-2022-database.html#data) and put it in the raw data folder.

pacman::p_load(dplyr, haven)
options(scipen = 999)
rm(list = ls())

pisa22 <- read_sav("input/data/raw_data/CY08MSP_STU_QQQ.SAV")

#Filter only countries that have applied the ICT questionnarie and the ICT and sociodemographic variables. 
pisa22 <- pisa22 %>%
  filter(Option_ICTQ == 1) %>%
  select(CNT, CNTRYID, CNTSCHID, CNTSTUID, W_FSTUWT, SENWT, ESCS, SDLEFF, ST001D01T, ST004D01T, starts_with("ST322"), ST337Q08JA, ST338Q08JA, starts_with("IC"), starts_with("ST355"))

saveRDS(pisa22, "input/data/proc_data/pisa22ict.rds")


library(pacman)
pacman::p_load(dplyr, haven)
rm(list = ls())
pisa22 <- readRDS("input/data/proc_data/pisa22ict.rds")
pisa22_proc <- pisa22 %>%
  select(CNT, sex = ST004D01T, ESCS, SDLEFF, ICTWKEND, ICTHOME, IC183Q01JA, IC183Q02JA, IC183Q03JA, IC183Q04JA,
         IC183Q05JA, IC183Q07JA, IC183Q08JA, IC183Q09JA, IC183Q10JA,
         IC183Q12JA, IC183Q13JA, IC183Q14JA, IC183Q15JA, IC183Q16JA, starts_with("IC174"), starts_with("ST355"), starts_with("IC178"), starts_with("IC171"))

#Elimiar respuesta no sabe
pisa22_proc$IC183Q01JA[pisa22_proc$IC183Q01JA==5]<-NA
pisa22_proc$IC183Q02JA[pisa22_proc$IC183Q02JA==5]<-NA
pisa22_proc$IC183Q03JA[pisa22_proc$IC183Q03JA==5]<-NA
pisa22_proc$IC183Q04JA[pisa22_proc$IC183Q04JA==5]<-NA
pisa22_proc$IC183Q05JA[pisa22_proc$IC183Q05JA==5]<-NA
pisa22_proc$IC183Q07JA[pisa22_proc$IC183Q07JA==5]<-NA
pisa22_proc$IC183Q08JA[pisa22_proc$IC183Q08JA==5]<-NA
pisa22_proc$IC183Q09JA[pisa22_proc$IC183Q09JA==5]<-NA
pisa22_proc$IC183Q10JA[pisa22_proc$IC183Q10JA==5]<-NA
pisa22_proc$IC183Q12JA[pisa22_proc$IC183Q12JA==5]<-NA
pisa22_proc$IC183Q13JA[pisa22_proc$IC183Q13JA==5]<-NA
pisa22_proc$IC183Q14JA[pisa22_proc$IC183Q14JA==5]<-NA
pisa22_proc$IC183Q15JA[pisa22_proc$IC183Q15JA==5]<-NA
pisa22_proc$IC183Q16JA[pisa22_proc$IC183Q16JA==5]<-NA

# Recodear 6 a 0 en IC171

pisa22_proc$IC171Q01JA[pisa22_proc$IC171Q01JA==6]<-0
pisa22_proc$IC171Q02JA[pisa22_proc$IC171Q02JA==6]<-0
pisa22_proc$IC171Q03JA[pisa22_proc$IC171Q03JA==6]<-0
pisa22_proc$IC171Q04JA[pisa22_proc$IC171Q04JA==6]<-0
pisa22_proc$IC171Q05JA[pisa22_proc$IC171Q05JA==6]<-0
pisa22_proc$IC171Q06JA[pisa22_proc$IC171Q06JA==6]<-0

pisa22_proc <- pisa22_proc %>% rename("search_info"=IC183Q01JA,
                                      "evaluate_info"=IC183Q02JA,
                                      "share_content"=IC183Q03JA,
                                      "pair_collab"=IC183Q04JA,
                                      "explain_content"=IC183Q05JA,
                                      "write_text"=IC183Q07JA,
                                      "collect_data"=IC183Q08JA,
                                      "create_media"=IC183Q09JA,
                                      "develop_webpage"=IC183Q10JA,
                                      "change_settings"=IC183Q12JA,
                                      "identify_app"=IC183Q13JA,
                                      "programming"=IC183Q14JA,
                                      "identify_error"=IC183Q15JA,
                                      "logical_solution"=IC183Q16JA)

pisa22_proc$sex <- haven::as_factor(pisa22_proc$sex)

saveRDS(pisa22_proc, "input/data/proc_data/pisa22_proc_2.rds")

