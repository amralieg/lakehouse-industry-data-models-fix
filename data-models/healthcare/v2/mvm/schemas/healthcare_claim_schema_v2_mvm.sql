-- Schema for Domain: claim | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`claim` COMMENT 'Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim record.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to encounter.encounter_authorization. Business justification: Revenue cycle authorization reconciliation: the claim must be matched to the clinical prior authorization record (encounter_authorization) to validate that the billed service was pre-approved. This is',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `demographics_id` BIGINT COMMENT 'Patient demographic record.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: DRG billing validation and MS-DRG audit: the inpatient claim must reference the finalized DRG assignment record to support grouper reconciliation, RAC audit defense, and expected vs. paid reimbursemen',
    `drg_id` BIGINT COMMENT 'Diagnosis Related Group for inpatient claims.',
    `health_plan_id` BIGINT COMMENT 'Payer health plan.',
    `hipaa_authorization_id` BIGINT COMMENT 'Foreign key linking to consent.hipaa_authorization. Business justification: HIPAA 45 CFR §164.508 requires a valid authorization for PHI disclosure to payers. Claims processing must verify a hipaa_authorization exists before submitting PHI to the payer. No existing column on ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Enterprise patient identity resolution requires claims linked to the MPI golden record — not just facility-level demographics — for duplicate claim detection, cross-facility claim reconciliation, and ',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Claims are adjudicated under a specific payer contract governing reimbursement rates, timely filing limits, and payment terms. Contract-level claim reporting is required for managed care contract perf',
    `payer_id` BIGINT COMMENT 'Insurance payer receiving the claim.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: A claim references a prior authorization for the services billed. The claim currently stores authorization_number as a STRING, which is a denormalized reference. Adding prior_authorization_id as a pro',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Claims compliance and billing audit require traceability from each claim to the consent_record authorizing treatment and billing. HIPAA and CMS audit workflows verify consent exists for billed service',
    `referral_order_id` BIGINT COMMENT 'Link to referral order if applicable.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: CMS-1500/837P claims require a referring provider distinct from billing and rendering providers. Referral pattern analytics, network adequacy reporting, and referral authorization workflows all depend',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Claim adjudication and HIPAA compliance require validating the referring provider NPI against the authoritative NPI registry. referring_provider_npi is a denormalized string; a FK enables real-time NP',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.restriction_request. Business justification: Under HITECH/45 CFR §164.522, if a patient paid out-of-pocket and filed a restriction_request, the provider CANNOT submit the claim to that payer. Claims processing must check active restriction_reque',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `visit_insurance_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_insurance. Business justification: Billing reconciliation: the claim must be verifiably tied to the specific visit_insurance record capturing coverage at time of service, including COB sequence, eligibility status, and preauth requirem',
    `adjudication_timestamp` TIMESTAMP COMMENT 'When payer adjudicated the claim.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount.',
    `admission_date` DATE COMMENT 'Inpatient admission date.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates if appeal was filed.',
    `bill_type` STRING COMMENT 'UB-04 bill type code.',
    `claim_number` STRING COMMENT 'Provider-assigned claim number.',
    `claim_status` STRING COMMENT 'Current claim status (submitted, paid, denied, etc.).',
    `claim_type` STRING COMMENT 'Professional, institutional, dental, pharmacy.',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Indicates coordination of benefits applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `denial_reason_code` STRING COMMENT 'CARC code if denied.',
    `denial_reason_description` STRING COMMENT 'Human-readable denial reason.',
    `discharge_date` DATE COMMENT 'Inpatient discharge date.',
    `drg_grouper_version` STRING COMMENT 'Version of DRG grouper used.',
    `paid_timestamp` TIMESTAMP COMMENT 'When claim was paid.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Patient out-of-pocket amount.',
    `payer_claim_number` STRING COMMENT 'Payer-assigned claim control number.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code.',
    `primary_payer_flag` BOOLEAN COMMENT 'Indicates if this is primary payer.',
    `principal_diagnosis_code` STRING COMMENT 'ICD-10 principal diagnosis.',
    `principal_procedure_code` STRING COMMENT 'ICD-10-PCS principal procedure.',
    `rac_audit_flag` BOOLEAN COMMENT 'Indicates RAC audit involvement.',
    `service_from_date` DATE COMMENT 'Service period start date.',
    `service_to_date` DATE COMMENT 'Service period end date.',
    `source_system_claim_code` STRING COMMENT 'Source system claim identifier.',
    `submission_method` STRING COMMENT 'EDI, paper, portal.',
    `submitted_timestamp` TIMESTAMP COMMENT 'When claim was submitted to payer.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Total payer-allowed amount.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Total billed amount.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total paid amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Core claim record representing a request for payment from a payer for healthcare services rendered. Links patient, provider, payer, and clinical context. Supports revenue cycle, denial management, and compliance workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the claim line.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Claim line adjudication requires matching each billed service to a specific benefit to determine coverage, cost-sharing tier, and allowed amount. Benefit-level adjudication is a core managed care reve',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule. Business justification: Claim lines are priced against a specific fee schedule to determine allowed amounts during adjudication. Fee schedule assignment at the line level is a core managed care contracting and payment integr',
    `fulfillment_id` BIGINT COMMENT 'Link to order fulfillment.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Drug utilization review, formulary validation, and CMS drug claim reporting require linking claim lines to the authoritative NDC drug registry. ndc_code on line is a denormalized string; a proper FK e',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Ordering provider NPI validation against the NPI registry is required for claim line adjudication, medical necessity review, and CMS compliance. ordering_provider_npi is a denormalized string; a FK su',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Individual service lines may require prior authorization, and the line table currently stores authorization_number as a STRING — a denormalized reference to the prior_authorization record. Adding prio',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Revenue cycle reconciliation requires matching each claim line to the clinical procedure event that generated the charge. Coding accuracy audits, unbilled procedure identification, and CPT modifier va',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Charge reconciliation and claim audit: each billed claim line must trace back to the source clinical procedure performed. Revenue cycle teams use this link for charge capture validation, denial manage',
    `adjudication_date` DATE COMMENT 'Date line was adjudicated.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Line adjustment amount.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Payer-allowed amount.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Billed amount.',
    `coordination_of_benefits_indicator` STRING COMMENT 'COB indicator.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `denial_reason_code` STRING COMMENT 'CARC code if denied.',
    `diagnosis_pointer_1` STRING COMMENT 'First diagnosis pointer.',
    `diagnosis_pointer_2` STRING COMMENT 'Second diagnosis pointer.',
    `diagnosis_pointer_3` STRING COMMENT 'Third diagnosis pointer.',
    `diagnosis_pointer_4` STRING COMMENT 'Fourth diagnosis pointer.',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG weight.',
    `drug_quantity` DECIMAL(18,2) COMMENT 'Drug quantity.',
    `drug_unit_of_measure` STRING COMMENT 'Drug unit of measure.',
    `line_number` STRING COMMENT 'Line sequence number.',
    `line_status` STRING COMMENT 'Line status.',
    `modifier_1` STRING COMMENT 'First modifier.',
    `modifier_2` STRING COMMENT 'Second modifier.',
    `modifier_3` STRING COMMENT 'Third modifier.',
    `modifier_4` STRING COMMENT 'Fourth modifier.',
    `outlier_payment_amount` DECIMAL(18,2) COMMENT 'Outlier payment amount.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Paid amount.',
    `paid_date` DATE COMMENT 'Date line was paid.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Patient out-of-pocket amount.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code.',
    `procedure_code` STRING COMMENT 'CPT/HCPCS procedure code.',
    `remark_code` STRING COMMENT 'Remittance advice remark code.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code.',
    `service_description` STRING COMMENT 'Service description.',
    `service_from_date` DATE COMMENT 'Service period start date.',
    `service_to_date` DATE COMMENT 'Service period end date.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Units of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual service line within a claim. Each line represents a distinct procedure, supply, or service with its own charge, diagnosis pointers, and adjudication. Supports line-level denial analysis and revenue integrity.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` (
    `diagnosis_link_id` BIGINT COMMENT 'Unique identifier for the diagnosis link.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: CDI and coding compliance workflows require tracing each claim diagnosis pointer back to the source clinical diagnosis record. Revenue cycle teams use this for HAC validation, POA indicator verificati',
    `icd_code_id` BIGINT COMMENT 'ICD-10 diagnosis code.',
    `visit_diagnosis_id` BIGINT COMMENT 'Link to visit diagnosis.',
    `active_flag` BOOLEAN COMMENT 'Indicates if diagnosis is active.',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates if CDI query was issued.',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates chronic condition.',
    `coding_source` STRING COMMENT 'Source of coding (manual, CAC, etc.).',
    `coding_timestamp` TIMESTAMP COMMENT 'When diagnosis was coded.',
    `complication_flag` BOOLEAN COMMENT 'Indicates complication.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `denial_risk_flag` BOOLEAN COMMENT 'Indicates denial risk.',
    `diagnosis_category` STRING COMMENT 'Diagnosis category.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code.',
    `diagnosis_date` DATE COMMENT 'Date diagnosis was made.',
    `diagnosis_description` STRING COMMENT 'Diagnosis description.',
    `diagnosis_pointer` STRING COMMENT 'Diagnosis pointer (A-L).',
    `diagnosis_sequence` STRING COMMENT 'Diagnosis sequence number.',
    `diagnosis_type` STRING COMMENT 'Principal, secondary, admitting, etc.',
    `diagnosis_version` STRING COMMENT 'ICD-10-CM version.',
    `drg_grouper_flag` BOOLEAN COMMENT 'Indicates if used in DRG grouping.',
    `encounter_type` STRING COMMENT 'Encounter type.',
    `hac_flag` BOOLEAN COMMENT 'Hospital-acquired condition flag.',
    `laterality` STRING COMMENT 'Left, right, bilateral.',
    `poa_indicator` STRING COMMENT 'Present on admission indicator.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates if used in quality measure.',
    `rac_audit_risk_score` DECIMAL(18,2) COMMENT 'RAC audit risk score.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_diagnosis_link PRIMARY KEY(`diagnosis_link_id`)
) COMMENT 'Links diagnosis codes to claims for medical necessity justification, DRG grouping, and quality measure attribution. Tracks POA indicators, HAC flags, and CDI query status. Critical for compliance and reimbursement optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the submission.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `hipaa_authorization_id` BIGINT COMMENT 'Foreign key linking to consent.hipaa_authorization. Business justification: Each claim submission to a payer constitutes a PHI disclosure requiring a valid HIPAA authorization. A single claim may have multiple submissions (resubmissions) each requiring authorization verificat',
    `original_submission_id` BIGINT COMMENT 'Link to original submission if resubmission.',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Claim submissions are made under a specific payer contract governing submission method, EDI requirements, and timely filing limits. Contract-level submission tracking is required for timely filing com',
    `payer_id` BIGINT COMMENT 'Payer receiving the submission.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: A claim submission includes the prior authorization number as part of the EDI transaction. The submission table currently stores prior_authorization_number as a STRING, which is a denormalized referen',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `acknowledgment_date` DATE COMMENT 'Date acknowledgment received.',
    `acknowledgment_status` STRING COMMENT 'Acknowledgment status.',
    `batch_number` STRING COMMENT 'Batch number.',
    `batch_sequence_number` STRING COMMENT 'Batch sequence number.',
    `claim_charge_amount` DECIMAL(18,2) COMMENT 'Claim charge amount.',
    `claim_filing_indicator_code` STRING COMMENT 'Claim filing indicator code.',
    `clearinghouse_transaction_number` STRING COMMENT 'Clearinghouse transaction number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set (837P, 837I).',
    `error_code` STRING COMMENT 'Error code if rejected.',
    `error_description` STRING COMMENT 'Error description.',
    `is_timely_filed` BOOLEAN COMMENT 'Indicates if timely filed.',
    `method` STRING COMMENT 'Submission method (EDI, paper, portal).',
    `notes` STRING COMMENT 'Notes.',
    `payer_acknowledgment_number` STRING COMMENT 'Payer acknowledgment number.',
    `rejection_reason_code` STRING COMMENT 'Rejection reason code.',
    `rejection_reason_description` STRING COMMENT 'Rejection reason description.',
    `resubmission_count` STRING COMMENT 'Resubmission count.',
    `resubmission_reason_code` STRING COMMENT 'Resubmission reason code.',
    `submission_date` DATE COMMENT 'Submission date.',
    `submission_number` STRING COMMENT 'Submission number.',
    `submission_status` STRING COMMENT 'Submission status.',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp.',
    `submission_type` STRING COMMENT 'Original, corrected, void.',
    `submitter_contact_email` STRING COMMENT 'Submitter contact email.',
    `submitter_contact_name` STRING COMMENT 'Submitter contact name.',
    `submitter_contact_phone` STRING COMMENT 'Submitter contact phone.',
    `submitter_organization_name` STRING COMMENT 'Submitter organization name.',
    `timely_filing_deadline` DATE COMMENT 'Timely filing deadline.',
    `transmission_control_number` STRING COMMENT 'Transmission control number.',
    `transmission_file_name` STRING COMMENT 'Transmission file name.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Tracks each claim submission attempt to a payer, including EDI transmission details, acknowledgment status, and rejection reasons. Supports resubmission workflows, timely filing tracking, and clearinghouse reconciliation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for the status history record.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claim.appeal. Business justification: When a claim status changes due to an appeal outcome (e.g., appeal upheld, appeal overturned), the status_history entry should reference the appeal that triggered the status change. The appeal_indicat',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: When a claim status transitions to denied, the status_history entry should reference the denial record that caused the status change. This creates a direct link between the claim lifecycle audit tra',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: When a claim status transitions to paid or partially paid, it is triggered by a remittance (835 ERA) posting. Linking status_history to the remittance that caused the status change enables financi',
    `submission_id` BIGINT COMMENT 'Foreign key linking to claim.submission. Business justification: Status history tracks claim lifecycle transitions, many of which are triggered by submission events (e.g., submitted, acknowledged, rejected by clearinghouse). Linking status_history to the specific s',
    `appeal_indicator` BOOLEAN COMMENT 'Indicates if appeal was filed.',
    `check_or_eft_number` STRING COMMENT 'Check or EFT number.',
    `clearinghouse_trace_number` STRING COMMENT 'Clearinghouse trace number.',
    `coordination_of_benefits_sequence` STRING COMMENT 'COB sequence.',
    `corrected_claim_indicator` BOOLEAN COMMENT 'Indicates if corrected claim.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `days_in_prior_status` STRING COMMENT 'Days in prior status.',
    `effective_timestamp` TIMESTAMP COMMENT 'When status became effective.',
    `is_final_status` BOOLEAN COMMENT 'Indicates if final status.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp.',
    `lifecycle_scope` STRING COMMENT 'Discriminator confirming this row tracks the CLAIM adjudication lifecycle, distinguishing it from the order fulfillment lifecycle in order.order_status_history.',
    `merged_with_order_order_status_history` STRING COMMENT '',
    `notes` STRING COMMENT 'Notes.',
    `payer_claim_control_number` STRING COMMENT 'Payer claim control number.',
    `payer_response_code` STRING COMMENT 'Payer response code.',
    `payer_response_description` STRING COMMENT 'Payer response description.',
    `prior_status_code` STRING COMMENT 'Prior status code.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates SLA compliance.',
    `ssot_canonical_reference` STRING COMMENT 'Distinct entity; counterpart order.order_status_history serves a separate domain context',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT review: kept distinct from order.order_status_history (documented as separate business concepts)',
    `status_category` STRING COMMENT 'Status category.',
    `status_code` STRING COMMENT 'Status code.',
    `status_description` STRING COMMENT 'Status description.',
    `status_reason` STRING COMMENT 'Status reason.',
    `transaction_set_identifier` STRING COMMENT 'Transaction set identifier.',
    `triggered_by_process` STRING COMMENT 'Process that triggered the status change.',
    `void_indicator` BOOLEAN COMMENT 'Indicates if voided.',
    `work_queue_assignment` STRING COMMENT 'Work queue assignment.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Claim lifecycle status-history SSOT. Tracks payer adjudication status transitions (submitted, accepted, denied, paid, appealed) for a claim. Distinct from order.order_status_history which tracks clinical order fulfillment lifecycle; differentiated per SSOT review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance` (
    `remittance_id` BIGINT COMMENT 'Unique identifier for the remittance.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Remittance payment accuracy and provider payment integrity programs require validating the payee NPI against the NPI registry. payee_npi is a denormalized string; a FK enables payee identity verificat',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Remittances are issued to a specific provider organization (payee). Provider payment reconciliation, accounts receivable management, and ERA/835 posting workflows require linking remittance to the pay',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Remittance advice is issued under a specific payer contract; contract-level payment reconciliation and variance analysis require linking the remittance header to the governing contract. remittance_lin',
    `payer_id` BIGINT COMMENT 'Payer issuing the remittance.',
    `bank_account_number` STRING COMMENT 'Bank account number.',
    `check_eft_number` STRING COMMENT 'Check or EFT number.',
    `coverage_period_end_date` DATE COMMENT 'Coverage period end date.',
    `coverage_period_start_date` DATE COMMENT 'Coverage period start date.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `fiscal_period_date` DATE COMMENT 'Fiscal period date.',
    `group_control_number` STRING COMMENT 'Group control number.',
    `interchange_control_number` STRING COMMENT 'Interchange control number.',
    `notes` STRING COMMENT 'Notes.',
    `payer_claim_control_number` STRING COMMENT 'Payer claim control number.',
    `payer_contact_email` STRING COMMENT 'Payer contact email.',
    `payer_contact_name` STRING COMMENT 'Payer contact name.',
    `payer_contact_phone` STRING COMMENT 'Payer contact phone.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Payment amount.',
    `payment_date` DATE COMMENT 'Payment date.',
    `payment_method_code` STRING COMMENT 'Payment method code.',
    `posting_date` DATE COMMENT 'Posting date.',
    `production_date` DATE COMMENT 'Production date.',
    `provider_adjustment_amount` DECIMAL(18,2) COMMENT 'Provider adjustment amount.',
    `provider_adjustment_reason_code` STRING COMMENT 'Provider adjustment reason code.',
    `received_timestamp` TIMESTAMP COMMENT 'Received timestamp.',
    `receiver_identification` STRING COMMENT 'Receiver identification.',
    `reconciliation_status` STRING COMMENT 'Reconciliation status.',
    `remittance_status` STRING COMMENT 'Remittance status.',
    `routing_number` STRING COMMENT 'Routing number.',
    `sender_identification` STRING COMMENT 'Sender identification.',
    `source_file_name` STRING COMMENT 'Source file name.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Total allowed amount.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Total billed amount.',
    `total_claim_count` STRING COMMENT 'Total claim count.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Total patient responsibility amount.',
    `transaction_set_control_number` STRING COMMENT 'Transaction set control number.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_remittance PRIMARY KEY(`remittance_id`)
) COMMENT 'Electronic Remittance Advice (835) from payer detailing payment, adjustments, and denials across multiple claims. Links to cash posting, AR transactions, and GL journal entries. Supports auto-posting and variance analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` (
    `remittance_line_id` BIGINT COMMENT 'Unique identifier for the remittance line.',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `fee_schedule_id` BIGINT COMMENT 'Fee schedule.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `line_id` BIGINT COMMENT 'Link to claim line.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Drug remittance reconciliation and 340B covered entity compliance require linking remittance lines to the NDC drug registry. ndc_code on remittance_line is a denormalized string; a FK enables drug-lev',
    `payer_contract_id` BIGINT COMMENT 'Payer contract.',
    `remittance_id` BIGINT COMMENT 'Parent remittance.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount.',
    `adjustment_date` DATE COMMENT 'Adjustment date.',
    `adjustment_group_code` STRING COMMENT 'Adjustment group code (CO, PR, OA, PI).',
    `adjustment_quantity` DECIMAL(18,2) COMMENT 'Adjustment quantity.',
    `adjustment_source` STRING COMMENT 'Adjustment source.',
    `adjustment_type` STRING COMMENT 'Adjustment type.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Allowed amount.',
    `balance_transfer_amount` DECIMAL(18,2) COMMENT 'Balance transfer amount.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Billed amount.',
    `claim_adjustment_reason_code` STRING COMMENT 'CARC code.',
    `coinsurance_amount` DECIMAL(18,2) COMMENT 'Coinsurance amount.',
    `contractual_adjustment_amount` DECIMAL(18,2) COMMENT 'Contractual adjustment amount.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Copay amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credit_balance_amount` DECIMAL(18,2) COMMENT 'Credit balance amount.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount.',
    `denial_reason_code` STRING COMMENT 'Denial reason code.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `line_payment_status` STRING COMMENT 'Line payment status.',
    `line_sequence_number` STRING COMMENT 'Line sequence number.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue amount.',
    `note` STRING COMMENT 'Note.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Paid amount.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Patient responsibility amount.',
    `payer_claim_control_number` STRING COMMENT 'Payer claim control number.',
    `posting_date` DATE COMMENT 'Posting date.',
    `procedure_code` STRING COMMENT 'Procedure code.',
    `procedure_modifier_1` STRING COMMENT 'Procedure modifier 1.',
    `procedure_modifier_2` STRING COMMENT 'Procedure modifier 2.',
    `procedure_modifier_3` STRING COMMENT 'Procedure modifier 3.',
    `procedure_modifier_4` STRING COMMENT 'Procedure modifier 4.',
    `recoupment_amount` DECIMAL(18,2) COMMENT 'Recoupment amount.',
    `remittance_advice_remark_code` STRING COMMENT 'RARC code.',
    `revenue_code` STRING COMMENT 'Revenue code.',
    `service_date` DATE COMMENT 'Service date.',
    `service_line_number` STRING COMMENT 'Service line number.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Units of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount (billed - allowed).',
    CONSTRAINT pk_remittance_line PRIMARY KEY(`remittance_line_id`)
) COMMENT 'Line-level detail from 835 ERA showing allowed amount, paid amount, adjustments (contractual, deductible, copay), and CARC/RARC codes. Links to claim lines and GL accounts for automated posting and variance reconciliation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`denial` (
    `denial_id` BIGINT COMMENT 'Unique identifier for the denial.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Diagnosis-specific denials (medical necessity, not covered) must be traceable to the source clinical diagnosis record for root cause analysis, denial prevention programs, and CDI feedback loops. Reven',
    `coverage_policy_id` BIGINT COMMENT 'Coverage policy.',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: A denial at the service line level should reference the specific claim line (line) that was denied. The denial table currently stores claim_line_number as an INT — a denormalized positional reference.',
    `payer_id` BIGINT COMMENT 'Payer issuing the denial.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Procedure-level denials must be traceable to the clinical procedure event for appeal preparation, rebilling, and root cause analysis. Revenue cycle teams use this link to identify patterns in denied p',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Denial root cause analysis and prevention reporting require linking denials to the consent_record that was absent, expired, or deficient. Denial management workflows categorize consent-related denials',
    `remittance_line_id` BIGINT COMMENT 'Foreign key linking to claim.remittance_line. Business justification: A denial at the service line level corresponds to a specific remittance_line entry in the 835 ERA that documents the denial with CARC/RARC codes and denied amounts. Linking denial to the remittance_li',
    `submission_id` BIGINT COMMENT 'Foreign key linking to claim.submission. Business justification: A denial is issued in response to a specific submission attempt. Linking denial to the submission that was denied enables root cause analysis (e.g., was the denial due to a timely filing issue, an EDI',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Allowed amount.',
    `appeal_deadline_date` DATE COMMENT 'Appeal deadline date.',
    `appeal_filed_date` DATE COMMENT 'Appeal filed date.',
    `appeal_level` STRING COMMENT 'Appeal level.',
    `appeal_outcome` STRING COMMENT 'Appeal outcome.',
    `appeal_outcome_date` DATE COMMENT 'Appeal outcome date.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Billed amount.',
    `carc_code` STRING COMMENT 'Claim Adjustment Reason Code.',
    `carc_description` STRING COMMENT 'CARC description.',
    `denial_category` STRING COMMENT 'Denial category (clinical, administrative, technical).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `denial_date` DATE COMMENT 'Denial date.',
    `denial_number` STRING COMMENT 'Denial number.',
    `denial_type` STRING COMMENT 'Denial type.',
    `denied_amount` DECIMAL(18,2) COMMENT 'Denied amount.',
    `is_preventable` BOOLEAN COMMENT 'Indicates if denial was preventable.',
    `is_rac_audit` BOOLEAN COMMENT 'Indicates if RAC audit.',
    `medical_record_number` STRING COMMENT 'Medical record number.',
    `notes` STRING COMMENT 'Notes.',
    `patient_account_number` STRING COMMENT 'Patient account number.',
    `priority_level` STRING COMMENT 'Priority level.',
    `rarc_code` STRING COMMENT 'Remittance Advice Remark Code.',
    `rarc_description` STRING COMMENT 'RARC description.',
    `reason_text` STRING COMMENT 'Reason text.',
    `received_date` DATE COMMENT 'Received date.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Recovered amount.',
    `resolution_status` STRING COMMENT 'Resolution status.',
    `responsible_department` STRING COMMENT 'Responsible department.',
    `root_cause_code` STRING COMMENT 'Root cause code.',
    `root_cause_description` STRING COMMENT 'Root cause description.',
    `service_date` DATE COMMENT 'Service date.',
    `source` STRING COMMENT 'Denial source.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Write-off amount.',
    `write_off_date` DATE COMMENT 'Write-off date.',
    CONSTRAINT pk_denial PRIMARY KEY(`denial_id`)
) COMMENT 'Tracks denied claims and lines with root cause analysis, preventability flags, and recovery tracking. Links to appeals, corrective action plans, and quality peer review. Supports denial prevention and revenue recovery workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the appeal.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `coverage_policy_id` BIGINT COMMENT 'Coverage policy.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: An appeal is filed in direct response to a denial. This is a fundamental parent-child relationship in claims management: one denial can have multiple appeal levels (first-level, second-level, external',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer receiving the appeal.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Appeals are frequently filed when prior authorization was denied or when a claim was denied due to a prior authorization issue. The appeal table has prior_authorization_issue_flag (BOOLEAN) indicating',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: Clinical appeals require attaching physician notes as supporting documentation for medical necessity. Appeals teams must reference the specific clinical note record when submitting clinical rationale ',
    `appeal_number` STRING COMMENT 'Appeal number.',
    `appeal_status` STRING COMMENT 'Appeal status.',
    `appeal_type` STRING COMMENT 'Appeal type.',
    `clinical_rationale` DECIMAL(18,2) COMMENT 'Clinical rationale for appeal.',
    `coordination_of_benefits_issue_flag` BOOLEAN COMMENT 'Indicates COB issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `deadline_date` DATE COMMENT 'Appeal deadline date.',
    `denied_amount` DECIMAL(18,2) COMMENT 'Denied amount.',
    `external_review_requested_flag` BOOLEAN COMMENT 'Indicates external review requested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `appeal_level` STRING COMMENT 'Appeal level (first, second, third, external).',
    `notes` STRING COMMENT 'Notes.',
    `original_claim_amount` DECIMAL(18,2) COMMENT 'Original claim amount.',
    `outcome_code` STRING COMMENT 'Outcome code.',
    `outcome_description` STRING COMMENT 'Outcome description.',
    `overturn_amount` DECIMAL(18,2) COMMENT 'Overturn amount.',
    `payer_appeal_reference_number` STRING COMMENT 'Payer appeal reference number.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates peer review required.',
    `prior_authorization_issue_flag` BOOLEAN COMMENT 'Indicates prior authorization issue.',
    `priority_flag` BOOLEAN COMMENT 'Indicates priority appeal.',
    `rac_audit_related_flag` BOOLEAN COMMENT 'Indicates RAC audit related.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Requested amount.',
    `resolution_date` DATE COMMENT 'Resolution date.',
    `service_from_date` DATE COMMENT 'Service from date.',
    `service_to_date` DATE COMMENT 'Service to date.',
    `service_type_code` STRING COMMENT 'Service type code.',
    `submission_date` DATE COMMENT 'Submission date.',
    `submission_method` STRING COMMENT 'Submission method.',
    `supporting_documentation_references` STRING COMMENT 'Supporting documentation references.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Manages multi-level appeal process for denied claims, tracking deadlines, clinical rationale, peer review requirements, and outcomes. Links to corrective action plans and recovery journal entries. Supports appeal success rate analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Unique identifier for the prior authorization.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: PA requests are evaluated against a specific benefit to determine if the requested service is covered and what authorization criteria apply. Benefit-level PA linkage is required for utilization manage',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: Prior authorization submissions require clinical documentation of medical necessity. Linking the supporting clinical note to the prior auth record enables audit defense, resubmission workflows, and ut',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: PA decisions are governed by coverage policies that define medical necessity criteria and authorization requirements. Linking PA to coverage_policy enables utilization management teams to audit PA dec',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Prior authorization requests for DME, supplies, and non-physician services use HCPCS codes, not CPT codes. Linking PA to hcpcs_code enables payer PA rule enforcement for HCPCS-coded services, supporti',
    `icd_code_id` BIGINT COMMENT 'ICD-10 diagnosis code.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Prior authorization requests must be tied to the enterprise patient identity record for PA tracking, utilization management reporting, and regulatory audits (e.g., CMS prior auth transparency rule). N',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Drug prior authorization is a major payer workflow for specialty and high-cost medications. Linking PA requests to the NDC drug registry enables formulary tier validation, step therapy enforcement, an',
    `patient_account_id` BIGINT COMMENT 'Patient account.',
    `payer_id` BIGINT COMMENT 'Payer issuing the authorization.',
    `prior_auth_rule_id` BIGINT COMMENT 'Prior auth rule.',
    `clinician_id` BIGINT COMMENT 'Clinician requesting the authorization.',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: Prior auth decisions for procedures like bariatric surgery or cardiac interventions are driven by specific clinical observations (assessment scores, functional status). Linking the triggering observat',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `appeal_decision_date` DATE COMMENT 'Appeal decision date.',
    `appeal_filed_date` DATE COMMENT 'Appeal filed date.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates appeal filed.',
    `appeal_outcome` STRING COMMENT 'Appeal outcome.',
    `approved_end_date` DATE COMMENT 'Approved end date.',
    `approved_start_date` DATE COMMENT 'Approved start date.',
    `approved_units` DECIMAL(18,2) COMMENT 'Approved units.',
    `authorization_notes` STRING COMMENT 'Authorization notes.',
    `authorization_number` STRING COMMENT 'Authorization number.',
    `authorization_source` STRING COMMENT 'Authorization source.',
    `authorization_status` STRING COMMENT 'Authorization status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `decision_date` DATE COMMENT 'Decision date.',
    `denial_reason_code` STRING COMMENT 'Denial reason code.',
    `denial_reason_description` STRING COMMENT 'Denial reason description.',
    `payer_type` STRING COMMENT 'Payer type.',
    `peer_review_completed_date` DATE COMMENT 'Peer review completed date.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates peer review required.',
    `rendering_provider_npi` STRING COMMENT 'Rendering provider NPI.',
    `requested_service_cpt_code` STRING COMMENT 'Requested service CPT code.',
    `requested_units` DECIMAL(18,2) COMMENT 'Requested units.',
    `service_setting` STRING COMMENT 'Service setting.',
    `submission_date` DATE COMMENT 'Submission date.',
    `units_consumed` DECIMAL(18,2) COMMENT 'Units consumed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `urgency_level` STRING COMMENT 'Urgency level.',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Tracks prior authorization requests and approvals for services, procedures, and supplies. Links to payer rules, clinical orders, and utilization review. Supports authorization tracking, unit consumption, and appeal workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`eligibility` (
    `eligibility_id` BIGINT COMMENT 'Unique identifier for the eligibility record.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Eligibility verification is performed to support claim adjudication. Linking the eligibility record to the claim it supported enables payers and providers to trace which eligibility check was used for',
    `clinician_id` BIGINT COMMENT 'Clinician requesting eligibility.',
    `dependent_id` BIGINT COMMENT 'Foreign key linking to insurance.dependent. Business justification: When the patient is a dependent, eligibility verification is performed against the dependents record to confirm coverage status, relationship type, and effective dates. Dependent-level eligibility is',
    `mpi_record_id` BIGINT COMMENT 'Member MPI record.',
    `eligibility_mpi_record_id` BIGINT COMMENT 'MPI record.',
    `health_plan_id` BIGINT COMMENT 'Health plan.',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Real-time eligibility verification is performed against a specific enrollment record to confirm active enrollment, benefit period, and coverage tier at time of service. This is a standard 270/271 elig',
    `payer_id` BIGINT COMMENT 'Payer.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Eligibility verification requires validating the patients assigned PCP NPI against the authoritative registry to confirm active status, network participation, and correct taxonomy. pcp_npi is a denor',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Claim-time eligibility verifications are frequently triggered by or reconciled against patient registration events. Linking patient.eligibility to patient.registration_event supports revenue cycle workf',
    `subscriber_id` BIGINT COMMENT 'Subscriber.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `clearinghouse_name` STRING COMMENT 'Clearinghouse name.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Coinsurance percentage.',
    `coordination_of_benefits_order` STRING COMMENT 'COB order.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Copay amount.',
    `coverage_effective_date` DATE COMMENT 'Coverage effective date.',
    `coverage_level` STRING COMMENT 'Coverage level.',
    `coverage_status` STRING COMMENT 'Coverage status.',
    `coverage_termination_date` DATE COMMENT 'Coverage termination date.',
    `coverage_type` STRING COMMENT 'Coverage type.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Deductible met amount.',
    `deductible_remaining_amount` DECIMAL(18,2) COMMENT 'Deductible remaining amount.',
    `group_number` STRING COMMENT 'Group number.',
    `network_status` STRING COMMENT 'Network status.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Out of pocket maximum.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Out of pocket met amount.',
    `pcp_name` STRING COMMENT 'PCP name.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates prior authorization required.',
    `referral_required` BOOLEAN COMMENT 'Indicates referral required.',
    `rejection_reason` STRING COMMENT 'Rejection reason.',
    `response_code` STRING COMMENT 'Response code.',
    `response_description` STRING COMMENT 'Response description.',
    `service_date` DATE COMMENT 'Service date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `verification_date` DATE COMMENT 'Verification date.',
    `verification_method` STRING COMMENT 'Verification method.',
    `verification_request_timestamp` TIMESTAMP COMMENT 'Verification request timestamp.',
    `verification_response_timestamp` TIMESTAMP COMMENT 'Verification response timestamp.',
    `verification_status` STRING COMMENT 'Verification status.',
    `verification_transaction_number` STRING COMMENT 'Verification transaction number.',
    CONSTRAINT pk_eligibility PRIMARY KEY(`eligibility_id`)
) COMMENT 'Real-time eligibility verification responses (270/271) capturing coverage status, benefit details, deductible/OOP amounts, and network status. Supports pre-service financial counseling and authorization workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Unique identifier for the COB record.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `dependent_id` BIGINT COMMENT 'Foreign key linking to insurance.dependent. Business justification: COB processing for dependents requires linking to the dependent record to apply birthday rule, gender rule, and relationship-based coordination order. The cob table has mpi_record_id but no direct dep',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Coordination of Benefits determination relies directly on eligibility verification data — specifically the coordination_of_benefits_order field on eligibility. The COB record uses eligibility informat',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: COB processing requires direct reference to the patients specific insurance coverage record to determine benefit coordination order, apply birthday rule, and calculate patient responsibility. cob has',
    `mpi_record_id` BIGINT COMMENT 'MPI record.',
    `payer_id` BIGINT COMMENT 'Primary payer.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to insurance.subscriber. Business justification: COB determination requires identifying the subscriber record for the secondary payer to establish coordination order, coverage details, and apply birthday/gender rules. Role-prefix secondary_ distin',
    `tertiary_payer_id` BIGINT COMMENT 'Tertiary payer.',
    `birthday_rule_applied` BOOLEAN COMMENT 'Indicates birthday rule applied.',
    `cob_status` STRING COMMENT 'COB status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `crossover_claim_indicator` BOOLEAN COMMENT 'Indicates crossover claim.',
    `determination_date` DATE COMMENT 'Determination date.',
    `determination_method` STRING COMMENT 'Determination method.',
    `duplicate_payment_prevention_flag` BOOLEAN COMMENT 'Indicates duplicate payment prevention.',
    `gender_rule_applied` BOOLEAN COMMENT 'Indicates gender rule applied.',
    `method` STRING COMMENT 'COB method.',
    `msp_indicator` BOOLEAN COMMENT 'Medicare Secondary Payer indicator.',
    `msp_type_code` STRING COMMENT 'MSP type code.',
    `notes` STRING COMMENT 'Notes.',
    `order_sequence` STRING COMMENT 'Order sequence.',
    `primary_adjustment_amount` DECIMAL(18,2) COMMENT 'Primary adjustment amount.',
    `primary_adjustment_reason_code` STRING COMMENT 'Primary adjustment reason code.',
    `primary_allowed_amount` DECIMAL(18,2) COMMENT 'Primary allowed amount.',
    `primary_billed_amount` DECIMAL(18,2) COMMENT 'Primary billed amount.',
    `primary_paid_amount` DECIMAL(18,2) COMMENT 'Primary paid amount.',
    `primary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Primary patient responsibility amount.',
    `tertiary_billed_amount` DECIMAL(18,2) COMMENT 'Tertiary billed amount.',
    `tertiary_paid_amount` DECIMAL(18,2) COMMENT 'Tertiary paid amount.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Total patient responsibility amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `verification_date` DATE COMMENT 'Verification date.',
    `verification_method` STRING COMMENT 'Verification method.',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Coordination of Benefits logic determining primary/secondary/tertiary payer order, tracking payments and adjustments across multiple payers. Supports birthday rule, gender rule, and Medicare Secondary Payer (MSP) determination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_original_submission_id` FOREIGN KEY (`original_submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_remittance_line_id` FOREIGN KEY (`remittance_line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance_line`(`remittance_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`eligibility`(`eligibility_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Insurance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `bill_type` SET TAGS ('dbx_business_glossary_term' = 'Bill Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'COB Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `primary_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `rac_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'COB Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_quantity` SET TAGS ('dbx_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `outlier_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Link Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('dbx_business_glossary_term' = 'Coding Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coding Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `complication_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `denial_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouper Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'POA Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `rac_audit_risk_score` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `hipaa_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `is_timely_filed` SET TAGS ('dbx_business_glossary_term' = 'Is Timely Filed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Deadline');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Status History Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `check_or_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check or EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `coordination_of_benefits_sequence` SET TAGS ('dbx_business_glossary_term' = 'COB Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `corrected_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Corrected Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `days_in_prior_status` SET TAGS ('dbx_business_glossary_term' = 'Days in Prior Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `is_final_status` SET TAGS ('dbx_business_glossary_term' = 'Is Final Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `lifecycle_scope` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Scope');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_description` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `prior_status_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_category` SET TAGS ('dbx_business_glossary_term' = 'Status Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_description` SET TAGS ('dbx_business_glossary_term' = 'Status Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `triggered_by_process` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Process');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `void_indicator` SET TAGS ('dbx_business_glossary_term' = 'Void Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `work_queue_assignment` SET TAGS ('dbx_business_glossary_term' = 'Work Queue Assignment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `check_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Provider Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `receiver_identification` SET TAGS ('dbx_business_glossary_term' = 'Receiver Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `sender_identification` SET TAGS ('dbx_business_glossary_term' = 'Sender Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_subdomain' = 'payment_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `balance_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `credit_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Line Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Note');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('dbx_subdomain' = 'denial_recovery');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('dbx_business_glossary_term' = 'CARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_description` SET TAGS ('dbx_business_glossary_term' = 'CARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('dbx_business_glossary_term' = 'Denial Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_preventable` SET TAGS ('dbx_business_glossary_term' = 'Is Preventable');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_rac_audit` SET TAGS ('dbx_business_glossary_term' = 'Is RAC Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_code` SET TAGS ('dbx_business_glossary_term' = 'RARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_description` SET TAGS ('dbx_business_glossary_term' = 'RARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `reason_text` SET TAGS ('dbx_business_glossary_term' = 'Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Denial Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write Off Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('dbx_subdomain' = 'denial_recovery');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coordination_of_benefits_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'COB Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `external_review_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'External Review Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `original_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Outcome Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `overturn_amount` SET TAGS ('dbx_business_glossary_term' = 'Overturn Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_appeal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Appeal Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `rac_audit_related_flag` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation References');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_subdomain' = 'coverage_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Observation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('dbx_business_glossary_term' = 'Authorization Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Service CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_units` SET TAGS ('dbx_business_glossary_term' = 'Requested Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `units_consumed` SET TAGS ('dbx_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_subdomain' = 'coverage_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out of Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out of Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_business_glossary_term' = 'PCP Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_description` SET TAGS ('dbx_business_glossary_term' = 'Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_subdomain' = 'coverage_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'COB Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Birthday Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('dbx_business_glossary_term' = 'Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `duplicate_payment_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Payment Prevention Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Gender Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('dbx_business_glossary_term' = 'MSP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_type_code` SET TAGS ('dbx_business_glossary_term' = 'MSP Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `order_sequence` SET TAGS ('dbx_business_glossary_term' = 'Order Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
