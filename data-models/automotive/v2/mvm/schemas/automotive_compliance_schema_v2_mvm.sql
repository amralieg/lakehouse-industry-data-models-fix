-- Schema for Domain: compliance | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`compliance` COMMENT 'Regulatory compliance and homologation management across all global markets. Owns CAFE (Corporate Average Fuel Economy) reporting, EPA/CARB emissions certifications, NHTSA FMVSS homologation records, WLTP/Euro NCAP test submissions, UNECE type approvals, and recall regulatory filings. Manages compliance testing, certification documentation, regulatory submissions, and audit trails. Ensures adherence to environmental, safety, and trade regulations across jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` (
    `homologation_record_id` BIGINT COMMENT 'Homologation Record Id',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Type approval / homologation is granted for a specific BOM configuration in automotive. Regulators approve the exact bill-of-materials variant. This FK enables traceability from homologation approval ',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `regulatory_body_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_body. Business justification: A homologation record is issued or recognized by a specific regulatory body (e.g., UNECE for international type approvals, EU national authorities for EU type approvals, Transport Canada). This FK lin',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: A homologation record certifies compliance with a specific regulatory requirement (e.g., UNECE Regulation 100, EU Whole Vehicle Type Approval). This FK normalizes the relationship between the homologa',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Type approval / homologation is obtained per vehicle program before market launch. Compliance teams must trace each homologation record to the engineering program that defines the vehicle configuratio',
    `approval_date` DATE COMMENT 'Approval Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `eu_taxonomy_activity_code` STRING COMMENT 'EU Taxonomy economic activity code for this homologation',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `homologation_number` STRING COMMENT 'Homologation Number',
    `homologation_status` STRING COMMENT 'Homologation Status',
    `market_code` STRING COMMENT 'Market Code',
    `type_approval_category` STRING COMMENT 'Type Approval Category',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_homologation_record PRIMARY KEY(`homologation_record_id`)
) COMMENT 'Master record for vehicle type approval and homologation certifications across global markets. Captures UNECE type approval numbers, FMVSS homologation status, Euro NCAP ratings, WLTP certification references, and jurisdiction-specific approval details for each vehicle model and variant. Serves as the authoritative SSOT for all regulatory type approvals required before a vehicle can be sold in a given market.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` (
    `emissions_certification_id` BIGINT COMMENT 'Compliance Emissions Certification Id',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Emissions certification (EPA, Euro 6, etc.) is granted for a specific powertrain/BOM configuration. Product engineers must know which BOM revision holds a valid emissions certificate before releasing ',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: EPA and CARB emissions certificates are issued for specific vehicle configurations. The model-level link is insufficient; compliance engineers must validate which exact configurations hold valid emiss',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: EPA/CARB emissions certifications are issued per engine family and powertrain variant. Regulatory submissions reference the specific powertrain tested. Compliance teams need this link to track which p',
    `regulatory_body_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_body. Business justification: An emissions certification is issued by a specific certifying authority (EPA, CARB, EU type approval authority). The existing `certifying_authority` column is a denormalized text field capturing the a',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: An emissions certification is issued to certify compliance with a specific regulatory requirement (e.g., EPA Tier 3, Euro 6d, CARB LEV III). This FK links the certification to the governing standard i',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Emissions certifications are issued per vehicle programs powertrain and emission standard configuration. Regulatory reporting (e.g., EU CO2 fleet targets, EPA compliance) requires linking certified e',
    `carbon_credit_eligible` BOOLEAN COMMENT 'Whether certification qualifies for carbon credits',
    `certificate_number` STRING COMMENT '',
    `certification_date` DATE COMMENT 'Certification Date',
    `certification_number` STRING COMMENT 'Certification Number',
    `certification_status` STRING COMMENT 'Certification Status',
    `certified_co2_g_per_km` DECIMAL(18,2) COMMENT '',
    `co2_emissions_g_per_km` DECIMAL(18,2) COMMENT '',
    `co2_g_per_km` DECIMAL(18,2) COMMENT 'Co2 G Per Km',
    `compliance_emissions_certification_description` STRING COMMENT 'Description of the entity',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `emission_standard` STRING COMMENT 'Emission Standard',
    `esg_reporting_framework` STRING COMMENT 'Applicable ESG framework (CSRD, EU Taxonomy)',
    `eu_taxonomy_eligible_flag` BOOLEAN COMMENT 'Whether this certification qualifies under EU Taxonomy',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `fuel_type` STRING COMMENT 'Fuel Type',
    `issue_date` DATE COMMENT '',
    `nox_mg_per_km` DECIMAL(18,2) COMMENT 'Nox Mg Per Km',
    `pm_mg_per_km` DECIMAL(18,2) COMMENT 'Pm Mg Per Km',
    `powertrain_type` STRING COMMENT 'Powertrain Type',
    `test_cycle` STRING COMMENT 'Test Cycle',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_emissions_certification PRIMARY KEY(`emissions_certification_id`)
) COMMENT 'Master record for EPA, CARB, and Euro 6/7 emissions certifications issued for specific vehicle configurations and powertrain variants. Tracks certification number, applicable standard (EPA Tier 3, CARB LEV III, Euro 6d), test cycle (WLTP, FTP-75, US06), certification date, expiry, and compliance status. Covers ICE, HEV, PHEV, and EV powertrain types. Links to the specific engine family and vehicle model year program. SUPERSEDED: Use vehicle.vehicle_emissions_certification as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Regulatory Submission Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to engineering.milestone. Business justification: Regulatory submissions have hard due dates tied to vehicle program milestones (e.g., SOP, Job 1, market launch gate). Linking regulatory_submission to the triggering engineering milestone enables prog',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: CAFE fuel economy compliance submissions, annual safety standard filings, and market authorization submissions are filed per vehicle model. Compliance teams need to link regulatory submissions to the ',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Regulatory submissions are frequently filed in the context of a recall campaign (e.g., NHTSA recall filings, amendments, status updates). Multiple submissions can be made for a single recall campaign ',
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Regulatory submissions (type approval, homologation dossiers, emissions filings) are made per vehicle program for specific markets. Program managers and compliance teams need to track all submissions ',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `regulatory_submission_description` STRING COMMENT 'Description',
    `due_date` DATE COMMENT 'Due Date',
    `esg_submission_type` STRING COMMENT 'Type of ESG regulatory submission',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `submission_date` DATE COMMENT 'Submission Date',
    `submission_number` STRING COMMENT 'Submission Number',
    `submission_status` STRING COMMENT 'Submission Status',
    `submission_type` STRING COMMENT 'Submission Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record for each formal regulatory submission made to a governing body (NHTSA, EPA, CARB, UNECE, Euro NCAP, DOT). Captures submission type (type approval application, certificate of conformity, recall notice, CAFE report, safety standard compliance report), submission date, regulatory body, submission reference number, status (submitted, acknowledged, approved, rejected, under review), and responsible compliance officer. Central audit trail for all outbound regulatory filings.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` (
    `recall_campaign_id` BIGINT COMMENT 'Recall Campaign Id',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: FMEA records are the primary engineering root-cause artifact for recall investigations. NHTSA and other regulators require OEMs to demonstrate that the failure mode, severity, and detection ratings fr',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Recall campaigns are jurisdiction-specific regulatory actions — a US NHTSA recall is distinct from a European recall under EU regulations, and from a Canadian Transport Canada recall. This FK links th',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: NHTSA and global recall campaigns are filed against specific vehicle models. Compliance teams must identify which model a recall applies to for remedy planning, affected unit count validation, and reg',
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Recall campaigns affect vehicles produced under specific vehicle programs. Linking recall_campaign to vehicle_program enables engineering teams to assess program-level recall exposure, cost impact, an',
    `affected_unit_count` STRING COMMENT '',
    `affected_vehicles_count` STRING COMMENT 'Affected Vehicles Count',
    `campaign_code` STRING COMMENT '',
    `campaign_description` STRING COMMENT '',
    `campaign_number` STRING COMMENT '',
    `campaign_status` STRING COMMENT '',
    `campaign_title` STRING COMMENT '',
    `completion_rate` DECIMAL(18,2) COMMENT '',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Completion Rate Percent',
    `completion_target_date` DATE COMMENT 'Completion Target Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `defect_description` STRING COMMENT 'Defect Description',
    `recall_campaign_description` STRING COMMENT 'Description of the entity',
    `environmental_impact_flag` BOOLEAN COMMENT 'Whether the recall has environmental/emissions impact',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated Cost',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `initiation_date` DATE COMMENT 'Initiation Date',
    `launch_date` DATE COMMENT '',
    `nhtsa_campaign_number` STRING COMMENT 'Nhtsa Campaign Number',
    `recall_description` STRING COMMENT '',
    `recall_number` STRING COMMENT 'Recall Number',
    `recall_status` STRING COMMENT 'Recall Status',
    `recall_title` STRING COMMENT 'Recall Title',
    `remedy_description` STRING COMMENT 'Remedy Description',
    `safety_risk_description` STRING COMMENT 'Safety Risk Description',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_recall_campaign PRIMARY KEY(`recall_campaign_id`)
) COMMENT 'Master record for NHTSA safety recall campaigns and OEM-initiated service campaigns. Captures NHTSA recall number, campaign type (safety recall, emissions recall, OEM voluntary service campaign), defect description, affected population (VIN range, model year, nameplate), remedy description, campaign open date, remedy availability date, and campaign closure status. Serves as the compliance SSOT for recall management, distinct from aftersales.recall_completion which tracks dealer-level execution.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `regulatory_requirement_description` STRING COMMENT 'Description',
    `effective_date` DATE COMMENT 'Effective Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `requirement_category` STRING COMMENT 'Requirement Category',
    `requirement_code` STRING COMMENT 'Requirement Code',
    `requirement_status` STRING COMMENT 'Requirement Status',
    `requirement_title` STRING COMMENT 'Requirement Title',
    `sunset_date` DATE COMMENT 'Sunset Date',
    `sustainability_relevance_flag` BOOLEAN COMMENT 'Whether this requirement is relevant to sustainability/ESG reporting',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Reference master defining all applicable regulatory requirements and standards that Automotive must comply with across jurisdictions. Captures regulation name, issuing body (NHTSA, EPA, CARB, UNECE, IATF, ISO), regulation code (e.g., FMVSS 208, ECE R94, Euro 6d), effective date, applicability scope (market, vehicle category, powertrain type), compliance deadline, and current status (active, superseded, proposed). Serves as the regulatory obligation register.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `parent_jurisdiction_id` BIGINT COMMENT 'Parent Jurisdiction Id',
    `jurisdiction_code` STRING COMMENT 'Jurisdiction Code',
    `country_code` STRING COMMENT 'Country Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_regulatory_framework` STRING COMMENT 'Applicable ESG regulatory framework in this jurisdiction',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `jurisdiction_type` STRING COMMENT 'Jurisdiction Type',
    `jurisdiction_name` STRING COMMENT 'Jurisdiction Name',
    `region` STRING COMMENT 'Region',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference master for regulatory jurisdictions in which Automotive operates and sells vehicles. Captures jurisdiction name, jurisdiction type (federal, state, national, supranational), country or region code, primary regulatory body, applicable emissions standard tier, applicable safety standard framework, and market entry requirements. Used to map vehicles and certifications to the correct regulatory regime for each sales market.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` (
    `fmvss_certification_id` BIGINT COMMENT 'Fmvss Certification Id',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: FMVSS certification is issued for a specific vehicle configuration defined by its BOM. US regulatory compliance requires tracing which BOM configuration passed FMVSS testing. Without this FK, engineer',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: FMVSS self-certification applies to specific vehicle configurations (e.g., FMVSS 208 airbag requirements vary by body style and powertrain). Compliance records must reference the certified configurati',
    `model_id` BIGINT COMMENT 'Model Id',
    `regulatory_body_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_body. Business justification: FMVSS certifications, while self-certified by the OEM, are filed with and overseen by NHTSA. This FK links the FMVSS certification to the governing regulatory body (NHTSA) in the regulatory_body maste',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: FMVSS certifications are self-certifications against specific FMVSS standards defined in the regulatory_requirement master. This FK is CRITICAL for eliminating the fmvss_certification silo — without i',
    `certification_date` DATE COMMENT 'Certification Date',
    `certification_status` STRING COMMENT 'Certification Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `emissions_related_flag` BOOLEAN COMMENT 'Whether this FMVSS certification has emissions implications',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `model_year` STRING COMMENT 'Model Year',
    `test_report_reference` STRING COMMENT 'Test Report Reference',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_fmvss_certification PRIMARY KEY(`fmvss_certification_id`)
) COMMENT 'Master record for Federal Motor Vehicle Safety Standard (FMVSS) self-certification records maintained by Automotive as required by NHTSA. Captures FMVSS standard number (e.g., FMVSS 208 Occupant Crash Protection, FMVSS 126 ESC, FMVSS 138 TPMS), vehicle model and model year, certification basis (self-certification), test evidence reference, certification date, and responsible certifying engineer. Supports NHTSA audit readiness and recall root-cause traceability.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` (
    `recall_defect_report_id` BIGINT COMMENT 'Recall Defect Report Id',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Recall defect reports document the specific failure mode identified in field incidents. Linking to fmea_record provides the engineering root-cause analysis that substantiates the defect. failure_mode ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Recall defect reports identify the specific component/part involved in the defect. Linking to part_master enables part-level recall traceability, supplier identification, and BOM impact analysis. comp',
    `product_bom_line_id` BIGINT COMMENT 'Foreign key linking to product.product_bom_line. Business justification: Recall defect reports identify the specific component/part that failed. component_affected is a free-text denormalization of the BOM line item. Replacing it with a FK to product_bom_line enables str',
    `recall_campaign_id` BIGINT COMMENT 'Recall Campaign Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `defect_category` STRING COMMENT 'Defect Category',
    `environmental_hazard_flag` BOOLEAN COMMENT 'Whether the defect poses an environmental hazard',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `incidents_reported` STRING COMMENT 'Incidents Reported',
    `injuries_reported` STRING COMMENT 'Injuries Reported',
    `report_date` DATE COMMENT 'Report Date',
    `report_number` STRING COMMENT 'Report Number',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_recall_defect_report PRIMARY KEY(`recall_defect_report_id`)
) COMMENT 'Transactional record for Early Warning Reporting (EWR) and defect investigation reports submitted to or received from NHTSA. Captures report type (EWR quarterly report, Part 579 defect report, consumer complaint aggregate, field report), reporting period, defect category (safety, emissions, structural), number of incidents reported, injury/fatality count, investigation status, and NHTSA investigation number if opened. Supports 49 CFR Part 579 Early Warning Reporting obligations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` (
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `body_code` STRING COMMENT 'Body Code',
    `body_name` STRING COMMENT 'Body Name',
    `body_type` STRING COMMENT 'Body Type',
    `country_code` STRING COMMENT 'Country Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_oversight_scope` STRING COMMENT 'Scope of ESG oversight by this regulatory body',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `website_url` STRING COMMENT 'Website Url',
    CONSTRAINT pk_regulatory_body PRIMARY KEY(`regulatory_body_id`)
) COMMENT 'Master reference table for regulatory_body. Referenced by regulatory_body_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ADD CONSTRAINT `fk_compliance_emissions_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ADD CONSTRAINT `fk_compliance_fmvss_certification_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ADD CONSTRAINT `fk_compliance_fmvss_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ADD CONSTRAINT `fk_compliance_recall_defect_report_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ADD CONSTRAINT `fk_compliance_regulatory_body_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_automotive_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` SET TAGS ('dbx_subdomain' = 'vehicle_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `regulatory_body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `eu_taxonomy_activity_code` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Activity Code');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` SET TAGS ('dbx_subdomain' = 'vehicle_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `regulatory_body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `carbon_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credit Eligible');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `esg_reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Framework');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_certification` ALTER COLUMN `eu_taxonomy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Eligible');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `esg_submission_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Submission Type');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` SET TAGS ('dbx_subdomain' = 'safety_recalls');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `sustainability_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Relevance');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ALTER COLUMN `esg_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Regulatory Framework');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` SET TAGS ('dbx_subdomain' = 'vehicle_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `regulatory_body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `emissions_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Related');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` SET TAGS ('dbx_subdomain' = 'safety_recalls');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `environmental_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazard');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ALTER COLUMN `esg_oversight_scope` SET TAGS ('dbx_business_glossary_term' = 'ESG Oversight Scope');
