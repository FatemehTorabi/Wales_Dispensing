---------------------------------------------------
--Project: 0911
--By: fatemeh.torabi@swansea.ac.uk
--Aim: checks on all imported refrence tables for monthly mappings
---------------------------------------------------

SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202008;	
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202010;	
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202011;	
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202012;	
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202101;	
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202104;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202105;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202106;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202107;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202108;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202109;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202110;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202111;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202112;
SELECT COUNT(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202201;

--ADD ANY NEW existing extracts

---------------------------------------------------
--COMBINED 
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20210831; --UP TO August 2021
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20210731; --UP TO July 2021
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20210630; --UP TO June 2021
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20210531; --UP TO May 2021
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20210101; --UP TO JAN 2021
SELECT COUNT(*), count(DISTINCT bnf_cd) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20201230; --UP TO DEC 2020


--NOTE: 
--IF THE ABOVE CODES HAVE BEEN UPDATED AND A NEW MERGED REFERENCE TABLE IS TO BE GENERATED
--END DATE AT THE END SHOULD GET UPDATED TO YYYYMMDD OF MOST RECENT VERSION OF ABOVE TABLES

CREATE TABLE SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20220126 --**UPDATE**-- THE END DATE BASED ON RELEASE DATE
AS 
(
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202008 	
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202010 	
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202011			
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202012
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202101
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202104 
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202105
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202106
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')			
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202107
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202108
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')			
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202109
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202110
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202111
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_code cnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202112
		WHERE DMD IS NOT NULL AND  BNF_CoDe NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_code cnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 		
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202201
		WHERE DMD IS NOT NULL AND  BNF_CoDe NOT IN (' ')
		--**UPDATE**-- ADD NEW TABLES IN:
		/*
	 	UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_NEWDATE
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')
		 */
)WITH NO DATA; 

INSERT INTO SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED_20220126 --**UPDATE**-- THE END DATE BASED ON RELEASE DATE
	SELECT DISTINCT * FROM 
		(
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202008 	
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202010 	
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202011			
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202012
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202101
		WHERE SNOMED_CD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202104 
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202105
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')		
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202106
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')			
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202107
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202108
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')				
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202109
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')			
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202110
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202111
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_code cnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202112
		WHERE DMD IS NOT NULL AND  BNF_CoDe NOT IN (' ')	
		UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_code cnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 		
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_202201
		WHERE DMD IS NOT NULL AND  BNF_CoDe NOT IN (' ')		
		--**UPDATE**-- ADD NEW TABLES IN:
		/*
	 	UNION 
		SELECT DISTINCT presentation_pack, TYPE, bnf_cd, bnf_name, DMD snomed_cd, dmd_product_desc, strength, unit_of_measure, dmd_product_and_pack_desc, pack, sub_pack 
		FROM 
		SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_NEWDATE
		WHERE DMD IS NOT NULL AND  BNF_CD NOT IN (' ')
		*/
		);

COMMIT;

