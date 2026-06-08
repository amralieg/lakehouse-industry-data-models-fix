-- Schema for Domain: order | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`order` COMMENT 'Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`clinical_order` (
    `clinical_order_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical order record in the enterprise data lakehouse. Primary key for the clinical_order data product.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Medical necessity and coverage determination: the specific coverage policy applied at order entry drives clinical decision support alerts, order approval workflows, and retrospective audit trails. Pay',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure orders must link to CPT master for charge capture, prior authorization validation, RVU-based resource planning, and compliance with coding standards. Essential for revenue cycle and utilizat',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Clinical orders for DME, home health services, and non-physician services require HCPCS coding for Medicare/Medicaid billing compliance and prior authorization. HCPCS covers services not in CPT; clini',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Orders must validate against specific plan benefits, formulary restrictions, and coverage policies. Real-world process: CPOE systems check plan-specific authorization requirements, copays, and covered',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Core clinical ordering workflow requires validation of diagnosis indication against ICD-10 master for billing compliance, clinical decision support, quality reporting, and medical necessity documentat',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Clinical order prior authorization, formulary compliance, and payer-specific order routing require linking the order to the patients specific active coverage episode. clinical_order has payer_id and ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab and observation orders are a core clinical_order type; LOINC is the regulatory standard for identifying them. This link supports HL7/FHIR interoperability, lab result mapping, and CMS quality meas',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Surgical and procedural orders frequently specify medical devices, implants, or supplies by catalog number (e.g., orthopedic hardware, cardiac stents). Essential for charge capture, inventory depletio',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical order was placed. Core PARTY_REFERENCE linking the order to the patient master record.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy orders (a primary clinical_order type) must reference the authoritative NDC drug record for formulary compliance, medication reconciliation, drug utilization review, and CMS medication qualit',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: clinical_order.ordering_provider_npi is a plain-text denormalization of the NPI Registry. Linking to npi_registry supports CMS provider credentialing validation, DEA schedule compliance for controlled',
    `parent_order_clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order when this order is a child or linked order in a chained order relationship (e.g., a reflex lab order triggered by a parent panel, or a follow-up order linked to an original). Null for top-level independent orders.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Every clinical order requires payer identification for real-time eligibility verification, coverage determination, and prior authorization checks at order entry. CPOE systems integrate payer data for ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: High-value implant orders often specify preferred vendor (e.g., vendor rep present in OR for device support). Tracks vendor-specific devices for consignment inventory, pricing, and vendor performance.',
    `care_site_id` BIGINT COMMENT 'Reference to the clinical department or unit from which the order was placed (e.g., ICU, ED, Cardiology Clinic). Used for departmental utilization reporting, cost allocation, and operational analytics.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who entered or authorized this order via Computerized Physician Order Entry (CPOE). Corresponds to the ordering provider NPI-linked record in the provider master.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Prior authorization compliance: when a clinical order is placed, the specific PA rule governing that procedure/payer combination must be tracked for authorization workflow, denial management, and CMS ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Orders must comply with specific regulatory programs (controlled substance orders under DEA program, imaging orders under radiation safety). Compliance tracking at order level is operational requireme',
    `set_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which this order was generated, if applicable. Order sets are pre-defined bundles of evidence-based orders (e.g., Sepsis Bundle, AMI Order Set). Null if the order was placed individually outside an order set.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical orders carry a clinical indication; SNOMED CT is the standard terminology for encoding it. Required for clinical decision support rule triggering, FHIR MedicationRequest/ServiceRequest resour',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: A clinical_order can be generated by activating a standing_order (pre-authorized protocol). This FK links the executed clinical order back to its standing order template, enabling protocol compliance ',
    `tertiary_clinical_authorizing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who authorized or approved the order when different from the ordering provider (e.g., attending physician authorizing a resident-entered order). Supports order authentication and supervision compliance tracking.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Contract compliance at point-of-order: clinical orders for supply items must reference the applicable vendor contract to enforce GPO/formulary compliance, support contract utilization reporting, and f',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which this clinical order was placed. Links the order to the encounter context (inpatient, outpatient, ED, ambulatory).',
    `authorization_number` STRING COMMENT 'Payer-issued prior authorization number obtained before order fulfillment for services requiring pre-authorization (e.g., advanced imaging, elective procedures, specialty referrals). Required for claims submission and denial prevention.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled or discontinued (e.g., Duplicate Order, Patient Refused, Clinical Contraindication, Order Error). Required for medication safety and quality reporting. [ENUM-REF-CANDIDATE: duplicate|patient_refused|contraindication|order_error|provider_request|clinical_change — promote to reference product]',
    `cancelled_datetime` TIMESTAMP COMMENT 'Timestamp when the order was cancelled or discontinued. Null for active or completed orders. Used for order lifecycle analytics, duplicate order detection, and medication safety reporting.',
    `clinical_decision_support_alert` STRING COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was triggered at order entry and the providers response. Supports medication safety monitoring, duplicate order detection, and CDS effectiveness analytics per AHRQ and ONC requirements.. Valid values are `no_alert|alert_accepted|alert_overridden|alert_cancelled`',
    `clinical_indication_text` STRING COMMENT 'Free-text clinical rationale or indication entered by the ordering provider to justify the order. Supplements the ICD-10 indication code with narrative context. Used by Clinical Documentation Improvement (CDI) and utilization management teams.',
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
    `order_datetime` TIMESTAMP COMMENT 'The principal real-world timestamp when the clinical order was placed or entered into the CPOE system. Serves as the BUSINESS_EVENT_TIMESTAMP for this transaction. Used for turnaround time (TAT) calculations and regulatory reporting.',
    `order_entered_datetime` TIMESTAMP COMMENT 'Timestamp when the order was physically entered into the EHR system, which may differ from order_datetime (the clinically intended order time) for verbal or backdated orders. Used for CPOE compliance auditing and order authentication tracking.',
    `order_mode` STRING COMMENT 'Method by which the clinical order was entered or communicated. Electronic orders are entered directly via CPOE; verbal and telephone orders require co-signature per regulatory requirements. Supports compliance auditing and order authentication tracking.. Valid values are `electronic|verbal|written|telephone`',
    `order_name` STRING COMMENT 'Human-readable name or description of the ordered item or service as displayed in the EHR (e.g., CBC with Differential, Chest X-Ray PA and Lateral, Metoprolol 25mg PO). Sourced from the Charge Description Master (CDM) or order catalog.',
    `order_number` STRING COMMENT 'Externally-known, human-readable order identifier assigned by the source system (Epic Orders or Cerner Millennium). Used for cross-system reconciliation, audit trails, and communication with clinical staff. Serves as the BUSINESS_IDENTIFIER for this transaction.',
    `order_priority` STRING COMMENT 'Clinical urgency classification for the order. STAT indicates immediate action required; timed indicates a specific scheduled execution time. Embedded enum per product design specification. Drives turnaround time (TAT) SLA monitoring.. Valid values are `STAT|routine|urgent|timed`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the clinical order. Drives downstream fulfillment routing and reporting. Values align with Epic Orders and HL7 FHIR ServiceRequest status codes.. Valid values are `pending|active|completed|cancelled|on_hold|discontinued`',
    `order_type` STRING COMMENT 'Classification of the clinical order by modality or service category. Determines routing to the appropriate fulfillment system: Beaker (LIS) for lab, Radiant (RIS) for radiology, Willow for pharmacy, etc. Embedded enum per product design specification. [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|nursing|dietary|consult — 7 candidates stripped; promote to reference product]',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Numeric quantity of the ordered item or service (e.g., number of lab panels, number of imaging views, medication dose quantity). Unit of measure is captured in quantity_unit. Used for supply chain, pharmacy dispensing, and charge capture.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity_ordered field (e.g., mg, mL, units, each, tablet). Follows UCUM (Unified Code for Units of Measure) standards for interoperability with HL7 FHIR.',
    `source_system` STRING COMMENT 'Operational system of record from which this clinical order originated. Supports data lineage, ETL reconciliation, and multi-system enterprise integration. Values correspond to the enterprise EHR systems in use.. Valid values are `Epic|Cerner|MEDITECH|manual`',
    `start_datetime` TIMESTAMP COMMENT 'Datetime when the order is scheduled to begin or when fulfillment should commence. For timed orders, this is the precise execution start time. Distinct from order_datetime (when placed) and order_datetime (when entered).',
    `stop_datetime` TIMESTAMP COMMENT 'Datetime when the order expires, is discontinued, or fulfillment should cease. Critical for pharmacy and nursing orders to prevent over-administration. Nullable for one-time orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was last modified in the enterprise data lakehouse. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_clinical_order PRIMARY KEY(`clinical_order_id`)
) COMMENT 'Core master record for every clinical order entered via CPOE (Computerized Physician Order Entry) in Epic Orders or Cerner Millennium. Captures the authoritative order identity, ordering provider NPI, patient MRN, order type (lab, radiology, pharmacy, referral, nursing, dietary, consult), order priority (STAT, routine, urgent, timed), order mode (verbal, written, electronic), clinical indication (ICD-10 coded), ordering datetime, start and stop datetimes, order source system, order set membership flag, parent order reference for linked/chained orders, current order status, and order class (inpatient, outpatient, ED, ambulatory). SSOT for all clinical order identity, metadata, and type/priority classification across the enterprise. Absorbs order_type and order_priority reference attributes as embedded enums. All modality-specific attributes are owned by extension products (lab_order, radiology_order, pharmacy_order, referral_order).';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each order lifecycle event record in the immutable audit trail. Primary key for this append-only event log.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Compliance and payer audits sample order status change events to verify order integrity, cosignature compliance, and verbal order authentication. Auditors reviewing order modification chains need orde',
    `clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order whose lifecycle event is being recorded. Links this history record to the originating order in the order management system (Epic Orders / Cerner Millennium).',
    `demographics_id` BIGINT COMMENT 'Reference to the patient associated with the clinical order. Required for HIPAA audit compliance and PHI traceability across all order lifecycle events.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: order_status_history.modifying_provider_npi is a plain-text denormalization of the NPI Registry. Linking to npi_registry supports HIPAA audit trail integrity, controlled substance order authentication',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originally placed the order. Used for accountability tracking and CPOE audit trails.',
    `set_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which the parent order was generated, if applicable. Supports analysis of order set adherence and protocol-driven order modification patterns.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, admission, or ED episode) during which this order lifecycle event occurred. Supports encounter-level order audit and CDI review.',
    `cds_alert_overridden` BOOLEAN COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was overridden by the provider when this event was triggered. True = alert was acknowledged and overridden; False = alert was not overridden or no alert was present. Critical for patient safety audit and alert override rate reporting.',
    `cosignature_required` BOOLEAN COMMENT 'Indicates whether this order modification or event requires a co-signature from a supervising or authorizing provider before the change takes effect. Applies to resident/trainee orders and controlled substance modifications per institutional policy.',
    `cosignature_timestamp` TIMESTAMP COMMENT 'The date and time at which the required co-signature was completed by the supervising provider. Null if co-signature has not yet been obtained. Used to measure co-signature turnaround time for compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this history record was first written to the lakehouse silver layer. Represents the ETL ingestion time, distinct from event_timestamp (the real-world clinical event time). Used for data pipeline monitoring and late-arrival detection.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule (CI through CV) applicable to the medication order at the time of this event. Populated only when is_controlled_substance is True. Determines regulatory handling requirements.. Valid values are `CI|CII|CIII|CIV|CV`',
    `discontinuation_type` STRING COMMENT 'Classifies the reason category for order discontinuation when event_type is DISCONTINUATION. AMA = Against Medical Advice. Supports medication reconciliation, discharge planning, and quality reporting. [ENUM-REF-CANDIDATE: COMPLETED|PROVIDER_DISCONTINUED|PATIENT_REFUSED|AMA|FORMULARY|DUPLICATE|PROTOCOL — promote to reference product]',
    `effective_datetime` TIMESTAMP COMMENT 'The date and time at which this lifecycle event becomes clinically effective (e.g., when a renewed order becomes active, when a hold is lifted). May differ from event_timestamp when events are scheduled or backdated. Supports medication administration record (MAR) reconciliation.',
    `event_sequence_number` STRING COMMENT 'Monotonically increasing sequence number for all lifecycle events belonging to the same parent order. Enables chronological ordering of events within an orders history and detection of out-of-order event delivery from source systems.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which this lifecycle event occurred in the clinical system. This is the authoritative real-world event time, distinct from record audit timestamps. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `event_type` STRING COMMENT 'Discriminator classifying the kind of lifecycle event recorded. STATUS_CHANGE = workflow state transition; MODIFICATION = dose/frequency/route/priority change; AMENDMENT = clinical content update; CORRECTION = error correction; RENEWAL = order re-authorization; DISCONTINUATION = order stopped; COSIGN_REQUEST = co-signature required; COSIGN_COMPLETED = co-signature fulfilled. [ENUM-REF-CANDIDATE: STATUS_CHANGE|MODIFICATION|AMENDMENT|CORRECTION|RENEWAL|DISCONTINUATION|COSIGN_REQUEST|COSIGN_COMPLETED — promote to reference product]',
    `hipaa_audit_category` STRING COMMENT 'HIPAA-defined audit event category for this order lifecycle event, used for compliance reporting to OCR and internal privacy audits. Classifies the event as an access, modification, disclosure, correction, or deletion of PHI per HIPAA Security Rule requirements.. Valid values are `ACCESS|MODIFICATION|DISCLOSURE|CORRECTION|DELETION`',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this event represents a formal clinical amendment to the order record (as opposed to a routine status change or system-generated update). True = formal amendment requiring clinical documentation. Supports HIM and CDI amendment tracking.',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether the order subject to this lifecycle event involves a DEA-scheduled controlled substance. True = controlled substance order. Triggers enhanced audit requirements and DEA compliance tracking.',
    `is_verbal_order` BOOLEAN COMMENT 'Indicates whether this order event was initiated as a verbal or telephone order requiring subsequent written authentication. True = verbal/telephone order; False = directly entered CPOE order. Tracked for Joint Commission verbal order compliance.',
    `modified_field_name` STRING COMMENT 'The name of the specific clinical order field that was changed during a MODIFICATION, AMENDMENT, or CORRECTION event (e.g., dose, frequency, route, quantity, priority, start_date, stop_date, indication). Null for pure status transitions.',
    `modifying_user_role` STRING COMMENT 'The clinical or operational role of the user who triggered this lifecycle event at the time of the event. Supports role-based audit analysis and compliance review (e.g., identifying unauthorized order modifications). [ENUM-REF-CANDIDATE: PHYSICIAN|NURSE|PHARMACIST|RESIDENT|SYSTEM|ADMIN|TECHNICIAN — 7 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The order workflow status immediately after this lifecycle event. Together with previous_status, defines the state transition that occurred. [ENUM-REF-CANDIDATE: DRAFT|PENDING|ACTIVE|HOLD|SUSPENDED|COMPLETED|DISCONTINUED|CANCELLED|EXPIRED|ERROR — promote to reference product]',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the modified clinical field immediately after this modification event. Paired with previous_value to form a complete before/after audit record. Contains PHI when the field relates to medication or clinical details.',
    `order_number` STRING COMMENT 'The human-readable, externally visible order identifier (e.g., Epic order number, Cerner accession number) at the time of this event. Denormalized from the order header to support direct lookup in audit reports without joining to the order table.',
    `order_priority` STRING COMMENT 'The priority level of the order at the time of this event. Captures the priority as it existed at this point in the lifecycle, enabling detection of priority escalations or de-escalations over time.. Valid values are `ROUTINE|URGENT|STAT|ASAP`',
    `order_type` STRING COMMENT 'Classification of the clinical order category at the time of this event. Determines routing to downstream fulfillment systems: LAB → Beaker/LIS; RADIOLOGY → Radiant/RIS; PHARMACY → Willow; REFERRAL → Cadence. Denormalized here to support event-level analytics without joining back to the order header. [ENUM-REF-CANDIDATE: LAB|RADIOLOGY|PHARMACY|REFERRAL|PROCEDURE|NURSING|DIET|CONSULT — 8 candidates stripped; promote to reference product]',
    `override_reason` STRING COMMENT 'The structured or free-text reason provided by the provider when overriding a Clinical Decision Support (CDS) alert associated with this order event. Populated only when cds_alert_overridden is True. Supports patient safety review and quality improvement programs.',
    `previous_status` STRING COMMENT 'The order workflow status immediately before this lifecycle event. Enables reconstruction of the full state machine history and supports CDI review and medication reconciliation. [ENUM-REF-CANDIDATE: DRAFT|PENDING|ACTIVE|HOLD|SUSPENDED|COMPLETED|DISCONTINUED|CANCELLED|EXPIRED|ERROR — promote to reference product]',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the modified clinical field (dose, frequency, route, priority, quantity, etc.) immediately before this modification event. Stored as a string to accommodate heterogeneous field types across order categories. Populated only for MODIFICATION, AMENDMENT, and CORRECTION event types. Contains PHI when the field relates to medication or clinical details.',
    `reason_code` STRING COMMENT 'Structured reason code explaining why this lifecycle event occurred (e.g., CLINICAL_CHANGE, PATIENT_REQUEST, PROVIDER_CORRECTION, DUPLICATE_ORDER, ALLERGY_ALERT, DRUG_INTERACTION, FORMULARY_SUBSTITUTION, PROTOCOL_CHANGE). Sourced from the EHR reason code catalog. Supports CDI and quality review workflows.',
    `reason_text` STRING COMMENT 'Free-text clinical justification or narrative explanation provided by the user or system for this lifecycle event. Supplements the structured reason_code with provider-authored context. May contain PHI when clinical rationale references patient-specific information.',
    `renewal_sequence_number` STRING COMMENT 'Sequential counter indicating which renewal iteration this event represents for the parent order. Starts at 1 for the first renewal. Null for non-renewal events. Supports chronic medication management and long-term order tracking.',
    `source_system` STRING COMMENT 'The operational system of record that generated this lifecycle event. Identifies the originating EHR module for data lineage and reconciliation purposes (e.g., EPIC_ORDERS for physician CPOE, WILLOW for pharmacy verification, BEAKER for lab order processing, RADIANT for radiology order management). [ENUM-REF-CANDIDATE: EPIC_ORDERS|CERNER_POWERCHARTS|WILLOW|BEAKER|RADIANT|MEDITECH|MANUAL — 7 candidates stripped; promote to reference product]',
    `transmission_datetime` TIMESTAMP COMMENT 'The date and time at which this order event was transmitted to the downstream fulfillment system (Beaker, Radiant, Willow, etc.). Null if transmission is not required or has not yet occurred.',
    `transmission_status` STRING COMMENT 'Status of the order transmission to the downstream fulfillment system (pharmacy, lab, radiology) following this lifecycle event. Tracks whether the event was successfully communicated to the executing department.. Valid values are `SENT|PENDING|FAILED|ACKNOWLEDGED|NOT_REQUIRED`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this history record was last updated in the lakehouse silver layer. Although the event log is intended to be immutable, this field captures any correction or reprocessing events applied to the record for data quality purposes.',
    `verbal_order_authentication_datetime` TIMESTAMP COMMENT 'The date and time at which a verbal or telephone order was authenticated (signed) by the ordering provider. Null for non-verbal orders. Must occur within the timeframe required by Joint Commission standards (typically 24-48 hours).',
    `workstation_code` STRING COMMENT 'Identifier of the clinical workstation, device, or terminal from which this order lifecycle event was initiated. Supports HIPAA access audit trails and security incident investigation.',
    CONSTRAINT pk_order_status_history PRIMARY KEY(`order_status_history_id`)
) COMMENT 'Immutable audit trail of every lifecycle event for a clinical order, including status transitions, modifications (dose, frequency, route, priority changes), amendments, corrections, renewals, and discontinuations. Captures event type, previous and new values, modification details, the datetime of each event, the user or system that triggered it, reason codes, clinical justification, co-signature requirements for modifications, modifying provider NPI, and the source system event. SSOT for all order lifecycle changes — no other product in this domain records order state transitions or modifications. Supports HIPAA audit compliance, CDI (Clinical Documentation Improvement), medication reconciliation, and clinical quality review.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`referral_order` (
    `referral_order_id` BIGINT COMMENT 'Unique surrogate identifier for the referral order record in the lakehouse Silver layer. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site from which the referral was originated. Used for network management, referral pattern analytics, and facility-level reporting.',
    `clinical_order_id` BIGINT COMMENT 'The native order identifier from the originating operational system (e.g., Epic order ID, Salesforce referral record ID). Enables cross-system reconciliation and traceability back to the system of record.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: HIPAA and state regulations require documented patient consent for PHI disclosure when referring to external providers. The consent_reference record captures consent scope and phi_disclosure_authorize',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Referral coverage validation: the coverage policy determines whether the referred specialty service is a covered benefit under the patients plan. Care coordinators and utilization management teams us',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Referral service specification links anticipated procedure to CPT master for prior authorization submission, scheduling coordination, and expected reimbursement calculation. Essential for referral man',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the referral order was placed. Links to the patient master record.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Referrals for home health, DME, and outpatient therapy services require HCPCS coding for Medicare/Medicaid prior authorization and billing compliance. referral_order already has cpt_code_id; HCPCS cov',
    `health_plan_id` BIGINT COMMENT 'Identifier for the patients health plan (HMO, PPO, POS, etc.) under which the referral is being processed. Used for payer-specific authorization routing and claims adjudication.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Referral authorization and medical necessity determination require valid ICD-10 linkage. Payers validate diagnosis against coverage policies for specialist referral approval, and providers need accura',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Referral prior authorization workflows require linking the referral to the specific active insurance coverage episode. Payer-specific authorization rules, authorized visit counts, and referral expirat',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Referral management, HIE reporting, and referral loop closure tracking operate against the enterprise patient identity (MPI). referral_order currently links only to demographics; the MPI anchor is req',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Referral processing requires payer-specific authorization workflows, network validation, and timely filing requirements. Real-world process: referral management systems verify payer requirements, chec',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Referral orders are governed by specific policies (referral management policy, authorization policy, specialist access policy). Policy framework ensures appropriate referrals and regulatory compliance',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originated and placed the referral order. Typically the patients Primary Care Physician (PCP) or treating provider.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Specialist referral PA management: referral orders require prior authorization per payer-specific rules. Linking the governing PA rule enables automated authorization checks, tracks authorization_requ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Closed-loop referral management and network adequacy reporting require identifying the receiving organizational provider. receiving_facility_name is a denormalized plain column; replacing with FK to o',
    `receiving_provider_clinician_id` BIGINT COMMENT 'Reference to the specialist or external provider to whom the patient is being referred. May be null if the receiving provider has not yet been assigned.',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Referral orders must specify the exact practice location where the patient will be seen for appointment scheduling, directory accuracy, and referral loop closure. provider_location captures site-speci',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Referral orders route patients to specific clinical services (cardiology, oncology). Linking to facility.service enables referral loop closure tracking by service line, payer contract validation (serv',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: referral_order.referring_provider_npi is a plain-text denormalization of the NPI Registry. Linking to npi_registry supports referral network credentialing validation, CMS referral quality reporting, a',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Referral management requires tracking whether a referral resulted in a confirmed diagnosis (referral-to-diagnosis conversion). This FK supports referral outcome reporting, quality measure calculation,',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SNOMED CT provides granular clinical semantics for referral routing, specialty matching, and interoperable care coordination. Supports clinical detail beyond ICD-10 for precise referral indication and',
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
    `mrn` STRING COMMENT 'The patients Medical Record Number (MRN) as assigned by the facilitys Master Patient Index (MPI). Included on the referral for cross-system patient identification and payer submission.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'The date and time when the referring provider placed the referral order via Computerized Physician Order Entry (CPOE) in the Electronic Health Record (EHR). This is the principal business event timestamp for the referral lifecycle.',
    `order_source_system` STRING COMMENT 'The operational system of record from which the referral order was originated or ingested into the lakehouse. Supports data lineage, reconciliation, and multi-system integration auditing.. Valid values are `Epic|Cerner|MEDITECH|Salesforce|manual`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the referral order. Drives downstream processing in Salesforce Health Cloud and Epic Orders. [ENUM-REF-CANDIDATE: pending|active|accepted|declined|completed|cancelled|expired — promote to reference product]',
    `plan_type` STRING COMMENT 'The type of health insurance plan governing the referral authorization requirements. HMO and POS plans typically require referrals; PPO plans may not. Drives authorization workflow logic. [ENUM-REF-CANDIDATE: HMO|PPO|POS|EPO|Medicare|Medicaid|self_pay — 7 candidates stripped; promote to reference product]',
    `receiving_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the specialist or receiving provider to whom the patient is referred. Required for payer authorization and claims adjudication.. Valid values are `^[0-9]{10}$`',
    `referral_disposition` STRING COMMENT 'The outcome or final disposition of the referral as reported by the receiving provider. Indicates whether the specialist accepted, declined, completed, or the patient did not attend. Used for referral loop closure tracking and quality reporting.. Valid values are `pending|accepted|declined|completed|cancelled|no_show`',
    `referral_loop_closed` BOOLEAN COMMENT 'Indicates whether the referring provider has received and acknowledged the specialists consultation report, closing the referral communication loop. A key quality metric for NCQA HEDIS and PCMH accreditation.',
    `referral_number` STRING COMMENT 'Externally visible, human-readable business identifier for the referral order. Used in payer communications, patient correspondence, and cross-system tracking (e.g., Salesforce Health Cloud, Epic Orders). Format: REF- followed by 10 digits.. Valid values are `^REF-[0-9]{10}$`',
    `referral_reason_description` STRING COMMENT 'Free-text clinical narrative describing the reason for the referral, supplementing the ICD-10 code. Captures clinical context not fully expressed by the diagnosis code, such as symptom progression, treatment failure, or specific clinical question for the specialist.',
    `referral_source` STRING COMMENT 'The clinical setting or care context from which the referral originated. Indicates whether the referral was initiated by a Primary Care Physician (PCP), Emergency Department (ED), inpatient unit, specialist, patient self-referral, or care program enrollment.. Valid values are `PCP|ED|inpatient|specialist|self|care_program`',
    `referral_type` STRING COMMENT 'Categorizes the nature of the referral: to a specialist, external provider, care program, second opinion, or for a specific diagnostic workup. Used for operational routing and analytics segmentation.. Valid values are `specialist|external_provider|care_program|second_opinion|diagnostic`',
    `scheduled_appointment_date` DATE COMMENT 'The date on which the patients appointment with the receiving specialist or provider has been scheduled. Used to measure time-to-appointment and referral fulfillment timeliness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was last modified in the lakehouse Silver layer. Supports change detection and incremental processing.',
    `urgency_level` STRING COMMENT 'Clinical priority level assigned to the referral order by the referring provider. Drives scheduling priority at the receiving provider and payer authorization turnaround time requirements. Values: routine, urgent, stat, emergent.. Valid values are `routine|urgent|stat|emergent`',
    `visits_used` STRING COMMENT 'The number of authorized visits that have been consumed against this referral to date. Compared against authorized_visits to determine remaining utilization and trigger re-authorization alerts.',
    CONSTRAINT pk_referral_order PRIMARY KEY(`referral_order_id`)
) COMMENT 'Clinical order for patient referral to a specialist, external provider, or care program. Captures referring provider NPI, receiving provider NPI, specialty type, referral reason (ICD-10 coded), urgency level, authorization requirement flag, payer authorization number, referral expiration date, number of authorized visits, referral source (PCP, ED, inpatient), and referral disposition (accepted, declined, pending, completed). Integrates with Salesforce Health Cloud Referral Management and payer authorization workflows.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`set` (
    `set_id` BIGINT COMMENT 'Unique surrogate identifier for the order set record in the lakehouse Silver layer. Primary key for the order_set data product.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Order sets are unit-specific (ICU sepsis bundle, ED chest pain order set, NICU protocol). Linking set to facility.unit enables unit-level order set governance, activation scope enforcement, and usage ',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or campus where this order set is deployed and available for use. Supports multi-facility health system deployments where order sets may be facility-specific or enterprise-wide.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Order set coverage alignment: order sets (care pathways, CMS core measure bundles) are designed against specific coverage policies. Clinical informatics teams require this link to ensure order sets re',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Order sets designed for specific appointment types (annual wellness visit order set, pre-operative order set) standardize care delivery. Linking order sets to appointment types enables protocol-driven',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG-based order sets support case management, utilization review, and cost containment initiatives. Links protocol to DRG master for expected LOS management, resource utilization tracking, and bundled',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Health systems create plan-specific order sets for value-based care contracts, formulary compliance, and coverage optimization. Real-world process: clinical informatics teams build order sets aligned ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Order set activation logic depends on diagnosis-driven protocol triggering. Links to ICD-10 master enables automated clinical pathway initiation, evidence-based care delivery, and quality measure comp',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Order sets are created to satisfy specific regulatory obligations (e.g., a sepsis bundle order set satisfies a CMS core measure obligation, a VTE prophylaxis set satisfies a Joint Commission NPSG obli',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Order sets are owned and governed by organizational providers (hospital systems, medical groups). For order set library governance, compliance rate reporting by organization, and CMS core measure attr',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Order sets implement clinical policies (antibiotic stewardship policy, opioid prescribing policy). Direct policy-to-protocol relationship ensures order sets enforce organizational standards and regula',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Order sets implement evidence-based protocols satisfying specific compliance programs (sepsis bundles for CMS SEP-1, VTE prophylaxis for Joint Commission). Direct link between clinical protocols and r',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Order sets are designed and governed by specific clinical service lines (cardiac surgery order set, oncology order set). Linking set to facility.service enables service-line governance of order set ac',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or clinical leader who formally approved the order set on behalf of the approving committee. Supports governance accountability and regulatory audit requirements.',
    `set_clinician_id` BIGINT COMMENT 'Identifier of the clinician or clinical informaticist who originally authored and submitted the order set for governance review. Links to the provider master for accountability and audit trail purposes.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Order sets are built around clinical conditions; set.clinical_indication is plain text. Linking to snomed_concept supports FHIR PlanDefinition mapping (set already has fhir_plan_definition_reference),',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Order sets are specialty-specific clinical protocols (cardiology admission order sets, oncology treatment pathways). Healthcare organizations maintain specialty-based order set libraries, track specia',
    `approval_date` DATE COMMENT 'Date on which the approving clinical committee formally approved the current version of the order set. Establishes the official governance record for audit and regulatory reporting purposes.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the order set within the clinical governance process. Drives whether the order set is available for provider use in CPOE. draft = under development; pending_review = submitted to approving committee; approved = active and available; retired = superseded; suspended = temporarily withdrawn.. Valid values are `draft|pending_review|approved|retired|suspended`',
    `approving_committee` STRING COMMENT 'Name of the clinical governance committee or body responsible for reviewing and approving the order set (e.g., Pharmacy and Therapeutics Committee, Medical Executive Committee, Clinical Quality Council). Required for Joint Commission accreditation and CMS Conditions of Participation compliance.',
    `care_pathway_name` STRING COMMENT 'Name of the clinical care pathway or protocol bundle with which this order set is associated (e.g., Sepsis Care Pathway, Hip Replacement Enhanced Recovery After Surgery (ERAS) Pathway). Links the executable order bundle to the broader clinical protocol framework.',
    `care_setting` STRING COMMENT 'Clinical care setting in which the order set is intended to be used. Restricts order set availability to appropriate clinical contexts within the EHR. inpatient = admitted patients; outpatient = clinic/ambulatory; emergency = Emergency Department (ED); icu = Intensive Care Unit (ICU); surgical = Operating Room (OR)/perioperative; observation = observation status.. Valid values are `inpatient|outpatient|emergency|icu|surgical|observation`',
    `clinical_indication` STRING COMMENT 'Free-text or structured description of the clinical condition, diagnosis, or scenario that triggers activation of this order set (e.g., Suspected sepsis with organ dysfunction, Acute ST-elevation myocardial infarction). Complements the ICD-10 trigger code.',
    `compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of triggered clinical scenarios where the order set was activated by providers, as reported by the EHR analytics module. Sourced from Epic reporting or Cerner analytics — not computed in the lakehouse. Supports HEDIS, MIPS, and VBP quality measure reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order set record was first created in the source system or lakehouse. Supports audit trail requirements per HIPAA Security Rule, Joint Commission, and HIM governance policies.',
    `effective_date` DATE COMMENT 'Date on which the order set version becomes clinically effective and available for provider use in CPOE. Aligns with the approved go-live date established by the governing clinical committee.',
    `evidence_level` STRING COMMENT 'Strength of clinical evidence supporting the order set, using standard evidence grading. A = strong evidence from multiple randomized controlled trials; B = moderate evidence; C = limited evidence; D = very limited evidence; expert_consensus = based on expert opinion in absence of trials. Supports quality measurement and regulatory reporting.. Valid values are `A|B|C|D|expert_consensus`',
    `expiration_date` DATE COMMENT 'Date on which the order set version expires and is no longer valid for clinical use. Null indicates no scheduled expiration. Triggers mandatory review workflow when approaching expiration per clinical governance policy.',
    `fhir_plan_definition_reference` STRING COMMENT 'HL7 FHIR PlanDefinition resource identifier corresponding to this order set, enabling interoperability with Health Information Exchange (HIE) platforms and external clinical decision support systems. Aligns with HL7 FHIR R4 PlanDefinition resource.',
    `governance_level` STRING COMMENT 'Classification of the governance authority underpinning the order set protocol. guideline = based on published clinical practice guidelines; consensus = based on institutional expert consensus without external guideline; regulatory_mandate = required by CMS, Joint Commission, or other regulatory body (e.g., CMS Core Measures, EMTALA requirements).. Valid values are `guideline|consensus|regulatory_mandate`',
    `guideline_reference` STRING COMMENT 'Citation or reference to the external clinical practice guideline, systematic review, or regulatory mandate that underpins the order set (e.g., Surviving Sepsis Campaign 2021 Guidelines, AHA/ACC STEMI Management Guidelines 2023, CMS Sepsis Core Measure SEP-1). Supports clinical documentation improvement (CDI) and regulatory compliance.',
    `includes_lab_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains laboratory orders routed to Beaker (LIS) or equivalent Laboratory Information System (LIS). True = lab orders present; False = no lab orders included.',
    `includes_pharmacy_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains medication orders routed to Willow (pharmacy) or equivalent pharmacy system. True = pharmacy/medication orders present; False = no pharmacy orders included. Relevant for DEA controlled substance tracking.',
    `includes_radiology_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains radiology/imaging orders routed to Radiant (RIS) or equivalent Radiology Information System (RIS). True = radiology orders present; False = no radiology orders included.',
    `includes_referral_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains referral orders to specialists or ancillary services. True = referral orders present; False = no referral orders included. Supports care coordination and transitions of care workflows.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the order set is currently active and available for selection in the CPOE workflow. True = active and selectable by providers; False = inactive and hidden from the order entry interface. Distinct from approval_status — an approved order set may be temporarily deactivated without retiring it.',
    `is_cms_core_measure` BOOLEAN COMMENT 'Indicates whether this order set is directly associated with a CMS Core Measure or quality reporting requirement (e.g., SEP-1 Sepsis Bundle, VTE Prophylaxis). True = linked to a CMS Core Measure; False = not a CMS Core Measure order set. Supports quality measurement and regulatory reporting.',
    `is_hipaa_sensitive` BOOLEAN COMMENT 'Indicates whether the order set is associated with HIPAA-sensitive clinical categories requiring enhanced access controls (e.g., behavioral health, substance use disorder, HIV/AIDS, reproductive health). True = sensitive category requiring additional PHI protections; False = standard clinical order set.',
    `last_review_date` DATE COMMENT 'Date of the most recent clinical review of the order set, regardless of whether a version change resulted. Supports mandatory periodic review cycles (typically annual) required by Joint Commission and institutional policy.',
    `next_review_date` DATE COMMENT 'Date by which the next mandatory clinical review of the order set must be completed. Drives governance workflow alerts and ensures compliance with periodic review requirements per Joint Commission and institutional policy.',
    `order_count` STRING COMMENT 'Total number of individual clinical orders (lab, radiology, pharmacy, nursing, referral) included in the order set bundle. Provides a quick indicator of order set complexity and scope for provider review.',
    `order_set_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the order set within the source system (e.g., Epic Orders catalog ID or Cerner Millennium order set mnemonic). Used for cross-system referencing and integration with Beaker (LIS), Radiant (RIS), and Willow (pharmacy).',
    `order_set_type` STRING COMMENT 'Classification of the order set by its clinical purpose in the care continuum. admission = admission orders bundle; discharge = discharge planning orders; procedure = pre/intra/post-procedure orders; condition = condition-specific management bundle; preventive = preventive care protocol; transition = transitions of care orders.. Valid values are `admission|discharge|procedure|condition|preventive|transition`',
    `owning_department` STRING COMMENT 'Name of the clinical department or service line that owns and is responsible for maintaining the order set (e.g., Department of Cardiology, Emergency Medicine, Pharmacy). Establishes accountability for content governance and periodic review.',
    `population_age_group` STRING COMMENT 'Target patient age group for which the order set is clinically appropriate. Restricts order set availability to appropriate patient populations in CPOE. pediatric = patients under 18; adult = 18-64; geriatric = 65+; neonatal = newborns; all = all age groups.. Valid values are `pediatric|adult|geriatric|neonatal|all`',
    `renal_adjustment_required` BOOLEAN COMMENT 'Indicates whether the order set contains medications requiring renal function-based dose adjustments (e.g., creatinine clearance-based dosing). True = renal adjustment logic embedded; False = no renal adjustment required. Supports clinical decision support (CDS) alerts in CPOE.',
    `set_description` STRING COMMENT 'Detailed narrative description of the order sets clinical purpose, intended patient population, and scope of included orders. Supports clinical documentation improvement (CDI) and provider education.',
    `set_name` STRING COMMENT 'Human-readable name of the pre-defined, evidence-based order set bundle as displayed in the Computerized Physician Order Entry (CPOE) interface (e.g., Sepsis Bundle — Adult ICU, Community-Acquired Pneumonia Admission Orders).',
    `source_system` STRING COMMENT 'Operational system of record from which the order set was sourced. epic = Epic Orders/CPOE; cerner = Cerner Millennium PowerChart; meditech = MEDITECH Expanse; manual = manually entered outside a standard EHR system.. Valid values are `epic|cerner|meditech|manual`',
    `source_system_code` STRING COMMENT 'Native identifier of the order set in the originating operational system (e.g., Epic Orders internal record ID, Cerner Millennium order set catalog ID). Supports ETL lineage tracking and cross-system reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order set record in the source system or lakehouse. Supports change tracking, audit trail requirements, and ETL incremental load processing.',
    `usage_count` STRING COMMENT 'Cumulative count of the number of times this order set version has been activated by providers in CPOE. Supports utilization analytics, adoption tracking, and clinical quality improvement initiatives. Not a calculated aggregate — sourced directly from the EHR order set activation log.',
    `version_number` STRING COMMENT 'Semantic version number of the order set (e.g., 1.0, 2.3, 3.1.2). Incremented upon each approved revision to support version control, audit trails, and rollback capabilities per Health Information Management (HIM) governance requirements.. Valid values are `^d+.d+(.d+)?$`',
    `weight_based_dosing` BOOLEAN COMMENT 'Indicates whether any pharmacy orders within the order set use weight-based dosing calculations (e.g., mg/kg). True = weight-based dosing required; False = fixed dosing. Critical for pediatric and oncology order sets and for pharmacy safety validation in Willow/PharmNet.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Master record for pre-defined, evidence-based bundles of clinical orders (order sets) and their governing clinical protocols and care pathways. Captures order set name, clinical indication, specialty, version number, effective and expiration dates, approval status, approving committee, evidence-based guideline reference, associated DRG or care pathway, active/inactive flag, protocol governance attributes (governance level — guideline, consensus, regulatory mandate), clinical condition or diagnosis trigger (ICD-10), applicable care setting, owning clinical department, evidence level, parent protocol hierarchy, and approval workflow status. SSOT for both the executable order bundle and the clinical policy that governs its activation. Managed in Epic Orders and Cerner Millennium.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`set_item` (
    `set_item_id` BIGINT COMMENT 'Unique identifier for the order set item. Primary key for this entity.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Order set items representing scheduling actions (follow-up visits, procedure bookings, referral appointments) must specify the appointment type to pre-configure scheduling parameters. This supports au',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Order set items map directly to CDM (Charge Description Master) entries for charge capture and price transparency compliance (CMS price transparency rule). Linking set_item to cdm_entry enables charge',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: set_item procedure and imaging items require CPT code linkage for billing compliance, prior authorization at the item level, and CMS core measure procedure tracking. set_item.order_code is plain text ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Order set items representing medication orders must reference drug_master to enable real-time formulary validation, black-box warning alerts, and ISMP high-alert medication checks at order set build a',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: set_item.diagnosis_criteria is a plain-text denormalization of ICD code. Order set items are conditionally included based on diagnosis (e.g., include DVT prophylaxis item only for ICD hip fracture cod',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Order set items specifying imaging procedures must reference the radiology protocol to pre-define exam parameters (contrast, prep, sequence). Clinical informatics teams use this link to auto-populate ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: set_item represents individual orders within order sets; for lab items, LOINC is the standard identifier. set_item.order_code is plain text. Linking to loinc_code supports lab order set standardizatio',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Order set management: supply-type set_item entries (wound care kits, procedure trays) must reference the specific material_master catalog item to enable formulary compliance checks, cost modeling, and',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: set_item medication items (default_dose, default_route, default_frequency exist on set_item) must reference the authoritative NDC drug record for formulary compliance, drug interaction checking within',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Individual order set items may carry distinct policy requirements beyond the parent set (e.g., a chemotherapy item requires a specific consent policy, a controlled substance item requires a DEA compli',
    `set_id` BIGINT COMMENT 'Reference to the parent order set that contains this item. Links this item to its containing order set bundle.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: set_item.order_description and diagnosis_criteria are plain text. Linking to snomed_concept supports FHIR ValueSet membership for order set items, clinical decision support conditional inclusion logic',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: An order set item (set_item) can represent a standing order component within an evidence-based order set. When order_type = standing_order, the set_item should reference the standing_order master re',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Order set build and maintenance: when a set_item represents a lab test, it must reference the test_catalog for specimen requirements, turnaround times, and orderable status. This link is essential for',
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
    `effective_end_date` DATE COMMENT 'Date when this order set item is no longer available for use. Null indicates the item remains effective indefinitely. Supports order set retirement and updates.',
    `effective_start_date` DATE COMMENT 'Date when this order set item becomes available for use. Supports versioning and phased rollout of order set changes.',
    `instruction_text` STRING COMMENT 'Additional instructions or guidance for the ordering provider or fulfillment team. Displayed during order entry and on order requisitions.',
    `is_default_selected` BOOLEAN COMMENT 'Indicates whether this item is pre-selected by default when the order set is opened. Providers can deselect optional items.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this order item must be included when the order set is activated. True means the item cannot be deselected by the ordering provider.',
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
    `version_number` STRING COMMENT 'Version identifier for this order set item configuration. Supports change tracking and audit requirements for clinical content management.',
    `weight_max_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no maximum weight restriction.',
    `weight_min_kg` DECIMAL(18,2) COMMENT 'Minimum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no minimum weight restriction.',
    CONSTRAINT pk_set_item PRIMARY KEY(`set_item_id`)
) COMMENT 'Individual order line within an order set, defining each component order that is pre-configured for a care pathway. Captures the parent order set, sequence number, order type, default values (dose, frequency, priority, route), mandatory vs. optional flag, conditional inclusion logic (e.g., if lab value exceeds threshold then include order), conditional logic trigger criteria, age/weight/diagnosis-based inclusion rules, clinical rationale, and alternative order options. Enables granular management of order set content and supports clinical decision support (CDS) rule evaluation at the item level. SSOT for the composition and conditional logic of order set bundles.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the order routing record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or campus where the destination department is located. Supports multi-site health systems.',
    `clinical_order_id` BIGINT COMMENT 'Identifier of the clinical order being routed. Links to the parent order from CPOE (Computerized Physician Order Entry) system.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Order routing directs work to specific clinical units (lab, pharmacy, radiology). Linking routing to facility.unit enables unit-level queue management, workload balancing, and turnaround time SLA repo',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Order routing decisions must comply with policies governing controlled substance routing, STAT order escalation, and cross-facility routing. Compliance auditors reviewing routing rule adherence need r',
    `acknowledgement_datetime` TIMESTAMP COMMENT 'Timestamp when the receiving department or system acknowledged receipt of the routed order. Used to measure queue wait time.',
    `auto_route_eligible_flag` BOOLEAN COMMENT 'Indicates whether the order was eligible for automatic routing based on order type, priority, and system configuration. False if manual routing was required.',
    `completion_datetime` TIMESTAMP COMMENT 'Timestamp when the routing event was marked complete, indicating the order reached its fulfillment destination and processing began.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was first created in the system. Audit field for data lineage and troubleshooting.',
    `datetime` TIMESTAMP COMMENT 'Timestamp when the order was routed to the destination department or facility. Critical for SLA (Service Level Agreement) tracking and turnaround time analysis.',
    `delay_minutes` STRING COMMENT 'Number of minutes the routing event exceeded the SLA target. Null if SLA was met. Used for bottleneck analysis and process improvement.',
    `destination_workstation_code` STRING COMMENT 'Identifier of the specific workstation, instrument, or device to which the order was routed within the destination department. Used for lab analyzers, imaging modalities, and pharmacy dispensing systems.',
    `estimated_completion_datetime` TIMESTAMP COMMENT 'Predicted timestamp when the order fulfillment will be completed, based on current queue depth, workload, and historical turnaround times.',
    `notes` STRING COMMENT 'Free-text notes entered by routing staff or system administrators regarding special handling, exceptions, or issues encountered during routing.',
    `patient_location_at_routing` STRING COMMENT 'Patient location (unit, room, bed) at the time the order was routed. Used to optimize routing for point-of-care services and specimen collection.',
    `priority` STRING COMMENT 'Priority level assigned to the routing event. STAT orders receive immediate routing and queue priority, urgent orders are expedited, routine orders follow standard workflows.. Valid values are `stat|urgent|routine|scheduled|timed`',
    `priority_override_flag` BOOLEAN COMMENT 'Indicates whether the routing priority was manually overridden by a clinician or supervisor. True if priority was escalated or de-escalated from the original order priority.',
    `priority_override_reason` STRING COMMENT 'Free-text explanation for why the routing priority was overridden. Captures clinical justification for escalation or de-escalation.',
    `queue_name` STRING COMMENT 'Name of the work queue to which the order was assigned within the destination department. Examples include STAT Lab Queue, Routine Radiology Queue, Pharmacy Verification Queue.',
    `queue_position` STRING COMMENT 'Position of the order within the assigned queue at the time of routing. Used to track queue depth and wait times.',
    `reroute_count` STRING COMMENT 'Number of times this order has been rerouted to different destinations. High reroute counts indicate routing rule issues or capacity constraints.',
    `reroute_reason` STRING COMMENT 'Reason why the order was rerouted from its original destination. Supports root cause analysis of routing failures and capacity planning. [ENUM-REF-CANDIDATE: capacity_exceeded|equipment_unavailable|staff_unavailable|patient_location_change|order_modification|system_error|clinical_decision — 7 candidates stripped; promote to reference product]',
    `routing_method` STRING COMMENT 'Method by which the order was routed. Distinguishes between automated rule-based routing, manual clinician override, load balancing algorithms, and emergency escalation paths.. Valid values are `automatic|manual_override|rule_based|load_balanced|escalated|emergency`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing event. Tracks progression from initial queue assignment through fulfillment or failure. [ENUM-REF-CANDIDATE: queued|acknowledged|in_progress|completed|rerouted|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `rule_name` STRING COMMENT 'Human-readable name of the routing rule applied, such as STAT Lab Priority Routing or Radiology Load Balancing Rule.',
    `sequence` STRING COMMENT 'Sequential number indicating the order of routing events for a single order. Supports tracking of rerouting and escalation workflows.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the routing event met the defined SLA target. True if acknowledgement or completion occurred within the target timeframe.',
    `sla_target_minutes` STRING COMMENT 'Target turnaround time in minutes from routing to acknowledgement or completion, based on order priority and type. Used for SLA compliance monitoring.',
    `specimen_collection_required_flag` BOOLEAN COMMENT 'Indicates whether the routed order requires specimen collection before fulfillment. True for lab orders requiring phlebotomy or other collection procedures.',
    `system_source` STRING COMMENT 'Source system that generated or processed the routing event. Identifies whether routing originated from Epic Orders, Beaker LIS, Radiant RIS, Willow Pharmacy, or other integrated systems. [ENUM-REF-CANDIDATE: epic_orders|beaker_lis|radiant_ris|willow_pharmacy|cerner_orders|interface_engine|manual_entry — 7 candidates stripped; promote to reference product]',
    `transport_required_flag` BOOLEAN COMMENT 'Indicates whether patient transport is required to fulfill the order. True for imaging or procedure orders where the patient must be moved to the destination department.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was last modified. Tracks status changes, rerouting events, and data corrections.',
    `workload_score` DECIMAL(18,2) COMMENT 'Calculated workload score of the destination department or queue at the time of routing. Used by load balancing algorithms to distribute orders across available resources.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Operational record capturing how a clinical order is routed to its fulfilling department, lab, pharmacy, or imaging unit. Captures routing rule applied, destination department or facility, routing datetime, routing method (automatic, manual override), routing priority, queue assignment, routing status (queued, acknowledged, rerouted, failed), and queue position. Supports operational visibility into order fulfillment bottlenecks, SLA compliance for STAT and urgent orders, and department workload balancing.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`fulfillment` (
    `fulfillment_id` BIGINT COMMENT 'Unique identifier for the order fulfillment record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Order fulfillment events (imaging studies, procedures, infusions) occur during scheduled appointments. Linking fulfillment to appointment enables turnaround time tracking, no-show impact analysis, and',
    `care_site_id` BIGINT COMMENT 'Foreign key reference to the facility, department, or location where the order was fulfilled (e.g., lab, radiology suite, pharmacy).',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that was fulfilled. Links to the originating order in the order management system.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Revenue cycle coverage verification: the coverage policy applied at fulfillment determines charge capture validity, modifier requirements, and billing rules. Coding and billing teams require this link',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charge capture at fulfillment links completed service to CPT master for accurate billing, RVU calculation, reimbursement determination, and revenue cycle management. Essential for financial reconcilia',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was fulfilled. Links fulfillment to the patient master record.',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Order fulfillment records for medication orders must reference the pharmacy dispense event that executed the fulfillment. This closes the order-to-dispense loop required for charge capture reconciliat',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to facility.equipment_asset. Business justification: Imaging, infusion, and procedure orders are fulfilled using specific equipment assets. Linking fulfillment to equipment_asset enables equipment utilization tracking, usage-based preventive maintenance',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule. Business justification: Reimbursement rate determination: the fee schedule applied at fulfillment drives charge_amount, contracted_rate reconciliation, and revenue recognition. Finance and revenue cycle teams require this li',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider, technician, or clinician who performed or completed the fulfillment. May be a lab technician, radiologist, pharmacist, or other clinical staff.',
    `fulfillment_ordering_provider_clinician_id` BIGINT COMMENT 'Foreign key reference to the provider who originally placed the clinical order. Distinct from the fulfilling provider.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME, supplies, and ambulance service fulfillment require HCPCS code linkage to master for pricing determination, coverage validation, and billing compliance. Critical for non-physician service revenue',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Order fulfillment reconciliation: fulfillment records the execution of a clinical_order; when that order is a lab order, linking to lab_order enables direct billing reconciliation, charge capture vali',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab order fulfillments must reference LOINC to identify what was performed, supporting result reporting, HL7 ORU message generation, CMS quality measure calculation, and lab accreditation reporting. A',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Charge capture and supply utilization reporting: when a clinical order is fulfilled using a specific supply item, fulfillment must reference material_master to enable accurate charge capture, CDM reco',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy order fulfillments (medication dispensing) must reference the dispensed NDC drug for medication administration records, drug utilization review, formulary compliance auditing, and DEA control',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Fulfillment events trigger charge capture and claim submission processes that require payer identification. Real-world process: revenue cycle systems link fulfilled orders to payer for billing, tracki',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Surgical order fulfillment must track which OR suite performed the procedure for OR utilization reporting, CMS surgical quality metrics, and block scheduling analytics. A healthcare operations expert ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Claims adjudication and payer billing require identifying the performing organizational provider (NPI Type 2) on fulfillment records. performing_department_code is insufficient for credentialing verif',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Order fulfillment must be attributed to the specific clinical unit (ICU, ED, pharmacy) for nursing workload reporting, unit-level quality metrics, and cost center charge capture. performing_department',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Order fulfillment activities are governed by specific compliance policies (e.g., charge capture policy, specimen handling policy, medication administration policy). Compliance officers reviewing fulfi',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Order fulfillment records for medication orders must reference the pharmacy prescription to support medication order completion verification, charge capture reconciliation, and 340B drug program compl',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Charge capture and PA compliance: at fulfillment, the PA rule that authorized the service must be recorded for claim submission and denial prevention. Revenue cycle teams require this link to validate',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Charge capture reconciliation requires linking the operational fulfillment record to the clinical procedure event. Revenue cycle teams use this to verify that billed procedures match documented clinic',
    `routing_id` BIGINT COMMENT 'Foreign key linking to order.routing. Business justification: A fulfillment record completes the work initiated by a specific routing event. Linking fulfillment.routing_id → routing.routing_id enables direct SLA compliance analysis (routing SLA target vs. fulfil',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen collected and used for fulfillment. Primarily applicable to laboratory and pathology orders. Links to specimen tracking systems.',
    `study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: Charge capture reconciliation requires matching fulfillment records to the actual radiology study performed. Revenue cycle teams and radiology operations use this link for turnaround time reporting, b',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Result-to-fulfillment linkage: fulfillment tracks result_availability_datetime and turnaround_time_minutes. Linking to test_result enables direct result lookup for charge capture, quality reporting (T',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Fulfillment records may track which vendor supplied the item, especially for consignment inventory or vendor-managed stock. Essential for vendor performance metrics, rebate tracking, and consignment r',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter during which the order was fulfilled. Links fulfillment to the clinical encounter context.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Order fulfillment reconciliation requires linking each fulfillment record to the resulting documented procedure for charge capture, coding accuracy, and surgical quality reporting. HIM and revenue cyc',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount associated with the fulfillment event. Represents the list price from the Charge Description Master (CDM) before adjustments, discounts, or contractual allowances.',
    `charge_capture_flag` BOOLEAN COMMENT 'Boolean indicator of whether a billable charge was captured for this fulfillment event. Used for revenue cycle management and billing reconciliation.',
    `charge_code` STRING COMMENT 'The internal charge code or CDM code associated with the fulfilled service. Links to the Charge Description Master for billing and revenue cycle processing.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was first created in the data system. Audit trail field for data lineage and record lifecycle tracking.',
    `datetime` TIMESTAMP COMMENT 'The date and time when the order was fulfilled or completed by the fulfilling department. This is the principal business event timestamp representing when the work was performed.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why the order was not fulfilled as originally ordered. Used when status is cancelled, failed, or partial. Maps to internal exception reason reference data.',
    `exception_reason_description` STRING COMMENT 'Free-text description of the exception or reason why the order was not fulfilled as ordered. Provides additional context beyond the standardized exception reason code.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The actual quantity or amount fulfilled by the performing department. May differ from ordered quantity in cases of partial fulfillment, substitution, or unavailability.',
    `fulfillment_method` STRING COMMENT 'The method or process used to fulfill the order. Indicates whether the fulfillment was performed manually, using automated equipment, at point of care, or outsourced to an external provider.. Valid values are `manual|automated|semi_automated|point_of_care|external_lab|outsourced`',
    `fulfillment_number` STRING COMMENT 'Business identifier for the fulfillment event. Human-readable unique number assigned by the fulfilling department or system (e.g., lab accession number, radiology case number, pharmacy dispense number).',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment event. Indicates whether the order was fully completed, partially fulfilled, cancelled, failed, or is still in progress.. Valid values are `completed|partial|cancelled|failed|in_progress|pending`',
    `modifier_codes` STRING COMMENT 'Comma-separated list of CPT or HCPCS modifier codes applied to the procedure. Modifiers provide additional information about the service performed (e.g., bilateral procedure, multiple procedures).',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the fulfilling provider or technician. May include technical details, observations, or special handling instructions relevant to the fulfillment.',
    `order_type` STRING COMMENT 'The category or type of clinical order that was fulfilled. Determines which downstream domain owns the detailed result data (laboratory, radiology, pharmacy). [ENUM-REF-CANDIDATE: laboratory|radiology|pharmacy|referral|procedure|therapy|consult — 7 candidates stripped; promote to reference product]',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity or amount originally ordered by the ordering provider. Used for comparison with actual fulfilled quantity to detect partial fulfillments.',
    `partial_fulfillment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the order was partially fulfilled (True) or fully fulfilled (False). Set to True when fulfilled quantity is less than ordered quantity.',
    `priority_code` STRING COMMENT 'The priority level assigned to the order at the time of fulfillment. Indicates urgency and expected turnaround time (STAT = immediate, urgent = within hours, routine = standard processing).. Valid values are `routine|urgent|stat|asap|timed`',
    `quality_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fulfillment event has been flagged for quality review or audit. Used for quality assurance, compliance monitoring, and performance improvement initiatives.',
    `quality_review_notes` STRING COMMENT 'Free-text notes entered during quality review or audit of the fulfillment event. Documents quality concerns, corrective actions, or compliance findings.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the ordered and fulfilled quantities (e.g., mg, mL, tablets, tests, images, doses). Standardized using UCUM (Unified Code for Units of Measure).',
    `result_availability_datetime` TIMESTAMP COMMENT 'The date and time when the results of the fulfilled order became available for review. May differ from fulfillment datetime for orders requiring processing time (e.g., lab cultures, pathology).',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with the fulfillment for hospital billing. Identifies the department or type of service for institutional claims.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated the fulfillment record (e.g., EPIC_ORDERS, BEAKER_LIS, RADIANT_RIS, WILLOW_PHARM). Used for data lineage and integration tracking.',
    `turnaround_time_minutes` STRING COMMENT 'Calculated elapsed time in minutes from order placement to fulfillment completion. Key performance indicator for order processing efficiency and departmental performance measurement.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was last modified. Audit trail field for tracking changes and data quality monitoring.',
    CONSTRAINT pk_fulfillment PRIMARY KEY(`fulfillment_id`)
) COMMENT 'Transactional record capturing the completion or execution of a clinical order by the fulfilling department, serving as the order domains acknowledgment that downstream work was performed. Captures fulfillment datetime, fulfilling provider or technician, fulfillment location, fulfillment method, actual vs. ordered quantity, partial fulfillment indicator, fulfillment notes, exception reason if the order was not fulfilled as ordered, fulfillment status, and turnaround time (order-to-fulfillment elapsed time). Bridges the order intent (clinical_order) with the result or dispensing event in downstream domains (laboratory, radiology, pharmacy). SSOT boundary: this product tracks fulfillment status and timing from the order perspective only. Detailed result data (lab values, imaging reports, dispensing records) is owned by the respective downstream domain — laboratory, radiology, or pharmacy.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`order`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order record. Primary key.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Standing orders (nurse-initiated protocols) are unit-scoped — an ICU vasopressor protocol must not activate on a med-surg floor. Linking standing_order to facility.unit is required for TJC standing or',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where this standing order protocol is authorized for use.',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or advanced practice provider who authorized this standing order protocol.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Standing orders for procedures (e.g., wound care, physical therapy protocols) require CPT code linkage for billing compliance, prior authorization workflows, and CMS quality measure reporting. A healt',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Standing medication orders must reference the authoritative drug master catalog for ISMP high-alert checks, REMS requirements, renal/hepatic dosing adjustments, and DEA schedule validation. The curren',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Standing medication orders must be validated against the formulary to enforce prior authorization requirements, quantity limits, and step therapy protocols. In real hospital operations, pharmacy revie',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: In value-based care and ACO models, physician groups authorize standing orders for their patient panels (e.g., standing HbA1c orders for diabetic patients). Linking standing_order to group enables gro',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Standing orders for DME (e.g., home oxygen, wound care supplies) and home health services require HCPCS coding for Medicare/Medicaid billing compliance and prior authorization. HCPCS covers services n',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Standing orders are protocol-driven and tied to specific diagnoses (e.g., DVT prophylaxis for hip fracture, insulin sliding scale for diabetes). Linking to icd_code supports population health manageme',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Standing imaging orders (e.g., annual surveillance CT, mammography) must reference the specific radiology protocol to ensure reproducibility across recurring exams. Radiology QA and dose optimization ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocol-driven lab orders in standing order protocols require LOINC linkage for standardized test ordering, interoperability, results interpretation, and quality measure reporting. Supports evidence-',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Supply demand forecasting: standing orders for recurring supply items (IV fluids, wound dressings, DME) must reference material_master to enable supply chain demand planning, par-level management, and',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: standing_order has medication_name, medication_dose, medication_route as plain-text columns — clear denormalization of ndc_drug. Standing medication protocols (e.g., PRN pain management, DVT prophylax',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Standing orders are frequently created to satisfy specific regulatory obligations (e.g., fall risk assessment standing orders satisfy CMS CoP obligations, VTE prophylaxis standing orders satisfy core ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Standing orders are authorized at the organizational level (hospital system, health network). Linking to org_provider enables regulatory compliance audits (CMS, Joint Commission), credentialing verifi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Standing orders are governed by specific policies defining scope, approval process, and usage criteria. Policy framework for standing order programs ensures regulatory compliance and clinical governan',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Protocol-based PA governance: standing orders (e.g., recurring lab panels, medication protocols) must reference the PA rule that permits repeated execution without individual authorization. Compliance',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Standing orders require approval under specific compliance programs (nursing protocols under state board requirements, emergency protocols under EMTALA). Regulatory governance of standing order progra',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: standing_order.clinical_indication is plain text. Linking to snomed_concept supports clinical decision support rule evaluation (e.g., trigger standing order when SNOMED condition is active), FHIR Plan',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Standing orders are specialty-driven protocols (ED standing orders for chest pain, ICU sepsis protocols). Specialty governance committees approve and audit standing order usage by specialty. Required ',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Standing lab order protocol management: standing orders for recurring lab tests (e.g., monthly INR, weekly CBC) must reference the test_catalog for specimen type, collection instructions, and turnarou',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: Standing orders for high-risk procedures (IV therapy, blood transfusion, chemotherapy) require executing staff to have completed specific training before acting on the order. Healthcare organizations ',
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
    `evidence_based_guideline_reference` STRING COMMENT 'Citation or reference to clinical practice guidelines, research studies, or evidence-based protocols supporting this standing order.',
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
    `usage_count` STRING COMMENT 'Number of times this standing order has been executed since activation, used for utilization tracking and quality monitoring.',
    CONSTRAINT pk_standing_order PRIMARY KEY(`standing_order_id`)
) COMMENT 'Master record for pre-authorized, protocol-driven orders that can be executed by nursing or ancillary staff without individual provider sign-off for each instance. Captures protocol name, authorizing provider, applicable patient population criteria, order parameters (drug, dose, frequency, lab test, intervention), activation conditions, maximum duration, renewal requirements, and approval status. Supports nurse-initiated protocols, ED standing orders, and population health standing order programs.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_parent_order_clinical_order_id` FOREIGN KEY (`parent_order_clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_set_id` FOREIGN KEY (`set_id`) REFERENCES `healthcare_ecm`.`order`.`set`(`set_id`);
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `healthcare_ecm`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `healthcare_ecm`.`order`.`routing`(`routing_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Department ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Response');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_value_regex' = 'no_alert|alert_accepted|alert_overridden|alert_cancelled');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Free Text');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Completed Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `cosign_completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Completed Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `cosign_due_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Due Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Frequency Code');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `is_cpoe_entered` SET TAGS ('dbx_business_glossary_term' = 'Computerized Physician Order Entry (CPOE) Flag');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('dbx_business_glossary_term' = 'Order Set Member Flag');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Order Flag');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `is_verbal_order` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `number_of_occurrences` SET TAGS ('dbx_business_glossary_term' = 'Number of Order Occurrences');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_catalog_code` SET TAGS ('dbx_business_glossary_term' = 'Order Catalog Code');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Class');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ED|ambulatory');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_entered_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Entered Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Mode');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_value_regex' = 'electronic|verbal|written|telephone');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Name');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Number');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Priority');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|urgent|timed');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Status');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|on_hold|discontinued');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Type');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|manual');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Start Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `stop_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Stop Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`clinical_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `order_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Modifying Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `cds_alert_overridden` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Overridden Flag');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `cosignature_required` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `cosignature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Type');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `effective_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Event Effective Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Order Event Type');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `hipaa_audit_category` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Audit Category');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `hipaa_audit_category` SET TAGS ('dbx_value_regex' = 'ACCESS|MODIFICATION|DISCLOSURE|CORRECTION|DELETION');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `is_verbal_order` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('dbx_business_glossary_term' = 'Modified Field Name');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `modifying_user_role` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Role');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Field Value');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'ROUTINE|URGENT|STAT|ASAP');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'CDS Alert Override Reason');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Field Value');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Free Text');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `renewal_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Sequence Number');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `transmission_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Transmission Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Order Transmission Status');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `transmission_status` SET TAGS ('dbx_value_regex' = 'SENT|PENDING|FAILED|ACKNOWLEDGED|NOT_REQUIRED');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `verbal_order_authentication_datetime` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Authentication Datetime');
ALTER TABLE `healthcare_ecm`.`order`.`order_status_history` ALTER COLUMN `workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Workstation ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Facility ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Health Plan ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Icd10 Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `receiving_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving (Specialist) Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Provider Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit (Encounter) ID');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `authorized_visits` SET TAGS ('dbx_business_glossary_term' = 'Number of Authorized Visits');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Notes');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Effective Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `first_available_date` SET TAGS ('dbx_business_glossary_term' = 'Specialist First Available Appointment Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `loop_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Placed Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|Salesforce|manual');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Status');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Receiving Provider National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|completed|cancelled|no_show');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_loop_closed` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Flag');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Number');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Description');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'PCP|ED|inpatient|specialist|self|care_program');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'specialist|external_provider|care_program|second_opinion|diagnostic');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Referred Appointment Scheduled Date');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency Level');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `healthcare_ecm`.`order`.`referral_order` ALTER COLUMN `visits_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Visits Used');
ALTER TABLE `healthcare_ecm`.`order`.`set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`order`.`set` SET TAGS ('dbx_subdomain' = 'clinical_protocols');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Default Appointment Type Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Trigger Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `set_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Approval Date');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Approval Status');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|retired|suspended');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `approving_committee` SET TAGS ('dbx_business_glossary_term' = 'Approving Clinical Committee');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `care_pathway_name` SET TAGS ('dbx_business_glossary_term' = 'Associated Care Pathway Name');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Applicable Care Setting');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|icu|surgical|observation');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Order Set Compliance Rate Percentage');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Effective Date');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `evidence_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Level');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `evidence_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|expert_consensus');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Expiration Date');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `fhir_plan_definition_reference` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) PlanDefinition ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `governance_level` SET TAGS ('dbx_business_glossary_term' = 'Protocol Governance Level');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `governance_level` SET TAGS ('dbx_value_regex' = 'guideline|consensus|regulatory_mandate');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `includes_lab_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Laboratory Orders Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `includes_pharmacy_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Pharmacy Orders Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `includes_radiology_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Radiology Orders Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `includes_referral_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Referral Orders Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Order Set Active Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `is_cms_core_measure` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Core Measure Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `is_hipaa_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Sensitive Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Clinical Review Date');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `order_set_code` SET TAGS ('dbx_business_glossary_term' = 'Order Set Code');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `order_set_type` SET TAGS ('dbx_business_glossary_term' = 'Order Set Type');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `order_set_type` SET TAGS ('dbx_value_regex' = 'admission|discharge|procedure|condition|preventive|transition');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Clinical Department');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `population_age_group` SET TAGS ('dbx_business_glossary_term' = 'Target Population Age Group');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `population_age_group` SET TAGS ('dbx_value_regex' = 'pediatric|adult|geriatric|neonatal|all');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `renal_adjustment_required` SET TAGS ('dbx_business_glossary_term' = 'Renal Dose Adjustment Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `set_description` SET TAGS ('dbx_business_glossary_term' = 'Order Set Description');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_business_glossary_term' = 'Order Set Name');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic|cerner|meditech|manual');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Set ID');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Order Set Usage Count');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Order Set Version Number');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `healthcare_ecm`.`order`.`set` ALTER COLUMN `weight_based_dosing` SET TAGS ('dbx_business_glossary_term' = 'Weight-Based Dosing Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` SET TAGS ('dbx_subdomain' = 'clinical_protocols');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `set_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age in Years');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `alternative_order_options` SET TAGS ('dbx_business_glossary_term' = 'Alternative Order Options');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Conditional Inclusion Logic');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `contrast_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contrast Indicator');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_business_glossary_term' = 'Default Dose');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('dbx_business_glossary_term' = 'Default Duration');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_frequency` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_business_glossary_term' = 'Default Priority');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `default_route` SET TAGS ('dbx_business_glossary_term' = 'Default Route');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Instruction Text');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `is_default_selected` SET TAGS ('dbx_business_glossary_term' = 'Default Selected Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'laboratory|radiology|pharmacy|procedure|referral|nursing');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Patient Instruction Text');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `requires_authorization` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Consent Flag');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Status');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `weight_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight in Kilograms (kg)');
ALTER TABLE `healthcare_ecm`.`order`.`set_item` ALTER COLUMN `weight_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight in Kilograms (kg)');
ALTER TABLE `healthcare_ecm`.`order`.`routing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`order`.`routing` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Order Routing ID');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `acknowledgement_datetime` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `auto_route_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Route Eligible Flag');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completion Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Routing Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Routing Delay Minutes');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Workstation ID');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `estimated_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Notes');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_business_glossary_term' = 'Patient Location at Routing');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'stat|urgent|routine|scheduled|timed');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `priority_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Flag');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `priority_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Reason');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `reroute_count` SET TAGS ('dbx_business_glossary_term' = 'Reroute Count');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `reroute_reason` SET TAGS ('dbx_business_glossary_term' = 'Reroute Reason');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `routing_method` SET TAGS ('dbx_business_glossary_term' = 'Routing Method');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `routing_method` SET TAGS ('dbx_value_regex' = 'automatic|manual_override|rule_based|load_balanced|escalated|emergency');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Routing Sequence Number');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'Routing System Source');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `transport_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transport Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Updated Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`routing` ALTER COLUMN `workload_score` SET TAGS ('dbx_business_glossary_term' = 'Workload Score');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'fulfillment_execution');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Or Suite Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `charge_capture_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Flag');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated|point_of_care|external_lab|outsourced');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|failed|in_progress|pending');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `modifier_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier Codes');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `partial_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Fulfillment Flag');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `quality_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `result_availability_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Availability Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Minutes');
ALTER TABLE `healthcare_ecm`.`order`.`fulfillment` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` SET TAGS ('dbx_subdomain' = 'clinical_protocols');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order ID');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_business_glossary_term' = 'Activation Condition');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `applicable_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicable Population Criteria');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `authorized_role` SET TAGS ('dbx_business_glossary_term' = 'Authorized Role');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `contraindication` SET TAGS ('dbx_business_glossary_term' = 'Contraindication');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `documentation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirement');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `evidence_based_guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `maximum_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration Days');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_business_glossary_term' = 'Medication Dose');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Medication Frequency');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_business_glossary_term' = 'Medication Route');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `notification_recipient_role` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Role');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `order_detail` SET TAGS ('dbx_business_glossary_term' = 'Order Detail');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Protocol Code');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Name');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `regulatory_compliance_note` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Note');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `renewal_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Days');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `healthcare_ecm`.`order`.`standing_order` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
