-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`compliance` COMMENT 'Regulatory compliance and homologation management across all global markets. Owns CAFE (Corporate Average Fuel Economy) reporting, EPA/CARB emissions certifications, NHTSA FMVSS homologation records, WLTP/Euro NCAP test submissions, UNECE type approvals, and recall regulatory filings. Manages compliance testing, certification documentation, regulatory submissions, and audit trails. Ensures adherence to environmental, safety, and trade regulations across jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` (
    `homologation_record_id` BIGINT COMMENT 'Homologation Record Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `approval_date` DATE COMMENT 'Approval Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `eu_taxonomy_activity_code` STRING COMMENT 'EU Taxonomy economic activity code for this homologation',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `homologation_number` STRING COMMENT 'Homologation Number',
    `homologation_status` STRING COMMENT 'Homologation Status',
    `market_code` STRING COMMENT 'Market Code',
    `regulation_reference` STRING COMMENT 'Regulation Reference',
    `type_approval_category` STRING COMMENT 'Type Approval Category',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_homologation_record PRIMARY KEY(`homologation_record_id`)
) COMMENT 'Master record for vehicle type approval and homologation certifications across global markets. Captures UNECE type approval numbers, FMVSS homologation status, Euro NCAP ratings, WLTP certification references, and jurisdiction-specific approval details for each vehicle model and variant. Serves as the authoritative SSOT for all regulatory type approvals required before a vehicle can be sold in a given market.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` (
    `compliance_emissions_certification_id` BIGINT COMMENT 'Compliance Emissions Certification Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `test_facility_id` BIGINT COMMENT 'Test Facility Id',
    `carbon_credit_eligible` BOOLEAN COMMENT 'Whether certification qualifies for carbon credits',
    `certificate_number` STRING COMMENT '',
    `certification_date` DATE COMMENT 'Certification Date',
    `certification_number` STRING COMMENT 'Certification Number',
    `certification_status` STRING COMMENT 'Certification Status',
    `certified_co2_g_per_km` DECIMAL(18,2) COMMENT '',
    `certifying_authority` STRING COMMENT '',
    `co2_emissions_g_per_km` DECIMAL(18,2) COMMENT '',
    `co2_g_per_km` DECIMAL(18,2) COMMENT 'Co2 G Per Km',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `compliance_emissions_certification_description` STRING COMMENT 'Description of the entity',
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
    CONSTRAINT pk_compliance_emissions_certification PRIMARY KEY(`compliance_emissions_certification_id`)
) COMMENT 'Master record for EPA, CARB, and Euro 6/7 emissions certifications issued for specific vehicle configurations and powertrain variants. Tracks certification number, applicable standard (EPA Tier 3, CARB LEV III, Euro 6d), test cycle (WLTP, FTP-75, US06), certification date, expiry, and compliance status. Covers ICE, HEV, PHEV, and EV powertrain types. Links to the specific engine family and vehicle model year program. SUPERSEDED: Use vehicle.vehicle_emissions_certification as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` (
    `cafe_compliance_record_id` BIGINT COMMENT 'Cafe Compliance Record Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `achieved_mpg` DECIMAL(18,2) COMMENT 'Achieved Mpg',
    `compliance_status` STRING COMMENT 'Compliance Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `credit_balance` DECIMAL(18,2) COMMENT 'Credit Balance',
    `csrd_disclosure_reference` STRING COMMENT 'Reference to CSRD disclosure requirement',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `eu_taxonomy_activity_code` STRING COMMENT 'EU Taxonomy economic activity classification',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `fleet_type` STRING COMMENT 'Fleet Type',
    `model_year` STRING COMMENT 'Model Year',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty Amount',
    `target_mpg` DECIMAL(18,2) COMMENT 'Target Mpg',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_cafe_compliance_record PRIMARY KEY(`cafe_compliance_record_id`)
) COMMENT 'Annual CAFE (Corporate Average Fuel Economy) compliance record tracking fleet-wide fuel economy performance against NHTSA-mandated standards. Captures model year, fleet type (domestic car, import car, light truck), actual achieved CAFE value (mpg), required standard, compliance gap or surplus, credit balance, and fine liability. Supports NHTSA annual CAFE reporting obligations and internal fleet mix planning.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Regulatory Submission Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
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
    `regulatory_body_id` BIGINT COMMENT 'Regulatory Body Id',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`test_event` (
    `test_event_id` BIGINT COMMENT 'Test Event Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `test_facility_id` BIGINT COMMENT 'Test Facility Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_test_protocol` STRING COMMENT 'ESG-specific test protocol reference',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `test_date` DATE COMMENT 'Test Date',
    `test_result` STRING COMMENT 'Test Result',
    `test_standard` STRING COMMENT 'Test Standard',
    `test_status` STRING COMMENT 'Test Status',
    `test_type` STRING COMMENT 'Test Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_test_event PRIMARY KEY(`test_event_id`)
) COMMENT 'Transactional record capturing each physical compliance test event conducted for regulatory certification purposes. Covers emissions testing (WLTP, FTP-75, NEDC, RDE), crash safety testing (NCAP, FMVSS), noise testing (NVH/ECE R51), and fuel economy testing. Captures test date, test facility, test type, vehicle configuration tested, test result (pass/fail/conditional), measured values, and the certifying laboratory. Links to the homologation record or emissions certification being pursued.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` (
    `compliance_test_result_id` BIGINT COMMENT 'Compliance Test Result Id',
    `test_event_id` BIGINT COMMENT 'Test Event Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_test_category` STRING COMMENT 'ESG category of the compliance test',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `limit_value` DECIMAL(18,2) COMMENT 'Limit Value',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured Value',
    `parameter_name` STRING COMMENT 'Parameter Name',
    `pass_fail_flag` BOOLEAN COMMENT 'Pass Fail Flag',
    `test_condition` STRING COMMENT 'Test Condition',
    `unit_of_measure` STRING COMMENT 'Unit Of Measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_compliance_test_result PRIMARY KEY(`compliance_test_result_id`)
) COMMENT 'Detailed test result record for each measured parameter within a compliance test event. Captures parameter name (CO2 g/km, NOx mg/km, crash deformation zone, noise dB), measured value, regulatory limit, pass/fail status, test phase (cold start, hot start, WLTP low/medium/high/extra-high), and measurement uncertainty. Enables granular traceability of test outcomes against specific regulatory thresholds for each parameter tested. SUPERSEDED: Use engineering.engineering_test_result as the single source of truth.';

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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Obligation Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `obligation_description` STRING COMMENT 'Description',
    `due_date` DATE COMMENT 'Due Date',
    `esg_obligation_type` STRING COMMENT 'Type of ESG obligation (carbon reporting, water disclosure, social audit)',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `obligation_status` STRING COMMENT 'Obligation Status',
    `obligation_type` STRING COMMENT 'Obligation Type',
    `responsible_party` STRING COMMENT 'Responsible Party',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational record linking a specific vehicle program or model year to its applicable regulatory requirements by jurisdiction. Captures the obligation status (pending, in-progress, certified, waived, non-compliant), target certification date, responsible engineering team, and associated homologation record or emissions certification. Enables compliance program managers to track which regulatory obligations are open, in-flight, or closed for each vehicle program.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` (
    `ncap_submission_id` BIGINT COMMENT 'Ncap Submission Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `test_facility_id` BIGINT COMMENT 'Test Facility Id',
    `adult_occupant_score` DECIMAL(18,2) COMMENT 'Adult Occupant Score',
    `child_occupant_score` DECIMAL(18,2) COMMENT 'Child Occupant Score',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `environmental_rating_score` DECIMAL(18,2) COMMENT 'Environmental rating score component of NCAP assessment',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `ncap_program` STRING COMMENT 'Ncap Program',
    `overall_rating` STRING COMMENT 'Overall Rating',
    `pedestrian_score` DECIMAL(18,2) COMMENT 'Pedestrian Score',
    `safety_assist_score` DECIMAL(18,2) COMMENT 'Safety Assist Score',
    `submission_status` STRING COMMENT 'Submission Status',
    `test_year` STRING COMMENT 'Test Year',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_ncap_submission PRIMARY KEY(`ncap_submission_id`)
) COMMENT 'Master record for New Car Assessment Programme (NCAP) test submissions including Euro NCAP, NHTSA NCAP, ANCAP, and JNCAP. Captures submission date, test programme version, vehicle variant tested, star rating achieved (overall and by category: adult occupant, child occupant, vulnerable road users, safety assist), ADAS features evaluated, and publication date. Distinct from general compliance_test_event due to the structured star-rating outcome and public disclosure requirements.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` (
    `ota_compliance_approval_id` BIGINT COMMENT 'Ota Compliance Approval Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `approval_date` DATE COMMENT 'Approval Date',
    `approval_number` STRING COMMENT 'Approval Number',
    `approval_status` STRING COMMENT 'Approval Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `ecu_type` STRING COMMENT 'Ecu Type',
    `energy_efficiency_impact` STRING COMMENT 'Impact of OTA update on vehicle energy efficiency',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `safety_impact_assessment` STRING COMMENT 'Safety Impact Assessment',
    `software_version` STRING COMMENT 'Software Version',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_ota_compliance_approval PRIMARY KEY(`ota_compliance_approval_id`)
) COMMENT 'Master record for regulatory approvals governing Over-the-Air (OTA) software updates to vehicle ECUs and ADAS systems. Captures OTA campaign reference, affected ECU or software module, regulatory body approval (UNECE R156 Software Update Management System), approval date, jurisdiction applicability, cybersecurity assessment reference, and rollout authorization status. Ensures OTA deployments comply with UNECE R155/R156 and applicable national regulations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` (
    `fmvss_certification_id` BIGINT COMMENT 'Fmvss Certification Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `certification_date` DATE COMMENT 'Certification Date',
    `certification_status` STRING COMMENT 'Certification Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `emissions_related_flag` BOOLEAN COMMENT 'Whether this FMVSS certification has emissions implications',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `fmvss_standard_number` STRING COMMENT 'Fmvss Standard Number',
    `model_year` STRING COMMENT 'Model Year',
    `test_report_reference` STRING COMMENT 'Test Report Reference',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_fmvss_certification PRIMARY KEY(`fmvss_certification_id`)
) COMMENT 'Master record for Federal Motor Vehicle Safety Standard (FMVSS) self-certification records maintained by Automotive as required by NHTSA. Captures FMVSS standard number (e.g., FMVSS 208 Occupant Crash Protection, FMVSS 126 ESC, FMVSS 138 TPMS), vehicle model and model year, certification basis (self-certification), test evidence reference, certification date, and responsible certifying engineer. Supports NHTSA audit readiness and recall root-cause traceability.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` (
    `compliance_document_id` BIGINT COMMENT 'Compliance Document Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `document_number` STRING COMMENT 'Document Number',
    `document_status` STRING COMMENT 'Document Status',
    `document_title` STRING COMMENT 'Document Title',
    `document_type` STRING COMMENT 'Document Type',
    `esg_document_type` STRING COMMENT 'Type of ESG-related document (CSRD, EU Taxonomy, GRI)',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `issue_date` DATE COMMENT 'Issue Date',
    `storage_url` STRING COMMENT 'Storage Url',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Master record for compliance documentation artifacts associated with regulatory submissions, certifications, and homologation records. Captures document type (Certificate of Conformity, Type Approval Certificate, Test Report, PPAP compliance evidence, IATF audit report, FMEA summary), document reference number, issuing authority, issue date, expiry date, storage location (document management system URI), and document status. Provides the document register for the compliance domain. SUPERSEDED: Use engineering.engineering_document as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` (
    `compliance_audit_finding_id` BIGINT COMMENT 'Compliance Audit Finding Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `compliance_audit_finding_description` STRING COMMENT 'Description of the entity',
    `due_date` DATE COMMENT 'Due Date',
    `esg_finding_category` STRING COMMENT 'ESG category of the audit finding (environmental, social, governance)',
    `esg_pillar` STRING COMMENT 'Environmental, Social, or Governance classification',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `finding_code` STRING COMMENT '',
    `finding_description` STRING COMMENT 'Finding Description',
    `finding_number` STRING COMMENT 'Finding Number',
    `finding_status` STRING COMMENT 'Finding Status',
    `finding_type` STRING COMMENT 'Finding Type',
    `identified_date` DATE COMMENT 'Identified Date',
    `responsible_party` STRING COMMENT 'Responsible Party',
    `severity` STRING COMMENT 'Severity',
    `severity_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_compliance_audit_finding PRIMARY KEY(`compliance_audit_finding_id`)
) COMMENT 'Transactional record for findings raised during regulatory audits, IATF 16949 surveillance audits, ISO 14001 environmental audits, and internal compliance audits. Captures audit type, auditing body, finding category (major non-conformance, minor non-conformance, observation, opportunity for improvement), finding description, affected process or product, corrective action required, due date, and closure status. Supports IATF 16949 and ISO 9001 corrective action management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` (
    `compliance_corrective_action_id` BIGINT COMMENT 'Compliance Corrective Action Id',
    `compliance_audit_finding_id` BIGINT COMMENT 'Compliance Audit Finding Id',
    `action_description` STRING COMMENT 'Action Description',
    `action_number` STRING COMMENT 'Action Number',
    `action_status` STRING COMMENT 'Action Status',
    `action_type` STRING COMMENT 'Action Type',
    `assigned_to` STRING COMMENT 'Assigned To',
    `completion_date` DATE COMMENT 'Completion Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `compliance_corrective_action_description` STRING COMMENT 'Description of the entity',
    `due_date` DATE COMMENT 'Due Date',
    `effectiveness_verified` BOOLEAN COMMENT 'Effectiveness Verified',
    `esg_impact_area` STRING COMMENT 'ESG impact area addressed by corrective action',
    `esg_related_flag` BOOLEAN COMMENT 'Whether corrective action relates to ESG finding',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `responsible_party` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_compliance_corrective_action PRIMARY KEY(`compliance_corrective_action_id`)
) COMMENT 'Transactional record tracking corrective and preventive actions (CAPA) initiated in response to audit findings, regulatory non-conformances, or compliance violations. Captures root cause analysis method (5-Why, Ishikawa), root cause description, corrective action plan, responsible owner, implementation date, verification method, effectiveness review date, and closure status. Supports IATF 16949 clause 10.2 and regulatory corrective action commitments to NHTSA, EPA, or CARB.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` (
    `trade_compliance_record_id` BIGINT COMMENT 'Trade Compliance Record Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `carbon_border_adjustment_flag` BOOLEAN COMMENT 'Whether CBAM (Carbon Border Adjustment Mechanism) applies',
    `compliance_status` STRING COMMENT 'Compliance Status',
    `country_of_origin` STRING COMMENT 'Country Of Origin',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `hs_code` STRING COMMENT 'Hs Code',
    `record_number` STRING COMMENT 'Record Number',
    `trade_type` STRING COMMENT 'Trade Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_trade_compliance_record PRIMARY KEY(`trade_compliance_record_id`)
) COMMENT 'Master record for import/export trade compliance covering CKD (Completely Knocked Down) and SKD (Semi Knocked Down) vehicle kits, parts, and finished vehicles. Captures HS tariff code, country of origin, export control classification (EAR/ITAR), free trade agreement applicability (USMCA, EU-Japan EPA), customs duty rate, import license reference, and compliance status. Supports trade compliance obligations across Automotives global manufacturing and distribution footprint.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'Environmental Permit Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_category` STRING COMMENT 'ESG reporting category for this permit',
    `esg_materiality_flag` BOOLEAN COMMENT 'Indicates if permit is material for ESG reporting',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `issue_date` DATE COMMENT 'Issue Date',
    `permit_number` STRING COMMENT 'Permit Number',
    `permit_status` STRING COMMENT 'Permit Status',
    `permit_type` STRING COMMENT 'Permit Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Master record for environmental operating permits held by Automotive manufacturing plants and facilities. Captures permit type (air emissions permit, wastewater discharge permit, hazardous waste permit), issuing regulatory authority (EPA, state environmental agency), permit number, facility reference, permitted emission limits by pollutant, permit issue date, expiry date, renewal status, and compliance monitoring frequency. Supports ISO 14001 environmental management and EPA reporting obligations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` (
    `emissions_monitoring_reading_id` BIGINT COMMENT 'Emissions Monitoring Reading Id',
    `emissions_monitoring_point_id` BIGINT COMMENT 'Emissions Monitoring Point Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `data_quality_flag` BOOLEAN COMMENT 'Data Quality Flag',
    `esg_reporting_category` STRING COMMENT 'Category for ESG/CSRD reporting alignment',
    `esg_scope_category` STRING COMMENT 'GHG Protocol scope classification (1, 2, 3)',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `limit_value` DECIMAL(18,2) COMMENT 'Limit Value',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured Value',
    `parameter_name` STRING COMMENT 'Parameter Name',
    `reading_timestamp` TIMESTAMP COMMENT 'Reading Timestamp',
    `unit_of_measure` STRING COMMENT 'Unit Of Measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_emissions_monitoring_reading PRIMARY KEY(`emissions_monitoring_reading_id`)
) COMMENT 'Transactional record capturing periodic emissions monitoring readings from manufacturing plant stacks, wastewater discharge points, and facility-level environmental monitoring stations. Captures reading timestamp, monitoring point identifier, pollutant type (NOx, SOx, VOC, CO2, particulate matter), measured value, unit of measure, permitted limit, exceedance flag, and monitoring method (CEMS, manual sampling). Supports EPA Continuous Emissions Monitoring System (CEMS) reporting and permit compliance verification.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` (
    `recall_defect_report_id` BIGINT COMMENT 'Recall Defect Report Id',
    `recall_campaign_id` BIGINT COMMENT 'Recall Campaign Id',
    `component_affected` STRING COMMENT 'Component Affected',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `defect_category` STRING COMMENT 'Defect Category',
    `environmental_hazard_flag` BOOLEAN COMMENT 'Whether the defect poses an environmental hazard',
    `failure_mode` STRING COMMENT 'Failure Mode',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `incidents_reported` STRING COMMENT 'Incidents Reported',
    `injuries_reported` STRING COMMENT 'Injuries Reported',
    `report_date` DATE COMMENT 'Report Date',
    `report_number` STRING COMMENT 'Report Number',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_recall_defect_report PRIMARY KEY(`recall_defect_report_id`)
) COMMENT 'Transactional record for Early Warning Reporting (EWR) and defect investigation reports submitted to or received from NHTSA. Captures report type (EWR quarterly report, Part 579 defect report, consumer complaint aggregate, field report), reporting period, defect category (safety, emissions, structural), number of incidents reported, injury/fatality count, investigation status, and NHTSA investigation number if opened. Supports 49 CFR Part 579 Early Warning Reporting obligations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`waiver` (
    `waiver_id` BIGINT COMMENT 'Waiver Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `esg_waiver_justification` STRING COMMENT 'Justification for ESG-related regulatory waiver',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `granted_date` DATE COMMENT 'Granted Date',
    `justification` STRING COMMENT 'Justification',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `waiver_number` STRING COMMENT 'Waiver Number',
    `waiver_status` STRING COMMENT 'Waiver Status',
    `waiver_type` STRING COMMENT 'Waiver Type',
    CONSTRAINT pk_waiver PRIMARY KEY(`waiver_id`)
) COMMENT 'Master record for regulatory waivers, exemptions, and derogations granted to Automotive by regulatory bodies. Captures waiver type (CAFE small manufacturer exemption, CARB ZEV credit waiver, FMVSS temporary exemption), granting authority, waiver reference number, applicable regulation, justification basis, granted date, expiry date, conditions attached, and compliance monitoring requirements during the waiver period.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` (
    `zev_credit_id` BIGINT COMMENT 'Zev Credit Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `model_id` BIGINT COMMENT 'Model Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `credit_status` STRING COMMENT 'Credit Status',
    `credit_type` STRING COMMENT 'Credit Type',
    `credit_value` DECIMAL(18,2) COMMENT 'Credit Value',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `eu_taxonomy_aligned_flag` BOOLEAN COMMENT 'Whether this ZEV credit is aligned with EU Taxonomy criteria',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `model_year` STRING COMMENT 'Model Year',
    `transaction_type` STRING COMMENT 'Transaction Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_zev_credit PRIMARY KEY(`zev_credit_id`)
) COMMENT 'Master record for Zero Emission Vehicle (ZEV) and greenhouse gas (GHG) compliance credits earned, purchased, transferred, or retired under CARB ZEV mandate and EPA GHG credit programs. Captures credit type (ZEV, TZEV, AT PZEV, GHG), model year, credit quantity, credit vintage, earning basis (vehicle sales volume, powertrain type), credit status (earned, banked, transferred, retired), and counterparty for credit transfers. Supports CARB ZEV mandate compliance and EPA GHG credit banking strategy.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` (
    `homologation_market_approval_id` BIGINT COMMENT 'Homologation Market Approval Id',
    `homologation_record_id` BIGINT COMMENT 'Homologation Record Id',
    `jurisdiction_id` BIGINT COMMENT 'Jurisdiction Id',
    `approval_date` DATE COMMENT 'Approval Date',
    `approval_number` STRING COMMENT 'Approval Number',
    `approval_status` STRING COMMENT 'Approval Status',
    `co2_limit_g_per_km` DECIMAL(18,2) COMMENT 'CO2 emission limit in grams per km for this market approval',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_homologation_market_approval PRIMARY KEY(`homologation_market_approval_id`)
) COMMENT 'Association record linking a homologation record to a specific market/jurisdiction approval status. Captures market, approval authority, approval date, approval number, validity period, conditions of approval, and any market-specific derogations or additional requirements. Enables tracking of which vehicle variants are approved for sale in which markets, supporting global market launch planning and compliance status dashboards.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` (
    `regulatory_change_notice_id` BIGINT COMMENT 'Regulatory Change Notice Id',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory Requirement Id',
    `change_description` STRING COMMENT 'Change Description',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_date` DATE COMMENT 'Effective Date',
    `esg_impact_assessment` STRING COMMENT 'Assessment of ESG impact from regulatory change',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `impact_assessment` STRING COMMENT 'Impact Assessment',
    `notice_number` STRING COMMENT 'Notice Number',
    `notice_status` STRING COMMENT 'Notice Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_regulatory_change_notice PRIMARY KEY(`regulatory_change_notice_id`)
) COMMENT 'Transactional record tracking incoming regulatory changes, proposed rules, and final rules published by governing bodies that may impact Automotives products or operations. Captures regulation reference, publishing body, notice type (NPRM, Final Rule, Guidance Document, Technical Circular), publication date, comment period deadline, effective date, impact assessment status, affected vehicle programs, and assigned compliance owner. Supports proactive regulatory horizon scanning and impact assessment.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` (
    `emissions_monitoring_point_id` BIGINT COMMENT 'Emissions Monitoring Point Id',
    `environmental_permit_id` BIGINT COMMENT 'Environmental Permit Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `csrd_disclosure_ref` STRING COMMENT 'CSRD disclosure requirement reference',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `data_quality_flag` BOOLEAN COMMENT 'Data Quality Flag',
    `esg_scope_classification` STRING COMMENT 'GHG Protocol scope classification (Scope 1, 2, 3)',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `location_description` STRING COMMENT 'Location Description',
    `monitoring_type` STRING COMMENT 'Monitoring Type',
    `point_code` STRING COMMENT 'Point Code',
    `point_name` STRING COMMENT 'Point Name',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_emissions_monitoring_point PRIMARY KEY(`emissions_monitoring_point_id`)
) COMMENT 'Master reference table for emissions_monitoring_point. Referenced by monitoring_point_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`test_facility` (
    `test_facility_id` BIGINT COMMENT 'Test Facility Id',
    `accreditation_expiry` DATE COMMENT 'Accreditation Expiry',
    `accreditation_number` STRING COMMENT 'Accreditation Number',
    `country_code` STRING COMMENT 'Country Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `facility_code` STRING COMMENT 'Facility Code',
    `facility_name` STRING COMMENT 'Facility Name',
    `facility_status` STRING COMMENT 'Facility Status',
    `facility_type` STRING COMMENT 'Facility Type',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    `iso_14001_certified_flag` BOOLEAN COMMENT 'Whether the test facility holds ISO 14001 environmental certification',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_test_facility PRIMARY KEY(`test_facility_id`)
) COMMENT 'Master reference table for test_facility. Referenced by test_facility_id.';

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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` (
    `homologation_variant_id` BIGINT COMMENT 'Primary key for homologation_variant',
    `field_service_info` STRING COMMENT 'Generic field service info placeholder',
    CONSTRAINT pk_homologation_variant PRIMARY KEY(`homologation_variant_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ADD CONSTRAINT `fk_compliance_compliance_emissions_certification_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ADD CONSTRAINT `fk_compliance_compliance_emissions_certification_test_facility_id` FOREIGN KEY (`test_facility_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`test_facility`(`test_facility_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` ADD CONSTRAINT `fk_compliance_cafe_compliance_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_test_facility_id` FOREIGN KEY (`test_facility_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`test_facility`(`test_facility_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` ADD CONSTRAINT `fk_compliance_compliance_test_result_test_event_id` FOREIGN KEY (`test_event_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`test_event`(`test_event_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_body_id` FOREIGN KEY (`regulatory_body_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_body`(`regulatory_body_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` ADD CONSTRAINT `fk_compliance_ncap_submission_test_facility_id` FOREIGN KEY (`test_facility_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`test_facility`(`test_facility_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` ADD CONSTRAINT `fk_compliance_ota_compliance_approval_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` ADD CONSTRAINT `fk_compliance_compliance_document_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` ADD CONSTRAINT `fk_compliance_environmental_permit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` ADD CONSTRAINT `fk_compliance_emissions_monitoring_reading_emissions_monitoring_point_id` FOREIGN KEY (`emissions_monitoring_point_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point`(`emissions_monitoring_point_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ADD CONSTRAINT `fk_compliance_recall_defect_report_recall_campaign_id` FOREIGN KEY (`recall_campaign_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`recall_campaign`(`recall_campaign_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` ADD CONSTRAINT `fk_compliance_homologation_market_approval_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` ADD CONSTRAINT `fk_compliance_homologation_market_approval_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` ADD CONSTRAINT `fk_compliance_regulatory_change_notice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` ADD CONSTRAINT `fk_compliance_emissions_monitoring_point_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ADD CONSTRAINT `fk_compliance_regulatory_body_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `vibe_automotive_v1`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_automotive_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_record` ALTER COLUMN `eu_taxonomy_activity_code` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Activity Code');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_ssot_owner' = 'compliance');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_ssot_concept' = 'emissions_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ALTER COLUMN `carbon_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credit Eligible');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ALTER COLUMN `esg_reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Framework');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_emissions_certification` ALTER COLUMN `eu_taxonomy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Eligible');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` SET TAGS ('dbx_structural_verified' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` ALTER COLUMN `csrd_disclosure_reference` SET TAGS ('dbx_business_glossary_term' = 'CSRD Disclosure Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`cafe_compliance_record` ALTER COLUMN `eu_taxonomy_activity_code` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Activity Code');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `esg_submission_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Submission Type');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` SET TAGS ('dbx_subdomain' = 'recall_safety');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_campaign` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_event` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_event` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_event` ALTER COLUMN `esg_test_protocol` SET TAGS ('dbx_business_glossary_term' = 'ESG Test Protocol');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_ssot_owner' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_ssot_concept' = 'test_result');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_test_result` ALTER COLUMN `esg_test_category` SET TAGS ('dbx_business_glossary_term' = 'ESG Test Category');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `sustainability_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Relevance');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`jurisdiction` ALTER COLUMN `esg_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'ESG Regulatory Framework');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`obligation` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`obligation` ALTER COLUMN `esg_obligation_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Obligation Type');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ncap_submission` ALTER COLUMN `environmental_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Rating Score');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`ota_compliance_approval` ALTER COLUMN `energy_efficiency_impact` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Impact');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`fmvss_certification` ALTER COLUMN `emissions_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Related');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_ssot_owner' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_ssot_concept' = 'document');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_document` ALTER COLUMN `esg_document_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Document Type');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'audit_corrective');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `esg_finding_category` SET TAGS ('dbx_business_glossary_term' = 'ESG Finding Category');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `esg_pillar` SET TAGS ('dbx_business_glossary_term' = 'ESG Pillar');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_subdomain' = 'audit_corrective');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `esg_impact_area` SET TAGS ('dbx_business_glossary_term' = 'ESG Impact Area');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `esg_related_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG Related Flag');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` ALTER COLUMN `carbon_border_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Border Adjustment');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`trade_compliance_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` ALTER COLUMN `esg_category` SET TAGS ('dbx_business_glossary_term' = 'ESG Category');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`environmental_permit` ALTER COLUMN `esg_materiality_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG Materiality Flag');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` ALTER COLUMN `esg_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Category');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_reading` ALTER COLUMN `esg_scope_category` SET TAGS ('dbx_business_glossary_term' = 'ESG Scope Category');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` SET TAGS ('dbx_subdomain' = 'recall_safety');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`recall_defect_report` ALTER COLUMN `environmental_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazard');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`waiver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`waiver` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`waiver` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`waiver` ALTER COLUMN `esg_waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'ESG Waiver Justification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`zev_credit` ALTER COLUMN `eu_taxonomy_aligned_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Taxonomy Aligned');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` ALTER COLUMN `co2_limit_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'CO2 Limit g/km');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_market_approval` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_change_notice` ALTER COLUMN `esg_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'ESG Impact Assessment');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` ALTER COLUMN `csrd_disclosure_ref` SET TAGS ('dbx_business_glossary_term' = 'CSRD Disclosure Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`emissions_monitoring_point` ALTER COLUMN `esg_scope_classification` SET TAGS ('dbx_business_glossary_term' = 'ESG Scope Classification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_facility` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_facility` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`test_facility` ALTER COLUMN `iso_14001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` SET TAGS ('dbx_subdomain' = 'emissions_regulatory');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`regulatory_body` ALTER COLUMN `esg_oversight_scope` SET TAGS ('dbx_business_glossary_term' = 'ESG Oversight Scope');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` SET TAGS ('dbx_subdomain' = 'homologation_certification');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` SET TAGS ('dbx_source_system' = 'DMS');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` SET TAGS ('dbx_SAP_CS' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`compliance`.`homologation_variant` ALTER COLUMN `homologation_variant_id` SET TAGS ('dbx_business_glossary_term' = 'homologation_variant Identifier');
