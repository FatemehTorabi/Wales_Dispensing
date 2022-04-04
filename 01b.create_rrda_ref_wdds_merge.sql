---------------------------------------------------
--Project: 0911
--By: fatemeh.torabi@swansea.ac.uk
--Aim: checks on all imported refrence tables for monthly mappings
---------------------------------------------------
--NOTE: 
--The undated table includes the code used to generate the undated RRDA = most recent version

TRUNCATE TABLE SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED IMMEDIATE;


INSERT INTO SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED
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

SELECT count(*) FROM SAILW0911V.RRDA_WDDS_REF_BNF_SNOMED_MERGED;