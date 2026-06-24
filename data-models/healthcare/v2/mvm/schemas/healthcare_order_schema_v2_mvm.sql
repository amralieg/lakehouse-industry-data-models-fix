-- Schema for Domain: order | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`order` COMMENT 'Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`clinical_order` (
    `clinical_order_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical order record in the enterprise data lakehouse. Primary key for the clinical_order data product.',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Joint Commission MS.06.01.03 requires that clinical orders for procedures be traceable to the clinicians active privilege grant. Linking clinical_order to the authorizing privileging record enables p',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Clinical orders are adjudicated against specific benefits (lab, imaging, DME). Benefit determines coverage percentage, quantity limits, and PA requirements. Clinical order validation, charge capture, ',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Coverage policy governs medical necessity criteria and PA requirements for individual clinical orders. Clinical decision support, PA determination, and denial prevention workflows require linking each',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure orders must link to CPT master for charge capture, prior authorization validation, RVU-based resource planning, and compliance with coding standards. Essential for revenue cycle and utilizat',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Orders must validate against specific plan benefits, formulary restrictions, and coverage policies. Real-world process: CPOE systems check plan-specific authorization requirements, copays, and covered',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Core clinical ordering workflow requires validation of diagnosis indication against ICD-10 master for billing compliance, clinical decision support, quality reporting, and medical necessity documentat',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Clinical orders for lab/diagnostic tests map to LOINC codes for HL7 FHIR interoperability, CDS Hooks triggering, and result reporting. EHR order catalogs require LOINC binding per ONC certification cr',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Every clinical order must be directly traceable to a patient MPI record for patient safety, CMS audit requirements, and Joint Commission compliance. clinical_order currently has no direct patient iden',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication clinical orders reference NDC drug codes for formulary compliance checking, drug interaction alerts (CPOE safety), and pharmacy dispensing reconciliation. clinical_order covers medication o',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CMS facility-level reporting, CPOE compliance tracking, and payer billing require clinical orders to be attributed to the ordering facility (org_provider). Joint Commission and CMS Conditions of Parti',
    `parent_order_clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order when this order is a child or linked order in a chained order relationship (e.g., a reflex lab order triggered by a parent panel, or a follow-up order linked to an original). Null for top-level independent orders.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Every clinical order requires payer identification for real-time eligibility verification, coverage determination, and prior authorization checks at order entry. CPOE systems integrate payer data for ',
    `clinician_id` BIGINT COMMENT 'Ordering Clinician Id for clinical order.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: clinical_order.authorization_number records the PA obtained, but the specific prior_auth_rule that triggered the requirement must be linked for PA compliance reporting, denial management, and audit wo',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Consent-before-fulfillment enforcement: clinical orders for surgery, chemotherapy, anesthesia, or experimental treatments require a documented consent_record before execution. This link enables EHR sy',
    `set_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which this order was generated, if applicable. Order sets are pre-defined bundles of evidence-based orders (e.g., Sepsis Bundle, AMI Order Set). Null if the order was placed individually outside an order set.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical orders carry a clinical indication coded in SNOMED CT for CDS rule evaluation, quality measure reporting, and FHIR ServiceRequest resources. clinical_indication_text is a denormalized plain-t',
    `tertiary_clinical_authorizing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who authorized or approved the order when different from the ordering provider (e.g., attending physician authorizing a resident-entered order). Supports order authentication and supervision compliance tracking.',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Medical necessity documentation requires linking each clinical order to the specific visit diagnosis that justifies it. CDI programs, payer audits, and CMS medical necessity reviews all depend on orde',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which this clinical order was placed. Links the order to the encounter context (inpatient, outpatient, ED, ambulatory).',
    `authorization_number` STRING COMMENT 'Payer-issued prior authorization number obtained before order fulfillment for services requiring pre-authorization (e.g., advanced imaging, elective procedures, specialty referrals). Required for claims submission and denial prevention.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled or discontinued (e.g., Duplicate Order, Patient Refused, Clinical Contraindication, Order Error). Required for medication safety and quality reporting. [ENUM-REF-CANDIDATE: duplicate|patient_refused|contraindication|order_error|provider_request|clinical_change — promote to reference product]',
    `cancelled_datetime` TIMESTAMP COMMENT 'Timestamp when the order was cancelled or discontinued. Null for active or completed orders. Used for order lifecycle analytics, duplicate order detection, and medication safety reporting.',
    `clinical_decision_support_alert` STRING COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was triggered at order entry and the providers response. Supports medication safety monitoring, duplicate order detection, and CDS effectiveness analytics per AHRQ and ONC requirements.. Valid values are `no_alert|alert_accepted|alert_overridden|alert_cancelled`',
    `completed_datetime` TIMESTAMP COMMENT 'Timestamp when the order was fulfilled and marked as completed by the performing department or system. Used for turnaround time (TAT) measurement and order fulfillment analytics.',
    `cosign_completed_datetime` TIMESTAMP COMMENT 'Timestamp when the required co-signature for a verbal or telephone order was completed by the authorizing provider. Used to measure compliance with TJC verbal order authentication requirements.',
    `cosign_due_datetime` TIMESTAMP COMMENT 'Deadline by which a verbal or telephone order must be co-signed by the authorizing provider per TJC and CMS requirements (typically within 24-48 hours). Null for electronically-entered orders that do not require co-signature.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was first created in the enterprise data lakehouse (Silver Layer). Serves as the RECORD_AUDIT_CREATED field for data lineage and audit trail purposes. Distinct from order_datetime (clinical event time).',
    `frequency_code` STRING COMMENT 'Standardized frequency code specifying how often a recurring order should be executed (e.g., QD for daily, BID for twice daily, Q4H for every 4 hours, PRN for as needed). Applicable primarily to pharmacy, nursing, and timed lab orders.',
    `is_cpoe_entered` BOOLEAN COMMENT 'Indicates whether the order was entered directly by the ordering provider via Computerized Physician Order Entry (CPOE) (True) versus entered by a nurse, pharmacist, or other staff on behalf of the provider (False). Key metric for CPOE adoption and Meaningful Use/Promoting Interoperability reporting.',
    `is_order_set_member` BOOLEAN COMMENT 'Indicates whether this order was placed as part of a clinical order set or protocol bundle (True) versus as a standalone individual order (False). Used for order set utilization analytics and evidence-based practice reporting.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this order is a recurring or standing order (True) that repeats on a defined schedule, versus a one-time order (False). Relevant for nursing, pharmacy, and lab orders with scheduled frequencies.',
    `is_verbal_order` BOOLEAN COMMENT 'Indicates whether this order was received verbally (True) and requires subsequent written or electronic authentication per TJC and CMS standards. Drives co-signature workflow and compliance monitoring.',
    `number_of_occurrences` STRING COMMENT 'Total number of times a recurring order is to be executed before automatic discontinuation. For example, a lab order for CBC x3 days would have number_of_occurrences = 3. Null for open-ended standing orders.',
    `order_catalog_code` STRING COMMENT 'Internal order catalog or procedure code from the source EHR system (Epic procedure ID or Cerner catalog item code). Used for order set management, CDM mapping, and charge capture reconciliation.',
    `order_class` STRING COMMENT 'Patient care setting classification for the order, indicating the clinical context in which the order was placed. Inpatient orders originate from admitted patients; ED orders from Emergency Department encounters; ambulatory from clinic visits.. Valid values are `inpatient|outpatient|ED|ambulatory`',
    `order_date` DATE COMMENT 'Order Date for clinical order.',
    `order_datetime` TIMESTAMP COMMENT 'The principal real-world timestamp when the clinical order was placed or entered into the CPOE system. Serves as the BUSINESS_EVENT_TIMESTAMP for this transaction. Used for turnaround time (TAT) calculations and regulatory reporting.',
    `order_entered_datetime` TIMESTAMP COMMENT 'Timestamp when the order was physically entered into the EHR system, which may differ from order_datetime (the clinically intended order time) for verbal or backdated orders. Used for CPOE compliance auditing and order authentication tracking.',
    `order_mode` STRING COMMENT 'Method by which the clinical order was entered or communicated. Electronic orders are entered directly via CPOE; verbal and telephone orders require co-signature per regulatory requirements. Supports compliance auditing and order authentication tracking.. Valid values are `electronic|verbal|written|telephone`',
    `order_name` STRING COMMENT 'Human-readable name or description of the ordered item or service as displayed in the EHR (e.g., CBC with Differential, Chest X-Ray PA and Lateral, Metoprolol 25mg PO). Sourced from the Charge Description Master (CDM) or order catalog.',
    `order_number` STRING COMMENT 'Externally-known, human-readable order identifier assigned by the source system (Epic Orders or Cerner Millennium). Used for cross-system reconciliation, audit trails, and communication with clinical staff. Serves as the BUSINESS_IDENTIFIER for this transaction.',
    `order_priority` STRING COMMENT 'Clinical urgency classification for the order. STAT indicates immediate action required; timed indicates a specific scheduled execution time. Embedded enum per product design specification. Drives turnaround time (TAT) SLA monitoring.. Valid values are `STAT|routine|urgent|timed`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the clinical order. Drives downstream fulfillment routing and reporting. Values align with Epic Orders and HL7 FHIR ServiceRequest status codes.. Valid values are `pending|active|completed|cancelled|on_hold|discontinued`',
    `order_type` STRING COMMENT 'Classification of the clinical order by modality or service category. Determines routing to the appropriate fulfillment system: Beaker (LIS) for lab, Radiant (RIS) for radiology, Willow for pharmacy, etc. Embedded enum per product design specification. [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|nursing|dietary|consult — 7 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Priority for clinical order.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Numeric quantity of the ordered item or service (e.g., number of lab panels, number of imaging views, medication dose quantity). Unit of measure is captured in quantity_unit. Used for supply chain, pharmacy dispensing, and charge capture.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity_ordered field (e.g., mg, mL, units, each, tablet). Follows UCUM (Unified Code for Units of Measure) standards for interoperability with HL7 FHIR.',
    `start_datetime` TIMESTAMP COMMENT 'Datetime when the order is scheduled to begin or when fulfillment should commence. For timed orders, this is the precise execution start time. Distinct from order_datetime (when placed) and order_datetime (when entered).',
    `stop_datetime` TIMESTAMP COMMENT 'Datetime when the order expires, is discontinued, or fulfillment should cease. Critical for pharmacy and nursing orders to prevent over-administration. Nullable for one-time orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was last modified in the enterprise data lakehouse. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental ETL processing, and audit compliance.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_clinical_order PRIMARY KEY(`clinical_order_id`)
) COMMENT 'Core clinical order record representing any order placed in the CPOE system including lab, radiology, pharmacy, referral, diet, and therapy orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`referral_order` (
    `referral_order_id` BIGINT COMMENT 'Unique surrogate identifier for the referral order record in the lakehouse Silver layer. Primary key for this entity.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Referral orders specify the type of appointment needed (specialist consult, procedure, diagnostic). Linking referral_order to appointment_type enables automated scheduling workflow — the scheduling sy',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: The benefit covering the referred service (e.g., specialist visit, mental health) determines visit limits, copay, and referral_required_flag. Benefit verification and utilization management workflows ',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Coverage policy governs whether specialist referrals are covered, require PA, and have visit limits. Referral authorization and utilization management workflows require linking each referral order to ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Referral service specification links anticipated procedure to CPT master for prior authorization submission, scheduling coordination, and expected reimbursement calculation. Essential for referral man',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the referral order was placed. Links to the patient master record.',
    `health_plan_id` BIGINT COMMENT 'Identifier for the patients health plan (HMO, PPO, POS, etc.) under which the referral is being processed. Used for payer-specific authorization routing and claims adjudication.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Referral authorization and medical necessity determination require valid ICD-10 linkage. Payers validate diagnosis against coverage policies for specialist referral approval, and providers need accura',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Referral management, care coordination dashboards, and payer authorization workflows require direct patient MPI linkage — not just a demographics snapshot — to support cross-facility patient matching ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Referral processing requires payer-specific authorization workflows, network validation, and timely filing requirements. Real-world process: referral management systems verify payer requirements, chec',
    `clinical_order_id` BIGINT COMMENT 'Clinical Order Id for referral order.',
    `clinician_id` BIGINT COMMENT 'Referred To Clinician Id for referral order.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Referral orders frequently require prior authorization. The prior_auth_rule specifies documentation requirements, turnaround times, and submission methods. Referral PA workflows and authorization trac',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Referrals to specialists frequently require prior authorization. Linking referral_order directly to prior_authorization enables referral management workflows to confirm PA status before scheduling, su',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Referral orders must validate the receiving providers NPI against the NPI Registry for payer authorization, credentialing verification, and CMS referral compliance. receiving_provider_npi is a denorm',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Closed-loop referral tracking and network adequacy reporting require linking referral_order to the receiving facility (org_provider). receiving_facility_name is a denormalized org_provider attribute',
    `receiving_provider_clinician_id` BIGINT COMMENT 'Reference to the specialist or external provider to whom the patient is being referred. May be null if the receiving provider has not yet been assigned.',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: HIPAA-compliant referral workflows require documented patient consent before PHI is shared with the receiving provider. This link supports consent-to-refer audits, referral loop closure compliance, an',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SNOMED CT provides granular clinical semantics for referral routing, specialty matching, and interoperable care coordination. Supports clinical detail beyond ICD-10 for precise referral indication and',
    `source_clinical_order_id` BIGINT COMMENT 'The native order identifier from the originating operational system (e.g., Epic order ID, Salesforce referral record ID). Enables cross-system reconciliation and traceability back to the system of record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Referral routing, network adequacy analysis, and payer authorization workflows require structured specialty linkage. Receiving_provider_clinician_id provides individual, but specialty_id enables speci',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which the referral order was initiated. Links to the encounter visit record.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether the patients payer requires prior authorization before the referral can be fulfilled. When True, the referral workflow is gated on obtaining a payer authorization number before scheduling.',
    `authorized_visits` STRING COMMENT 'The number of specialist visits or service encounters approved by the payer under this referral authorization. Used to track utilization against the authorized limit and trigger re-authorization workflows.',
    `cancellation_reason` STRING COMMENT 'The documented reason for cancellation of the referral order when order_status is cancelled. Captures clinical, administrative, or patient-driven reasons for cancellation to support quality improvement and operational analytics.',
    `clinical_indication` STRING COMMENT 'Structured or semi-structured clinical indication supporting the medical necessity of the referral. May include relevant findings, lab results, imaging results, or prior treatment history that justify the specialist consultation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was first created in the lakehouse Silver layer. Used for audit trail and data lineage tracking.',
    `disposition_date` DATE COMMENT 'The date on which the referral disposition was recorded by the receiving provider or care coordinator. Used to measure referral loop closure timeliness and time-to-specialist metrics.',
    `disposition_notes` STRING COMMENT 'Free-text notes from the receiving provider or care coordinator documenting the reason for the referral disposition, particularly for declined or cancelled referrals. Supports clinical documentation improvement (CDI) and care coordination workflows.',
    `effective_date` DATE COMMENT 'The date on which the referral authorization becomes valid and the patient may begin receiving referred services. Typically the date the authorization was approved by the payer.',
    `expiration_date` DATE COMMENT 'The date after which the referral authorization is no longer valid and services cannot be rendered under this referral. Triggers re-authorization workflows and patient outreach when approaching expiry.',
    `first_available_date` DATE COMMENT 'The earliest available appointment date offered by the receiving provider at the time the referral was processed. Used to measure access to specialty care and network adequacy.',
    `is_stat_order` BOOLEAN COMMENT 'Indicates whether the referral order was placed as a STAT (immediate/urgent) order requiring expedited processing and scheduling. Distinct from urgency_level as this is the operational flag used by scheduling and authorization workflows.',
    `loop_closed_date` DATE COMMENT 'The date on which the referral communication loop was closed, meaning the referring provider received the specialists consultation report or outcome documentation.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'The date and time when the referring provider placed the referral order via Computerized Physician Order Entry (CPOE) in the Electronic Health Record (EHR). This is the principal business event timestamp for the referral lifecycle.',
    `order_source_system` STRING COMMENT 'The operational system of record from which the referral order was originated or ingested into the lakehouse. Supports data lineage, reconciliation, and multi-system integration auditing.. Valid values are `Epic|Cerner|MEDITECH|Salesforce|manual`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the referral order. Drives downstream processing in Salesforce Health Cloud and Epic Orders. [ENUM-REF-CANDIDATE: pending|active|accepted|declined|completed|cancelled|expired — promote to reference product]',
    `plan_type` STRING COMMENT 'The type of health insurance plan governing the referral authorization requirements. HMO and POS plans typically require referrals; PPO plans may not. Drives authorization workflow logic. [ENUM-REF-CANDIDATE: HMO|PPO|POS|EPO|Medicare|Medicaid|self_pay — 7 candidates stripped; promote to reference product]',
    `referral_date` DATE COMMENT 'Referral Date for referral order.',
    `referral_disposition` STRING COMMENT 'The outcome or final disposition of the referral as reported by the receiving provider. Indicates whether the specialist accepted, declined, completed, or the patient did not attend. Used for referral loop closure tracking and quality reporting.. Valid values are `pending|accepted|declined|completed|cancelled|no_show`',
    `referral_loop_closed` BOOLEAN COMMENT 'Indicates whether the referring provider has received and acknowledged the specialists consultation report, closing the referral communication loop. A key quality metric for NCQA HEDIS and PCMH accreditation.',
    `referral_number` STRING COMMENT 'Externally visible, human-readable business identifier for the referral order. Used in payer communications, patient correspondence, and cross-system tracking (e.g., Salesforce Health Cloud, Epic Orders). Format: REF- followed by 10 digits.. Valid values are `^REF-[0-9]{10}$`',
    `referral_reason` STRING COMMENT 'Referral Reason for referral order.',
    `referral_reason_description` STRING COMMENT 'Free-text clinical narrative describing the reason for the referral, supplementing the ICD-10 code. Captures clinical context not fully expressed by the diagnosis code, such as symptom progression, treatment failure, or specific clinical question for the specialist.',
    `referral_source` STRING COMMENT 'The clinical setting or care context from which the referral originated. Indicates whether the referral was initiated by a Primary Care Physician (PCP), Emergency Department (ED), inpatient unit, specialist, patient self-referral, or care program enrollment.. Valid values are `PCP|ED|inpatient|specialist|self|care_program`',
    `referral_status` STRING COMMENT 'Referral Status for referral order.',
    `referral_type` STRING COMMENT 'Categorizes the nature of the referral: to a specialist, external provider, care program, second opinion, or for a specific diagnostic workup. Used for operational routing and analytics segmentation.. Valid values are `specialist|external_provider|care_program|second_opinion|diagnostic`',
    `referring_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the referring provider as registered with CMS. Required on CMS-1500 and UB-04 claim forms and payer authorization requests.. Valid values are `^[0-9]{10}$`',
    `scheduled_appointment_date` DATE COMMENT 'The date on which the patients appointment with the receiving specialist or provider has been scheduled. Used to measure time-to-appointment and referral fulfillment timeliness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was last modified in the lakehouse Silver layer. Supports change detection and incremental processing.',
    `urgency_level` STRING COMMENT 'Clinical priority level assigned to the referral order by the referring provider. Drives scheduling priority at the receiving provider and payer authorization turnaround time requirements. Values: routine, urgent, stat, emergent.. Valid values are `routine|urgent|stat|emergent`',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    `visits_used` STRING COMMENT 'The number of authorized visits that have been consumed against this referral to date. Compared against authorized_visits to determine remaining utilization and trigger re-authorization alerts.',
    CONSTRAINT pk_referral_order PRIMARY KEY(`referral_order_id`)
) COMMENT 'Referral orders directing patients to specialists or external facilities, including authorization tracking and referral loop closure.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set_item` (
    `set_item_id` BIGINT COMMENT 'Unique identifier for the order set item. Primary key for this entity.',
    `clinical_order_id` BIGINT COMMENT 'Clinical Order Id for set item.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Order set procedure items are identified by CPT codes for charge capture, prior authorization requirements, and RVU-based cost estimation during order set authoring. order_code on set_item is a denorm',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: set_item has a requires_consent boolean attribute. When true, the order set engine must surface the correct consent form template at order entry. This FK enables EHR order set configuration to autom',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Order set items for DME, supplies, and infusion services reference HCPCS codes for Medicare/Medicaid billing compliance and prior authorization. Enables order set content validation against payer cove',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Order set items are scoped to ICD diagnosis criteria for clinical appropriateness and payer authorization requirements. diagnosis_criteria on set_item is plain text; ICD FK enables structured diagnosi',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Order set items for lab/diagnostic orders are bound to LOINC codes in clinical decision support authoring tools (e.g., Zynx, Stanson). LOINC FK on set_item enables structured order set content managem',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Order set medication items reference NDC drug codes for formulary validation, default dose population, and drug interaction pre-screening at order set authoring time. Enables pharmacy and P&T committe',
    `set_id` BIGINT COMMENT 'Reference to the parent order set that contains this item. Links this item to its containing order set bundle.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Order set item inclusion conditions (condition_expression, diagnosis_criteria) are evaluated against SNOMED-coded clinical concepts in CDS authoring. SNOMED FK enables structured conditional logic for',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Order set build teams map each lab-type set_item to a test_catalog entry to enforce specimen requirements, turnaround expectations, and orderable status at order set activation. Without this FK, set_i',
    `age_max_years` STRING COMMENT 'Maximum patient age in years for which this order item is appropriate. Used for age-based inclusion rules. Null indicates no maximum age restriction.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years for which this order item is appropriate. Used for age-based inclusion rules. Null indicates no minimum age restriction.',
    `alternative_order_options` STRING COMMENT 'Comma-separated list of alternative order codes that can be substituted for this item. Supports clinical flexibility and formulary management.',
    `body_site` STRING COMMENT 'Anatomical location where the procedure or specimen collection should be performed. Uses standardized anatomical terminology.',
    `clinical_rationale` STRING COMMENT 'Evidence-based justification for including this order in the care pathway. May reference clinical guidelines, protocols, or best practices. Supports clinical decision support.',
    `collection_method` STRING COMMENT 'Method by which the specimen should be collected for laboratory orders (e.g., venipuncture, clean catch, biopsy). Ensures proper specimen quality.',
    `condition_expression` STRING COMMENT 'Formal expression defining the conditional logic criteria (e.g., age > 65, weight < 50kg, diagnosis = ICD-10:E11.9). Uses clinical decision support (CDS) rule syntax.',
    `condition_type` STRING COMMENT 'Category of conditional logic applied to this item. Determines which patient data elements are evaluated for inclusion/exclusion decisions. [ENUM-REF-CANDIDATE: age_based|weight_based|diagnosis_based|lab_value|allergy|medication_interaction|none — 7 candidates stripped; promote to reference product]',
    `conditional_inclusion_logic` STRING COMMENT 'Rule expression defining when this item should be automatically included or excluded from the order set. Evaluated at order set activation time based on patient context.',
    `contrast_indicator` BOOLEAN COMMENT 'Indicates whether contrast media should be used for radiology imaging orders. Affects patient preparation and allergy screening requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order set item record was first created in the system. Supports audit trail and compliance reporting.',
    `default_dose` STRING COMMENT 'Pre-configured dose amount for medication orders. May include numeric value and unit (e.g., 500 mg, 10 mL). Can be overridden at order entry.',
    `default_duration` STRING COMMENT 'Pre-configured duration for time-limited orders (e.g., 7 days, 2 weeks). Primarily used for medication orders with a defined treatment period.',
    `default_frequency` STRING COMMENT 'Pre-configured administration or execution frequency for this order (e.g., BID, TID, QD, Q4H). Primarily used for medication and nursing orders.',
    `default_priority` STRING COMMENT 'Pre-configured priority level for this order item. Can be overridden by the ordering provider at the time of order entry.. Valid values are `routine|urgent|stat|asap|timed`',
    `default_quantity` DECIMAL(18,2) COMMENT 'Pre-configured quantity for orders that require a count or volume (e.g., number of units to dispense, volume of fluid to administer).',
    `default_route` STRING COMMENT 'Pre-configured administration route for medication orders (e.g., oral, intravenous, intramuscular, subcutaneous). Can be overridden at order entry.',
    `diagnosis_criteria` STRING COMMENT 'ICD-10 diagnosis codes or diagnosis categories that must be present for this item to be included. Supports comma-separated list for multiple diagnoses.',
    `effective_end_date` DATE COMMENT 'Date when this order set item is no longer available for use. Null indicates the item remains effective indefinitely. Supports order set retirement and updates.',
    `effective_start_date` DATE COMMENT 'Date when this order set item becomes available for use. Supports versioning and phased rollout of order set changes.',
    `instruction_text` STRING COMMENT 'Additional instructions or guidance for the ordering provider or fulfillment team. Displayed during order entry and on order requisitions.',
    `is_active` BOOLEAN COMMENT 'Is Active for set item.',
    `is_default_selected` BOOLEAN COMMENT 'Indicates whether this item is pre-selected by default when the order set is opened. Providers can deselect optional items.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this order item must be included when the order set is activated. True means the item cannot be deselected by the ordering provider.',
    `is_required` BOOLEAN COMMENT 'Is Required for set item.',
    `item_sequence` STRING COMMENT 'Item Sequence for set item.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this order set item record was most recently updated. Supports change tracking and version control.',
    `laterality` STRING COMMENT 'Specifies which side of the body the order applies to for paired anatomical structures. Critical for surgical and imaging orders.. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `order_description` STRING COMMENT 'Human-readable description of the order item. Displayed to clinicians during order set selection and order entry.',
    `order_type` STRING COMMENT 'Category of clinical order represented by this item. Determines which fulfillment system and workflow will process the order.. Valid values are `laboratory|radiology|pharmacy|procedure|referral|nursing`',
    `patient_instruction_text` STRING COMMENT 'Instructions intended for the patient regarding this order (e.g., fasting requirements, preparation steps, post-procedure care). May be printed on patient education materials.',
    `requires_authorization` BOOLEAN COMMENT 'Indicates whether this order item requires prior authorization from the payer before it can be performed. Used for revenue cycle and utilization management.',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before this order can be performed. Used for high-risk procedures and research protocols.',
    `sequence_number` STRING COMMENT 'Ordinal position of this item within the parent order set. Determines the display and execution order of items in the set.',
    `set_item_status` STRING COMMENT 'Current lifecycle status of this order set item. Only active items are available for use in clinical order entry.. Valid values are `active|inactive|retired|draft|under_review`',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for laboratory orders (e.g., blood, urine, tissue, swab). Used for specimen collection and handling instructions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for set item.',
    `version_number` STRING COMMENT 'Version identifier for this order set item configuration. Supports change tracking and audit requirements for clinical content management.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    `weight_max_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no maximum weight restriction.',
    `weight_min_kg` DECIMAL(18,2) COMMENT 'Minimum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no minimum weight restriction.',
    CONSTRAINT pk_set_item PRIMARY KEY(`set_item_id`)
) COMMENT 'Individual order items within an order set, including default values, conditional logic, and clinical rationale for each component.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the order routing record. Primary key.',
    `clinical_order_id` BIGINT COMMENT 'Identifier of the clinical order being routed. Links to the parent order from CPOE (Computerized Physician Order Entry) system.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Order routing management and workload distribution require routing records to reference the destination org_provider. destination is a denormalized facility reference. Operational reporting on inter',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: Order routing to a scheduled slot (e.g., routing a procedure order to an OR or procedure room slot) requires a direct FK to open_slot for slot utilization reporting and routing efficiency analysis. de',
    `acknowledgement_datetime` TIMESTAMP COMMENT 'Timestamp when the receiving department or system acknowledged receipt of the routed order. Used to measure queue wait time.',
    `auto_route_eligible_flag` BOOLEAN COMMENT 'Indicates whether the order was eligible for automatic routing based on order type, priority, and system configuration. False if manual routing was required.',
    `completion_datetime` TIMESTAMP COMMENT 'Timestamp when the routing event was marked complete, indicating the order reached its fulfillment destination and processing began.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was first created in the system. Audit field for data lineage and troubleshooting.',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp for routing.',
    `datetime` TIMESTAMP COMMENT 'Timestamp when the order was routed to the destination department or facility. Critical for SLA (Service Level Agreement) tracking and turnaround time analysis.',
    `delay_minutes` STRING COMMENT 'Number of minutes the routing event exceeded the SLA target. Null if SLA was met. Used for bottleneck analysis and process improvement.',
    `estimated_completion_datetime` TIMESTAMP COMMENT 'Predicted timestamp when the order fulfillment will be completed, based on current queue depth, workload, and historical turnaround times.',
    `method` STRING COMMENT 'Method by which the order was routed. Distinguishes between automated rule-based routing, manual clinician override, load balancing algorithms, and emergency escalation paths.. Valid values are `automatic|manual_override|rule_based|load_balanced|escalated|emergency`',
    `notes` STRING COMMENT 'Free-text notes entered by routing staff or system administrators regarding special handling, exceptions, or issues encountered during routing.',
    `patient_location_at_routing` STRING COMMENT 'Patient location (unit, room, bed) at the time the order was routed. Used to optimize routing for point-of-care services and specimen collection.',
    `priority` STRING COMMENT 'Priority level assigned to the routing event. STAT orders receive immediate routing and queue priority, urgent orders are expedited, routine orders follow standard workflows.. Valid values are `stat|urgent|routine|scheduled|timed`',
    `priority_override_flag` BOOLEAN COMMENT 'Indicates whether the routing priority was manually overridden by a clinician or supervisor. True if priority was escalated or de-escalated from the original order priority.',
    `priority_override_reason` STRING COMMENT 'Free-text explanation for why the routing priority was overridden. Captures clinical justification for escalation or de-escalation.',
    `queue_name` STRING COMMENT 'Name of the work queue to which the order was assigned within the destination department. Examples include STAT Lab Queue, Routine Radiology Queue, Pharmacy Verification Queue.',
    `queue_position` STRING COMMENT 'Position of the order within the assigned queue at the time of routing. Used to track queue depth and wait times.',
    `reroute_count` STRING COMMENT 'Number of times this order has been rerouted to different destinations. High reroute counts indicate routing rule issues or capacity constraints.',
    `reroute_reason` STRING COMMENT 'Reason why the order was rerouted from its original destination. Supports root cause analysis of routing failures and capacity planning. [ENUM-REF-CANDIDATE: capacity_exceeded|equipment_unavailable|staff_unavailable|patient_location_change|order_modification|system_error|clinical_decision — 7 candidates stripped; promote to reference product]',
    `routed_timestamp` TIMESTAMP COMMENT 'Routed Timestamp for routing.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing event. Tracks progression from initial queue assignment through fulfillment or failure. [ENUM-REF-CANDIDATE: queued|acknowledged|in_progress|completed|rerouted|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `routing_type` STRING COMMENT 'Routing Type for routing.',
    `sequence` STRING COMMENT 'Sequential number indicating the order of routing events for a single order. Supports tracking of rerouting and escalation workflows.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the routing event met the defined SLA target. True if acknowledgement or completion occurred within the target timeframe.',
    `sla_target_minutes` STRING COMMENT 'Target turnaround time in minutes from routing to acknowledgement or completion, based on order priority and type. Used for SLA compliance monitoring.',
    `specimen_collection_required_flag` BOOLEAN COMMENT 'Indicates whether the routed order requires specimen collection before fulfillment. True for lab orders requiring phlebotomy or other collection procedures.',
    `system_source` STRING COMMENT 'Source system that generated or processed the routing event. Identifies whether routing originated from Epic Orders, Beaker LIS, Radiant RIS, Willow Pharmacy, or other integrated systems. [ENUM-REF-CANDIDATE: epic_orders|beaker_lis|radiant_ris|willow_pharmacy|cerner_orders|interface_engine|manual_entry — 7 candidates stripped; promote to reference product]',
    `transport_required_flag` BOOLEAN COMMENT 'Indicates whether patient transport is required to fulfill the order. True for imaging or procedure orders where the patient must be moved to the destination department.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was last modified. Tracks status changes, rerouting events, and data corrections.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for routing.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    `workload_score` DECIMAL(18,2) COMMENT 'Calculated workload score of the destination department or queue at the time of routing. Used by load balancing algorithms to distribute orders across available resources.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Order routing records tracking the dispatch and delivery of orders to performing departments, workstations, and queues.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`fulfillment` (
    `fulfillment_id` BIGINT COMMENT 'Unique identifier for the order fulfillment record. Primary key.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: The specific benefit covering the fulfilled service determines cost-sharing, allowed amounts, and billing rules. Benefit utilization tracking and revenue cycle reporting require linking each fulfillme',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that was fulfilled. Links to the originating order in the order management system.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Coverage policy determines medical necessity, PA requirements, and billing eligibility at fulfillment time. Denial management and compliance audit workflows require tracing each fulfillment to the cov',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charge capture at fulfillment links completed service to CPT master for accurate billing, RVU calculation, reimbursement determination, and revenue cycle management. Essential for financial reconcilia',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was fulfilled. Links fulfillment to the patient master record.',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Contracted rate for the specific procedure at fulfillment time is determined by the fee schedule line. Underpayment detection, contract performance reporting, and remittance variance analysis require ',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME, supplies, and ambulance service fulfillment require HCPCS code linkage to master for pricing determination, coverage validation, and billing compliance. Critical for non-physician service revenue',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Health plan governs allowed amounts, copay, and benefit coverage at the fulfillment/charge level. Charge capture, remittance reconciliation, and EOB matching in revenue cycle operations require health',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab and diagnostic order fulfillment records are identified by LOINC codes for result reporting, quality measure calculation (e.g., HEDIS), and HL7 ORU message generation. LOINC FK on fulfillment enab',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication order fulfillment (dispensing) records reference NDC drug codes for drug utilization review, 340B program compliance, controlled substance reporting (DEA ARCOS), and pharmacy charge capture',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: Order fulfillment occurs within a scheduled slot (e.g., imaging, procedure, lab collection). Linking fulfillment to the open_slot enables slot utilization vs. order fulfillment rate reporting — a key ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Claim submission and remittance reconciliation require knowing which payer is responsible for adjudicating a fulfillment. Revenue cycle management systems always carry payer_id at the fulfillment/char',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Revenue cycle and facility billing require fulfillment to be attributed to the performing org_provider. CMS facility billing (UB-04), charge capture, and quality reporting (e.g., CMS OP measures) all ',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider, technician, or clinician who performed or completed the fulfillment. May be a lab technician, radiologist, pharmacist, or other clinical staff.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: PA compliance reporting and denial prevention require linking each fulfillment to the prior auth rule that authorized the service. Revenue cycle teams use this to verify PA was obtained per the applic',
    `routing_id` BIGINT COMMENT 'Foreign key linking to order.routing. Business justification: A fulfillment record represents the completion of a clinical order that was dispatched via a routing event. Linking fulfillment.routing_id -> routing.routing_id enables direct traceability between the',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter during which the order was fulfilled. Links fulfillment to the clinical encounter context.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount associated with the fulfillment event. Represents the list price from the Charge Description Master (CDM) before adjustments, discounts, or contractual allowances.',
    `charge_capture_flag` BOOLEAN COMMENT 'Boolean indicator of whether a billable charge was captured for this fulfillment event. Used for revenue cycle management and billing reconciliation.',
    `charge_code` STRING COMMENT 'The internal charge code or CDM code associated with the fulfilled service. Links to the Charge Description Master for billing and revenue cycle processing.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was first created in the data system. Audit trail field for data lineage and record lifecycle tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp for fulfillment.',
    `datetime` TIMESTAMP COMMENT 'The date and time when the order was fulfilled or completed by the fulfilling department. This is the principal business event timestamp representing when the work was performed.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why the order was not fulfilled as originally ordered. Used when status is cancelled, failed, or partial. Maps to internal exception reason reference data.',
    `exception_reason_description` STRING COMMENT 'Free-text description of the exception or reason why the order was not fulfilled as ordered. Provides additional context beyond the standardized exception reason code.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The actual quantity or amount fulfilled by the performing department. May differ from ordered quantity in cases of partial fulfillment, substitution, or unavailability.',
    `fulfillment_number` STRING COMMENT 'Business identifier for the fulfillment event. Human-readable unique number assigned by the fulfilling department or system (e.g., lab accession number, radiology case number, pharmacy dispense number).',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment event. Indicates whether the order was fully completed, partially fulfilled, cancelled, failed, or is still in progress.. Valid values are `completed|partial|cancelled|failed|in_progress|pending`',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Fulfillment Timestamp for fulfillment.',
    `fulfillment_type` STRING COMMENT 'Fulfillment Type for fulfillment.',
    `method` STRING COMMENT 'The method or process used to fulfill the order. Indicates whether the fulfillment was performed manually, using automated equipment, at point of care, or outsourced to an external provider.. Valid values are `manual|automated|semi_automated|point_of_care|external_lab|outsourced`',
    `modifier_codes` STRING COMMENT 'Comma-separated list of CPT or HCPCS modifier codes applied to the procedure. Modifiers provide additional information about the service performed (e.g., bilateral procedure, multiple procedures).',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the fulfilling provider or technician. May include technical details, observations, or special handling instructions relevant to the fulfillment.',
    `order_type` STRING COMMENT 'The category or type of clinical order that was fulfilled. Determines which downstream domain owns the detailed result data (laboratory, radiology, pharmacy). [ENUM-REF-CANDIDATE: laboratory|radiology|pharmacy|referral|procedure|therapy|consult — 7 candidates stripped; promote to reference product]',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity or amount originally ordered by the ordering provider. Used for comparison with actual fulfilled quantity to detect partial fulfillments.',
    `partial_fulfillment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the order was partially fulfilled (True) or fully fulfilled (False). Set to True when fulfilled quantity is less than ordered quantity.',
    `performing_department_code` STRING COMMENT 'Standardized code identifying the department or service line that performed the fulfillment (e.g., LAB, RAD, PHARM, PT, OT). Maps to organizational department reference data.',
    `priority_code` STRING COMMENT 'The priority level assigned to the order at the time of fulfillment. Indicates urgency and expected turnaround time (STAT = immediate, urgent = within hours, routine = standard processing).. Valid values are `routine|urgent|stat|asap|timed`',
    `quality_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fulfillment event has been flagged for quality review or audit. Used for quality assurance, compliance monitoring, and performance improvement initiatives.',
    `quality_review_notes` STRING COMMENT 'Free-text notes entered during quality review or audit of the fulfillment event. Documents quality concerns, corrective actions, or compliance findings.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the ordered and fulfilled quantities (e.g., mg, mL, tablets, tests, images, doses). Standardized using UCUM (Unified Code for Units of Measure).',
    `result_availability_datetime` TIMESTAMP COMMENT 'The date and time when the results of the fulfilled order became available for review. May differ from fulfillment datetime for orders requiring processing time (e.g., lab cultures, pathology).',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with the fulfillment for hospital billing. Identifies the department or type of service for institutional claims.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated the fulfillment record (e.g., EPIC_ORDERS, BEAKER_LIS, RADIANT_RIS, WILLOW_PHARM). Used for data lineage and integration tracking.',
    `turnaround_time_minutes` STRING COMMENT 'Calculated elapsed time in minutes from order placement to fulfillment completion. Key performance indicator for order processing efficiency and departmental performance measurement.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was last modified. Audit trail field for tracking changes and data quality monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for fulfillment.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_fulfillment PRIMARY KEY(`fulfillment_id`)
) COMMENT 'Order fulfillment records capturing the completion of clinical orders including charge capture, quantity fulfilled, and turnaround time.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order record. Primary key.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Standing orders for recurring procedures (monthly infusions, weekly PT, dialysis) are associated with a specific appointment type to automate recurring scheduling. This link enables the scheduling sys',
    `clinical_order_id` BIGINT COMMENT 'Clinical Order Id for standing order.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Standing order protocols must align with payer coverage policies to ensure reimbursement and avoid denials. Real-world process: protocol committees review payer policies when creating standing orders ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Standing orders for procedures reference CPT codes for charge capture automation, prior authorization pre-screening, and RVU-based resource planning. Enables standing order compliance reporting and pa',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: Standing orders (nurse-initiated protocols, vaccination programs) specify which consent template must be used. Protocol compliance workflow ensures correct consent form is obtained before protocol exe',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Standing orders for DME, home health supplies, and infusion therapy reference HCPCS codes for Medicare/Medicaid coverage validation and prior authorization. Enables standing order billing compliance a',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Standing orders are scoped to specific ICD-coded diagnoses for clinical appropriateness, payer coverage validation, and population health protocol management. clinical_indication on standing_order is ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocol-driven lab orders in standing order protocols require LOINC linkage for standardized test ordering, interoperability, results interpretation, and quality measure reporting. Supports evidence-',
    `mpi_record_id` BIGINT COMMENT 'Mpi Record Id for standing order.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Standing medication orders carry medication_name, medication_dose, medication_route as plain text — clear denormalization of NDC drug reference. NDC FK enables formulary compliance checking, drug inte',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Standing orders are scoped to specific facilities for protocol governance and Joint Commission compliance. Facility-specific standing order management (e.g., nursing protocols, formulary standing orde',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Standing orders for recurring services must be validated against payer-specific coverage and reimbursement rules. Standing order approval and renewal workflows require payer context to ensure the prot',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or advanced practice provider who authorized this standing order protocol.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Standing orders for recurring services (monthly labs, weekly PT) must comply with PA rules governing frequency limits and documentation. PA compliance and standing order renewal workflows require link',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Standing orders (e.g., clinical trial protocols, chronic disease management protocols) require a signed, executed consent record on file before activation — distinct from the blank form_template alrea',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Standing orders reference SNOMED concepts in applicable_population_criteria for CDS-based patient eligibility evaluation and FHIR PlanDefinition resources. Enables structured population health protoco',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Standing orders are specialty-driven protocols (ED standing orders for chest pain, ICU sepsis protocols). Specialty governance committees approve and audit standing order usage by specialty. Required ',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Standing orders for recurring lab tests (e.g., HbA1c every 3 months) must reference the test_catalog to enforce specimen type, collection instructions, and CLIA complexity requirements at each recurre',
    `activation_condition` STRING COMMENT 'Specific clinical trigger or condition that must be met before the standing order can be executed (e.g., Systolic BP >180, Blood glucose <70 mg/dL).',
    `applicable_population_criteria` STRING COMMENT 'Clinical criteria defining which patient populations are eligible for this standing order (e.g., Adults age 18+ with suspected sepsis, Pediatric patients with fever >38.5C).',
    `approval_date` DATE COMMENT 'Date when the standing order protocol was officially approved for use.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the standing order protocol. [ENUM-REF-CANDIDATE: draft|pending_review|approved|active|suspended|expired|retired — 7 candidates stripped; promote to reference product]',
    `authorized_role` STRING COMMENT 'Clinical role or credential level authorized to execute this standing order (e.g., Registered Nurse, Licensed Practical Nurse, Respiratory Therapist).',
    `clinical_indication` STRING COMMENT 'Medical reason or clinical scenario for which this standing order is intended.',
    `contraindication` STRING COMMENT 'Clinical conditions or circumstances under which this standing order should NOT be executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this standing order record was first created in the system.',
    `documentation_requirement` STRING COMMENT 'Specific documentation that must be completed when this standing order is executed (e.g., vital signs, assessment findings, patient response).',
    `effective_end_date` DATE COMMENT 'Date when this standing order protocol expires or is no longer valid for use.',
    `effective_start_date` DATE COMMENT 'Date when this standing order protocol becomes active and available for use.',
    `end_date` DATE COMMENT 'End Date for standing order.',
    `evidence_based_guideline_reference` STRING COMMENT 'Citation or reference to clinical practice guidelines, research studies, or evidence-based protocols supporting this standing order.',
    `frequency` STRING COMMENT 'Frequency for standing order.',
    `imaging_modality` STRING COMMENT 'Type of imaging study if this standing order is for radiology orders. [ENUM-REF-CANDIDATE: x_ray|ct|mri|ultrasound|nuclear_medicine|pet|fluoroscopy|mammography — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this standing order record was last updated.',
    `last_review_date` DATE COMMENT 'Date when this standing order protocol was last reviewed by the clinical governance committee or medical staff.',
    `maximum_duration_days` STRING COMMENT 'Maximum number of days this standing order remains active before requiring renewal or expiration.',
    `medication_dose` STRING COMMENT 'Dosage amount and unit for medication orders (e.g., 500 mg, 10 units).',
    `medication_frequency` STRING COMMENT 'Frequency of medication administration (e.g., BID, TID, Q4H, PRN).',
    `medication_route` STRING COMMENT 'Route of administration for medication orders. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|sublingual|transdermal|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next required review of this standing order protocol.',
    `notification_recipient_role` STRING COMMENT 'Role or position of the clinician who should be notified when this standing order is executed (e.g., Attending Physician, Hospitalist, Charge Nurse).',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the authorizing provider or other clinician must be notified when this standing order is executed.',
    `order_detail` STRING COMMENT 'Detailed specification of the order including drug name and dose, lab test panel, imaging modality, or intervention description.',
    `order_type` STRING COMMENT 'Category of clinical order covered by this standing order (medication, lab test, imaging study, nursing intervention, etc.). [ENUM-REF-CANDIDATE: medication|laboratory|radiology|nursing_intervention|referral|procedure|diet|therapy — 8 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Priority level for execution of the standing order.. Valid values are `routine|urgent|stat|asap|timed`',
    `protocol_code` STRING COMMENT 'Unique alphanumeric code identifying the standing order protocol within the organizations order catalog.',
    `protocol_name` STRING COMMENT 'The official name of the standing order protocol (e.g., Sepsis Bundle, Chest Pain Protocol, Fall Prevention Standing Orders).',
    `protocol_version` STRING COMMENT 'Version identifier for the standing order protocol to track revisions and updates over time.',
    `regulatory_compliance_note` STRING COMMENT 'Notes regarding compliance with regulatory requirements, accreditation standards, or organizational policies related to this standing order.',
    `renewal_frequency_days` STRING COMMENT 'Number of days between required renewals if renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this standing order requires periodic renewal by the authorizing provider.',
    `special_instructions` STRING COMMENT 'Additional clinical guidance, precautions, or instructions for executing this standing order.',
    `standing_order_status` STRING COMMENT 'Status for standing order.',
    `start_date` DATE COMMENT 'Start Date for standing order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for standing order.',
    `usage_count` STRING COMMENT 'Number of times this standing order has been executed since activation, used for utilization tracking and quality monitoring.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_standing_order PRIMARY KEY(`standing_order_id`)
) COMMENT 'Pre-authorized standing orders allowing qualified staff to initiate specific orders based on defined clinical criteria without individual physician sign-off.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Unique identifier for the order reconciliation event. Primary key for the order reconciliation product.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to the specific clinical order that was reviewed during the reconciliation event.',
    `discharge_summary_id` BIGINT COMMENT 'Foreign key linking to encounter.discharge_summary. Business justification: Medication reconciliation at discharge is a Joint Commission and CMS requirement tied directly to the discharge summary. Linking reconciliation to discharge_summary enables compliance reporting on whe',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom medication and order reconciliation was performed.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Medication reconciliation is a facility-level CMS Condition of Participation requirement. Reconciliation records must be attributed to the org_provider for transition-of-care reporting, HEDIS MRP meas',
    `clinician_id` BIGINT COMMENT 'Internal identifier for the provider who performed the reconciliation.',
    `reconciliation_performed_by_clinician_id` BIGINT COMMENT 'Performed By Clinician Id for reconciliation.',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Reconciliation events at care transitions (admission, discharge, transfer) frequently involve reviewing and adjudicating standing orders — determining whether pre-authorized standing orders should be ',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit during which this reconciliation occurred.',
    `action_taken` STRING COMMENT 'Free-text or coded description of the clinical action taken to resolve any discrepancy or to document the rationale for the review disposition for this specific order within this reconciliation event.',
    `allergy_review_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether patient allergies were reviewed during the reconciliation process. True if reviewed, false otherwise.',
    `attestation_datetime` TIMESTAMP COMMENT 'Date and time when the provider attested to the accuracy and completeness of the reconciliation.',
    `attestation_signature` STRING COMMENT 'Electronic signature or attestation identifier of the provider who completed the reconciliation, confirming accuracy and completeness.',
    `completion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciliation was fully completed per regulatory requirements. True if completed, false otherwise.',
    `compliance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciliation met all regulatory and accreditation requirements. True if compliant, false otherwise.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this reconciliation record was first created in the system. Audit trail timestamp for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp for reconciliation.',
    `datetime` TIMESTAMP COMMENT 'Date and time when the medication and order reconciliation was performed. Principal business event timestamp for this transaction.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies identified during the reconciliation process, including medication omissions, duplications, dosing errors, or therapeutic substitutions.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified for this specific order during the reconciliation review. Order-level discrepancy flag that complements the aggregate discrepancy_identified_indicator on the reconciliation header.',
    `discrepancy_identified_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether any discrepancies were identified during reconciliation. True if discrepancies found, false otherwise.',
    `discrepancy_severity` STRING COMMENT 'Clinical severity level of identified discrepancies. High for potentially life-threatening, medium for clinically significant, low for minor, none if no discrepancies.. Valid values are `high|medium|low|none`',
    `documentation_location` STRING COMMENT 'Location or section within the EMR where the reconciliation documentation is stored (e.g., admission note, discharge summary, medication administration record).',
    `drug_interaction_check_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether drug-drug interaction screening was performed during reconciliation. True if performed, false otherwise.',
    `duration_minutes` STRING COMMENT 'Total time in minutes spent performing the reconciliation process.',
    `formulary_check_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether formulary status was checked for medications during reconciliation. True if checked, false otherwise.',
    `home_medication_list_reviewed_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the patients home medication list was reviewed during reconciliation. True if reviewed, false otherwise.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this reconciliation record was last modified. Audit trail timestamp for record updates.',
    `method` STRING COMMENT 'Method used to perform the reconciliation. CPOE (Computerized Physician Order Entry), paper-based, verbal, or hybrid approach.. Valid values are `cpoe|paper|verbal|hybrid`',
    `next_provider_communication_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciled medication list was communicated to the next provider of care. True if communicated, false otherwise.',
    `non_compliance_reason` STRING COMMENT 'Reason for non-compliance if the reconciliation did not meet regulatory requirements (e.g., patient refused, clinically unstable, incomplete information).',
    `orders_added_count` STRING COMMENT 'Number of new orders added during the reconciliation process.',
    `orders_continued_count` STRING COMMENT 'Number of orders continued without modification during reconciliation.',
    `orders_discontinued_count` STRING COMMENT 'Number of orders discontinued during the reconciliation process.',
    `orders_modified_count` STRING COMMENT 'Number of orders modified during the reconciliation process (dose changes, frequency adjustments, route changes).',
    `orders_reviewed_count` STRING COMMENT 'Total number of orders reviewed during the reconciliation process.',
    `patient_communication_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciled medication list was communicated to the patient or caregiver. True if communicated, false otherwise.',
    `reconciliation_date` DATE COMMENT 'Reconciliation Date for reconciliation.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process. Completed, incomplete, in progress, not required, or deferred.. Valid values are `completed|incomplete|in_progress|not_required|deferred`',
    `reconciliation_type` STRING COMMENT 'Type of care transition event that triggered the reconciliation process. Admission, transfer, discharge, pre-procedure, post-procedure, or outpatient visit.. Valid values are `admission|transfer|discharge|pre_procedure|post_procedure|outpatient_visit`',
    `reconciling_provider_npi` STRING COMMENT 'National Provider Identifier of the clinician who performed the medication reconciliation. Ten-digit unique identifier.. Valid values are `^[0-9]{10}$`',
    `review_action` STRING COMMENT 'The disposition decision applied to this clinical order during the reconciliation event. Indicates whether the order was continued without change, discontinued, modified (dose/frequency/route), or newly added as a result of the reconciliation review.',
    `review_datetime` TIMESTAMP COMMENT 'The date and time when this specific clinical order was reviewed within the reconciliation event. Belongs to the association because the same order may be reviewed at different times across multiple reconciliation events.',
    `source_medication_list_type` STRING COMMENT 'Source of the medication list used for reconciliation. Patient reported, pharmacy records, prior EMR, PCP records, family reported, or medication bottles.. Valid values are `patient_reported|pharmacy_records|prior_emr|pcp_records|family_reported|medication_bottles`',
    `transition_event` STRING COMMENT 'Specific care transition event that triggered the reconciliation requirement. Admit, transfer in, transfer out, discharge, pre-op, post-op, ED arrival, or ED departure. [ENUM-REF-CANDIDATE: admit|transfer_in|transfer_out|discharge|pre_op|post_op|ed_arrival|ed_departure — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for reconciliation.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure a change on order products',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Medication and order reconciliation events at care transitions, supporting Joint Commission NPSG.03.06.01 and CMS Transitions of Care requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set` (
    `set_id` BIGINT COMMENT 'Primary key for set',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Order sets are authored for DRG-based care pathways in bundled payment programs (e.g., CMS BPCI-A). DRG FK on set enables cost-per-episode analysis, bundled payment compliance reporting, and care path',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Order sets are scoped to ICD diagnosis ranges (icd_diagnosis_scope is plain text on set — clear denormalization). ICD FK enables structured order set triggering by admission diagnosis, quality measure',
    `parent_set_id` BIGINT COMMENT 'Self-referencing FK on set (parent_set_id)',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Order sets are clinically scoped to SNOMED-coded conditions for CDS-based triggering (e.g., SNOMED 22298006 Myocardial infarction triggers AMI order set). SNOMED FK on set enables structured order s',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Order set governance and clinical decision support require order sets to be formally linked to a specialty. clinical_specialty is a denormalized specialty name. Specialty-specific order set manageme',
    `approval_status` STRING COMMENT 'The governance approval state of the order set content, indicating whether it has cleared the clinical content review committee for production use.',
    `care_setting` STRING COMMENT 'The clinical care setting in which the order set is designed to be applied, influencing default routing and order behavior.',
    `clinical_domain` STRING COMMENT 'Primary clinical order domain(s) covered by the order set, indicating the downstream fulfillment systems (Beaker, Radiant, Willow) it integrates with.',
    `component_order_count` STRING COMMENT 'The number of individual orderable items (labs, medications, imaging, referrals) configured within the order set, indicating its complexity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order set master record was first captured in the source system.',
    `default_priority` STRING COMMENT 'The default priority assigned to orders generated from this set unless overridden by the ordering clinician, driving downstream fulfillment SLAs.',
    `default_routing_target` STRING COMMENT 'The default downstream system or queue to which orders from this set are routed for fulfillment (e.g., LIS, RIS, pharmacy verification queue).',
    `description_text` STRING COMMENT 'Detailed narrative describing the clinical purpose, intended population, and usage guidance for the order set, displayed to clinicians during selection.',
    `effective_date` DATE COMMENT 'The date on which this version of the order set becomes available for clinical use in production.',
    `evidence_basis` STRING COMMENT 'Reference to the clinical guideline, society recommendation, or evidence source that justifies the contents of the order set (e.g., Surviving Sepsis Campaign 2021).',
    `expiration_date` DATE COMMENT 'The date on which the order set is scheduled for mandatory review or retirement; nullable for open-ended active sets.',
    `is_evidence_based` BOOLEAN COMMENT 'Indicates whether the order set is formally tied to a published clinical evidence source, supporting quality and accreditation reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the order set master record was most recently modified, supporting change tracking and audit.',
    `last_reviewed_date` DATE COMMENT 'The date the order set content was most recently reviewed by the clinical content governance committee for continued evidence alignment.',
    `set_name` STRING COMMENT 'Human-readable display name of the order set as it appears to clinicians in the CPOE interface (e.g., Adult Sepsis Bundle, Post-Op Hip Replacement).',
    `next_review_due_date` DATE COMMENT 'The date by which the next scheduled clinical content review of the order set must occur to maintain its active status.',
    `order_set_code` STRING COMMENT 'Externally-known unique alphanumeric code/mnemonic that identifies the order set within the EHR build and across interfaces. Used for build versioning and cross-system mapping.',
    `order_set_status` STRING COMMENT 'Current state of the order set in its lifecycle, controlling whether it is available for clinician use, in development, or decommissioned.',
    `order_set_type` STRING COMMENT 'Categorical classification segmenting how the order set behaves in CPOE — e.g., a single-click panel, an evidence-based smartset, a clinical pathway, or a standing-order protocol.',
    `requires_cosignature` BOOLEAN COMMENT 'Indicates whether orders generated from this set require an attending physician cosignature before they become active.',
    `version_number` STRING COMMENT 'Semantic version of the order set build, enabling content governance teams to track revisions and roll back to prior approved versions.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Master reference table for set. Referenced by set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_parent_order_clinical_order_id` FOREIGN KEY (`parent_order_clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_source_clinical_order_id` FOREIGN KEY (`source_clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_healthcare_v1`.`order`.`routing`(`routing_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_parent_set_id` FOREIGN KEY (`parent_set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Response');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_value_regex' = 'no_alert|alert_accepted|alert_overridden|alert_cancelled');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_due_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Due Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Frequency Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_cpoe_entered` SET TAGS ('dbx_business_glossary_term' = 'Computerized Physician Order Entry (CPOE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('dbx_business_glossary_term' = 'Order Set Member Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_verbal_order` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `number_of_occurrences` SET TAGS ('dbx_business_glossary_term' = 'Number of Order Occurrences');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_catalog_code` SET TAGS ('dbx_business_glossary_term' = 'Order Catalog Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Class');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ED|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_entered_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Entered Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Mode');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_value_regex' = 'electronic|verbal|written|telephone');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|urgent|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|on_hold|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `stop_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Stop Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referred To Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Npi Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving (Specialist) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `source_clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit (Encounter) ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorized_visits` SET TAGS ('dbx_business_glossary_term' = 'Number of Authorized Visits');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `first_available_date` SET TAGS ('dbx_business_glossary_term' = 'Specialist First Available Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `loop_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Placed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|Salesforce|manual');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_loop_closed` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'PCP|ED|inpatient|specialist|self|care_program');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'specialist|external_provider|care_program|second_opinion|diagnostic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Referred Appointment Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visits_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Visits Used');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `alternative_order_options` SET TAGS ('dbx_business_glossary_term' = 'Alternative Order Options');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Conditional Inclusion Logic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `contrast_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contrast Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_business_glossary_term' = 'Default Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('dbx_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_frequency` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_business_glossary_term' = 'Default Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_route` SET TAGS ('dbx_business_glossary_term' = 'Default Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_default_selected` SET TAGS ('dbx_business_glossary_term' = 'Default Selected Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `item_sequence` SET TAGS ('dbx_business_glossary_term' = 'Item Sequence');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'laboratory|radiology|pharmacy|procedure|referral|nursing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Patient Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_authorization` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('dbx_subdomain' = 'clinical_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Order Routing ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `acknowledgement_datetime` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `auto_route_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Route Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Routing Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Routing Delay Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `estimated_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Routing Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'automatic|manual_override|rule_based|load_balanced|escalated|emergency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_business_glossary_term' = 'Patient Location at Routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'stat|urgent|routine|scheduled|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_count` SET TAGS ('dbx_business_glossary_term' = 'Reroute Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_reason` SET TAGS ('dbx_business_glossary_term' = 'Reroute Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Routing Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'Routing System Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `transport_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transport Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `workload_score` SET TAGS ('dbx_business_glossary_term' = 'Workload Score');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'clinical_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_capture_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|failed|in_progress|pending');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated|point_of_care|external_lab|outsourced');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `modifier_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `partial_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Fulfillment Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `performing_department_code` SET TAGS ('dbx_business_glossary_term' = 'Performing Department Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `result_availability_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Availability Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_business_glossary_term' = 'Activation Condition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `applicable_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicable Population Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `authorized_role` SET TAGS ('dbx_business_glossary_term' = 'Authorized Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `contraindication` SET TAGS ('dbx_business_glossary_term' = 'Contraindication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `documentation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirement');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `evidence_based_guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `imaging_modality` SET TAGS ('dbx_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `maximum_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `maximum_duration_days` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_business_glossary_term' = 'Medication Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Medication Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_business_glossary_term' = 'Medication Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_recipient_role` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_detail` SET TAGS ('dbx_business_glossary_term' = 'Order Detail');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `regulatory_compliance_note` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Note');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `standing_order_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('dbx_subdomain' = 'clinical_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Reconciliation ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Order Review - Clinical Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciling Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_performed_by_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('dbx_business_glossary_term' = 'Allergy Review Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `attestation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `attestation_signature` SET TAGS ('dbx_business_glossary_term' = 'Attestation Signature');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `completion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Completion Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `compliance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Compliance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_identified_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Identified Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_severity` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Severity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `documentation_location` SET TAGS ('dbx_business_glossary_term' = 'Documentation Location');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `drug_interaction_check_indicator` SET TAGS ('dbx_business_glossary_term' = 'Drug Interaction Check Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `drug_interaction_check_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `formulary_check_indicator` SET TAGS ('dbx_business_glossary_term' = 'Formulary Check Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Home Medication List Reviewed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'cpoe|paper|verbal|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `next_provider_communication_indicator` SET TAGS ('dbx_business_glossary_term' = 'Next Provider Communication Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_added_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Added Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Continued Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Discontinued Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_modified_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Modified Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Orders Reviewed Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `patient_communication_indicator` SET TAGS ('dbx_business_glossary_term' = 'Patient Communication Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `patient_communication_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `patient_communication_indicator` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|in_progress|not_required|deferred');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'admission|transfer|discharge|pre_procedure|post_procedure|outpatient_visit');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Reconciling Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `review_action` SET TAGS ('dbx_business_glossary_term' = 'Review Action');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `review_datetime` SET TAGS ('dbx_business_glossary_term' = 'Review Date Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('dbx_business_glossary_term' = 'Source Medication List Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('dbx_value_regex' = 'patient_reported|pharmacy_records|prior_emr|pcp_records|family_reported|medication_bottles');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `transition_event` SET TAGS ('dbx_business_glossary_term' = 'Transition Event');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `parent_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_uc_classification' = 'pii');
