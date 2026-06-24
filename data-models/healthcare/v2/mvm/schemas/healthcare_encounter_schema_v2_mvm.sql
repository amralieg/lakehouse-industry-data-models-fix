-- Schema for Domain: encounter | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`encounter` COMMENT 'Core operational record of every patient-provider interaction. Owns ADT (Admit, Discharge, Transfer) events, visit types (inpatient, outpatient, ED, observation, telehealth), admission source and disposition, attending and consulting providers, LOS (Length of Stay), DRG assignment, discharge status, and care setting transitions. Central hub linking patient, provider, clinical, and billing domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit` (
    `visit_id` BIGINT COMMENT 'Unique surrogate identifier for every patient-provider interaction record in the encounter domain. Primary key of the visit data product and central linkage point for clinical, billing, and provider domains.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Service line analytics and payer contract reporting require correlating appointment type (telehealth, office, procedure) with encounter outcomes (LOS, DRG, readmission). visit.visit_type_code is a den',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Visit-level DRG assignment—every inpatient visits DRG must reference the official DRG definition for payment calculation, expected LOS comparison, and case mix reporting. Required for revenue cycle o',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Every visit must be anchored to the enterprise patient identity (MPI) for CMS quality reporting, HEDIS, revenue cycle, and clinical operations. The plain mrn column on visit is a denormalized patient ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Identifies the rendering facility for each visit — required for CMS value-based care program attribution, facility-level quality reporting, and payer billing. A domain expert would expect every visit ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: The principal ICD-10 diagnosis on a visit drives DRG grouping, HRRP quality measure categorization, and CMS billing. A domain expert expects visit to carry a validated FK to the ICD code reference tab',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who authorized and completed the patient discharge. Used for care transition accountability, discharge instruction tracking, and quality audits.',
    `admission_source` STRING COMMENT 'Indicates the origin point from which the patient entered the facility for this visit. Required for UB-04 billing, readmission analysis, and care transition reporting. [ENUM-REF-CANDIDATE: emergency_department|direct_admission|transfer|referral|birth|court_law|information_not_available — promote to reference product]. Valid values are `emergency_department|direct_admission|transfer|referral|birth`',
    `admission_timestamp` TIMESTAMP COMMENT 'Date and time the patient was formally admitted to the facility or the visit began. Principal business event timestamp for the encounter lifecycle. Used for LOS calculation, throughput analytics, and regulatory reporting.',
    `admission_type` STRING COMMENT 'Characterizes the clinical urgency and circumstance under which the patient was admitted. Required for UB-04 billing and DRG grouping. Sourced from Epic ADT or Cerner PowerChart admission workflow.. Valid values are `elective|urgent|emergent|newborn|trauma`',
    `admitting_diagnosis_code` STRING COMMENT 'ICD-10-CM code representing the condition documented at the time of admission, before full workup. May differ from the principal discharge diagnosis. Required on UB-04 for inpatient claims.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `care_setting` STRING COMMENT 'Specific clinical environment within the facility where the patient received care during this visit. More granular than visit type; used for staffing, capacity management, and HAI surveillance. [ENUM-REF-CANDIDATE: inpatient_ward|icu|ed|or|observation_unit|outpatient_clinic|telehealth|labor_delivery|nicu|step_down — promote to reference product]',
    `care_transition_plan_completed` BOOLEAN COMMENT 'Indicates whether a formal care transition plan was completed and communicated to the receiving provider or care setting at discharge. Required for CMS Transitional Care Management billing and TJC accreditation.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for treatment was obtained and documented at the time of admission or prior to procedure. Required for TJC accreditation and HIPAA compliance.',
    `converted_to_inpatient` BOOLEAN COMMENT 'Indicates whether an observation encounter was subsequently converted to a formal inpatient admission. Triggers billing reclassification and DRG assignment workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the visit record was first created in the source EHR system. Used for audit trail, data lineage, and ETL processing. Sourced from Epic or Cerner encounter creation event.',
    `discharge_disposition` STRING COMMENT 'Standardized code describing where the patient went or what occurred at the conclusion of the visit. Required for UB-04 billing, DRG grouping, readmission risk stratification, and CMS quality reporting. [ENUM-REF-CANDIDATE: home|snf|rehab|ama|expired|hospice|transfer_acute|transfer_other|home_health|left_without_being_seen — promote to reference product]. Valid values are `home|snf|rehab|ama|expired|hospice`',
    `discharge_instructions_issued` BOOLEAN COMMENT 'Indicates whether written discharge instructions were provided to the patient or caregiver at the time of discharge. Required for TJC accreditation, HCAHPS scoring, and CMS Conditions of Participation.',
    `discharge_timestamp` TIMESTAMP COMMENT 'Date and time the patient was formally discharged or the visit concluded. Used for LOS calculation, bed management, and revenue cycle close-out. Null for visits still in progress.',
    `drg_type` STRING COMMENT 'Identifies the DRG classification system used for this encounter (Medicare Severity DRG, All Patient Refined DRG, or All Patient DRG). Determines reimbursement methodology and payer applicability.. Valid values are `MS-DRG|APR-DRG|AP-DRG`',
    `drg_weight` DECIMAL(18,2) COMMENT 'Numeric relative weight assigned to the DRG, reflecting the average resource intensity of cases in that group. Used to calculate expected reimbursement and Case Mix Index (CMI) contribution for the facility.',
    `emtala_compliant` BOOLEAN COMMENT 'Indicates whether EMTALA obligations were assessed and met for this visit, including medical screening examination and stabilization requirements. Critical for ED visits and transfer scenarios. Required for OIG compliance audits.',
    `encounter_number` STRING COMMENT 'Human-readable, externally-known visit or encounter number assigned by the source EHR system (e.g., Epic CSN — Contact Serial Number, or Cerner FIN — Financial Identification Number). Used in billing, claims, and patient communications.',
    `expected_los_days` DECIMAL(18,2) COMMENT 'DRG-based or risk-adjusted expected length of stay for this encounter, used to benchmark actual LOS against peer performance and identify outlier cases for CDI and utilization management review.',
    `financial_class` STRING COMMENT 'Payer category assigned at the time of visit registration, used to route the encounter through the appropriate revenue cycle workflow. Drives charge capture, claim form selection (UB-04 vs CMS-1500), and reimbursement expectations. [ENUM-REF-CANDIDATE: commercial|medicare|medicaid|self_pay|workers_comp|tricare|charity|other_government — promote to reference product]. Valid values are `commercial|medicare|medicaid|self_pay|workers_comp`',
    `follow_up_scheduled` BOOLEAN COMMENT 'Indicates whether a follow-up appointment was scheduled prior to or at the time of discharge. Used for care transition quality metrics, readmission prevention programs, and HEDIS measure compliance.',
    `inpatient_conversion_timestamp` TIMESTAMP COMMENT 'Date and time an observation status encounter was formally converted to inpatient admission. Used for LOS recalculation, billing reclassification, and two-midnight rule compliance documentation.',
    `length_of_stay_days` STRING COMMENT 'Total number of inpatient days from admission to discharge, calculated as discharge date minus admission date. Key operational and financial metric used for ALOS benchmarking, CMI analysis, and VBP performance.',
    `moon_delivered_timestamp` TIMESTAMP COMMENT 'Date and time the Medicare Outpatient Observation Notice (MOON) was delivered to the patient, as required by the NOTICE Act for Medicare beneficiaries receiving observation services exceeding 24 hours.',
    `observation_hours` DECIMAL(18,2) COMMENT 'Total number of hours the patient spent under outpatient observation status during this visit. Used for two-midnight rule compliance assessment, MOON trigger evaluation, and Medicare billing.',
    `observation_status` BOOLEAN COMMENT 'Indicates whether the patient is classified under outpatient observation status rather than formal inpatient admission. Drives MOON delivery requirement, two-midnight rule assessment, and Medicare Part A vs Part B billing determination.',
    `point_of_service_code` STRING COMMENT 'CMS two-digit Place of Service code indicating the setting where the professional service was rendered. Required on CMS-1500 professional claims for correct reimbursement routing.',
    `readmission_flag` BOOLEAN COMMENT 'Indicates whether this visit is classified as an unplanned readmission within 30 days of a prior discharge. Used for CMS Hospital Readmissions Reduction Program (HRRP) reporting and VBP performance measurement.',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (e.g., LACE, HOSPITAL score) predicting the probability of unplanned 30-day readmission. Used by care management teams to prioritize post-discharge follow-up and care transition interventions.',
    `source_encounter_code` STRING COMMENT 'Native encounter identifier from the originating EHR system (e.g., Epic CSN, Cerner Encounter ID). Preserved for cross-system reconciliation, HIE interoperability, and FHIR API mapping.',
    `telehealth_connection_quality` STRING COMMENT 'Assessed quality of the audio/video connection during a telehealth visit. Used for patient experience reporting, platform SLA monitoring, and identifying visits that may require follow-up due to technical issues.. Valid values are `excellent|good|fair|poor|failed`',
    `telehealth_platform` STRING COMMENT 'Name of the telehealth technology platform used to conduct the virtual visit (e.g., Epic MyChart Video, Zoom for Healthcare, Teladoc). Required for telehealth billing modifier application and platform performance reporting.',
    `two_midnight_compliant` BOOLEAN COMMENT 'Indicates whether the inpatient admission meets CMS two-midnight rule criteria, requiring the admitting physician to expect the patient to require hospital care spanning at least two midnights. Critical for Medicare inpatient billing compliance and RAC audit defense.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the visit record was most recently modified in the source EHR system or the lakehouse silver layer. Used for incremental ETL processing, change data capture, and audit compliance.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_product_list_verified_flag` BOOLEAN COMMENT 'Marker confirming canonical product list verification pass.',
    `visit_status` STRING COMMENT 'Current lifecycle state of the visit from scheduling through discharge. Drives ADT event processing, bed management, and revenue cycle workflows in Epic ADT and Cerner PowerChart.. Valid values are `scheduled|arrived|in_progress|discharged|cancelled|no_show`',
    `visit_type` STRING COMMENT 'Classification of the patient-provider interaction by care setting and service modality. Drives billing rules, regulatory requirements, and clinical workflow routing. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|telehealth|ambulatory|surgical|preventive — promote to reference product]. Valid values are `inpatient|outpatient|emergency|observation|telehealth|ambulatory`',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Core encounter/visit record representing a patient interaction with the health system.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` (
    `adt_event_id` BIGINT COMMENT 'Unique surrogate identifier for each ADT event record in the silver layer. Primary key for the adt_event data product. Role: TRANSACTION_HEADER.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending or responsible provider at the time of this ADT event. Captures the clinician accountable for the patient at the moment of admit, transfer, or discharge.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient associated with this ADT event. Serves as the PARTY_REFERENCE for this TRANSACTION_HEADER, linking the event to the Master Patient Index (MPI).',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: ADT event tracking—DRG codes captured during patient movement events must reference official DRG definitions for real-time case management, bed utilization analysis, and revenue cycle monitoring. Requ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: ADT events are the core patient movement transactions used for HIE notifications, patient matching, and identity resolution. adt_event currently links only to demographics; enterprise MPI linkage is r',
    `prior_event_adt_event_id` BIGINT COMMENT 'Reference to the immediately preceding ADT event in the same encounters event chain. Enables reconstruction of the full ADT event sequence and care pathway for LOS milestone tracking and transitions-of-care analysis.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: ADT transfer events require identification of the sending/receiving facility for EMTALA compliance tracking, inter-facility patient flow management, and transfer center operations. sending_facility is',
    `visit_id` BIGINT COMMENT 'Reference to the parent encounter (visit) to which this ADT event belongs. Links the ADT event to the broader encounter context including patient, provider, and billing information.',
    `accepting_provider_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the provider accepting responsibility for the patient at the destination care setting during a transfer event. Required for EMTALA transfer compliance documentation and inter-facility transfer records.. Valid values are `^[0-9]{10}$`',
    `admission_source_code` STRING COMMENT 'Standardized code indicating the source from which the patient was admitted (e.g., physician referral, emergency room, transfer from another facility, birth). Corresponds to PV1-14 (Admit Source) in HL7 v2.x and UB-04 field 15. Used for DRG grouping and regulatory reporting. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product per UB-04 Admit Source codes]',
    `ama_flag` BOOLEAN COMMENT 'Indicates whether the patient was discharged Against Medical Advice (AMA). Populated for discharge events (A03). Relevant for discharge disposition coding, liability documentation, and readmission risk analysis.',
    `bed_assigned_timestamp` TIMESTAMP COMMENT 'Date and time a specific bed was assigned to the patient as part of this ADT event. Used to calculate bed assignment turnaround time and support capacity management analytics.',
    `bed_request_timestamp` TIMESTAMP COMMENT 'Date and time a bed was requested for the patient as part of this ADT event. Used to calculate bed placement turnaround time and support real-time bed management KPIs.',
    `cancel_reason` STRING COMMENT 'Free-text or coded reason for cancellation when event_status is cancelled. Captures clinical or administrative rationale for reversing an ADT event (e.g., Patient not admitted, Duplicate registration). Corresponds to EVN-4 in HL7 v2.x.',
    `clinical_reason_for_transfer` STRING COMMENT 'Free-text or coded clinical justification for a patient transfer event (e.g., Requires ICU-level monitoring, Specialist not available at sending facility). Populated for transfer and inter-facility transition events. Supports EMTALA compliance documentation and care transitions analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this ADT event record was first created in the silver layer data product. Serves as the RECORD_AUDIT_CREATED timestamp for data lineage and audit trail purposes.',
    `discharge_disposition_code` STRING COMMENT 'Standardized code indicating the patients status or destination at discharge (e.g., home, skilled nursing facility, expired, AMA). Corresponds to PV1-36 (Discharge Disposition) in HL7 v2.x and UB-04 field 17. Required for DRG assignment, readmission risk, and CMS quality reporting. [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|20|30|43|50|51|61|62|63|64|65|66|69|70|71|72 — promote to reference product per NUBC Patient Discharge Status codes]',
    `drg_type` STRING COMMENT 'Classification of the DRG methodology used for grouping. MS-DRG (Medicare Severity DRG) is used for Medicare/Medicaid; APR-DRG (All Patient Refined DRG) is used for commercial and Medicaid managed care; IR-DRG (International Refined DRG) for international payers.. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `emtala_compliant` BOOLEAN COMMENT 'Indicates whether the transfer event meets all EMTALA (Emergency Medical Treatment and Labor Act) compliance requirements, including medical screening examination, stabilization, and appropriate transfer documentation. Applicable to inter-facility transfer events from emergency settings.',
    `emtala_transfer_form_completed` BOOLEAN COMMENT 'Indicates whether the required EMTALA transfer certification form was completed and signed by the responsible physician prior to inter-facility transfer. Supports OIG audit readiness and EMTALA compliance tracking.',
    `event_recorded_timestamp` TIMESTAMP COMMENT 'The date and time the ADT event was recorded or entered into the source system (Epic or Cerner). May differ from event_timestamp when events are back-entered. Corresponds to EVN-4 (Event Recorded Date/Time) in HL7 v2.x.',
    `event_status` STRING COMMENT 'Current lifecycle status of the ADT event record. active indicates a valid, confirmed event; cancelled indicates the event was reversed (e.g., A11 Cancel Admit); corrected indicates the event was amended; pending indicates the event is pre-registered or pre-admitted but not yet confirmed.. Valid values are `active|cancelled|corrected|pending`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time the ADT event occurred in the real world (e.g., when the patient was physically admitted, transferred, or discharged). This is the BUSINESS_EVENT_TIMESTAMP — distinct from record audit timestamps. Corresponds to EVN-2 in HL7 v2.x.',
    `event_type_code` STRING COMMENT 'HL7 ADT event type code identifying the nature of the ADT transaction. Standard HL7 v2.x event codes include A01 (Admit), A02 (Transfer), A03 (Discharge), A04 (Register Outpatient), A05 (Pre-Admit), A06 (Change Outpatient to Inpatient), A07 (Change Inpatient to Outpatient), A08 (Update Patient Info), A11 (Cancel Admit), A12 (Cancel Transfer), A13 (Cancel Discharge), A21 (Patient Goes on Leave of Absence), A22 (Patient Returns from Leave of Absence), among others. [ENUM-REF-CANDIDATE: A01|A02|A03|A04|A05|A06|A07|A08|A09|A10|A11|A12|A13|A21|A22 — promote to reference product]. Valid values are `A01|A02|A03|A04|A05|A06`',
    `event_type_description` STRING COMMENT 'Human-readable description of the ADT event type corresponding to the event_type_code (e.g., Admit a Patient, Transfer a Patient, Discharge/End Visit). Sourced from HL7 ADT event type table.',
    `from_bed_code` STRING COMMENT 'Specific bed identifier from which the patient is being transferred or discharged. Supports real-time bed management and occupancy tracking. Corresponds to PV1-3 (Prior Patient Location) bed component in HL7 v2.x.',
    `from_unit_code` STRING COMMENT 'Code identifying the nursing unit, care area, or department from which the patient is being transferred or discharged. For admission events, this represents the originating unit (e.g., ED). Corresponds to PV1-3 prior location in HL7 v2.x.',
    `isolation_flag` BOOLEAN COMMENT 'Indicates whether the patient requires isolation precautions at the time of this ADT event (e.g., contact, droplet, airborne precautions). Drives bed assignment logic, infection control workflows, and HAI prevention protocols.',
    `isolation_type` STRING COMMENT 'Type of isolation precaution required for the patient at the time of this ADT event. Values: contact, droplet, airborne, protective (reverse isolation), none. Populated when isolation_flag is true. Supports infection control and bed management workflows.. Valid values are `contact|droplet|airborne|protective|none`',
    `leave_of_absence_reason` STRING COMMENT 'Reason for a patient leave of absence event (HL7 A21). Captures the clinical or administrative justification when a patient temporarily leaves the facility (e.g., therapeutic pass, family visit). Null for non-leave events.',
    `level_of_care_code` STRING COMMENT 'Code representing the clinical level of care at the destination unit for this ADT event. Values: ICU (Intensive Care Unit), PCU (Progressive Care Unit), MED_SURG (Medical-Surgical), ED (Emergency Department), OR (Operating Room), PACU (Post-Anesthesia Care Unit), OBS (Observation), TELE (Telemetry), NICU (Neonatal ICU), PICU (Pediatric ICU). Supports LOS milestone tracking and level-of-care transition analysis. [ENUM-REF-CANDIDATE: ICU|PCU|MED_SURG|ED|OR|PACU|OBS|TELE|NICU|PICU — 10 candidates stripped; promote to reference product]',
    `patient_class_code` STRING COMMENT 'HL7 patient class code indicating the care setting type at the time of this ADT event. Values: I=Inpatient, O=Outpatient, E=Emergency, B=Obstetrics, C=Commercial Account, N=Not Applicable, R=Recurring Patient, U=Unknown. Corresponds to PV1-2 in HL7 v2.x. Drives billing, regulatory reporting, and LOS calculations. [ENUM-REF-CANDIDATE: I|O|E|B|C|N|R|U — 8 candidates stripped; promote to reference product]',
    `patient_stability_score` STRING COMMENT 'Clinical assessment of patient stability at the time of a transfer event. Values: stable, guarded, critical, unstable. Required for EMTALA transfer compliance documentation and supports risk stratification for inter-facility transfers.. Valid values are `stable|guarded|critical|unstable`',
    `readmission_risk_flag` BOOLEAN COMMENT 'Indicates whether the patient has been flagged as high-risk for readmission at the time of this discharge ADT event. Populated by predictive risk models or clinical decision support tools. Supports CMS Hospital Readmissions Reduction Program (HRRP) compliance and care transitions planning.',
    `sending_application` STRING COMMENT 'Name of the source application that generated the HL7 ADT message (e.g., EPIC, CERNER). Corresponds to MSH-3 (Sending Application) in HL7 v2.x. Supports source system traceability and ETL lineage.',
    `sending_facility` STRING COMMENT 'Name or identifier of the facility or system that originated the HL7 ADT message. Corresponds to MSH-4 (Sending Facility) in HL7 v2.x. Used for multi-facility environments and HIE routing.',
    `sequence_number` STRING COMMENT 'Ordinal sequence number of this ADT event within the encounters event chain. Enables chronological ordering of all ADT events for a given encounter when timestamps alone are insufficient (e.g., same-second events).',
    `source_system_event_code` STRING COMMENT 'Native identifier of this ADT event in the originating source system (Epic or Cerner). Used for ETL reconciliation, deduplication, and bi-directional traceability between the lakehouse silver layer and the operational EHR system.',
    `source_system_name` STRING COMMENT 'Name of the operational EHR system that is the authoritative source for this ADT event record. Values: EPIC (Epic EHR ADT), CERNER (Cerner Millennium ADT), MEDITECH (MEDITECH Expanse). Supports multi-system environments and data lineage.. Valid values are `EPIC|CERNER|MEDITECH`',
    `to_bed_code` STRING COMMENT 'Specific bed identifier to which the patient is being admitted or transferred. Supports real-time bed management, housekeeping workflows, and infection control tracking. Corresponds to PV1-3 assigned bed component in HL7 v2.x.',
    `to_room_code` STRING COMMENT 'Room identifier within the destination unit to which the patient is assigned. Complements to_bed_code for full location resolution. Corresponds to PV1-3 room component in HL7 v2.x.',
    `to_unit_code` STRING COMMENT 'Code identifying the nursing unit, care area, or department to which the patient is being admitted or transferred. Corresponds to PV1-3 (Assigned Patient Location) in HL7 v2.x. Central to real-time bed management and capacity planning.',
    `transition_type` STRING COMMENT 'Classification of the care setting transition for transfer events. Values: inter_unit (within same facility, same level of care), level_of_care_change (e.g., floor to ICU), inter_facility (between different facilities), internal_transfer, external_transfer. Null for non-transfer events. Supports transitions-of-care quality measures.. Valid values are `inter_unit|level_of_care_change|inter_facility|internal_transfer|external_transfer`',
    `transport_mode` STRING COMMENT 'Mode of transport used for patient transfer between care settings or facilities. Applicable for transfer and discharge events. Values include ambulance, helicopter, wheelchair, stretcher, ambulatory, private_vehicle. Null for non-transfer events.. Valid values are `ambulance|helicopter|wheelchair|stretcher|ambulatory|private_vehicle`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this ADT event record was last modified in the silver layer data product. Serves as the RECORD_AUDIT_UPDATED timestamp. Updated when corrections, cancellations, or amendments are applied to the event.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `visit_type_code` STRING COMMENT 'Classification of the visit type associated with this ADT event (e.g., inpatient, outpatient, emergency, observation, telehealth, ambulatory). Complements patient_class_code with business-level visit categorization used in analytics and reporting.. Valid values are `inpatient|outpatient|emergency|observation|telehealth|ambulatory`',
    CONSTRAINT pk_adt_event PRIMARY KEY(`adt_event_id`)
) COMMENT 'Admit-Discharge-Transfer event record tracking patient movements within and between facilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` (
    `visit_provider_id` BIGINT COMMENT 'Unique surrogate identifier for each visit-provider association record in the Silver layer lakehouse. Primary key for this junction entity linking a provider to a specific patient visit with a defined role.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Provider group attribution on a visit assignment is required for group-level billing (group NPI on claims), payer contract application, and MIPS group reporting. billing_provider_npi is a denormalized',
    `network_affiliation_id` BIGINT COMMENT 'Foreign key linking to provider.network_affiliation. Business justification: Links provider assignment to specific network participation record for the visits payer. Essential for determining in-network vs out-of-network status, calculating patient cost-sharing, and supportin',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Provider assignments are facility-specific — credentialing verification, network adequacy reporting, and payer billing all require knowing which facility a provider rendered services at. place_of_serv',
    `payer_id` BIGINT COMMENT 'Reference to the primary payer (insurance plan) associated with this visit at the time of provider assignment. Used for payer-specific provider network validation, credentialing verification, and RCM (Revenue Cycle Management) analytics.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider record assigned to this visit. Links to the provider domain clinician master record.',
    `referral_order_id` BIGINT COMMENT 'Reference to the formal consultation order or request that triggered this providers assignment to the visit. Applicable when assignment_type is consult_request. Links to the order management domain.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: specialty_at_assignment is a denormalized text column on visit_provider. Normalizing to provider.specialty supports specialty-level utilization reporting, network adequacy analysis, and payer credenti',
    `tertiary_visit_supervising_provider_clinician_id` BIGINT COMMENT 'Reference to the supervising or attending physician responsible for overseeing this providers participation in the visit. Required for resident, student, and mid-level provider assignments per CMS teaching physician billing guidelines.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter to which this provider is assigned. Links to the encounter domain visit record representing the ADT (Admit, Discharge, Transfer) event.',
    `admission_source_role` STRING COMMENT 'Indicates whether this provider served as the admitting, referring, or transferring physician at the time of patient admission. Relevant for ADT (Admit, Discharge, Transfer) event documentation and CMS admission source reporting.. Valid values are `admitting|referring|transferring|none`',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Date and time when the providers active participation in this visit ended. Null if the provider is still actively assigned. Used for LOS (Length of Stay) attribution, handoff documentation, and coverage gap analysis.',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Date and time when the providers active participation in this visit began. Used for time-bounded care team tracking, shift coverage analysis, and provider performance analytics per encounter.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the providers assignment to this visit. active indicates current participation; transferred indicates a handoff to another provider has occurred; cancelled indicates the assignment was voided.. Valid values are `active|inactive|pending|cancelled|transferred`',
    `assignment_type` STRING COMMENT 'Indicates how the provider came to be assigned to this visit — whether through scheduled care, unscheduled walk-in, emergency response, on-call coverage, or formal consult request. Supports operational staffing and care coordination analytics.. Valid values are `scheduled|unscheduled|emergency|coverage|consult_request`',
    `billing_provider_npi` STRING COMMENT 'The NPI (National Provider Identifier) used specifically for billing and claims submission for services rendered by this provider during this visit. May differ from the rendering provider NPI when billing under a group practice or supervising physician.. Valid values are `^[0-9]{10}$`',
    `care_setting` STRING COMMENT 'The clinical care setting in which the provider is participating for this visit (e.g., inpatient, outpatient, ED (Emergency Department), observation, telehealth, surgical, ICU (Intensive Care Unit)). Supports care setting-specific analytics and regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|ed|observation|telehealth|surgical|icu — 7 candidates stripped; promote to reference product]',
    `care_team_sequence` STRING COMMENT 'Ordinal sequence number indicating the order in which this provider was added to the visit care team. Used to reconstruct care team composition history and identify primary vs. secondary team members in chronological order.',
    `comments` STRING COMMENT 'Free-text comments or notes entered by clinical staff regarding this providers assignment to the visit. May include coverage rationale, special instructions, or handoff context not captured in structured fields.',
    `cosignature_required` BOOLEAN COMMENT 'Indicates whether the providers clinical documentation for this visit requires co-signature by a supervising physician (e.g., resident or student notes requiring attending co-signature). Supports CDI (Clinical Documentation Improvement) workflow and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this visit-provider association record was first created in the data platform. Supports audit trail, data lineage, and compliance with HIPAA record retention requirements.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Indicates whether the providers credentials and privileges were verified as current and active at the time of this visit assignment. Supports Joint Commission credentialing compliance and risk management.',
    `drg_attribution_flag` BOOLEAN COMMENT 'Indicates whether this providers assignment is attributed to the DRG (Diagnosis-Related Group) assignment for inpatient billing purposes. The attending of records DRG attribution drives inpatient reimbursement under CMS IPPS.',
    `effective_date` DATE COMMENT 'Calendar date on which this provider assignment became effective for the visit. Used for date-level scheduling, staffing reports, and daily census attribution distinct from the precise assignment_start_timestamp.',
    `handoff_reference` STRING COMMENT 'Reference identifier or note key pointing to the handoff documentation record created when this provider transferred care responsibility to another provider. Supports care continuity, patient safety, and Joint Commission handoff communication standards.',
    `is_attending_of_record` BOOLEAN COMMENT 'Indicates whether this provider is designated as the attending physician of record for the visit. The attending of record bears overall clinical and legal responsibility for the patients care and is reported on all billing claims.',
    `is_primary_provider` BOOLEAN COMMENT 'Indicates whether this provider holds primary clinical and billing responsibility for the visit. Only one provider per visit should have this flag set to True. Drives attending physician attribution on claims, UB-04, and CMS-1500 forms.',
    `locum_tenens_flag` BOOLEAN COMMENT 'Indicates whether the provider is serving in a locum tenens (temporary substitute) capacity for this visit. Locum tenens billing has specific CMS rules requiring the Q6 modifier on claims.',
    `mips_eligible_flag` BOOLEAN COMMENT 'Indicates whether this providers participation in this visit is eligible for MIPS (Merit-based Incentive Payment System) performance measurement under MACRA (Medicare Access and CHIP Reauthorization Act). Drives quality measure attribution.',
    `note_count` STRING COMMENT 'Number of clinical notes authored or co-signed by this provider for this visit. Supports CDI (Clinical Documentation Improvement) completeness tracking and provider documentation compliance reporting.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the assigned provider as issued by CMS. Captured at time of assignment to support billing, claims adjudication, and RVU (Relative Value Unit) attribution independent of provider master record changes.. Valid values are `^[0-9]{10}$`',
    `on_call_flag` BOOLEAN COMMENT 'Indicates whether this provider was assigned to the visit as part of an on-call coverage rotation rather than a scheduled or direct assignment. Supports on-call scheduling analytics and EMTALA (Emergency Medical Treatment and Labor Act) compliance tracking.',
    `order_count` STRING COMMENT 'Number of clinical orders (lab, radiology, pharmacy, procedures) placed by this provider via CPOE (Computerized Physician Order Entry) for this visit. Supports provider ordering pattern analytics and CPOE adoption reporting.',
    `participation_duration_minutes` STRING COMMENT 'Total number of minutes the provider was actively engaged in this visit, calculated from assignment_start_timestamp to assignment_end_timestamp. Used for time-based billing (e.g., anesthesia, critical care), provider productivity reporting, and staffing analytics.',
    `place_of_service_code` STRING COMMENT 'Two-digit CMS Place of Service (POS) code indicating the setting where the provider rendered services during this visit (e.g., 11=Office, 21=Inpatient Hospital, 23=Emergency Room, 02=Telehealth). Required on CMS-1500 professional claims.. Valid values are `^[0-9]{2}$`',
    `privilege_type` STRING COMMENT 'The type of clinical privileges held by the provider at the facility for this visit assignment (e.g., full, provisional, temporary, locum tenens, telemedicine). Determines scope of permissible clinical activities.. Valid values are `full|provisional|temporary|locum_tenens|telemedicine`',
    `provider_role` STRING COMMENT 'Clinical role of the provider for this specific visit assignment (e.g., attending, consulting, admitting, covering, resident, hospitalist, surgeon, anesthesiologist, PCP). Determines care team hierarchy, billing responsibility, and RVU attribution. [ENUM-REF-CANDIDATE: attending|consulting|admitting|covering|resident|hospitalist|surgeon|anesthesiologist|pcp|co_surgeon|scrub_tech|circulating_nurse|care_coordinator — promote to reference product]',
    `provider_type` STRING COMMENT 'Classification of the providers credential type for this assignment (e.g., physician, NP (Nurse Practitioner), PA (Physician Assistant), resident, fellow, student, RN, CRNA). Determines billing rules, supervision requirements, and scope of practice. [ENUM-REF-CANDIDATE: physician|np|pa|resident|fellow|student|rn|crna|other — 9 candidates stripped; promote to reference product]',
    `rendering_provider_npi` STRING COMMENT 'The NPI (National Provider Identifier) of the individual clinician who actually rendered the service during this visit. Distinct from billing_provider_npi when services are billed under a group or supervising provider.. Valid values are `^[0-9]{10}$`',
    `rvu_credit_flag` BOOLEAN COMMENT 'Indicates whether this provider assignment is eligible to receive RVU (Relative Value Unit) credit for services rendered during this visit. Used in provider productivity reporting, compensation modeling, and MIPS (Merit-based Incentive Payment System) performance tracking.',
    `rvu_work_units` DECIMAL(18,2) COMMENT 'The physician work RVU (wRVU) value attributed to this provider for services rendered during this visit assignment. Sourced from CMS RBRVS fee schedule and used for provider productivity measurement and compensation calculations.',
    `source_system_record_code` STRING COMMENT 'The native identifier of this provider assignment record in the originating operational system (e.g., Epic ClinDoc provider assignment ID, Cerner care team member ID). Enables traceability back to the system of record for reconciliation and audit.',
    `telehealth_flag` BOOLEAN COMMENT 'Indicates whether the providers participation in this visit was conducted via telehealth modality. Affects billing modifier requirements, place of service codes, and state telehealth licensure compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this visit-provider association record was last modified in the data platform. Supports change tracking, SCD (Slowly Changing Dimension) processing, and audit compliance.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    CONSTRAINT pk_visit_provider PRIMARY KEY(`visit_provider_id`)
) COMMENT 'Provider assignment record linking clinicians to visits with role and participation details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` (
    `drg_assignment_id` BIGINT COMMENT 'Primary key for drg_assignment',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician responsible for the encounter at the time of DRG assignment. Used for physician-level CMI reporting and CDI query targeting.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Core DRG grouping workflow—every DRG assignment must reference the official DRG definition for payment calculation, case mix index reporting, expected LOS comparison, and reimbursement validation. Ess',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with this DRG assignment, supporting CMI analysis and population health reporting.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: DRG grouping and payment calculations are facility-specific (base payment rate, outlier thresholds, grouper software version). Linking drg_assignment to org_provider supports facility-level DRG analyt',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: DRG reimbursement rates, outlier thresholds, and transfer case rules are defined at the payer contract level. Revenue cycle and managed care teams need to know which payer contract governs each DRG as',
    `payer_id` BIGINT COMMENT 'Reference to the primary payer (insurance plan) for this encounter. Determines which DRG version and payment methodology applies (e.g., MS-DRG for Medicare, APR-DRG for Medicaid managed care).',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: DRG assignment is fundamentally driven by the principal diagnosis. The drg_assignment table currently stores principal_diagnosis_code and principal_diagnosis_description as denormalized strings. Addin',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: DRG assignment for surgical DRGs is driven by the principal procedure. The drg_assignment table currently stores principal_procedure_code as a denormalized string. Adding principal_visit_procedure_id ',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or observation encounter for which this DRG assignment was generated. Links the DRG record to the core encounter event.',
    `actual_los` DECIMAL(18,2) COMMENT 'The actual number of days the patient was hospitalized for this encounter, calculated from admission to discharge. Compared against geometric and arithmetic mean LOS for efficiency and outlier analysis.',
    `admit_source_code` STRING COMMENT 'The UB-04 admission source code indicating how the patient was admitted (e.g., 1=Physician Referral, 4=Transfer from Hospital, 7=Emergency Room). Influences DRG grouping logic for certain MDCs.. Valid values are `^[0-9]{1,2}$`',
    `appeal_status` STRING COMMENT 'Current status of any payer or RAC appeal related to this DRG assignment. Tracks the outcome of reimbursement disputes through the appeals process.. Valid values are `not_appealed|pending|upheld|overturned|withdrawn`',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'The arithmetic mean length of stay in days for the assigned DRG, published by CMS. Used alongside geometric mean LOS for outlier threshold determination and payer contract benchmarking.',
    `assignment_status` STRING COMMENT 'Current workflow status of the DRG assignment record: preliminary (initial grouping), final (coding complete and validated), amended (revised after CDI query or audit), or voided (invalidated). Drives revenue cycle workflow routing.. Valid values are `preliminary|final|amended|voided`',
    `assignment_type` STRING COMMENT 'Classifies the nature of the DRG assignment: initial (first grouping at admission), working (interim CDI grouping), final (post-discharge coding), appeal (payer dispute), or rac_review (Recovery Audit Contractor review). [ENUM-REF-CANDIDATE: initial|working|final|appeal|rac_review — promote to reference product]. Valid values are `initial|working|final|appeal|rac_review`',
    `base_payment_rate` DECIMAL(18,2) COMMENT 'The hospital-specific or payer-contracted base payment rate (in USD) applied to the DRG weight to calculate expected reimbursement. Reflects IPPS standardized amount or negotiated payer contract rate.',
    `cc_mcc_flag` BOOLEAN COMMENT 'Indicates whether the encounter qualifies for a Complication and Comorbidity (CC) or Major Complication and Comorbidity (MCC) designation, which elevates the DRG tier and associated reimbursement weight. Critical CDI target for revenue optimization.',
    `cdi_query_count` STRING COMMENT 'The number of CDI queries issued to the attending physician for this encounter to clarify or improve clinical documentation supporting the DRG assignment. Key CDI productivity and impact metric.',
    `cdi_query_response_flag` BOOLEAN COMMENT 'Indicates whether at least one CDI query for this encounter received a physician response that resulted in a documentation change affecting the DRG assignment. Measures CDI program effectiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this DRG assignment record was first created in the system. Supports audit trail requirements and data lineage tracking.',
    `discharge_status_code` STRING COMMENT 'The UB-04 patient discharge status code (01–99) indicating the disposition of the patient at discharge (e.g., 01=Home, 02=SNF, 20=Expired). Affects DRG payment under post-acute care transfer rules.. Valid values are `^[0-9]{2}$`',
    `drg_changed_flag` BOOLEAN COMMENT 'Indicates whether the DRG code was changed from the initial working DRG to the final assigned DRG, typically as a result of CDI query responses or coding review. Tracks CDI program impact on reimbursement.',
    `drg_description` STRING COMMENT 'Full text description of the assigned DRG code (e.g., SIMPLE PNEUMONIA AND PLEURISY W MCC). Used in clinical documentation improvement workflows and reimbursement reporting.',
    `drg_version` STRING COMMENT 'The DRG classification system version used for grouping: MS-DRG (Medicare Severity), APR-DRG (All Patient Refined), or IR-DRG (International Refined). Determines the applicable reimbursement methodology and payer contract.. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `drg_version_number` STRING COMMENT 'The specific fiscal year or release version of the DRG grouper applied (e.g., v41 for MS-DRG Version 41). Required for audit trails and reimbursement reconciliation across fiscal year transitions.. Valid values are `^v?[0-9]{1,2}(.[0-9]{1,2})?$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'The relative weight assigned to the DRG, reflecting the average resource intensity of cases in that group relative to the average Medicare case. Used to calculate CMI and expected reimbursement from the base payment rate.',
    `expected_reimbursement` DECIMAL(18,2) COMMENT 'The calculated expected reimbursement amount (in USD) derived from DRG weight multiplied by the base payment rate, before outlier adjustments. Used for revenue forecasting and variance analysis against actual payments.',
    `finalized_timestamp` TIMESTAMP COMMENT 'The date and time when the DRG assignment was finalized by the coding team, triggering claim submission eligibility. Key milestone in the revenue cycle management workflow.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'The geometric mean length of stay in days for the assigned DRG, published by CMS. Used as a benchmark for LOS efficiency analysis and outlier payment threshold calculations.',
    `grouper_software` STRING COMMENT 'Name of the DRG grouper software used to assign the DRG (e.g., 3M Grouper Plus, OptumInsight Encoder). Required for audit trails and reimbursement dispute resolution.',
    `grouper_software_version` STRING COMMENT 'The specific release version of the grouper software applied (e.g., 3M Grouper Plus v32.1). Critical for audit compliance and reimbursement reconciliation when grouper logic changes between versions.',
    `grouping_date` DATE COMMENT 'The calendar date on which the DRG grouper software was executed and the DRG code was assigned. Used for tracking CDI workflow timelines and coding productivity.',
    `initial_drg_code` STRING COMMENT 'The DRG code assigned at the initial working grouping (typically at admission or during the stay), before final coding and CDI review. Compared against the final DRG to measure CDI program impact and reimbursement uplift.. Valid values are `^[0-9]{3}$`',
    `initial_drg_weight` DECIMAL(18,2) COMMENT 'The DRG relative weight associated with the initial working DRG code. Used to calculate the reimbursement uplift achieved through CDI and coding optimization.',
    `is_outlier` BOOLEAN COMMENT 'Indicates whether this encounter qualifies as a cost outlier under CMS IPPS policy, triggering additional outlier payment beyond the standard DRG payment. True when actual costs exceed the fixed-loss threshold.',
    `mdc_code` STRING COMMENT 'The Major Diagnostic Category code (01–25 plus PRE for pre-MDC) that serves as the primary clinical grouping tier above the DRG. Derived from the principal diagnosis and used for service-line analytics and CMI benchmarking.. Valid values are `^(P[RR]E|[0-9]{1,2})$`',
    `mdc_description` STRING COMMENT 'Full text description of the MDC (e.g., Diseases and Disorders of the Respiratory System). Supports service-line reporting and clinical program analytics.',
    `outlier_payment` DECIMAL(18,2) COMMENT 'Additional payment amount (in USD) approved for high-cost outlier cases where actual costs exceed the fixed-loss outlier threshold. Applicable under CMS IPPS cost outlier policy.',
    `patient_type` STRING COMMENT 'Classifies the encounter type for DRG assignment purposes: inpatient (full admission), observation (outpatient observation status), or short_stay. Determines DRG applicability and reimbursement methodology.. Valid values are `inpatient|observation|short_stay`',
    `procedure_count` STRING COMMENT 'The total number of ICD-10-PCS procedure codes submitted on the claim. Surgical procedures drive DRG assignment into surgical partitions, significantly affecting reimbursement weight.',
    `rac_review_flag` BOOLEAN COMMENT 'Indicates whether this DRG assignment has been selected for review by a Recovery Audit Contractor (RAC) under the CMS RAC program. Triggers additional documentation retention and appeal workflow.',
    `transfer_case_flag` BOOLEAN COMMENT 'Indicates whether this encounter is a transfer case subject to the post-acute care transfer (PACT) policy, which may reduce DRG payment when the patient is transferred to a post-acute care setting before the geometric mean LOS.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this DRG assignment record was last modified. Tracks amendments from CDI queries, coding audits, or payer appeals.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    CONSTRAINT pk_drg_assignment PRIMARY KEY(`drg_assignment_id`)
) COMMENT 'Diagnosis-Related Group assignment record for inpatient visit reimbursement classification.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` (
    `visit_diagnosis_id` BIGINT COMMENT 'Unique surrogate identifier for each visit diagnosis record in the Silver layer lakehouse. Primary key for this encounter-level diagnosis entity. Role: TRANSACTION_LINE — this record is a line-level diagnosis attached to a parent encounter/visit header.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician responsible for the patients care during this encounter, as associated with this diagnosis. Used for provider-level quality reporting, MIPS attribution, and UB-04 claim form population. Aligns with PARTY_REFERENCE canonical category.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Core clinical coding workflow—every diagnosis on a visit must reference the official ICD-10 code set for billing compliance, quality reporting, HCC risk adjustment, and clinical documentation integrit',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with this visit diagnosis. Supports patient-level longitudinal diagnosis history, population health analytics, and risk adjustment. Classified as restricted PHI per HIPAA.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical terminology mapping—SNOMED codes on diagnoses must reference the official SNOMED CT concept for interoperability, clinical decision support, quality measure reporting, and data exchange with ',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the parent encounter/visit record. Establishes the HEADER_REFERENCE relationship linking this diagnosis line to its owning visit. Central to DRG grouping, quality reporting, and revenue cycle processing.',
    `bill_indicator` BOOLEAN COMMENT 'Indicates whether this diagnosis code is included on the claim submitted to the payer. True = included on the claim. Some diagnoses may be documented clinically but excluded from billing (e.g., working diagnoses, non-billable codes). Drives UB-04 and CMS-1500 claim form population.',
    `cc_mcc_indicator` STRING COMMENT 'Classifies this diagnosis as a Complication/Comorbidity (CC), Major Complication/Comorbidity (MCC), Hospital-Acquired Condition (HAC), or none. Directly impacts MS-DRG assignment and inpatient reimbursement under IPPS. Sourced from 3M HIS grouper output and CMS CC/MCC exclusion lists.. Valid values are `CC|MCC|HAC|none`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a chronic condition as defined by CMS Chronic Condition Warehouse (CCW) or clinical classification standards. True = chronic condition. Supports population health management, care management program enrollment, HEDIS chronic disease measure attribution, and SDOH analysis.',
    `coded_date` DATE COMMENT 'The date on which the ICD-10-CM code was assigned to this diagnosis by the HIM coding team. Used for coding productivity tracking, CDI program metrics, and revenue cycle timeliness reporting. Sourced from 3M HIS and Epic Resolute coding workflows.',
    `coding_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the clinician or coder who assigned or attested this diagnosis code. Used for audit trails, CDI accountability, RAC audit defense, and provider-level coding quality reporting. Sourced from 3M HIS and Epic ClinDoc coding workflows.. Valid values are `^[0-9]{10}$`',
    `coding_status` STRING COMMENT 'Current workflow status of this diagnosis record within the HIM/CDI coding lifecycle. pending indicates awaiting coder review; coded indicates initial code assignment; validated indicates coder-confirmed; queried indicates a CDI query has been issued; amended indicates a post-bill correction; final indicates billing-ready. Drives revenue cycle workflow and CDI query management in 3M HIS and Epic Resolute.. Valid values are `pending|coded|validated|queried|amended|final`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this visit diagnosis record was first created in the source system or ingested into the Silver layer. Supports audit trail, data lineage, and RECORD_AUDIT_CREATED canonical category requirement.',
    `diagnosis_rank` STRING COMMENT 'Clinical ranking of this diagnosis by severity or clinical significance within the encounter, as assigned by the coding team or clinical documentation system. Distinct from diagnosis_seq_num (billing sequence); this rank reflects clinical priority for care management and quality reporting purposes.',
    `diagnosis_seq_num` STRING COMMENT 'Ordinal position of this diagnosis within the encounters diagnosis list. Sequence 1 typically denotes the principal diagnosis. Used for claim form ordering (UB-04 diagnosis fields), DRG grouping logic, and quality measure attribution. Aligns with LINE_SEQUENCE canonical category.',
    `diagnosis_source` STRING COMMENT 'Identifies who or what originated this diagnosis record. physician = entered by the treating clinician; coder = assigned by HIM coding staff; cdi_specialist = added via CDI query resolution; system = auto-populated by clinical decision support; imported = received via HIE or external system. Supports audit trail and coding accountability.. Valid values are `physician|coder|cdi_specialist|system|imported`',
    `diagnosis_type` STRING COMMENT 'Classification of the diagnosis role within the encounter. admitting is the reason for admission; principal is the condition chiefly responsible for the stay after study; secondary are comorbidities and complications; discharge is the final coded diagnosis at discharge; working is a provisional diagnosis during the encounter; final is the confirmed diagnosis post-workup. Drives DRG assignment and UB-04/CMS-1500 claim form population.. Valid values are `admitting|principal|secondary|discharge|working|final`',
    `drg_code` STRING COMMENT 'The MS-DRG or APR-DRG code assigned to the encounter as influenced by this diagnosis. Populated after DRG grouping by 3M HIS or CMS grouper. Central to inpatient reimbursement under IPPS and case mix index (CMI) calculation.. Valid values are `^[0-9]{3}$`',
    `drg_relevance_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code contributes to the DRG assignment for this encounter. True = this diagnosis is a complication/comorbidity (CC) or major complication/comorbidity (MCC) that affects DRG grouping and reimbursement. Critical for revenue cycle optimization and CDI program targeting.',
    `drg_type` STRING COMMENT 'Specifies the DRG classification system used: MS-DRG (Medicare Severity DRG, CMS), APR-DRG (All Patient Refined DRG, 3M), or IR-DRG (International Refined DRG). Determines the reimbursement methodology and payer applicability.. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `encounter_diagnosis_comment` STRING COMMENT 'Free-text clinical comment or qualifier associated with this diagnosis record, as entered by the coding team or clinician. May include specificity notes, CDI query resolution rationale, or coding clarifications. Classified as restricted PHI per HIPAA.',
    `encounter_diagnosis_source_code` STRING COMMENT 'The native identifier for this diagnosis record in the source operational system (e.g., Epic ClinDoc diagnosis ID or Cerner PowerChart diagnosis ID). Supports ETL lineage, data reconciliation, and source system audit trails in the Silver layer.',
    `external_cause_code` STRING COMMENT 'ICD-10-CM external cause code (V, W, X, Y codes) documenting the cause, place of occurrence, activity, and status for injury and poisoning diagnoses. Required for trauma registries, injury surveillance, workers compensation claims, and public health reporting.. Valid values are `^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$`',
    `hai_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a healthcare-associated infection (HAI) such as CLABSI, CAUTI, or SSI. True = HAI diagnosis. Triggers HAI surveillance workflows, CMS HAC Reduction Program payment adjustments, and TJC infection control reporting.',
    `hcc_category_code` STRING COMMENT 'The specific CMS HCC category code to which this ICD-10-CM diagnosis maps. Populated only when hcc_flag is True. Used for risk score calculation in Medicare Advantage, ACO, and MIPS/APM programs. Sourced from CMS HCC mapping crosswalk tables.',
    `hcc_flag` BOOLEAN COMMENT 'Indicates whether this ICD-10-CM diagnosis code maps to a CMS Hierarchical Condition Category (HCC) used for risk adjustment in Medicare Advantage and ACO programs. True = this diagnosis contributes to the patients HCC risk score. Critical for population health management, value-based care contracting, and capitation payment accuracy.',
    `icd10_code` STRING COMMENT 'The ICD-10-CM diagnosis code assigned to this visit. Drives DRG grouping, quality measure attribution, risk adjustment (HCC mapping), and medical billing. Sourced from Epic ClinDoc and validated through 3M HIS coding workflows. Conforms to WHO ICD-10-CM code format.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `icd10_description` STRING COMMENT 'Full clinical description of the ICD-10-CM diagnosis code as defined by the WHO/CMS code set. Provides human-readable context for the coded diagnosis. Used in clinical documentation, reporting, and CDI workflows.',
    `icd10_version` STRING COMMENT 'The fiscal year version of the ICD-10-CM code set used to assign this diagnosis code (e.g., FY2024). ICD-10-CM is updated annually by CMS/CDC. Ensures accurate code interpretation across fiscal year transitions and supports historical data analysis.. Valid values are `^FY[0-9]{4}$`',
    `mental_health_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is classified as a mental health or behavioral health condition per ICD-10-CM Chapter 5 (F-codes). True = mental/behavioral health diagnosis. Supports behavioral health program management, parity compliance reporting, and population health segmentation.',
    `onset_date` DATE COMMENT 'The date on which the diagnosed condition first manifested or was first identified, as documented in the clinical record. Supports longitudinal disease tracking, chronic condition management, POA determination, and population health analytics. Aligns with BUSINESS_EVENT_TIMESTAMP canonical category.',
    `poa_indicator` STRING COMMENT 'Indicates whether the diagnosis condition was present at the time of inpatient admission. Values: Y=Yes (present on admission), N=No (not present on admission), U=Unknown, W=Clinically undetermined, 1=Exempt from POA reporting. Required by CMS for inpatient claims on UB-04. Impacts HAI reporting, VBP penalties, and hospital-acquired condition (HAC) payment adjustments.. Valid values are `Y|N|U|W|1`',
    `primary_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is designated as the primary/principal diagnosis for the encounter. True = primary diagnosis. Provides a quick boolean filter for analytics and reporting without requiring sequence number logic. Complements diagnosis_seq_num and diagnosis_type.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis contributes to one or more quality measure denominators or numerators (e.g., HEDIS, MIPS, VBP, TJC core measures). True = this diagnosis is relevant to at least one active quality measure. Supports quality reporting, MIPS scoring, and VBP program management.',
    `reportable_condition_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is a notifiable/reportable condition requiring mandatory reporting to public health authorities (e.g., state health departments, CDC). True = reportable. Supports public health surveillance, regulatory compliance, and HIE reporting obligations.',
    `resolved_date` DATE COMMENT 'The date on which the diagnosed condition was resolved, abated, or no longer active, as documented in the clinical record. Null if the condition is ongoing. Used for chronic disease management, care plan updates, and longitudinal patient health tracking.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code represents a Social Determinants of Health (SDOH) factor (e.g., Z-codes for housing instability, food insecurity, transportation barriers). True = SDOH-related diagnosis. Supports population health management, care coordination, and CMS SDOH reporting initiatives.',
    `snomed_code` STRING COMMENT 'The SNOMED CT concept identifier mapped to this ICD-10-CM diagnosis code. Supports clinical interoperability, HL7 FHIR-based HIE data exchange, and clinical decision support. Populated via ICD-10 to SNOMED CT crosswalk. Used in FHIR Condition resources for interoperability.. Valid values are `^[0-9]{6,18}$`',
    `substance_use_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a substance use disorder (SUD) per ICD-10-CM codes. True = substance use disorder diagnosis. Supports SUD program management, 42 CFR Part 2 confidentiality compliance, and population health analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this visit diagnosis record was last modified in the source system or Silver layer. Supports change data capture, audit trail, and RECORD_AUDIT_UPDATED canonical category requirement.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    CONSTRAINT pk_visit_diagnosis PRIMARY KEY(`visit_diagnosis_id`)
) COMMENT 'Diagnosis recorded during a visit, including ICD-10 coding, POA indicator, and DRG relevance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` (
    `visit_procedure_id` BIGINT COMMENT 'Unique surrogate identifier for each procedure record performed during a patient visit. Primary key for the visit_procedure data product in the encounter domain.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Charge capture reconciliation requires linking the billed procedure (visit_procedure) to the clinical procedure documentation (procedure_event). Surgical quality reporting, CDI, and charge integrity a',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Essential procedure coding workflow—every CPT code on a visit procedure must validate against the official CPT reference for claims submission, reimbursement calculation, RVU assignment, and NCCI edit',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Revenue cycle charge capture: each procedures expected reimbursement is calculated against a specific fee schedule line (CPT/HCPCS + payer contract rate). Healthcare revenue cycle teams require this ',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Required for HCPCS procedure coding—DME, supplies, drugs, and non-physician services must reference official HCPCS codes for billing, coverage determination, and reimbursement. Critical for outpatient',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Inpatient procedure coding workflow—ICD-10-PCS codes must validate against the official ICD-10 code set for inpatient claims submission, DRG grouping, and quality measure reporting. Required for hospi',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient on whom the procedure was performed. Supports patient-level procedure history, quality measurement, and population health analytics.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Procedures are performed at specific facilities — facility-level procedure volume reporting, credentialing scope verification (privileges are org_provider-specific), and CMS quality measure attributio',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who performed the procedure. Used for provider-level quality reporting, credentialing validation, and RVU attribution.',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Enables retrospective verification that performing clinician held valid privileges for the specific procedure at the facility on the procedure date. Required for peer review, quality assurance audits,',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Procedure terminology mapping—SNOMED codes on procedures must reference official SNOMED CT for clinical documentation, interoperability, and data exchange with external systems. Required for USCDI com',
    `visit_id` BIGINT COMMENT 'Reference to the parent encounter/visit during which this procedure was performed. Links the procedure to the ADT event, visit type, and associated clinical and billing context.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia administered during the procedure. Drives anesthesia CPT code selection, anesthesia time unit billing, ASA physical status documentation, and OR case complexity classification.. Valid values are `general|regional|local|monitored_anesthesia_care|none`',
    `asa_class` STRING COMMENT 'ASA physical status classification assigned by the anesthesiologist prior to the procedure, reflecting the patients overall health status. Used for anesthesia risk stratification, surgical case complexity scoring, and outcomes risk adjustment.. Valid values are `I|II|III|IV|V|VI`',
    `body_site` STRING COMMENT 'Anatomical location or body site where the procedure was performed, coded using SNOMED CT body structure concepts. Supports surgical safety documentation, quality measure stratification, and clinical analytics.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why a scheduled procedure was cancelled (e.g., patient not ready, equipment unavailable, surgeon unavailable, insurance denial). Populated only when is_cancelled is true. Supports root cause analysis and OR efficiency improvement.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount posted to the patient account for this procedure based on the CDM. Represents the billed amount before contractual adjustments, payer discounts, or patient responsibility. Used in revenue cycle management and financial reporting.',
    `charge_code` STRING COMMENT 'Internal charge code from the Charge Description Master (CDM) mapped to this procedure. Links the clinical procedure to the revenue cycle for charge capture, pricing, and claim generation in Epic Resolute or Cerner Revenue Cycle.',
    `complication_description` STRING COMMENT 'Free-text or coded description of the complication that occurred during or after the procedure. Populated only when complication_flag is true. Used for clinical documentation, quality review, and risk management reporting.',
    `complication_flag` BOOLEAN COMMENT 'Indicates whether a complication was documented as occurring during or immediately following the procedure. Triggers CDI query workflow, quality event review, and HAI/PSI surveillance reporting.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was documented as obtained from the patient or legal guardian prior to the procedure. Required for regulatory compliance, malpractice risk management, and The Joint Commission accreditation standards.',
    `cpt_code` STRING COMMENT 'AMA CPT code identifying the procedure for professional billing, charge capture, and payer adjudication. Required on CMS-1500 claims. Drives RVU calculation and reimbursement.. Valid values are `^[0-9]{4}[0-9A-Z]$`',
    `cpt_modifier_1` STRING COMMENT 'Primary CPT modifier appended to the procedure code to indicate special circumstances (e.g., 50=bilateral, LT=left side, RT=right side, 22=increased procedural services, 59=distinct procedural service). Required for accurate claim adjudication.. Valid values are `^[A-Z0-9]{2}$`',
    `cpt_modifier_2` STRING COMMENT 'Secondary CPT modifier providing additional claim specificity when a single modifier is insufficient. Used in conjunction with cpt_modifier_1 for complex billing scenarios per CMS Correct Coding Initiative.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procedure record was first created in the source system. Used for audit trail, data lineage, and regulatory compliance documentation per HIPAA and The Joint Commission medical record requirements.',
    `drg_relevant_flag` BOOLEAN COMMENT 'Indicates whether this procedure influences the DRG assignment for the inpatient encounter. Flagged by the 3M grouper or equivalent DRG grouping engine. Critical for inpatient revenue integrity and CDI prioritization.',
    `hcpcs_code` STRING COMMENT 'HCPCS Level II code used when a CPT code is not applicable, primarily for supplies, durable medical equipment, and non-physician services billed to Medicare/Medicaid. Complements CPT on UB-04 and CMS-1500 claims.. Valid values are `^[A-Z][0-9]{4}$`',
    `icd10_pcs_code` STRING COMMENT 'ICD-10-PCS code assigned for inpatient procedures. Required for inpatient DRG grouping, UB-04 institutional claims, and CMS inpatient prospective payment system (IPPS) reimbursement. Not applicable for outpatient encounters.. Valid values are `^[0-9A-HJ-NP-Z]{7}$`',
    `implant_flag` BOOLEAN COMMENT 'Indicates whether a medical device or implant was used during the procedure. Triggers UDI (Unique Device Identifier) documentation requirements per FDA regulations and supply chain charge capture workflows.',
    `is_cancelled` BOOLEAN COMMENT 'Indicates whether a scheduled procedure was cancelled before execution. Used for OR cancellation rate reporting, scheduling efficiency analysis, and revenue impact assessment.',
    `is_elective` BOOLEAN COMMENT 'Indicates whether the procedure was scheduled as elective (non-urgent) versus emergent or urgent. Supports surgical scheduling analytics, OR block time management, and payer prior authorization workflows.',
    `is_principal_procedure` BOOLEAN COMMENT 'Indicates whether this is the principal procedure performed for the encounter, as defined by the Uniform Hospital Discharge Data Set (UHDDS). The principal procedure is the one most closely related to the principal diagnosis and drives DRG assignment for inpatient cases.',
    `laterality` STRING COMMENT 'Body side on which the procedure was performed. Required for correct CPT modifier assignment (RT/LT/50), surgical safety checklists, and wrong-site surgery prevention per The Joint Commission Universal Protocol.. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `performing_provider_npi` STRING COMMENT '10-digit NPI of the performing provider as required on CMS-1500 and UB-04 claims. Stored denormalized here for claim generation and audit purposes, as the NPI is a regulatory billing requirement independent of the provider master record.. Valid values are `^[0-9]{10}$`',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed. Used for charge capture date-of-service, quality measure denominator identification, and surgical case scheduling analytics.',
    `procedure_description` STRING COMMENT 'Full clinical description of the procedure as documented in the source system (Epic ClinDoc, OpTime, or Cerner SurgiNet). Provides human-readable context for the CPT/HCPCS/ICD-10-PCS code.',
    `procedure_end_timestamp` TIMESTAMP COMMENT 'Date and time when the procedure was completed (closure for surgical cases, or final clinical action for non-surgical). Combined with start timestamp to derive procedure duration for OR utilization and case costing.',
    `procedure_number` STRING COMMENT 'Externally visible, human-readable identifier assigned to this procedure record within the source system (e.g., Epic OpTime case number or Cerner SurgiNet procedure order number). Used for cross-system reconciliation and audit.',
    `procedure_start_timestamp` TIMESTAMP COMMENT 'Date and time when the procedure began (knife-to-skin for surgical cases, or first clinical action for non-surgical). Used for OR utilization analysis, case duration calculation, and scheduling efficiency reporting.',
    `procedure_status` STRING COMMENT 'Current workflow status of the procedure record per HL7 FHIR Procedure.status value set. Drives charge capture eligibility, quality measure inclusion/exclusion, and CDI workflow routing.. Valid values are `completed|in-progress|not-done|entered-in-error|unknown`',
    `procedure_type` STRING COMMENT 'High-level classification of the procedure category. Supports operational reporting, OR scheduling, charge master (CDM) mapping, and departmental cost allocation. [ENUM-REF-CANDIDATE: surgical|diagnostic|therapeutic|anesthesia|radiology|laboratory|nursing|other — promote to reference product]',
    `quantity` STRING COMMENT 'Number of times this procedure was performed or units billed within the encounter. Used for charge capture accuracy, claim line quantity reporting, and utilization analysis.',
    `rvu_total` DECIMAL(18,2) COMMENT 'Total RVU for the procedure, comprising work RVU, practice expense RVU, and malpractice RVU components per the CMS Physician Fee Schedule. Used for overall provider productivity benchmarking and reimbursement modeling.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Physician work RVU assigned to this procedure per the CMS Physician Fee Schedule. Represents the time, skill, and intensity of the physicians work. Used for provider productivity measurement, compensation modeling, and MIPS performance reporting.',
    `sequence_number` STRING COMMENT 'Ordinal position of this procedure within the encounter, used to distinguish principal from secondary procedures on claims. Sequence 1 typically denotes the principal procedure for DRG grouping and IPPS reimbursement.',
    `snomed_code` STRING COMMENT 'SNOMED CT concept identifier for the procedure, providing a clinically precise, interoperable representation beyond CPT/ICD-10-PCS. Supports HIE data exchange, FHIR-based interoperability, and clinical decision support.. Valid values are `^[0-9]{6,18}$`',
    `source_system_procedure_code` STRING COMMENT 'Native identifier of this procedure record in the originating source system (e.g., Epic OpTime case ID, Cerner SurgiNet order ID). Enables bidirectional traceability between the lakehouse silver layer and the operational EHR system.',
    `surgical_approach` STRING COMMENT 'Method or technique used to access the operative site. Drives ICD-10-PCS character 5 (approach) coding, surgical case complexity classification, and outcomes benchmarking.. Valid values are `open|laparoscopic|robotic|endoscopic|percutaneous|other`',
    `timeout_performed_flag` BOOLEAN COMMENT 'Indicates whether the pre-procedure surgical time-out (Universal Protocol) was performed and documented, confirming correct patient, site, and procedure. Required by The Joint Commission Universal Protocol for preventing wrong-site surgery.',
    `udi` STRING COMMENT 'FDA-assigned Unique Device Identifier for any medical device or implant used during the procedure. Required for FDA MDR (Medical Device Reporting), recall management, and supply chain traceability. Populated only when implant_flag is true.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this procedure record in the source system. Supports incremental ETL processing, change data capture, and audit trail requirements for medical record integrity.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `wound_class` STRING COMMENT 'CDC wound classification assigned at the time of surgery, indicating the degree of microbial contamination. Used for SSI (Surgical Site Infection) risk stratification, HAI surveillance, and quality reporting to NHSN.. Valid values are `clean|clean_contaminated|contaminated|dirty_infected`',
    CONSTRAINT pk_visit_procedure PRIMARY KEY(`visit_procedure_id`)
) COMMENT 'Procedure performed during a visit, including CPT/ICD-10-PCS coding and clinical details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` (
    `bed_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each bed assignment record in the lakehouse Silver layer. Primary key for the bed_assignment data product.',
    `adt_event_id` BIGINT COMMENT 'Foreign key linking to encounter.adt_event. Business justification: A bed assignment is directly triggered by an ADT (Admit/Discharge/Transfer) event. The bed_assignment table currently carries adt_event_type as a denormalized string describing the triggering event ty',
    `clinician_id` BIGINT COMMENT 'Reference to the attending or admitting provider responsible for the patient at the time of bed assignment. Used for provider-level capacity and workload reporting.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient assigned to this bed. Supports patient-level bed utilization tracking and HAI (Healthcare-Associated Infection) isolation compliance.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: Elective and pre-scheduled admissions are driven by a booked open slot; linking bed_assignment to the originating open_slot enables bed management capacity planning, request-to-assignment time analyti',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) associated with this bed assignment. Links the bed assignment to the core encounter record for the patient visit.',
    `admission_date` DATE COMMENT 'Calendar date of the patients hospital admission associated with this bed assignment. Used for LOS (Length of Stay) calculation, DRG (Diagnosis-Related Group) assignment, and CMS reporting.',
    `admission_source_code` STRING COMMENT 'Standardized CMS admission source code indicating how the patient arrived for this admission (e.g., 1 = physician referral, 4 = transfer from hospital, 7 = emergency room). Required for UB-04 billing and CMS quality reporting. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|D|E|F — promote to reference product]',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Date and time when the patient vacated the assigned bed, either through discharge, transfer, or death. Null if the assignment is still active. Used to compute bed occupancy duration.',
    `assignment_number` STRING COMMENT 'Externally visible, human-readable identifier for this bed assignment event as generated by the ADT (Admit, Discharge, Transfer) system. Used for operational tracking and audit trails.',
    `assignment_reason` STRING COMMENT 'Clinical or operational reason for this specific bed assignment event. admission = initial placement upon admission; transfer = moved from another bed/unit; upgrade = moved to higher acuity bed; downgrade = moved to lower acuity bed; isolation_precaution = placed for infection control; overflow = placed due to capacity constraints; elective = planned placement. [ENUM-REF-CANDIDATE: admission|transfer|upgrade|downgrade|isolation_precaution|overflow|elective|post_procedure|observation_conversion — promote to reference product]',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Date and time when the patient was physically placed in the assigned bed. Principal business event timestamp for the bed assignment lifecycle. Used for LOS (Length of Stay) calculation and capacity analytics.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the bed assignment. pending indicates a bed request has been made but not yet fulfilled; active indicates the patient is currently occupying the bed; completed indicates the patient has vacated; cancelled indicates the assignment was voided; transferred indicates the patient moved to another bed.. Valid values are `pending|active|completed|cancelled|transferred`',
    `bed_class` STRING COMMENT 'Regulatory classification of the bed for CMS (Centers for Medicare and Medicaid Services) reporting and reimbursement purposes. Determines whether the bed counts toward licensed inpatient capacity or outpatient/observation capacity. [ENUM-REF-CANDIDATE: inpatient|outpatient|observation|emergency|behavioral_health|rehabilitation|long_term_care|skilled_nursing — promote to reference product]. Valid values are `inpatient|outpatient|observation|emergency|behavioral_health|rehabilitation`',
    `bed_gender_designation` STRING COMMENT 'Gender designation of the bed for patient placement purposes. male = designated for male patients; female = designated for female patients; any = no gender restriction. Used for bed placement rules and patient privacy compliance.. Valid values are `male|female|any`',
    `bed_hold_reason` STRING COMMENT 'Reason the bed is being held for a patient who is temporarily off the unit (e.g., for a procedure, imaging, or therapy). none indicates no hold is in effect. Used for bed availability accuracy and capacity management.. Valid values are `procedure|imaging|therapy|family_request|clinical_hold|none`',
    `bed_label` STRING COMMENT 'Human-readable label or name of the bed as displayed in the ADT system (e.g., 4B-12A). Used by nursing staff and bed coordinators for operational identification.',
    `bed_request_source` STRING COMMENT 'Origin point from which the bed request was initiated. ed = Emergency Department; or = Operating Room post-procedure; icu = ICU step-down; direct_admit = direct admission from clinic or physician office; transfer_center = inter-facility transfer; observation = conversion from observation status; pacu = Post-Anesthesia Care Unit. Used for bed flow analysis and throughput optimization. [ENUM-REF-CANDIDATE: ed|or|icu|direct_admit|transfer_center|observation|pacu — 7 candidates stripped; promote to reference product]',
    `bed_type` STRING COMMENT 'Clinical classification of the bed based on care intensity and equipment capability. icu = Intensive Care Unit bed; telemetry = cardiac monitoring bed; med_surg = medical-surgical bed; isolation = negative pressure or contact precaution bed; observation = short-stay observation bed; step_down = intermediate care bed. Drives staffing ratios, reimbursement, and HAI (Healthcare-Associated Infection) tracking.. Valid values are `icu|telemetry|med_surg|isolation|observation|step_down`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bed assignment record was first created in the source ADT system. Supports audit trail and data lineage requirements.',
    `discharge_date` DATE COMMENT 'Calendar date of the patients discharge from the facility associated with this bed assignment. Null if the patient is still admitted. Used for ALOS (Average Length of Stay) reporting and DRG (Diagnosis-Related Group) reimbursement.',
    `discharge_disposition_code` STRING COMMENT 'Standardized CMS discharge disposition code indicating where the patient went upon leaving this bed assignment (e.g., 01 = home, 02 = short-term hospital, 03 = SNF, 20 = expired). Required for UB-04 billing and CMS quality reporting. [ENUM-REF-CANDIDATE: 01|02|03|04|05|06|07|20|21|30|43|50|51|61|62|63|64|65|66|69|70|71|72|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99 — promote to reference product]',
    `expected_discharge_date` DATE COMMENT 'Clinician-estimated date of patient discharge from this bed assignment. Used for discharge planning, bed availability forecasting, and ALOS (Average Length of Stay) management. Sourced from Epic Discharge Planning or Cerner Millennium care management workflows.',
    `floor_number` STRING COMMENT 'Physical floor or level of the facility building where the bed is located. Used for facility management, emergency evacuation planning, and environmental services routing.',
    `housekeeping_status_at_assignment` STRING COMMENT 'Environmental services (EVS) status of the bed at the moment of patient assignment. clean = bed was verified clean and ready; dirty = bed had not yet been cleaned (emergency placement); in_progress = cleaning was underway; inspected = cleaning completed and inspected; out_of_service = bed was flagged as unavailable. Critical for HAI (Healthcare-Associated Infection) prevention audits and EVS performance measurement.. Valid values are `clean|dirty|in_progress|inspected|out_of_service`',
    `is_isolation_bed` BOOLEAN COMMENT 'Indicates whether this bed is designated as a negative pressure or isolation room capable of supporting infection control precautions. True = isolation-capable bed; False = standard bed. Used for capacity planning of isolation-capable beds and HAI (Healthcare-Associated Infection) compliance reporting.',
    `is_observation_status` BOOLEAN COMMENT 'Indicates whether the patient is under CMS observation status (rather than formal inpatient admission) during this bed assignment. True = observation status; False = inpatient or other status. Critical for CMS Two-Midnight Rule compliance, Medicare Part A vs. Part B billing, and patient financial counseling obligations under the NOTICE Act.',
    `is_private_room` BOOLEAN COMMENT 'Indicates whether the bed is located in a private single-occupancy room. True = private room; False = semi-private or multi-bed room. Relevant for infection control, patient satisfaction (CAHPS), and revenue for private room upgrades.',
    `is_telemetry_monitored` BOOLEAN COMMENT 'Indicates whether the patient in this bed assignment is connected to continuous cardiac telemetry monitoring. True = telemetry active; False = no telemetry. Used for telemetry capacity management and nursing workload planning.',
    `isolation_type` STRING COMMENT 'Type of infection control isolation precaution in effect for this bed assignment. contact = contact precautions (e.g., MRSA, C. diff); droplet = droplet precautions (e.g., influenza); airborne = airborne precautions (e.g., TB, COVID-19); protective = reverse isolation for immunocompromised patients; none = no isolation required. Critical for HAI (Healthcare-Associated Infection) tracking including CLABSI, CAUTI, and SSI prevention.. Valid values are `contact|droplet|airborne|protective|none`',
    `los_days` DECIMAL(18,2) COMMENT 'Number of days the patient occupied this specific bed assignment, calculated as the difference between assignment end and start timestamps expressed in fractional days. Supports ALOS (Average Length of Stay) benchmarking, CMI (Case Mix Index) analysis, and capacity planning. Note: this is bed-level LOS, not encounter-level LOS.',
    `nursing_station_code` STRING COMMENT 'Code identifying the nursing station responsible for this bed. Used for nursing assignment, medication administration routing (MAR), and staffing ratio compliance reporting.',
    `patient_class` STRING COMMENT 'CMS-defined patient classification status at the time of this bed assignment. Determines reimbursement pathway (inpatient DRG vs. outpatient APC), two-midnight rule applicability, and Medicare Part A vs. Part B billing. observation status has significant patient financial implications under CMS rules.. Valid values are `inpatient|outpatient|observation|emergency|recurring|preadmit`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the bed request was initiated by the clinical team or bed coordinator. Used to calculate bed request-to-assignment elapsed time, a key operational KPI (Key Performance Indicator) for bed management efficiency.',
    `request_to_assignment_minutes` STRING COMMENT 'Elapsed time in minutes between the bed request timestamp and the assignment start timestamp. Key operational KPI (Key Performance Indicator) for bed management throughput and ED (Emergency Department) boarding reduction. Sourced from Epic ADT or Cerner Bed Board workflow timestamps.',
    `room_number` STRING COMMENT 'Room number within the unit or ward where the bed is located. Used for wayfinding, nursing assignments, and infection control zone tracking.',
    `sequence` STRING COMMENT 'Sequential ordinal number of this bed assignment within the patients encounter, starting at 1 for the first bed assignment. Used to reconstruct the patients bed movement history throughout a visit and calculate total number of transfers.',
    `source_system_assignment_code` STRING COMMENT 'Native identifier of this bed assignment record in the originating operational system (Epic ADT, Cerner Millennium, or MEDITECH Expanse). Used for cross-system reconciliation, data lineage tracing, and support of HIE (Health Information Exchange) integrations.',
    `unit_code` STRING COMMENT 'Standardized alphanumeric code identifying the clinical unit or ward in the facilitys master data. Used for cross-system reporting and integration with billing and staffing systems.',
    `unit_name` STRING COMMENT 'Name of the clinical unit or ward where the bed is located (e.g., Medical ICU, 4 North Med-Surg, ED Observation). Used for unit-level capacity planning and staffing analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this bed assignment record was last modified in the source ADT system. Supports change tracking and incremental ETL (Extract, Transform, Load) processing.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `wing_or_pod` STRING COMMENT 'Sub-unit designation within a nursing unit identifying the wing, pod, or cluster where the bed is located (e.g., North Wing, Pod A). Used for nursing assignment optimization and infection control zone management.',
    CONSTRAINT pk_bed_assignment PRIMARY KEY(`bed_assignment_id`)
) COMMENT 'Bed assignment record tracking patient placement in specific beds during a visit.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` (
    `visit_insurance_id` BIGINT COMMENT 'Unique surrogate identifier for the visit insurance record. Primary key for the visit_insurance data product within the encounter domain.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to encounter.encounter_authorization. Business justification: Visit insurance records carry authorization details (authorization_number, authorization_status, authorization_effective_date, authorization_expiration_date) that are fully owned by the encounter_auth',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Visit insurance records denormalize plan_name and plan_type but lack FK to health_plan. Direct link is essential for benefit determination, claims adjudication, and cost-sharing calculation—core reven',
    `payer_contract_id` BIGINT COMMENT 'Identifier of the payer contract or fee schedule agreement under which services for this visit will be reimbursed. Used in contract management and expected reimbursement calculation.',
    `payer_id` BIGINT COMMENT 'Reference to the payer (insurance company or government program) responsible for reimbursement for this visit. Links to the payer reference entity.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identification number assigned by the payer to identify the insured individual on the insurance card and in payer systems. Required for eligibility verification and claims submission.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the primary policyholder (subscriber) as assigned by the payer. May differ from the patients member ID when the patient is a dependent.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter to which this insurance coverage record is associated. Core linkage to the encounter domain.',
    `billing_npi` STRING COMMENT 'National Provider Identifier (NPI) of the billing provider or organization submitted to the payer for this visit. Required on CMS-1500 and UB-04 claim forms.. Valid values are `^[0-9]{10}$`',
    `claim_form_type` STRING COMMENT 'Type of claim form used to bill the payer for this visit. CMS_1500 = professional/physician claims; UB_04 = institutional/facility claims; ELECTRONIC_837P = electronic professional claim; ELECTRONIC_837I = electronic institutional claim.. Valid values are `CMS_1500|UB_04|ELECTRONIC_837P|ELECTRONIC_837I`',
    `cob_notes` STRING COMMENT 'Free-text notes related to coordination of benefits (COB) for this visit, capturing special instructions, payer-specific COB rules, or manual overrides documented by revenue cycle staff.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Patients coinsurance percentage (expressed as a decimal, e.g., 0.20 = 20%) representing the share of covered service costs the patient is responsible for after the deductible is met.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the patient is responsible for paying at the time of service as defined by the insurance plan for this visit type. Used in patient financial counseling and billing.',
    `coverage_effective_date` DATE COMMENT 'Date on which the patients insurance coverage under this plan became effective. Used to confirm coverage was active at the time of the visit.',
    `coverage_sequence` STRING COMMENT 'Coordination of Benefits (COB) sequence number indicating the order in which payers are billed. 1 = primary, 2 = secondary, 3 = tertiary. Governs payer billing priority per COB rules.',
    `coverage_termination_date` DATE COMMENT 'Date on which the patients insurance coverage under this plan ends or was terminated. Null if coverage is open-ended or still active. Used to validate coverage at time of service.',
    `coverage_type` STRING COMMENT 'Type of insurance coverage applicable to this visit. Determines which benefit category applies for claims adjudication. MEDICAL = general medical/surgical; DENTAL; VISION; BEHAVIORAL_HEALTH = mental health/substance use; PHARMACY.. Valid values are `MEDICAL|DENTAL|VISION|BEHAVIORAL_HEALTH|PHARMACY`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this visit insurance record was first created in the system. Supports audit trail and data lineage tracking per HIPAA and internal data governance requirements.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the patient must meet before the insurance plan begins paying for covered services. Sourced from eligibility verification response for patient financial counseling.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the patients annual deductible that has already been satisfied as of the date of this visit. Used to estimate patient financial responsibility.',
    `eligibility_status` STRING COMMENT 'Current status of the insurance eligibility verification for this visit. Indicates whether the patients coverage has been confirmed active with the payer at the time of service.. Valid values are `VERIFIED|PENDING|INACTIVE|UNABLE_TO_VERIFY|NOT_ELIGIBLE`',
    `eligibility_verification_method` STRING COMMENT 'Method used to verify the patients insurance eligibility. ELECTRONIC = automated 270/271 transaction; PHONE = staff called payer; PORTAL = payer web portal; MANUAL = paper/fax; REAL_TIME = real-time API query.. Valid values are `ELECTRONIC|PHONE|PORTAL|MANUAL|REAL_TIME`',
    `eligibility_verified_date` DATE COMMENT 'Date on which the patients insurance eligibility was last verified with the payer for this visit. Used to confirm coverage was active at the time of service.',
    `financial_class` STRING COMMENT 'Financial classification assigned to the visit based on the primary payer, used for revenue cycle management (RCM), billing workflow routing, and financial reporting. Examples: Commercial, Medicare, Medicaid, Self-Pay, Workers Comp, Charity Care. [ENUM-REF-CANDIDATE: COMMERCIAL|MEDICARE|MEDICAID|SELF_PAY|WORKERS_COMP|CHARITY_CARE|TRICARE|MANAGED_CARE — promote to reference product]',
    `group_number` STRING COMMENT 'Group policy number assigned by the payer to identify the employer group or association under which the patients insurance plan is issued. Used in claims submission and eligibility verification.',
    `insurance_type_code` STRING COMMENT 'Standardized payer-assigned or industry-standard code identifying the type of insurance (e.g., Medicare Part A, Medicare Part B, Medicaid, CHAMPUS/TRICARE, FECA Black Lung, Group Health Plan). Corresponds to Box 1 on CMS-1500.',
    `insurance_verification_source` STRING COMMENT 'Source system or clearinghouse used to perform the insurance eligibility verification for this visit. Supports audit trail and troubleshooting of eligibility discrepancies.. Valid values are `EPIC|CERNER|CHANGE_HEALTHCARE|AVAILITY|MANUAL|PAYER_PORTAL`',
    `network_status` STRING COMMENT 'Indicates whether the rendering provider and/or facility is in-network or out-of-network with the patients insurance plan for this visit. Affects patient cost-sharing and reimbursement rates.. Valid values are `IN_NETWORK|OUT_OF_NETWORK|UNKNOWN`',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum annual dollar amount the patient is required to pay out-of-pocket for covered services under the insurance plan. Once met, the plan covers 100% of covered services.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the patients annual out-of-pocket maximum that has already been satisfied as of the date of this visit. Used to determine remaining patient financial liability.',
    `payer_phone` STRING COMMENT 'Primary contact phone number for the insurance payers provider services or claims department. Used by revenue cycle staff for eligibility verification and claims follow-up.. Valid values are `^+?[0-9-s().]{7,20}$`',
    `preauth_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization for the services rendered during this visit. True = pre-authorization is required; False = no pre-authorization needed.',
    `referral_number` STRING COMMENT 'Referral authorization number issued by the patients Primary Care Physician (PCP) or gatekeeper for HMO/POS plans requiring referrals for specialist or facility services during this visit.',
    `reimbursement_method` STRING COMMENT 'Expected payment methodology under which the payer will reimburse the provider for this visit. FFS = Fee-For-Service; CAPITATION = per-member per-month; BUNDLED = bundled payment; VBP = Value-Based Purchasing; DRG = Diagnosis-Related Group; PER_DIEM = daily rate.. Valid values are `FFS|CAPITATION|BUNDLED|VBP|DRG|PER_DIEM`',
    `subscriber_dob` DATE COMMENT 'Date of birth of the primary policyholder (subscriber). Used for eligibility verification and claims adjudication when the patient is a dependent.',
    `subscriber_relationship` STRING COMMENT 'Relationship of the patient to the primary policyholder (subscriber). Determines dependent eligibility and COB rules. Values: SELF (patient is the subscriber), SPOUSE, CHILD, OTHER. [ENUM-REF-CANDIDATE: SELF|SPOUSE|CHILD|DOMESTIC_PARTNER|WARD|EMPLOYEE|UNKNOWN|OTHER — promote to reference product]. Valid values are `SELF|SPOUSE|CHILD|OTHER`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this visit insurance record was last modified. Used for change data capture (CDC), audit trail, and downstream ETL processing in the Databricks Silver layer.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    CONSTRAINT pk_visit_insurance PRIMARY KEY(`visit_insurance_id`)
) COMMENT 'Insurance coverage details applicable to a specific visit, including eligibility and authorization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`authorization` (
    `authorization_id` BIGINT COMMENT 'Unique surrogate primary key for the prior authorization and concurrent review record within the encounter domain. Assigned by the lakehouse Silver layer upon ingestion.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who submitted the prior authorization request to the payer. Used for provider-level utilization management reporting.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Authorizations are approved or denied based on specific coverage policies. Tracking which policy was applied enables denial management, appeals preparation, and policy effectiveness analysis—critical ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Prior authorization workflow—requested procedures must reference official CPT codes for payer review, medical necessity determination, and authorization approval. Required for utilization management a',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the authorization was requested. Supports patient-level denial management and utilization management analytics.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient authorization workflow—DRG-based authorizations must reference official DRG definitions for expected payment calculation and length-of-stay approval. Required for inpatient utilization manag',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Prior authorization for HCPCS services—DME, supplies, and drug authorizations must reference official HCPCS codes for payer review and approval. Required for utilization management of non-physician se',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Authorization requirements and approval criteria are plan-specific, not just payer-level. Different plans under same payer have distinct benefit designs, authorization rules, and coverage policies. Re',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Medical necessity validation—authorization diagnosis codes must reference official ICD-10 for clinical justification and payer approval. Required for utilization management to validate that requested ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Prior authorization submissions to payers require standardized clinical indication coding. SNOMED CT is the standard for clinical indication in FHIR CoverageEligibilityRequest and X12 278 transactions',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Prior authorization submissions to payers require the enterprise patient identifier (MPI) for utilization management, appeals tracking, and payer portal submissions. encounter_authorization has a plai',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Prior authorizations are issued for services at a specific facility. Linking to org_provider validates that authorized services match the contracted facility, supports payer-facility contract complian',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan responsible for adjudicating the authorization request. Drives payer contract compliance and denial trend analysis.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Each authorization decision applies specific prior auth rules defined by payer. Direct link enables compliance tracking, rule effectiveness analysis, and appeals documentation—essential for utilizatio',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) for which this prior authorization was obtained or requested. Links the authorization record to the core ADT encounter event.',
    `appeal_decision` STRING COMMENT 'Outcome of the payer appeal review. Upheld: original denial maintained; Overturned: denial reversed, services approved; Partial: partial approval granted on appeal; Pending: appeal under review. Drives denial overturn rate KPI reporting.. Valid values are `upheld|overturned|partial|pending`',
    `appeal_decision_date` DATE COMMENT 'Date when the payer rendered a decision on the appeal.',
    `appeal_filed_date` DATE COMMENT 'Date when an appeal was filed with the payer for a denied or partially approved authorization.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed against a denial or partial approval decision.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied|appeal_withdrawn`',
    `appeal_submitted_date` DATE COMMENT 'Date on which a formal appeal of the payer denial was submitted. Populated when authorization_status is appealed. Used to track appeal filing deadlines and payer response timelines.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of services, visits, units, or procedures approved by the payer. May represent number of visits, units of service, or treatment sessions.',
    `approved_quantity_unit` STRING COMMENT 'Unit of measure for the approved quantity (e.g., visits, units, sessions, days).. Valid values are `visits|units|sessions|days|procedures|treatments`',
    `authorization_number` STRING COMMENT 'Externally assigned authorization reference number issued by the payer upon approval or acknowledgment of the prior authorization request. Required on claims submission to validate covered services. Sourced from Epic Resolute HB payer portal integration.',
    `authorization_status` STRING COMMENT 'Current workflow state of the prior authorization request. Drives revenue cycle integrity, denial management workflows, and utilization management escalation. Key values: approved (payer approved services), denied (payer denied services), pending (awaiting payer decision), appealed (denial under appeal), retro_authorized (authorization obtained after service delivery), cancelled (request withdrawn).. Valid values are `approved|denied|pending|appealed|retro_authorized|cancelled`',
    `authorization_type` STRING COMMENT 'Classification of the authorization request by timing relative to service delivery. Prior: requested before service; Concurrent: requested during ongoing inpatient stay (utilization review); Retrospective: requested after service delivery; Expedited: urgent/emergent prior authorization with accelerated payer review timeline.. Valid values are `prior|concurrent|retrospective|expedited`',
    `authorized_amount` DECIMAL(18,2) COMMENT 'Dollar amount of services approved by the payer under this authorization. Used for revenue cycle forecasting, expected reimbursement calculation, and payer contract compliance monitoring.',
    `authorized_days` STRING COMMENT 'Number of inpatient days or service days approved by the payer for the authorized admission or ongoing care episode. Critical for concurrent review, length-of-stay management, and discharge planning. Distinct from authorized_units which applies to discrete service counts.',
    `authorized_units` STRING COMMENT 'Number of service units (e.g., therapy visits, procedure units, infusion doses) approved by the payer for the authorized service. Used for utilization tracking against approved quantities and denial prevention.',
    `clinical_indication` STRING COMMENT 'Narrative description of the medical necessity justification submitted to the payer supporting the authorization request. Documents the clinical rationale, patient condition, and treatment plan context. Used by CDI teams for documentation improvement and appeal preparation.',
    `clinical_notes` STRING COMMENT 'Free-text clinical notes or justification provided to support the authorization request.',
    `context` STRING COMMENT '',
    `cpt_code` STRING COMMENT 'AMA Current Procedural Terminology code identifying the specific procedure or service for which authorization is requested. Used for claims matching, denial root cause analysis, and payer contract compliance validation.. Valid values are `^[0-9]{4}[0-9A-Z]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the authorization record was first created in the source system (Epic Resolute HB or payer portal integration). Audit trail field for data lineage and compliance.',
    `days_used` STRING COMMENT 'Number of authorized inpatient days actually consumed against this authorization. Compared against authorized_days for concurrent review, length-of-stay management, and proactive extension request triggering.',
    `decision_datetime` TIMESTAMP COMMENT 'Date and time when the payer rendered the authorization decision (approved, denied, or partial).',
    `denial_reason_code` STRING COMMENT 'Payer-issued standardized code identifying the reason for authorization denial (e.g., not medically necessary, experimental/investigational, out-of-network, missing documentation, benefit exclusion). Used for denial management root cause analysis and appeal strategy. Populated only when authorization_status is denied or appealed.',
    `denial_reason_description` STRING COMMENT 'Free-text or payer-provided narrative description of the denial rationale. Supplements the denial_reason_code with additional clinical or administrative context. Used by CDI and RCM teams for appeal letter preparation.',
    `effective_date` DATE COMMENT 'Date when the authorization becomes effective and services may begin. Start of the authorization validity period.',
    `end_date` DATE COMMENT 'Last date on which authorized services may be rendered under this authorization. Services delivered after this date require re-authorization. Used for authorization expiration monitoring and proactive renewal workflows.',
    `expiration_date` DATE COMMENT 'Date when the authorization expires and is no longer valid. End of the authorization validity period.',
    `extension_authorization_number` STRING COMMENT 'Payer-issued authorization number for an approved extension of the original authorization period or unit count. Links the extension approval to the parent authorization record for complete authorization chain tracking.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicates whether an extension of the original authorization (additional days or units) has been requested from the payer. True = extension request submitted. Supports concurrent review workflow management and LOS management reporting.',
    `facility_type` STRING COMMENT 'Type of care setting or facility for which the authorization was requested. Inpatient: acute hospital admission; Outpatient: ambulatory services; ED: emergency department; Observation: observation status; SNF: skilled nursing facility; Home Health: home-based services; Telehealth: virtual care services. [ENUM-REF-CANDIDATE: inpatient|outpatient|ed|observation|snf|home_health|telehealth — 7 candidates stripped; promote to reference product]',
    `hcpcs_code` STRING COMMENT 'HCPCS Level II code for services, supplies, or equipment not covered by CPT codes (e.g., durable medical equipment, ambulance services, drugs). Complements CPT code for comprehensive service identification on authorization requests.. Valid values are `^[A-Z][0-9]{4}$`',
    `icd10_diagnosis_code` STRING COMMENT 'Primary ICD-10-CM diagnosis code submitted as clinical indication supporting the medical necessity of the requested service. Required by most payers for authorization adjudication. Sourced from Epic ClinDoc clinical documentation.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `merged_with_order_order_authorization` STRING COMMENT '',
    `mvm_alias_name` STRING COMMENT 'MVM-tier alias name (authorization) for this ECM product, ensuring ECM is a true superset of the MVM.',
    `mvm_ecm_reconciled_flag` BOOLEAN COMMENT 'True when this ECM product has been reconciled against its MVM alias.',
    `notes` STRING COMMENT 'Free-text field capturing additional clinical, administrative, or payer-specific notes related to the authorization request or decision. Used by RCM and utilization management staff to document follow-up actions, payer communications, and special circumstances.',
    `payer_authorization_reference` STRING COMMENT 'Payer-assigned internal tracking or case reference number for the authorization request, distinct from the final authorization_number. Used for payer portal follow-up, status inquiries, and audit trail documentation during the pending review period.',
    `payer_decision_timestamp` TIMESTAMP COMMENT 'Date and time the payer issued its authorization decision (approval, denial, or partial approval). Used to calculate payer turnaround time, measure compliance with CMS prior authorization timelines, and support denial management workflows.',
    `payer_reviewer_name` STRING COMMENT 'Name of the payer clinical reviewer or medical director who adjudicated the authorization request. Used for peer-to-peer review scheduling, appeal escalation, and payer relationship management.',
    `payer_reviewer_npi` STRING COMMENT 'National Provider Identifier of the payer medical director or clinical reviewer who adjudicated the authorization. Required for peer-to-peer review documentation and regulatory audit trails.. Valid values are `^[0-9]{10}$`',
    `peer_to_peer_conducted` BOOLEAN COMMENT 'Indicates whether a peer-to-peer clinical review was conducted between the requesting provider and payer medical director.',
    `peer_to_peer_date` DATE COMMENT 'Date when the peer-to-peer clinical review was conducted.',
    `peer_to_peer_outcome` STRING COMMENT 'Result of the peer-to-peer clinical review with the payer medical director. Approved: payer reversed denial after P2P; Denied: payer upheld denial after P2P; Partial: partial approval granted; Pending: outcome not yet determined.. Valid values are `approved|denied|partial|pending`',
    `peer_to_peer_review_date` DATE COMMENT 'Date on which the peer-to-peer clinical review between the requesting provider and payer medical director was conducted. Populated when peer_to_peer_review_flag is True.',
    `peer_to_peer_review_flag` BOOLEAN COMMENT 'Indicates whether a peer-to-peer clinical review was requested or conducted between the requesting provider and the payer medical director to contest a denial or support authorization. True = P2P review requested/completed. Key metric for utilization management and denial overturn tracking.',
    `priority` STRING COMMENT 'Priority level of the authorization request indicating urgency (e.g., routine, urgent, stat, emergent).. Valid values are `routine|urgent|stat|emergent`',
    `reconciled_from_mvm` STRING COMMENT 'Indicates source MVM table reconciled into ECM',
    `reconciliation_source` STRING COMMENT 'Source MVM table: encounter.authorization',
    `request_datetime` TIMESTAMP COMMENT 'Date and time when the prior authorization request was submitted to the payer. Represents the principal business event timestamp for this transaction.',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time the prior authorization request was formally submitted to the payer. Principal business event timestamp for the authorization lifecycle. Used for turnaround time measurement and payer SLA compliance tracking.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of services, visits, or units originally requested in the authorization submission.',
    `requesting_provider_name` STRING COMMENT 'Full name of the provider who submitted the authorization request.',
    `requesting_provider_npi` STRING COMMENT 'National Provider Identifier (NPI) of the provider who requested the authorization.. Valid values are `^[0-9]{10}$`',
    `retro_authorization_reason` STRING COMMENT 'Documented reason why authorization was obtained retrospectively after service delivery (e.g., emergency admission, system downtime, payer portal unavailability, clinical urgency). Required for retro-authorization requests and RAC audit defense. Populated when authorization_type is retrospective.',
    `reviewer_name` STRING COMMENT 'Name of the payer representative or medical reviewer who processed the authorization request.',
    `service_category` STRING COMMENT 'High-level category of the clinical service requiring authorization (e.g., inpatient, outpatient, lab, radiology, pharmacy, DME). [ENUM-REF-CANDIDATE: inpatient|outpatient|laboratory|radiology|pharmacy|dme|home_health|skilled_nursing — 8 candidates stripped; promote to reference product]',
    `service_type` STRING COMMENT 'Category of clinical service or care setting for which authorization is being requested (e.g., inpatient admission, outpatient surgery, skilled nursing facility, home health, durable medical equipment, specialty referral, imaging, infusion therapy). Sourced from payer-specific service type codes. [ENUM-REF-CANDIDATE: inpatient|outpatient_surgery|skilled_nursing|home_health|dme|specialty_referral|imaging|infusion|behavioral_health|physical_therapy — promote to reference product]',
    `servicing_facility_name` STRING COMMENT 'Name of the facility where the authorized service will be performed.',
    `servicing_provider_npi` STRING COMMENT 'National Provider Identifier (NPI) of the provider who will perform the authorized service.. Valid values are `^[0-9]{10}$`',
    `source_system_auth_code` STRING COMMENT 'Native authorization record identifier from the originating source system (e.g., Epic Resolute HB authorization ID or payer portal case ID). Enables cross-system reconciliation, ETL traceability, and audit trail back to the system of record.',
    `ssot_canonical_reference` STRING COMMENT 'Reference to the canonical SSOT record when this record is deprecated or merged',
    `ssot_reconciliation_status` STRING COMMENT 'Status indicating reconciliation state with related SSOT entity: ACTIVE, DEPRECATED, MERGED, SUPERSEDED',
    `start_date` DATE COMMENT 'First date on which the authorized services may be rendered under this authorization. Services delivered before this date are not covered and may result in claim denial. Sourced from payer authorization response.',
    `submission_method` STRING COMMENT 'Channel through which the prior authorization request was submitted to the payer. Electronic: automated EDI 278 transaction; Phone: verbal submission via payer call center; Fax: paper-based fax submission; Portal: payer web portal submission; EDI: direct EDI integration. Used for operational efficiency analysis and automation opportunity identification.. Valid values are `electronic|phone|fax|portal|edi`',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Elapsed time in hours between authorization request submission and payer decision. Used for performance monitoring and SLA tracking.',
    `units_used` STRING COMMENT 'Number of authorized service units actually consumed against this authorization. Compared against authorized_units to monitor utilization, prevent over-utilization, and trigger re-authorization workflows when approaching the authorized limit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the authorization record was most recently modified in the source system. Tracks status changes, unit updates, and appeal outcomes throughout the authorization lifecycle.',
    `urgency_level` STRING COMMENT 'Clinical urgency classification of the authorization request. Routine: standard processing timeline; Urgent: accelerated review required within 72 hours; Emergent: immediate review required; Expedited: CMS-defined expedited review for life-threatening conditions. Drives payer SLA requirements and processing priority.. Valid values are `routine|urgent|emergent|expedited`',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_reconciled_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_authorization PRIMARY KEY(`authorization_id`)
) COMMENT 'Prior authorization record for services rendered during an encounter. MVM alias: authorization (ECM superset of MVM).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` (
    `triage_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for the triage assessment record in the Silver layer lakehouse. Primary key for this entity.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Chief complaint coding via SNOMED CT is standard in ED triage for clinical decision support, sepsis/stroke alert triggering, and FHIR Condition resource generation. triage_assessment.chief_complaint_c',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed nurse or clinician who performed the triage assessment. Used for accountability, staffing analytics, and EMTALA compliance tracking.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Triage vital signs (heart rate, SpO2, temperature, BP) are LOINC-coded observations in HL7 FHIR and CDA clinical documents. Linking triage_assessment to the LOINC reference table supports interoperabi',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who was triaged. Core party reference linking the triage assessment to the Master Patient Index (MPI).',
    `prior_triage_assessment_id` BIGINT COMMENT 'Reference to the original triage assessment record when this record is a reassessment. Enables linkage of reassessment chains for acuity escalation tracking and waiting room safety analytics.',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: ED triage generates structured clinical observations (ESI scoring, pain assessments, sepsis/stroke screening). Linking triage_assessment to the clinical observation record supports ED quality reportin',
    `visit_id` BIGINT COMMENT 'Reference to the parent Emergency Department (ED) or urgent care encounter for which this triage assessment was performed. Links triage to the broader encounter lifecycle.',
    `acuity_change_reason` STRING COMMENT 'Free-text or structured reason documented by the triage nurse when the ESI acuity level is changed during a reassessment. PHI under HIPAA. Used for clinical quality review and patient safety event analysis.',
    `ama_flag` BOOLEAN COMMENT 'Indicates whether the patient left the ED Against Medical Advice (AMA) after triage but before completing the full ED visit. Distinct from LWBS — AMA occurs after provider contact. Used for risk management, quality reporting, and EMTALA compliance.',
    `arrival_mode` STRING COMMENT 'Method by which the patient arrived at the ED or urgent care facility. Includes ground ambulance, air transport (helicopter), walk-in, police transport, private vehicle, or inter-facility transfer. Used for EMTALA compliance, acuity benchmarking, and EMS coordination analytics.. Valid values are `ambulance|walk_in|helicopter|police|private_vehicle|transfer`',
    `chief_complaint` STRING COMMENT 'Free-text or structured description of the patients primary reason for presenting to the ED or urgent care, as stated by the patient or documented by the triage nurse. Protected Health Information (PHI) under HIPAA. Used for clinical documentation, coding, and population health analytics.',
    `chief_complaint_code` STRING COMMENT 'Standardized SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) code representing the chief complaint. Enables structured clinical analytics, interoperability, and population health reporting across systems.',
    `diastolic_bp_mmhg` STRING COMMENT 'Diastolic blood pressure measurement recorded at triage, expressed in millimeters of mercury (mmHg). Used alongside systolic BP for hemodynamic assessment and ESI acuity scoring. PHI under HIPAA.',
    `door_arrival_timestamp` TIMESTAMP COMMENT 'Date and time the patient physically arrived at the ED or urgent care facility (door time). Used as the baseline for door-to-triage and door-to-provider time quality measures reported to CMS.',
    `esi_level` STRING COMMENT 'Emergency Severity Index (ESI) triage acuity score assigned by the triage nurse, ranging from 1 (most critical/immediate) to 5 (least urgent/non-urgent). Drives resource allocation, bed assignment priority, and ED throughput analytics. Defined by AHRQ ESI Triage Algorithm.',
    `glasgow_coma_score` STRING COMMENT 'Total Glasgow Coma Scale (GCS) score assessed at triage, ranging from 3 (deep unconsciousness) to 15 (fully alert). Used for neurological status assessment, ESI acuity determination, and trauma triage protocols. PHI under HIPAA.',
    `heart_rate_bpm` STRING COMMENT 'Heart rate (pulse) measured at triage, expressed in beats per minute (BPM). Key vital sign for ESI acuity determination and identification of hemodynamic instability. PHI under HIPAA.',
    `interpreter_language` STRING COMMENT 'Primary language for which interpretation services are required, using ISO 639-1 two-letter language codes (e.g., es for Spanish, zh for Chinese). Supports LEP compliance reporting and interpreter resource planning.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires language interpretation services during the triage assessment. Supports compliance with Title VI of the Civil Rights Act and CMS Limited English Proficiency (LEP) requirements.',
    `isolation_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires isolation precautions at triage (e.g., airborne, droplet, contact, or neutropenic precautions). Drives bed assignment workflows, infection control protocols, and Healthcare-Associated Infection (HAI) prevention measures.',
    `isolation_type` STRING COMMENT 'Type of isolation precaution required for the patient as determined at triage. Drives room assignment, personal protective equipment (PPE) requirements, and infection control workflows.. Valid values are `airborne|droplet|contact|neutropenic|standard`',
    `lwbs_flag` BOOLEAN COMMENT 'Indicates whether the patient left the ED without being seen by a provider after triage (LWBS). Key ED throughput quality metric reported to CMS and used for EMTALA compliance monitoring and operational improvement initiatives.',
    `lwbs_timestamp` TIMESTAMP COMMENT 'Date and time the patient departed the ED without being seen by a provider, when the LWBS flag is true. Used to calculate time-to-LWBS and identify peak demand periods contributing to patient walkouts.',
    `mental_health_flag` BOOLEAN COMMENT 'Indicates whether the patients chief complaint or triage assessment involves a primary mental health or behavioral health concern. Used for ED behavioral health throughput analytics, psychiatric bed management, and EMTALA psychiatric screening compliance.',
    `pain_scale_type` STRING COMMENT 'Type of validated pain assessment scale used to obtain the pain score at triage. Distinguishes between numeric rating scale (NRS), Wong-Baker FACES (pediatric), FLACC (non-verbal), verbal descriptor, or behavioral observation scales.. Valid values are `numeric|faces|flacc|verbal|behavioral`',
    `pain_score` STRING COMMENT 'Patient-reported pain intensity score at triage, typically on a 0–10 numeric rating scale (NRS) or equivalent validated scale (e.g., Wong-Baker FACES for pediatric patients). Used for ESI acuity determination and Joint Commission pain management compliance. PHI under HIPAA.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this triage assessment record was first created in the source system. Used for audit trail, data lineage, and Silver layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this triage assessment record was most recently modified in the source system. Used for change detection, incremental ETL processing, and audit compliance.',
    `respiratory_rate_bpm` STRING COMMENT 'Respiratory rate measured at triage, expressed in breaths per minute. Used for ESI acuity scoring and identification of respiratory distress. PHI under HIPAA.',
    `sepsis_alert_flag` BOOLEAN COMMENT 'Indicates whether a sepsis screening alert was triggered at triage based on vital signs and clinical criteria (e.g., SIRS criteria, qSOFA). Supports SEP-1 bundle compliance reporting to CMS and Joint Commission sepsis quality measures.',
    `source_system_record_code` STRING COMMENT 'Native record identifier from the originating operational system (Epic ClinDoc or Cerner PowerChart ED) for this triage assessment. Enables cross-system traceability and supports Health Information Exchange (HIE) reconciliation.',
    `spo2_percent` DECIMAL(18,2) COMMENT 'Peripheral oxygen saturation (SpO2) measured by pulse oximetry at triage, expressed as a percentage. Critical indicator for respiratory status and ESI acuity level assignment. PHI under HIPAA.',
    `stroke_alert_flag` BOOLEAN COMMENT 'Indicates whether a stroke alert protocol was activated at triage based on presenting symptoms (e.g., FAST criteria). Supports door-to-CT and door-to-needle time quality measures for stroke care reported to The Joint Commission and CMS.',
    `systolic_bp_mmhg` STRING COMMENT 'Systolic blood pressure measurement recorded at triage, expressed in millimeters of mercury (mmHg). Critical vital sign for ESI acuity determination and clinical decision support. PHI under HIPAA.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Body temperature measured at triage, expressed in degrees Celsius. Used for ESI acuity determination, sepsis screening, and infection surveillance. PHI under HIPAA.',
    `temperature_route` STRING COMMENT 'Anatomical route used to obtain the body temperature measurement at triage (e.g., oral, rectal, axillary, tympanic, temporal). Affects clinical interpretation of temperature values.. Valid values are `oral|rectal|axillary|tympanic|temporal`',
    `trauma_activation_flag` BOOLEAN COMMENT 'Indicates whether a trauma team activation was initiated at or following triage. Used for trauma registry reporting, ACS trauma center verification, and ED resource utilization analytics.',
    `trauma_level` STRING COMMENT 'Level of trauma team activation triggered at triage (Level 1 = full activation for most critical injuries, Level 2 = partial activation, Level 3 = consult/standby). Drives resource deployment and trauma registry classification.. Valid values are `level_1|level_2|level_3`',
    `triage_category` STRING COMMENT 'Categorical classification of triage acuity corresponding to the ESI level. Supports ED throughput reporting, staffing models, and payer analytics. Values align with standard ED triage nomenclature.. Valid values are `emergent|urgent|semi_urgent|non_urgent|immediate`',
    `triage_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the triage assessment was fully documented and completed by the triage nurse. Used to calculate triage duration and nurse productivity metrics.',
    `triage_number` STRING COMMENT 'Externally visible, human-readable identifier for the triage assessment record as assigned by the source system (Epic ClinDoc or Cerner PowerChart ED). Used for cross-system reconciliation and audit trails.',
    `triage_nurse_npi` STRING COMMENT 'National Provider Identifier (NPI) of the licensed nurse or clinician who performed the triage assessment. Required for EMTALA compliance documentation and provider-level quality reporting. Sourced from Epic ClinDoc or Cerner PowerChart ED.. Valid values are `^[0-9]{10}$`',
    `triage_reassessment_flag` BOOLEAN COMMENT 'Indicates whether this triage record represents a reassessment of a previously triaged patient (e.g., patient condition changed while waiting). Supports tracking of acuity escalation events and waiting room safety monitoring.',
    `triage_status` STRING COMMENT 'Current workflow state of the triage assessment record. Indicates whether triage documentation is in progress, finalized, subsequently amended, or voided.. Valid values are `in_progress|completed|amended|voided`',
    `triage_timestamp` TIMESTAMP COMMENT 'Date and time when the triage assessment was initiated by the triage nurse. This is the principal business event timestamp used to calculate door-to-triage time and ED throughput quality measures.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `weight_kg` DECIMAL(18,2) COMMENT 'Patient weight measured or reported at triage, expressed in kilograms. Used for medication dosing calculations, pediatric weight-based protocols, and clinical decision support. PHI under HIPAA.',
    CONSTRAINT pk_triage_assessment PRIMARY KEY(`triage_assessment_id`)
) COMMENT 'Emergency department triage assessment including vital signs, ESI level, and chief complaint.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`readmission` (
    `readmission_id` BIGINT COMMENT 'Unique surrogate identifier for the readmission tracking record linking an index encounter to a subsequent readmission encounter.',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient record. Links the readmission pair to the Master Patient Index (MPI) for population health analytics and care management targeting.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: HRRP readmission penalty calculations and value-based care readmission reporting are health-plan-specific. Quality and population health teams analyze readmission rates by health plan for CMS reportin',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: HRRP (Hospital Readmissions Reduction Program) penalty calculation requires validated ICD-10 coding of the readmission principal diagnosis to determine measure category applicability. A FK to icd_code',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: HRRP (Hospital Readmissions Reduction Program) CMS reporting requires linking readmission events to the clinical diagnosis driving the index admission. Supports penalty calculation, root cause analysi',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Readmission tracking—index admission DRG must reference official DRG definition for HRRP penalty calculation, excess readmission ratio reporting, and quality measure validation. Required for CMS readm',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: HRRP (Hospital Readmissions Reduction Program) reporting and population health analytics require linking readmission records to the enterprise patient identity. readmission currently has only demograp',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HRRP (Hospital Readmissions Reduction Program) penalty calculations are facility-specific. CMS assesses penalties at the hospital level using excess readmission ratios. Linking readmission to org_prov',
    `payer_id` BIGINT COMMENT 'Foreign key reference to the payer (insurance plan) responsible for the index encounter. Used to segment readmission rates by payer for value-based contract performance reporting and ACO/HMO/PPO analytics.',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the subsequent encounter that qualifies as a readmission within the defined time window following the index discharge.',
    `waitlist_entry_id` BIGINT COMMENT 'Foreign key linking to scheduling.waitlist_entry. Business justification: HRRP regulatory reporting requires identifying whether a failed or incomplete waitlist/follow-up scheduling event contributed to a readmission. Linking readmission to the post-discharge waitlist_entry',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether the patient was attributed to an Accountable Care Organization (ACO) at the time of the index encounter. ACO-attributed readmissions have direct financial implications under shared savings and risk-based contracts.',
    `admission_date` DATE COMMENT 'Date the patient was admitted for the readmission encounter. Used to calculate days between discharge and readmission and to determine which time-window cohort (7, 30, 90 days) the readmission falls into.',
    `admit_source` STRING COMMENT 'Source through which the patient was admitted for the readmission encounter (e.g., Emergency Department, physician referral, transfer from another facility). Supports analysis of care transition failure points.. Valid values are `ed|physician_referral|transfer|direct_admit|other`',
    `care_gap_identified` STRING COMMENT 'Specific care gap identified during readmission review that contributed to the readmission event. Used to drive post-discharge intervention program design and care management outreach. [ENUM-REF-CANDIDATE: no_follow_up_appointment|medication_reconciliation_gap|no_discharge_instructions|no_post_acute_referral|no_care_gap — promote to reference product]. Valid values are `no_follow_up_appointment|medication_reconciliation_gap|no_discharge_instructions|no_post_acute_referral|no_care_gap`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this readmission tracking record was first created in the system, typically triggered by the ADT discharge event or quality review workflow initiation.',
    `days_to_readmission` STRING COMMENT 'Number of calendar days elapsed between the index discharge date and the readmission admission date. Core metric for HRRP cohort assignment and post-discharge intervention effectiveness analysis.',
    `drg_code` STRING COMMENT 'MS-DRG code assigned to the readmission encounter by the grouper. Used for financial impact analysis of readmissions on reimbursement and for HRRP penalty cost modeling.',
    `estimated_penalty_amount` DECIMAL(18,2) COMMENT 'Estimated financial penalty amount (in USD) attributable to this readmission under the CMS Hospital Readmissions Reduction Program. Used for revenue cycle impact analysis and CFO-level financial reporting. Confidential business financial data.',
    `follow_up_appointment_date` DATE COMMENT 'Scheduled date of the first post-discharge follow-up appointment after the index encounter. Used to assess timeliness of follow-up care and its correlation with readmission prevention.',
    `follow_up_appointment_scheduled` BOOLEAN COMMENT 'Indicates whether a follow-up outpatient appointment was scheduled prior to or at the time of index discharge. A key care gap indicator; absence is associated with higher 30-day readmission risk.',
    `hrrp_excess_readmission_ratio` DECIMAL(18,2) COMMENT 'CMS-calculated ratio of predicted to expected readmissions for the applicable HRRP measure category. A ratio greater than 1.0 indicates excess readmissions subject to payment penalty. Sourced from CMS IPPS final rule calculations.',
    `hrrp_measure_category` STRING COMMENT 'CMS HRRP condition-specific measure category assigned to the readmission. AMI=Acute Myocardial Infarction, HF=Heart Failure, PN=Pneumonia, COPD=Chronic Obstructive Pulmonary Disease, THA_TKA=Total Hip/Knee Arthroplasty, CABG=Coronary Artery Bypass Graft, other=does not fall under a specific HRRP measure. Drives CMS penalty calculation and quality reporting. [ENUM-REF-CANDIDATE: AMI|HF|PN|COPD|THA_TKA|CABG|other — promote to reference product]',
    `index_discharge_date` DATE COMMENT 'Date the patient was discharged from the index (original) inpatient encounter. Serves as the start of the readmission measurement window per CMS HRRP methodology.',
    `index_discharge_disposition` STRING COMMENT 'Discharge disposition code from the index encounter indicating where the patient was discharged to. Critical for identifying post-acute care failures as a readmission root cause and for HRRP exclusion logic (e.g., AMA, expired). [ENUM-REF-CANDIDATE: home|home_health|snf|ltach|rehab|hospice|ama|expired — promote to reference product]',
    `index_los_days` STRING COMMENT 'Number of inpatient days for the index encounter. Used in readmission risk stratification and to assess whether short LOS contributed to the readmission.',
    `index_primary_icd10_code` STRING COMMENT 'Primary ICD-10-CM diagnosis code from the index encounter. Used to determine HRRP measure category eligibility and to analyze clinical patterns driving readmissions.. Valid values are `^[A-Z][0-9A-Z]{1,6}$`',
    `is_hrrp_applicable` BOOLEAN COMMENT 'Indicates whether this readmission is subject to CMS HRRP penalty calculation. False when the readmission meets CMS exclusion criteria (e.g., planned readmission, transfer, AMA discharge, death during index stay).',
    `is_related_to_index` BOOLEAN COMMENT 'Indicates whether the readmission diagnosis is clinically related to the index encounters principal diagnosis, as determined by clinical documentation review or CDI query outcome. Supports root cause analysis and preventability assessment.',
    `los_days` STRING COMMENT 'Number of inpatient days for the readmission encounter. Used for financial impact analysis and to assess severity of the readmission event.',
    `medication_reconciliation_completed` BOOLEAN COMMENT 'Indicates whether medication reconciliation was completed at the time of index discharge. Medication discrepancies are a leading cause of preventable readmissions; this flag supports MAR audit and quality reporting.',
    `payer_type` STRING COMMENT 'Classification of the payer for the index encounter. Medicare is the primary payer subject to CMS HRRP penalties. Segmentation by payer type enables value-based contract performance analysis across HMO, PPO, ACO, and government programs.. Valid values are `medicare|medicaid|commercial|self_pay|other`',
    `preventability_assessment` STRING COMMENT 'Clinical determination of whether the readmission was potentially preventable through improved care coordination, discharge planning, or post-discharge follow-up. Drives care management program targeting and quality improvement initiatives.. Valid values are `potentially_preventable|not_preventable|undetermined`',
    `readmission_status` STRING COMMENT 'Current workflow status of the readmission record within the quality review and HRRP adjudication process. pending_review indicates awaiting clinical validation; confirmed indicates validated readmission; excluded indicates meets CMS exclusion criteria; appealed indicates under payer or CMS appeal; closed indicates final disposition reached.. Valid values are `pending_review|confirmed|excluded|appealed|closed`',
    `readmission_type` STRING COMMENT 'Classification of the readmission as planned or unplanned per CMS HRRP methodology. Planned readmissions (e.g., scheduled chemotherapy, elective procedures) are excluded from HRRP penalty calculations. Unplanned readmissions are subject to CMS penalty assessment.. Valid values are `planned|unplanned`',
    `review_completed_date` DATE COMMENT 'Date on which the clinical quality review of this readmission record was completed by the quality or CDI team. Supports workflow management and regulatory reporting timeliness tracking.',
    `reviewer_notes` STRING COMMENT 'Free-text clinical notes entered by the quality reviewer documenting the rationale for preventability assessment, root cause determination, and any care gaps identified during the readmission review process.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned to the patient at the time of index discharge predicting likelihood of 30-day readmission (e.g., LACE score, HOSPITAL score, Epic readmission risk model output). Used for care management program targeting and post-discharge intervention prioritization.',
    `risk_score_model` STRING COMMENT 'Name of the validated risk stratification model used to generate the readmission risk score. LACE=Length of stay, Acuity, Comorbidities, ED visits; HOSPITAL=Hemoglobin, Oncology, Sodium, Procedure, Index admission type, Type of admission, number of Admissions, Length of stay.. Valid values are `LACE|HOSPITAL|BOOST|epic_model|custom`',
    `root_cause_category` STRING COMMENT 'Categorized root cause of the readmission as identified through clinical review. Supports targeted quality improvement interventions and population health management. [ENUM-REF-CANDIDATE: medication_issue|care_coordination_gap|patient_non_compliance|inadequate_discharge_planning|disease_progression|social_determinants|post_acute_care_failure — promote to reference product]',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health (SDOH) factors (e.g., housing instability, food insecurity, transportation barriers) were identified as contributing to the readmission. Supports population health management and care management program targeting.',
    `tracking_number` STRING COMMENT 'Externally visible business identifier for this readmission record, used in care management workflows, quality reporting submissions, and cross-system reconciliation (e.g., Epic Healthy Planet case reference).',
    `transition_of_care_completed` BOOLEAN COMMENT 'Indicates whether a formal transition of care communication (e.g., discharge summary transmitted to PCP, care transition call completed) was documented following the index discharge. Supports HEDIS Transitions of Care measure compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this readmission tracking record was last modified, such as when a review is completed, status changes, or preventability assessment is updated.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `window` STRING COMMENT 'Defined time window within which the readmission occurred relative to the index discharge. 7_day supports high-acuity post-discharge monitoring; 30_day is the primary CMS HRRP measurement window; 90_day supports extended care management program targeting.. Valid values are `7_day|30_day|90_day`',
    CONSTRAINT pk_readmission PRIMARY KEY(`readmission_id`)
) COMMENT 'Readmission tracking record for HRRP compliance and care quality improvement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` (
    `discharge_summary_id` BIGINT COMMENT 'Unique identifier for the discharge summary record. Primary key.',
    `addended_discharge_summary_id` BIGINT COMMENT 'Self-referencing FK on discharge_summary (addended_discharge_summary_id)',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who was discharged.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: Normalization of DRG data in discharge summary. Currently discharge_summary duplicates drg_code and drg_description from the authoritative drg_assignment record. Both products link to the same visit, ',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who authorized and completed the patient discharge.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Clinical Documentation Improvement (CDI) and final billing require the discharge summary to reference a validated principal ICD-10 diagnosis code. Linking to icd_code enables CDI query workflows, codi',
    `tertiary_discharge_follow_up_provider_clinician_id` BIGINT COMMENT 'Reference to the provider with whom the follow-up appointment is scheduled.',
    `visit_id` BIGINT COMMENT 'Reference to the parent encounter for which this discharge summary was created.',
    `activity_restrictions` STRING COMMENT 'Physical activity limitations and restrictions prescribed at discharge including weight-bearing, lifting, and exercise guidelines.',
    `care_transition_plan_completed` BOOLEAN COMMENT 'Indicates whether a comprehensive care transition plan was documented and communicated to the patient and receiving providers.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the discharge summary was completed within the required timeframe per organizational policy and regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge summary record was first created in the data warehouse.',
    `diet_instructions` STRING COMMENT 'Dietary recommendations and restrictions provided to the patient at discharge.',
    `discharge_condition` STRING COMMENT 'The patients clinical condition at the time of discharge compared to admission status.. Valid values are `improved|stable|deteriorated|unchanged|expired`',
    `discharge_date` DATE COMMENT 'The date the patient was discharged from the facility or care setting.',
    `discharge_disposition` STRING COMMENT 'The destination or status of the patient at discharge indicating where the patient went after leaving the facility. [ENUM-REF-CANDIDATE: home|home_health|snf|rehab|ltac|hospice|ama|expired|transfer|other — 10 candidates stripped; promote to reference product]',
    `discharge_disposition_code` STRING COMMENT 'Standardized code representing the discharge disposition per CMS or payer requirements.',
    `discharge_instructions_issued` BOOLEAN COMMENT 'Indicates whether written discharge instructions were provided to the patient or caregiver at discharge.',
    `discharge_instructions_text` STRING COMMENT 'Free-text narrative of the discharge instructions provided to the patient including medications, activity restrictions, diet, wound care, and warning signs.',
    `discharge_medications_prescribed` STRING COMMENT 'List or narrative of medications prescribed at discharge including drug name, dosage, frequency, and duration.',
    `discharge_summary_number` STRING COMMENT 'Business identifier for the discharge summary document, often used for clinical documentation tracking and retrieval.',
    `discharge_timestamp` TIMESTAMP COMMENT 'The precise date and time the patient was discharged from the facility, including time zone information.',
    `discharging_provider_npi` STRING COMMENT 'The National Provider Identifier of the discharging provider for billing and regulatory reporting.',
    `durable_medical_equipment_ordered` STRING COMMENT 'List of durable medical equipment prescribed for home use such as oxygen, wheelchair, walker, or hospital bed.',
    `follow_up_appointment_date` DATE COMMENT 'The scheduled date for the patient to return for follow-up care after discharge.',
    `follow_up_instructions` STRING COMMENT 'Specific instructions for follow-up care including tests, specialist referrals, or monitoring requirements.',
    `follow_up_scheduled` BOOLEAN COMMENT 'Indicates whether a follow-up appointment with a provider was scheduled prior to discharge.',
    `functional_status_at_discharge` STRING COMMENT 'Assessment of the patients functional abilities at discharge including mobility, self-care, and activities of daily living.',
    `home_health_referral_made` BOOLEAN COMMENT 'Indicates whether a referral to home health services was made at discharge.',
    `hospital_course_narrative` STRING COMMENT 'Detailed chronological narrative of the patients clinical course during hospitalization including daily progress and significant events.',
    `length_of_stay_days` STRING COMMENT 'The total number of days the patient was admitted, calculated from admission to discharge date.',
    `medication_reconciliation_completed` BOOLEAN COMMENT 'Indicates whether medication reconciliation was performed at discharge comparing pre-admission, inpatient, and discharge medications.',
    `mrn` STRING COMMENT 'The unique medical record number assigned to the patient by the healthcare facility.',
    `patient_education_provided` BOOLEAN COMMENT 'Indicates whether patient education regarding their condition, treatment, and self-care was documented.',
    `patient_education_topics` STRING COMMENT 'List of topics covered during patient education sessions including disease management, medication use, and lifestyle modifications.',
    `principal_diagnosis_description` STRING COMMENT 'Human-readable description of the principal diagnosis for clinical documentation and patient communication.',
    `procedures_performed_summary` STRING COMMENT 'Summary of all procedures, surgeries, and interventions performed during the hospitalization.',
    `summary_authored_timestamp` TIMESTAMP COMMENT 'The date and time when the discharge summary was initially authored or dictated by the provider.',
    `summary_finalized_timestamp` TIMESTAMP COMMENT 'The date and time when the discharge summary was finalized and signed by the responsible provider.',
    `summary_of_hospitalization` STRING COMMENT 'Narrative summary of the hospital course including reason for admission, significant findings, procedures performed, treatment provided, and patient response.',
    `summary_status` STRING COMMENT 'Current lifecycle status of the discharge summary document indicating its completion and approval state.. Valid values are `draft|preliminary|final|amended|corrected|cancelled`',
    `time_to_completion_hours` DECIMAL(18,2) COMMENT 'The number of hours between discharge and finalization of the discharge summary, used for compliance monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge summary record was last modified in the data warehouse.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `warning_signs` STRING COMMENT 'Symptoms or conditions that should prompt the patient to seek immediate medical attention after discharge.',
    `wound_care_instructions` STRING COMMENT 'Specific instructions for surgical site care, dressing changes, or wound management at home.',
    CONSTRAINT pk_discharge_summary PRIMARY KEY(`discharge_summary_id`)
) COMMENT 'Discharge summary document capturing the hospital course, discharge instructions, and follow-up plan.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_prior_event_adt_event_id` FOREIGN KEY (`prior_event_adt_event_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_adt_event_id` FOREIGN KEY (`adt_event_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`authorization`(`authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ADD CONSTRAINT `fk_encounter_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_prior_triage_assessment_id` FOREIGN KEY (`prior_triage_assessment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_addended_discharge_summary_id` FOREIGN KEY (`addended_discharge_summary_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`discharge_summary`(`discharge_summary_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`encounter` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`encounter` SET TAGS ('dbx_domain' = 'encounter');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_source` SET TAGS ('dbx_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_source` SET TAGS ('dbx_value_regex' = 'emergency_department|direct_admission|transfer|referral|birth');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Admission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|newborn|trauma');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Admitting Diagnosis ICD-10 Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_transition_plan_completed` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Plan Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `converted_to_inpatient` SET TAGS ('dbx_business_glossary_term' = 'Converted to Inpatient Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `converted_to_inpatient` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `converted_to_inpatient` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|snf|rehab|ama|expired|hospice');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_instructions_issued` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|AP-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_weight` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `emtala_compliant` SET TAGS ('dbx_business_glossary_term' = 'Emergency Medical Treatment and Labor Act (EMTALA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `encounter_number` SET TAGS ('dbx_business_glossary_term' = 'Encounter Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `encounter_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `expected_los_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `financial_class` SET TAGS ('dbx_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `financial_class` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|self_pay|workers_comp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `financial_class` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `follow_up_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Scheduled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `inpatient_conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Conversion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `inpatient_conversion_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `inpatient_conversion_timestamp` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `moon_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Medicare Outpatient Observation Notice (MOON) Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Observation Hours');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `point_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `readmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `readmission_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `source_encounter_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Connection Quality');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `two_midnight_compliant` SET TAGS ('dbx_business_glossary_term' = 'Two-Midnight Rule Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|arrived|in_progress|discharged|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Admit Discharge Transfer (ADT) Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `prior_event_adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prior ADT Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `prior_event_adt_event_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Transferring Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Accepting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `ama_flag` SET TAGS ('dbx_business_glossary_term' = 'Against Medical Advice (AMA) Discharge Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `bed_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assigned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `bed_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `cancel_reason` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_business_glossary_term' = 'Clinical Reason for Transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `emtala_compliant` SET TAGS ('dbx_business_glossary_term' = 'Emergency Medical Treatment and Labor Act (EMTALA) Transfer Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `emtala_transfer_form_completed` SET TAGS ('dbx_business_glossary_term' = 'EMTALA Transfer Form Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|corrected|pending');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_value_regex' = 'A01|A02|A03|A04|A05|A06');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_description` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Type Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `from_bed_code` SET TAGS ('dbx_business_glossary_term' = 'From Bed Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `from_unit_code` SET TAGS ('dbx_business_glossary_term' = 'From Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Isolation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `leave_of_absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `level_of_care_code` SET TAGS ('dbx_business_glossary_term' = 'Level of Care Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_class_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Class Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_class_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_class_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Stability Score at Transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_value_regex' = 'stable|guarded|critical|unstable');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `sending_application` SET TAGS ('dbx_business_glossary_term' = 'Sending Application');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `sending_facility` SET TAGS ('dbx_business_glossary_term' = 'Sending Facility');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ADT Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'EPIC|CERNER|MEDITECH');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_bed_code` SET TAGS ('dbx_business_glossary_term' = 'To Bed Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_room_code` SET TAGS ('dbx_business_glossary_term' = 'To Room Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_unit_code` SET TAGS ('dbx_business_glossary_term' = 'To Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'inter_unit|level_of_care_change|inter_facility|internal_transfer|external_transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'ambulance|helicopter|wheelchair|stretcher|ambulatory|private_vehicle');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `visit_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consult Request ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `tertiary_visit_supervising_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `tertiary_visit_supervising_provider_clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `admission_source_role` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Role');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `admission_source_role` SET TAGS ('dbx_value_regex' = 'admitting|referring|transferring|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|cancelled|transferred');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|emergency|coverage|consult_request');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_team_sequence` SET TAGS ('dbx_business_glossary_term' = 'Care Team Sequence');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assignment Comments');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `cosignature_required` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `drg_attribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `drg_attribution_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `handoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Handoff Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `is_attending_of_record` SET TAGS ('dbx_business_glossary_term' = 'Attending of Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `is_primary_provider` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `locum_tenens_flag` SET TAGS ('dbx_business_glossary_term' = 'Locum Tenens Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `mips_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `note_count` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `participation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Provider Participation Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `participation_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'full|provisional|temporary|locum_tenens|telemedicine');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `provider_role` SET TAGS ('dbx_business_glossary_term' = 'Provider Role');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rvu_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Credit Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rvu_credit_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rvu_work_units` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Units');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Encounter Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` SET TAGS ('dbx_subdomain' = 'billing_authorization');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `actual_los` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `admit_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `admit_source_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'DRG Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|pending|upheld|overturned|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Arithmetic Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'DRG Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|voided');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'DRG Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'initial|working|final|appeal|rac_review');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `base_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'DRG Base Payment Rate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `base_payment_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `base_payment_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cc_mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication and Comorbidity / Major Complication and Comorbidity (CC/MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cdi_query_count` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cdi_query_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Response Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Discharge Status Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_changed_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Changed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_changed_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version_number` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Version Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version_number` SET TAGS ('dbx_value_regex' = '^v?[0-9]{1,2}(.[0-9]{1,2})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_weight` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `expected_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Expected DRG Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `expected_reimbursement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'DRG Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Geometric Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouper_software` SET TAGS ('dbx_business_glossary_term' = 'Grouper Software Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouper_software_version` SET TAGS ('dbx_business_glossary_term' = 'Grouper Software Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouping_date` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouping Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_code` SET TAGS ('dbx_business_glossary_term' = 'Initial Working Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Initial Working Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_weight` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `is_outlier` SET TAGS ('dbx_business_glossary_term' = 'Cost Outlier Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_value_regex' = '^(P[RR]E|[0-9]{1,2})$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_description` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `outlier_payment` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `outlier_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_value_regex' = 'inpatient|observation|short_stay');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `rac_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `transfer_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Case Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `bill_indicator` SET TAGS ('dbx_business_glossary_term' = 'Billable Diagnosis Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `cc_mcc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Complication/Comorbidity (CC) / Major Complication/Comorbidity (MCC) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `cc_mcc_indicator` SET TAGS ('dbx_value_regex' = 'CC|MCC|HAC|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coded_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Coded Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Coding Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_value_regex' = 'pending|coded|validated|queried|amended|final');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_value_regex' = 'physician|coder|cdi_specialist|system|imported');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'admitting|principal|secondary|discharge|working|final');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_relevance_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_business_glossary_term' = 'Encounter Diagnosis Comment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_business_glossary_term' = 'Encounter Diagnosis Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_business_glossary_term' = 'External Cause of Injury (ICD-10-CM) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_value_regex' = '^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hai_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hcc_category_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Category Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_business_glossary_term' = 'ICD-10-CM Fiscal Year Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Mental Health Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Resolved Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `resolved_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `resolved_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `substance_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder (SUD) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `substance_use_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Pcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `asa_class` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `asa_class` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Procedure Body Site');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `complication_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Complication Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `complication_flag` SET TAGS ('dbx_business_glossary_term' = 'Procedure Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9A-Z]$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevant Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Procedure Coding System (ICD-10-PCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_value_regex' = '^[0-9A-HJ-NP-Z]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `implant_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancelled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_elective` SET TAGS ('dbx_business_glossary_term' = 'Elective Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'completed|in-progress|not-done|entered-in-error|unknown');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Procedure Quantity');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `rvu_total` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Total');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Work Component');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `surgical_approach` SET TAGS ('dbx_business_glossary_term' = 'Surgical Approach');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `surgical_approach` SET TAGS ('dbx_value_regex' = 'open|laparoscopic|robotic|endoscopic|percutaneous|other');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `timeout_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Surgical Time-Out Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `wound_class` SET TAGS ('dbx_business_glossary_term' = 'Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `wound_class` SET TAGS ('dbx_value_regex' = 'clean|clean_contaminated|contaminated|dirty_infected');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adt Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|transferred');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_class` SET TAGS ('dbx_business_glossary_term' = 'Bed Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|behavioral_health|rehabilitation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Bed Gender Designation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_value_regex' = 'male|female|any');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Bed Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_hold_reason` SET TAGS ('dbx_value_regex' = 'procedure|imaging|therapy|family_request|clinical_hold|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_label` SET TAGS ('dbx_business_glossary_term' = 'Bed Label');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_request_source` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_type` SET TAGS ('dbx_value_regex' = 'icu|telemetry|med_surg|isolation|observation|step_down');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `expected_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `housekeeping_status_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status at Assignment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `housekeeping_status_at_assignment` SET TAGS ('dbx_value_regex' = 'clean|dirty|in_progress|inspected|out_of_service');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_isolation_bed` SET TAGS ('dbx_business_glossary_term' = 'Is Isolation Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_business_glossary_term' = 'Is Observation Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_private_room` SET TAGS ('dbx_business_glossary_term' = 'Is Private Room Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_telemetry_monitored` SET TAGS ('dbx_business_glossary_term' = 'Is Telemetry Monitored Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `los_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `nursing_station_code` SET TAGS ('dbx_business_glossary_term' = 'Nursing Station Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|recurring|preadmit');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `request_to_assignment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Bed Request to Assignment Elapsed Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `source_system_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `wing_or_pod` SET TAGS ('dbx_business_glossary_term' = 'Wing or Pod');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` SET TAGS ('dbx_subdomain' = 'billing_authorization');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Insurance ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_insurance_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_insurance_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_value_regex' = 'CMS_1500|UB_04|ELECTRONIC_837P|ELECTRONIC_837I');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `cob_notes` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Notes');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `copay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coverage Sequence (Coordination of Benefits)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'MEDICAL|DENTAL|VISION|BEHAVIORAL_HEALTH|PHARMACY');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'VERIFIED|PENDING|INACTIVE|UNABLE_TO_VERIFY|NOT_ELIGIBLE');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'ELECTRONIC|PHONE|PORTAL|MANUAL|REAL_TIME');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `financial_class` SET TAGS ('dbx_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `financial_class` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_type_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_type_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_type_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Source System');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_value_regex' = 'EPIC|CERNER|CHANGE_HEALTHCARE|AVAILITY|MANUAL|PAYER_PORTAL');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'IN_NETWORK|OUT_OF_NETWORK|UNKNOWN');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `preauth_required` SET TAGS ('dbx_business_glossary_term' = 'Pre-Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'FFS|CAPITATION|BUNDLED|VBP|DRG|PER_DIEM');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'SELF|SPOUSE|CHILD|OTHER');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` SET TAGS ('dbx_subdomain' = 'billing_authorization');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Diagnosis Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partial|pending');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied|appeal_withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `appeal_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Service Quantity');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `approved_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `approved_quantity_unit` SET TAGS ('dbx_value_regex' = 'visits|units|sessions|days|procedures|treatments');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|appealed|retro_authorized|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_value_regex' = 'prior|concurrent|retrospective|expedited');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorized_days` SET TAGS ('dbx_business_glossary_term' = 'Authorized Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `authorized_units` SET TAGS ('dbx_business_glossary_term' = 'Authorized Units');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `context` SET TAGS ('dbx_ssot' = 'discriminator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9A-Z]$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `cpt_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `days_used` SET TAGS ('dbx_business_glossary_term' = 'Days Used');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `decision_datetime` SET TAGS ('dbx_business_glossary_term' = 'Authorization Decision Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization End Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `extension_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Extension Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Extension Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Authorized Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `mvm_alias_name` SET TAGS ('dbx_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `mvm_alias_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `mvm_alias_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `mvm_ecm_reconciled_flag` SET TAGS ('dbx_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payer Decision Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_npi` SET TAGS ('dbx_business_glossary_term' = 'Payer Reviewer National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `payer_reviewer_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_conducted` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer Review Conducted Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_date` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer Review Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_outcome` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer (P2P) Review Outcome');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partial|pending');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer (P2P) Review Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `peer_to_peer_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer (P2P) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Authorization Request Priority');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `reconciled_from_mvm` SET TAGS ('dbx_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `reconciliation_source` SET TAGS ('dbx_reconciliation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `request_datetime` SET TAGS ('dbx_business_glossary_term' = 'Authorization Request Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Request Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Quantity');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `retro_authorization_reason` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Authorization Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Servicing Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Servicing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `source_system_auth_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('dbx_business_glossary_term' = 'SSOT Canonical Reference');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'SSOT Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Start Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|phone|fax|portal|edi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Authorization Turnaround Time in Hours');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `units_used` SET TAGS ('dbx_business_glossary_term' = 'Units Used');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|expedited');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`authorization` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Chief Complaint Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Nurse Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `prior_triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Triage Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Observation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `acuity_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Acuity Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `acuity_change_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `acuity_change_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `ama_flag` SET TAGS ('dbx_business_glossary_term' = 'Against Medical Advice (AMA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `arrival_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Arrival');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `arrival_mode` SET TAGS ('dbx_value_regex' = 'ambulance|walk_in|helicopter|police|private_vehicle|transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_business_glossary_term' = 'Chief Complaint');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint_code` SET TAGS ('dbx_business_glossary_term' = 'Chief Complaint SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `diastolic_bp_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Diastolic Blood Pressure (BP) in mmHg');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `diastolic_bp_mmhg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `diastolic_bp_mmhg` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `door_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Door Arrival Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `esi_level` SET TAGS ('dbx_business_glossary_term' = 'Emergency Severity Index (ESI) Level');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `glasgow_coma_score` SET TAGS ('dbx_business_glossary_term' = 'Glasgow Coma Scale (GCS) Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `glasgow_coma_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `glasgow_coma_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Heart Rate (HR) in Beats Per Minute (BPM)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Precaution Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'airborne|droplet|contact|neutropenic|standard');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `lwbs_flag` SET TAGS ('dbx_business_glossary_term' = 'Left Without Being Seen (LWBS) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `lwbs_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Left Without Being Seen (LWBS) Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Mental Health Presentation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pain Assessment Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_value_regex' = 'numeric|faces|flacc|verbal|behavioral');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_business_glossary_term' = 'Pain Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Respiratory Rate (RR) in Breaths Per Minute');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `sepsis_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Sepsis Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Saturation (SpO2) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `stroke_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Stroke Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `systolic_bp_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Systolic Blood Pressure (BP) in mmHg');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `systolic_bp_mmhg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `systolic_bp_mmhg` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Body Temperature in Degrees Celsius');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_route` SET TAGS ('dbx_business_glossary_term' = 'Temperature Measurement Route');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_route` SET TAGS ('dbx_value_regex' = 'oral|rectal|axillary|tympanic|temporal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Trauma Activation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Activation Level');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_category` SET TAGS ('dbx_business_glossary_term' = 'Triage Category');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_category` SET TAGS ('dbx_value_regex' = 'emergent|urgent|semi_urgent|non_urgent|immediate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triage Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_number` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_business_glossary_term' = 'Triage Nurse National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_reassessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Triage Reassessment Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_status` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|amended|voided');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triage Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Patient Weight in Kilograms');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `readmission_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Index Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Index Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Readmission Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `waitlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `aco_attributed` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Attributed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Readmission Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `admit_source` SET TAGS ('dbx_business_glossary_term' = 'Readmission Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `admit_source` SET TAGS ('dbx_value_regex' = 'ed|physician_referral|transfer|direct_admit|other');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `care_gap_identified` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Identified');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `care_gap_identified` SET TAGS ('dbx_value_regex' = 'no_follow_up_appointment|medication_reconciliation_gap|no_discharge_instructions|no_post_acute_referral|no_care_gap');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `days_to_readmission` SET TAGS ('dbx_business_glossary_term' = 'Days to Readmission');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Readmission Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `drg_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `estimated_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated HRRP Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `estimated_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `follow_up_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Discharge Follow-Up Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `follow_up_appointment_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Post-Discharge Follow-Up Appointment Scheduled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `hrrp_excess_readmission_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hospital Readmissions Reduction Program (HRRP) Excess Readmission Ratio');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `hrrp_excess_readmission_ratio` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `hrrp_measure_category` SET TAGS ('dbx_business_glossary_term' = 'Hospital Readmissions Reduction Program (HRRP) Measure Category');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Index Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Index Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_los_days` SET TAGS ('dbx_business_glossary_term' = 'Index Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_primary_icd10_code` SET TAGS ('dbx_business_glossary_term' = 'Index Primary International Classification of Diseases 10th Revision (ICD-10) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_primary_icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `index_primary_icd10_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `is_hrrp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hospital Readmissions Reduction Program (HRRP) Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `is_related_to_index` SET TAGS ('dbx_business_glossary_term' = 'Clinically Related to Index Encounter Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `los_days` SET TAGS ('dbx_business_glossary_term' = 'Readmission Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_business_glossary_term' = 'Medication Reconciliation Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'medicare|medicaid|commercial|self_pay|other');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_business_glossary_term' = 'Readmission Preventability Assessment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_value_regex' = 'potentially_preventable|not_preventable|undetermined');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `readmission_status` SET TAGS ('dbx_business_glossary_term' = 'Readmission Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `readmission_status` SET TAGS ('dbx_value_regex' = 'pending_review|confirmed|excluded|appealed|closed');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `readmission_type` SET TAGS ('dbx_business_glossary_term' = 'Readmission Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `readmission_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Readmission Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Readmission Reviewer Notes');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `risk_score_model` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score Model');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `risk_score_model` SET TAGS ('dbx_value_regex' = 'LACE|HOSPITAL|BOOST|epic_model|custom');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Readmission Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Contributing Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Readmission Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `transition_of_care_completed` SET TAGS ('dbx_business_glossary_term' = 'Transition of Care Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `window` SET TAGS ('dbx_business_glossary_term' = 'Readmission Time Window');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ALTER COLUMN `window` SET TAGS ('dbx_value_regex' = '7_day|30_day|90_day');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `addended_discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Addended Discharge Summary Id');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `addended_discharge_summary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `tertiary_discharge_follow_up_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `activity_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Activity Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `care_transition_plan_completed` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Plan Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `diet_instructions` SET TAGS ('dbx_business_glossary_term' = 'Diet Instructions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Condition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_value_regex' = 'improved|stable|deteriorated|unchanged|expired');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_issued` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_text` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Text');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Discharge Medications Prescribed');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_summary_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment (DME) Ordered');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Instructions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Scheduled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `functional_status_at_discharge` SET TAGS ('dbx_business_glossary_term' = 'Functional Status at Discharge');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_business_glossary_term' = 'Home Health Referral Made Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `hospital_course_narrative` SET TAGS ('dbx_business_glossary_term' = 'Hospital Course Narrative');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `hospital_course_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_business_glossary_term' = 'Medication Reconciliation Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_topics` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Topics');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_topics` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_topics` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_business_glossary_term' = 'Procedures Performed Summary');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_authored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Summary Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Summary Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_of_hospitalization` SET TAGS ('dbx_business_glossary_term' = 'Summary of Hospitalization');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_of_hospitalization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `time_to_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Completion in Hours');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `warning_signs` SET TAGS ('dbx_business_glossary_term' = 'Warning Signs');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `wound_care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Wound Care Instructions');
