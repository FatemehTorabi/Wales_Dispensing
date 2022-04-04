SELECT DISTINCT YR, MNTH, sum(TOTaL_ITEMS) TOT FROM 
(
			SELECT DISTINCT YEAR(DT_PRESCRIBED) YR ,month(Dt_prescribed) MNTH , LEFT(BNF_COMBINED, 2) BNF, 
			COUNT(*) TOTAL_ITEMS
			FROM 
			--Ensuring the duplication of row counts due to descriptions are not coming through-> only selecting columns in need
			(		
				SELECT DISTINCT ALF_E , DT_PRESCRIBED , DMDCODE_PRESCRIBED , PRODUCT_PRESCRIBED , BNF_COMBINED 
				FROM
				SAILW0911V.RRDA_WDDS_20210825
				WHERE 
				YEAR(DT_PRESCRIBED) IN ('2016','2017','2018','2019','2020','2021')
				AND 
				DT_PRESCRIBED <= CURRENT DATE 
				AND 
				alf_e IS NOT NULL 

			)		
			GROUP BY 
			YEAR(DT_PRESCRIBED), LEFT(BNF_COMBINED ,2),month(Dt_prescribed)
)GROUP BY YR, MNTH
ORDER BY YR, MNTH;