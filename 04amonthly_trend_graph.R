
library(RODBC);
library (Cairo);
library (lattice);
library (getopt);
library(dplyr)
library(psych)
library(rmarkdown)
library(tidyverse)
library(knitr)
library(ggplot2)
library(ggthemes)

#working directory
setwd("P:/torabif/workspace/RRDA_WDDS")

#Include the file login_box.r in your project. You may have to include the full
#path to the file depending on how R is configured.
#obtain the longin_box file either via wiki or ask any member of the team

source("S:/0000 - Analysts Shared Resources/r-share/login_box.r");

#Get the login info, using 'yourUsername' as username.

login = getLogin();

#Connect and get the database
sql = odbcConnect('PR_SAIL',login[1],login[2]);
login = 0 # this will make your password anonymous

####################################################
####Fig 1: 
####################################################

BNF.ALL.ITEM<-sqlQuery(sql,"
SELECT * FROM 
(
	--2020/21: 
	SELECT DISTINCT A.YR, MNTH,
		CASE 
		WHEN A.MNTH=1 THEN 'Jan'
		WHEN A.MNTH=2 THEN 'Feb'
		WHEN A.MNTH=3 THEN 'Mar'
		WHEN A.MNTH=4 THEN 'Apr'
		WHEN A.MNTH=5 THEN 'May'
		WHEN A.MNTH=6 THEN 'Jun'
		WHEN A.MNTH=7 THEN 'Jul'
		WHEN A.MNTH=8 THEN 'Aug'
		WHEN A.MNTH=9 THEN 'Sep'
		WHEN A.MNTH=10 THEN 'Oct'
		WHEN A.MNTH=11 THEN 'Nov'
		WHEN A.MNTH=12 THEN 'Dec'
		END AS MNTHS 
		, A.BNF, B.BNF_CHAPTER , A.TOTAL_ITEMS 
	FROM 
		(
			SELECT DISTINCT YEAR(DT_PRESCRIBED) YR ,month(Dt_prescribed) MNTH , LEFT(BNF_COMBINED, 2) BNF, 
			COUNT(*) TOTAL_ITEMS
			FROM 
			--Ensuring the duplication of row counts due to descriptions are not coming through-> only selecting columns in need
			(		
				SELECT DISTINCT ALF_E , DT_PRESCRIBED , DMDCODE_PRESCRIBED , PRODUCT_PRESCRIBED , BNF_COMBINED 
				FROM
				SAILW0911V.RRDA_WDDS
				WHERE 
				YEAR(DT_PRESCRIBED) IN ('2016','2017','2018','2019','2020','2021')
				AND 
				DT_PRESCRIBED <= CURRENT DATE 
				AND 
				alf_e IS NOT NULL 

			)		
			GROUP BY 
			YEAR(DT_PRESCRIBED), LEFT(BNF_COMBINED ,2),month(Dt_prescribed)
		) A 
	LEFT JOIN 		
	SAILUKHDV.BNF_BNF_CODE_INFORMATION_SCD B 
	ON 
	A.BNF=B.BNF_CHAPTER_CODE
)
WHERE total_items > 10
AND 
--duplicated chapter names excluded
BNF_CHAPTER <> 'Immunological Products and Vaccines'
AND
BNF_CHAPTER <> 'Ear, Nose And Oropharynx'
AND
BNF_CHAPTER <> 'Malignant Disease and Immunosuppression'
AND
BNF_CHAPTER <> 'Musculoskeletal and Joint Diseases'
AND 
BNF_CHAPTER <> 'Nutrition And Blood'
AND 
BNF_CHAPTER <> 'Obstetrics, Gynaecology and Urinary-Trac'
AND 
BNF_CHAPTER <> 'Other Drugs And Preparations'
ORDER BY 
bnf, mnth;
")


BNF<-BNF.ALL.ITEM

BNF$MNTHS <- factor(BNF$MNTHS,levels = c("Jan","Feb","Mar","Apr", "May", "Jun","Jul","Aug","Sep", "Oct", "Nov", "Dec"))


library(ggplot2)
library(ggthemes)

ALLH<-ggplot(BNF, aes(x=MNTHS, y= TOTAL_ITEMS, group = YR, colour=factor(YR)))+     geom_line(size=1)+
  labs(color="Year", size=20)+
  guides(alpha = FALSE) +
  facet_wrap(.~BNF_CHAPTER, scales="free")+
  xlab("Month of dispensed")+
  ylab("Total dispensed items")+
  scale_x_discrete()+
  theme_calc()+
  scale_color_manual(values = c("2016"="#B1CAD2","2017"="#FFDB99","2018"="#45B0AD" ,"2019" ="#AFDD7E", "2020"="#296EB4","2021"="#7F0000"))+
  geom_vline(xintercept = as.numeric(3.7),linetype = "dotted", color = "purple", size = 1.0)+
  annotate("text", x = as.numeric(5.5), y = as.numeric(100000), label = "National Lockdown (23/03/20)", colour = "purple", size = 2.5)+
  scale_y_continuous(labels = function(x) format(x,scientific = FALSE))

ALLH

ggsave(filename="Figures/Fig1-all_20211026.png", plot=ALLH, device= "png",height = 30, width=40, units="cm", dpi=300)


BNF <- BNF %>% 
      filter(BNF_CHAPTER=="Cardiovascular System")

CVD<-ggplot(BNF, aes(x=MNTHS, y= TOTAL_ITEMS, group = YR, colour=factor(YR)))+     geom_line(size=1)+
  labs(color="Year", size=20)+
  guides(alpha = FALSE) +
  facet_wrap(.~BNF_CHAPTER, scales="free")+
  xlab("Month of dispensed")+
  ylab("Total dispensed items")+
  scale_x_discrete()+
  theme_calc()+
  scale_color_manual(values = c("2016"="#B1CAD2","2017"="#FFDB99","2018"="#45B0AD" ,"2019" ="#AFDD7E", "2020"="#296EB4","2021"="#7F0000"))+
  geom_vline(xintercept = as.numeric(3.7),linetype = "dotted", color = "purple", size = 1.0)+
  annotate("text", x = as.numeric(5.5), y = as.numeric(100000), label = "National Lockdown (23/03/20)", colour = "purple", size = 2.5)+
  scale_y_continuous(labels = function(x) format(x,scientific = FALSE))

CVD

ggsave(filename="Figures/Fig2-CVD_20211026.png", plot=CVD, device= "png",height = 15, width=20, units="cm", dpi=300)


