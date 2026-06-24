-- Schema for Domain: claim | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`claim` COMMENT 'Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim record.',
    `ar_account_id` BIGINT COMMENT 'Link to the AR account for revenue tracking.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `clinical_order_id` BIGINT COMMENT 'Link to the originating clinical order.',
    `demographics_id` BIGINT COMMENT 'Patient demographic record.',
    `drg_id` BIGINT COMMENT 'Diagnosis Related Group for inpatient claims.',
    `health_plan_id` BIGINT COMMENT 'Payer health plan.',
    `hedis_measure_id` BIGINT COMMENT 'Link to HEDIS quality measure if applicable.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage record.',
    `material_master_id` BIGINT COMMENT 'Link to supply item if applicable.',
    `payer_id` BIGINT COMMENT 'Insurance payer receiving the claim.',
    `referral_order_id` BIGINT COMMENT 'Link to referral order if applicable.',
    `journal_entry_id` BIGINT COMMENT 'Link to revenue journal entry.',
    `cost_center_id` BIGINT COMMENT 'Cost center for service.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period of service.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'When payer adjudicated the claim.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount.',
    `admission_date` DATE COMMENT 'Inpatient admission date.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates if appeal was filed.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
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
    `referring_provider_npi` STRING COMMENT 'NPI of referring provider.',
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
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `fulfillment_id` BIGINT COMMENT 'Link to order fulfillment.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `material_master_id` BIGINT COMMENT 'Link to supply item.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `adjudication_date` DATE COMMENT 'Date line was adjudicated.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Line adjustment amount.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Payer-allowed amount.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
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
    `ndc_code` STRING COMMENT 'National Drug Code.',
    `ordering_provider_npi` STRING COMMENT 'NPI of ordering provider.',
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
    `audit_finding_id` BIGINT COMMENT 'Link to audit finding if applicable.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `employee_id` BIGINT COMMENT 'Coder who assigned the diagnosis.',
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
    `care_site_id` BIGINT COMMENT 'Facility submitting the claim.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel used.',
    `original_submission_id` BIGINT COMMENT 'Link to original submission if resubmission.',
    `payer_id` BIGINT COMMENT 'Payer receiving the submission.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner (clearinghouse).',
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
    `prior_authorization_number` STRING COMMENT 'Prior authorization number.',
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
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `employee_id` BIGINT COMMENT 'Employee who triggered the status change.',
    `appeal_indicator` BOOLEAN COMMENT 'Indicates if appeal was filed.',
    `check_or_eft_number` STRING COMMENT 'Check or EFT number.',
    `clearinghouse_trace_number` STRING COMMENT 'Clearinghouse trace number.',
    `coordination_of_benefits_sequence` STRING COMMENT 'COB sequence.',
    `corrected_claim_indicator` BOOLEAN COMMENT 'Indicates if corrected claim.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `days_in_prior_status` STRING COMMENT 'Days in prior status.',
    `denial_category` STRING COMMENT 'Denial category.',
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
    `remittance_date` DATE COMMENT 'Remittance date.',
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
    `ar_transaction_id` BIGINT COMMENT 'Link to AR transaction.',
    `journal_entry_id` BIGINT COMMENT 'Link to cash receipt journal entry.',
    `audit_id` BIGINT COMMENT 'Link to compliance audit.',
    `employee_id` BIGINT COMMENT 'Employee who posted the remittance.',
    `financial_entity_id` BIGINT COMMENT 'Financial entity.',
    `message_log_id` BIGINT COMMENT 'Link to message log.',
    `payer_id` BIGINT COMMENT 'Payer issuing the remittance.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period of posting.',
    `cost_center_id` BIGINT COMMENT 'Revenue cost center.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner.',
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
    `payee_name` STRING COMMENT 'Payee name.',
    `payee_npi` STRING COMMENT 'Payee NPI.',
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
    `journal_entry_line_id` BIGINT COMMENT 'Link to adjustment journal entry line.',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `employee_id` BIGINT COMMENT 'Employee who posted the line.',
    `fee_schedule_id` BIGINT COMMENT 'Fee schedule.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code.',
    `line_id` BIGINT COMMENT 'Link to claim line.',
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
    `ar_transaction_id` BIGINT COMMENT 'Link to AR transaction.',
    `audit_finding_id` BIGINT COMMENT 'Link to audit finding.',
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `coverage_policy_id` BIGINT COMMENT 'Coverage policy.',
    `deficiency_id` BIGINT COMMENT 'Link to consent deficiency.',
    `employee_id` BIGINT COMMENT 'Employee managing the denial.',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer issuing the denial.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `quality_peer_review_id` BIGINT COMMENT 'Link to quality peer review.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `journal_entry_id` BIGINT COMMENT 'Link to write-off journal entry.',
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
    `claim_line_number` STRING COMMENT 'Claim line number.',
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
    `corrective_action_plan_id` BIGINT COMMENT 'Link to corrective action plan.',
    `coverage_policy_id` BIGINT COMMENT 'Coverage policy.',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer receiving the appeal.',
    `employee_id` BIGINT COMMENT 'Employee who created the appeal.',
    `journal_entry_id` BIGINT COMMENT 'Link to recovery journal entry.',
    `tertiary_appeal_last_modified_by_user_employee_id` BIGINT COMMENT 'Employee who last modified the appeal.',
    `appeal_number` STRING COMMENT 'Appeal number.',
    `appeal_status` STRING COMMENT 'Appeal status.',
    `appeal_type` STRING COMMENT 'Appeal type.',
    `clinical_rationale` DECIMAL(18,2) COMMENT 'Clinical rationale for appeal.',
    `coordination_of_benefits_issue_flag` BOOLEAN COMMENT 'Indicates COB issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `deadline_date` DATE COMMENT 'Appeal deadline date.',
    `denial_reason_code` STRING COMMENT 'Denial reason code.',
    `denial_reason_description` STRING COMMENT 'Denial reason description.',
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
    `billing_coverage_id` BIGINT COMMENT 'Link to billing coverage.',
    `care_site_id` BIGINT COMMENT 'Facility where service will be rendered.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `icd_code_id` BIGINT COMMENT 'ICD-10 diagnosis code.',
    `material_master_id` BIGINT COMMENT 'Link to supply item.',
    `order_authorization_id` BIGINT COMMENT 'Link to order authorization.',
    `patient_account_id` BIGINT COMMENT 'Patient account.',
    `payer_id` BIGINT COMMENT 'Payer issuing the authorization.',
    `prior_auth_rule_id` BIGINT COMMENT 'Prior auth rule.',
    `clinician_id` BIGINT COMMENT 'Clinician requesting the authorization.',
    `research_study_id` BIGINT COMMENT 'Link to research study.',
    `stark_arrangement_id` BIGINT COMMENT 'Link to Stark arrangement.',
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
    `clinical_indication_icd10_code` STRING COMMENT 'Clinical indication ICD-10 code.',
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
    `clinician_id` BIGINT COMMENT 'Clinician requesting eligibility.',
    `mpi_record_id` BIGINT COMMENT 'Member MPI record.',
    `eligibility_mpi_record_id` BIGINT COMMENT 'MPI record.',
    `employee_id` BIGINT COMMENT 'Employee who requested eligibility.',
    `fhir_resource_log_id` BIGINT COMMENT 'Link to FHIR resource log.',
    `health_plan_id` BIGINT COMMENT 'Health plan.',
    `insurance_coverage_id` BIGINT COMMENT 'Insurance coverage.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel.',
    `payer_id` BIGINT COMMENT 'Payer.',
    `subscriber_id` BIGINT COMMENT 'Subscriber.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner.',
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
    `pcp_npi` STRING COMMENT 'PCP NPI.',
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
    `mpi_record_id` BIGINT COMMENT 'MPI record.',
    `payer_id` BIGINT COMMENT 'Primary payer.',
    `health_plan_id` BIGINT COMMENT 'Secondary plan health plan.',
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
    `other_insurance_on_file_date` DATE COMMENT 'Other insurance on file date.',
    `primary_adjustment_amount` DECIMAL(18,2) COMMENT 'Primary adjustment amount.',
    `primary_adjustment_reason_code` STRING COMMENT 'Primary adjustment reason code.',
    `primary_allowed_amount` DECIMAL(18,2) COMMENT 'Primary allowed amount.',
    `primary_billed_amount` DECIMAL(18,2) COMMENT 'Primary billed amount.',
    `primary_paid_amount` DECIMAL(18,2) COMMENT 'Primary paid amount.',
    `primary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Primary patient responsibility amount.',
    `secondary_adjustment_amount` DECIMAL(18,2) COMMENT 'Secondary adjustment amount.',
    `secondary_adjustment_reason_code` STRING COMMENT 'Secondary adjustment reason code.',
    `secondary_allowed_amount` DECIMAL(18,2) COMMENT 'Secondary allowed amount.',
    `secondary_billed_amount` DECIMAL(18,2) COMMENT 'Secondary billed amount.',
    `secondary_paid_amount` DECIMAL(18,2) COMMENT 'Secondary paid amount.',
    `secondary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Secondary patient responsibility amount.',
    `tertiary_billed_amount` DECIMAL(18,2) COMMENT 'Tertiary billed amount.',
    `tertiary_paid_amount` DECIMAL(18,2) COMMENT 'Tertiary paid amount.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Total patient responsibility amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `verification_date` DATE COMMENT 'Verification date.',
    `verification_method` STRING COMMENT 'Verification method.',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Coordination of Benefits logic determining primary/secondary/tertiary payer order, tracking payments and adjustments across multiple payers. Supports birthday rule, gender rule, and Medicare Secondary Payer (MSP) determination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` (
    `authorization_service_id` BIGINT COMMENT 'Unique identifier for the authorization service.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `icd_code_id` BIGINT COMMENT 'ICD-10 diagnosis code.',
    `payer_id` BIGINT COMMENT 'Payer.',
    `prior_authorization_id` BIGINT COMMENT 'Parent prior authorization.',
    `clinician_id` BIGINT COMMENT 'Rendering provider.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'Authorized amount.',
    `authorized_units` DECIMAL(18,2) COMMENT 'Authorized units.',
    `clinical_review_required` BOOLEAN COMMENT 'Indicates clinical review required.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code.',
    `extension_count` STRING COMMENT 'Extension count.',
    `last_claim_date` DATE COMMENT 'Last claim date.',
    `line_number` STRING COMMENT 'Line number.',
    `modifier_1` STRING COMMENT 'Modifier 1.',
    `modifier_2` STRING COMMENT 'Modifier 2.',
    `modifier_3` STRING COMMENT 'Modifier 3.',
    `modifier_4` STRING COMMENT 'Modifier 4.',
    `notes` STRING COMMENT 'Notes.',
    `payer_authorization_number` STRING COMMENT 'Payer authorization number.',
    `peer_review_completed` BOOLEAN COMMENT 'Indicates peer review completed.',
    `procedure_code` STRING COMMENT 'Procedure code.',
    `service_from_date` DATE COMMENT 'Service from date.',
    `service_setting` STRING COMMENT 'Service setting.',
    `service_status` STRING COMMENT 'Service status.',
    `service_to_date` DATE COMMENT 'Service to date.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `units_consumed` DECIMAL(18,2) COMMENT 'Units consumed.',
    `units_remaining` DECIMAL(18,2) COMMENT 'Units remaining.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Utilization percentage.',
    CONSTRAINT pk_authorization_service PRIMARY KEY(`authorization_service_id`)
) COMMENT 'Line-level detail within a prior authorization tracking authorized units, consumed units, and remaining balance per service/procedure. Supports unit tracking, extension requests, and utilization monitoring.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`attachment` (
    `attachment_id` BIGINT COMMENT 'Unique identifier for the attachment.',
    `behavioral_health_consent_id` BIGINT COMMENT 'Link to behavioral health consent.',
    `care_site_id` BIGINT COMMENT 'Care site.',
    `cda_document_id` BIGINT COMMENT 'Link to CDA document.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `demographics_id` BIGINT COMMENT 'Patient demographics.',
    `employee_id` BIGINT COMMENT 'Employee who submitted the attachment.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `icd_code_id` BIGINT COMMENT 'ICD-10 diagnosis code.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel.',
    `payer_id` BIGINT COMMENT 'Payer.',
    `primary_original_attachment_id` BIGINT COMMENT 'Link to original attachment if resubmission.',
    `clinician_id` BIGINT COMMENT 'Provider clinician.',
    `substance_use_consent_id` BIGINT COMMENT 'Link to substance use consent.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `attachment_number` STRING COMMENT 'Attachment number.',
    `attachment_status` STRING COMMENT 'Attachment status.',
    `attachment_type` STRING COMMENT 'Attachment type.',
    `authorization_number` STRING COMMENT 'Authorization number.',
    `clearinghouse_transaction_number` STRING COMMENT 'Clearinghouse transaction number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `diagnosis_code` STRING COMMENT 'Diagnosis code.',
    `document_description` STRING COMMENT 'Document description.',
    `document_format` STRING COMMENT 'Document format (PDF, TIFF, CDA).',
    `document_title` STRING COMMENT 'Document title.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set.',
    `encryption_status` STRING COMMENT 'Encryption status.',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes.',
    `medical_record_number` STRING COMMENT 'Medical record number.',
    `notes` STRING COMMENT 'Notes.',
    `page_count` STRING COMMENT 'Page count.',
    `payer_attachment_control_number` STRING COMMENT 'Payer attachment control number.',
    `phi_indicator` BOOLEAN COMMENT 'Indicates PHI present.',
    `procedure_code` STRING COMMENT 'Procedure code.',
    `received_date` DATE COMMENT 'Received date.',
    `redaction_required` BOOLEAN COMMENT 'Indicates redaction required.',
    `rejection_reason_code` STRING COMMENT 'Rejection reason code.',
    `rejection_reason_description` STRING COMMENT 'Rejection reason description.',
    `request_date` DATE COMMENT 'Request date.',
    `response_deadline_date` DATE COMMENT 'Response deadline date.',
    `resubmission_count` STRING COMMENT 'Resubmission count.',
    `service_from_date` DATE COMMENT 'Service from date.',
    `service_to_date` DATE COMMENT 'Service to date.',
    `storage_location` STRING COMMENT 'Storage location (S3, ADLS, etc.).',
    `submission_date` DATE COMMENT 'Submission date.',
    `submission_method` STRING COMMENT 'Submission method.',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    CONSTRAINT pk_attachment PRIMARY KEY(`attachment_id`)
) COMMENT 'Clinical documentation attachments (medical records, imaging reports, operative notes) submitted with claims or in response to payer requests. Tracks PHI redaction, encryption, and 42 CFR Part 2 consent requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` (
    `study_attribution_id` BIGINT COMMENT 'Unique identifier for the study attribution.',
    `claim_id` BIGINT COMMENT 'Parent claim.',
    `research_study_id` BIGINT COMMENT 'Research study.',
    `attribution_amount` DECIMAL(18,2) COMMENT 'Attribution amount.',
    `attribution_rationale` DECIMAL(18,2) COMMENT 'Attribution rationale.',
    `attribution_status` STRING COMMENT 'Attribution status.',
    `billing_responsibility` STRING COMMENT 'Billing responsibility (sponsor, payer, patient).',
    `coverage_determination_date` DATE COMMENT 'Coverage determination date.',
    `created_date` TIMESTAMP COMMENT 'Created date.',
    `last_modified_by` STRING COMMENT 'Last modified by.',
    `last_modified_date` TIMESTAMP COMMENT 'Last modified date.',
    `research_only_flag` BOOLEAN COMMENT 'Indicates research-only service.',
    `service_attribution_percentage` DECIMAL(18,2) COMMENT 'Service attribution percentage.',
    `sponsor_invoice_number` STRING COMMENT 'Sponsor invoice number.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates standard of care service.',
    `created_by` STRING COMMENT 'Created by.',
    CONSTRAINT pk_study_attribution PRIMARY KEY(`study_attribution_id`)
) COMMENT 'Links claims to clinical research studies for coverage analysis and billing responsibility determination (standard of care vs. research-only). Supports sponsor invoicing and Medicare Coverage Analysis (MCA) workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` (
    `audit_sample_id` BIGINT COMMENT 'Unique identifier for the audit sample.',
    `audit_id` BIGINT COMMENT 'Parent audit.',
    `claim_id` BIGINT COMMENT 'Claim selected for audit.',
    `audit_scope_reason` STRING COMMENT 'Audit scope reason.',
    `claim_review_status` STRING COMMENT 'Claim review status.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates corrective action required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact amount.',
    `finding_description` STRING COMMENT 'Finding description.',
    `finding_severity` STRING COMMENT 'Finding severity.',
    `review_completion_date` DATE COMMENT 'Review completion date.',
    `review_start_date` DATE COMMENT 'Review start date.',
    `reviewer_name` STRING COMMENT 'Reviewer name.',
    `sample_selection_method` STRING COMMENT 'Sample selection method (random, targeted, risk-based).',
    `sample_sequence_number` STRING COMMENT 'Sample sequence number.',
    `selected_date` DATE COMMENT 'Selected date.',
    CONSTRAINT pk_audit_sample PRIMARY KEY(`audit_sample_id`)
) COMMENT 'Tracks claims selected for compliance audits (RAC, MAC, ZPIC, internal) with sample selection method, review findings, and financial impact. Links to corrective action plans and supports audit response workflows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_original_submission_id` FOREIGN KEY (`original_submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_primary_original_attachment_id` FOREIGN KEY (`primary_original_attachment_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`attachment`(`attachment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Billing Provider Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `hedis_measure_id` SET TAGS ('pii_business_glossary_term' = 'HEDIS Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Revenue Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Service Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Service Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `bill_type` SET TAGS ('pii_business_glossary_term' = 'Bill Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('pii_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('pii_business_glossary_term' = 'COB Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('pii_business_glossary_term' = 'DRG Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `paid_timestamp` SET TAGS ('pii_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_claim_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `primary_payer_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_business_glossary_term' = 'Principal Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `rac_audit_flag` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Referring Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('pii_business_glossary_term' = 'Source System Claim Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fulfillment_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjudication_date` SET TAGS ('pii_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('pii_business_glossary_term' = 'COB Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_quantity` SET TAGS ('pii_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `outlier_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_date` SET TAGS ('pii_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('pii_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_description` SET TAGS ('pii_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Link Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Visit Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `cdi_query_flag` SET TAGS ('pii_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('pii_business_glossary_term' = 'Coding Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_timestamp` SET TAGS ('pii_business_glossary_term' = 'Coding Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `complication_flag` SET TAGS ('pii_business_glossary_term' = 'Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `denial_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Denial Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Grouper Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('pii_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `hac_flag` SET TAGS ('pii_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('pii_business_glossary_term' = 'POA Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `rac_audit_risk_score` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('pii_business_glossary_term' = 'Original Submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('pii_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('pii_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `is_timely_filed` SET TAGS ('pii_business_glossary_term' = 'Is Timely Filed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_acknowledgment_number` SET TAGS ('pii_business_glossary_term' = 'Payer Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_count` SET TAGS ('pii_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('pii_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_business_glossary_term' = 'Timely Filing Deadline');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_control_number` SET TAGS ('pii_business_glossary_term' = 'Transmission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_business_glossary_term' = 'Transmission File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_workflow' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot' = 'claim_status_lifecycle');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_lifecycle_scope' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_pair_resolved' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('pii_business_glossary_term' = 'Status History Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `appeal_indicator` SET TAGS ('pii_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `check_or_eft_number` SET TAGS ('pii_business_glossary_term' = 'Check or EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `coordination_of_benefits_sequence` SET TAGS ('pii_business_glossary_term' = 'COB Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `corrected_claim_indicator` SET TAGS ('pii_business_glossary_term' = 'Corrected Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `days_in_prior_status` SET TAGS ('pii_business_glossary_term' = 'Days in Prior Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `denial_category` SET TAGS ('pii_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `is_final_status` SET TAGS ('pii_business_glossary_term' = 'Is Final Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `lifecycle_scope` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Scope');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_code` SET TAGS ('pii_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_description` SET TAGS ('pii_business_glossary_term' = 'Payer Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `prior_status_code` SET TAGS ('pii_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `remittance_date` SET TAGS ('pii_business_glossary_term' = 'Remittance Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_category` SET TAGS ('pii_business_glossary_term' = 'Status Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_code` SET TAGS ('pii_business_glossary_term' = 'Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_description` SET TAGS ('pii_business_glossary_term' = 'Status Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `triggered_by_process` SET TAGS ('pii_business_glossary_term' = 'Triggered By Process');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `void_indicator` SET TAGS ('pii_business_glossary_term' = 'Void Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `work_queue_assignment` SET TAGS ('pii_business_glossary_term' = 'Work Queue Assignment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('pii_business_glossary_term' = 'Remittance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'AR Transaction');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Cash Receipt Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Posting Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Revenue Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `check_eft_number` SET TAGS ('pii_business_glossary_term' = 'Check EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_date` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `group_control_number` SET TAGS ('pii_business_glossary_term' = 'Group Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `interchange_control_number` SET TAGS ('pii_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_classification' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_business_glossary_term' = 'Payee NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('pii_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `production_date` SET TAGS ('pii_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Provider Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Provider Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `receiver_identification` SET TAGS ('pii_business_glossary_term' = 'Receiver Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('pii_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `sender_identification` SET TAGS ('pii_business_glossary_term' = 'Sender Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_claim_count` SET TAGS ('pii_business_glossary_term' = 'Total Claim Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('pii_business_glossary_term' = 'Remittance Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Journal Entry Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_business_glossary_term' = 'Payer Contract');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('pii_business_glossary_term' = 'Remittance');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_date` SET TAGS ('pii_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_quantity` SET TAGS ('pii_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('pii_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `balance_transfer_amount` SET TAGS ('pii_business_glossary_term' = 'Balance Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `credit_balance_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('pii_business_glossary_term' = 'Line Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('pii_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `note` SET TAGS ('pii_business_glossary_term' = 'Note');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `recoupment_amount` SET TAGS ('pii_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_line_number` SET TAGS ('pii_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_subdomain' = 'denial_audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('pii_business_glossary_term' = 'Denial Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'AR Transaction');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `deficiency_id` SET TAGS ('pii_business_glossary_term' = 'Deficiency');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Quality Peer Review');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Write Off Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_level` SET TAGS ('pii_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('pii_business_glossary_term' = 'CARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_description` SET TAGS ('pii_business_glossary_term' = 'CARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_category` SET TAGS ('pii_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_line_number` SET TAGS ('pii_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('pii_business_glossary_term' = 'Denial Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('pii_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denied_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_preventable` SET TAGS ('pii_business_glossary_term' = 'Is Preventable');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_rac_audit` SET TAGS ('pii_business_glossary_term' = 'Is RAC Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_business_glossary_term' = 'Patient Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_code` SET TAGS ('pii_business_glossary_term' = 'RARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_description` SET TAGS ('pii_business_glossary_term' = 'RARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `reason_text` SET TAGS ('pii_business_glossary_term' = 'Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `recovered_amount` SET TAGS ('pii_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_code` SET TAGS ('pii_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_description` SET TAGS ('pii_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Denial Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write Off Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_subdomain' = 'denial_audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Created By User');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Last Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('pii_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coordination_of_benefits_issue_flag` SET TAGS ('pii_business_glossary_term' = 'COB Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denied_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `external_review_requested_flag` SET TAGS ('pii_business_glossary_term' = 'External Review Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_level` SET TAGS ('pii_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `original_claim_amount` SET TAGS ('pii_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_code` SET TAGS ('pii_business_glossary_term' = 'Outcome Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_description` SET TAGS ('pii_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `overturn_amount` SET TAGS ('pii_business_glossary_term' = 'Overturn Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_appeal_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payer Appeal Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `peer_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_issue_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `priority_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `rac_audit_related_flag` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `requested_amount` SET TAGS ('pii_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_type_code` SET TAGS ('pii_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation References');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_clinical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Billing Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `order_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Order Authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('pii_business_glossary_term' = 'Prior Auth Rule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Stark Arrangement');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_end_date` SET TAGS ('pii_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_start_date` SET TAGS ('pii_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_units` SET TAGS ('pii_business_glossary_term' = 'Approved Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('pii_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('pii_business_glossary_term' = 'Authorization Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication ICD-10 Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_type` SET TAGS ('pii_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('pii_business_glossary_term' = 'Requested Service CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_units` SET TAGS ('pii_business_glossary_term' = 'Requested Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `units_consumed` SET TAGS ('pii_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Member MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Log');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `subscriber_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('pii_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('pii_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_met_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_remaining_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('pii_business_glossary_term' = 'Out of Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('pii_business_glossary_term' = 'Out of Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_business_glossary_term' = 'PCP Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_business_glossary_term' = 'PCP NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_code` SET TAGS ('pii_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_description` SET TAGS ('pii_business_glossary_term' = 'Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Verification Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('pii_business_glossary_term' = 'COB Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Secondary Plan Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_business_glossary_term' = 'Birthday Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('pii_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('pii_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_date` SET TAGS ('pii_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('pii_business_glossary_term' = 'Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `duplicate_payment_prevention_flag` SET TAGS ('pii_business_glossary_term' = 'Duplicate Payment Prevention Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_business_glossary_term' = 'Gender Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('pii_business_glossary_term' = 'MSP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_type_code` SET TAGS ('pii_business_glossary_term' = 'MSP Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `order_sequence` SET TAGS ('pii_business_glossary_term' = 'Order Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_on_file_date` SET TAGS ('pii_business_glossary_term' = 'Other Insurance On File Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_on_file_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_on_file_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Primary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Secondary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Tertiary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Tertiary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorization_service_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Service Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_amount` SET TAGS ('pii_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_units` SET TAGS ('pii_business_glossary_term' = 'Authorized Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_business_glossary_term' = 'Clinical Review Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `extension_count` SET TAGS ('pii_business_glossary_term' = 'Extension Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `last_claim_date` SET TAGS ('pii_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Payer Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `peer_review_completed` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_status` SET TAGS ('pii_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_consumed` SET TAGS ('pii_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_remaining` SET TAGS ('pii_business_glossary_term' = 'Units Remaining');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_id` SET TAGS ('pii_business_glossary_term' = 'Attachment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_business_glossary_term' = 'Behavioral Health Consent');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'CDA Document');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `primary_original_attachment_id` SET TAGS ('pii_business_glossary_term' = 'Original Attachment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_business_glossary_term' = 'Substance Use Consent');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_number` SET TAGS ('pii_business_glossary_term' = 'Attachment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_status` SET TAGS ('pii_business_glossary_term' = 'Attachment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_type` SET TAGS ('pii_business_glossary_term' = 'Attachment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_description` SET TAGS ('pii_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_format` SET TAGS ('pii_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `edi_transaction_set` SET TAGS ('pii_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `encryption_status` SET TAGS ('pii_business_glossary_term' = 'Encryption Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `payer_attachment_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Attachment Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `phi_indicator` SET TAGS ('pii_business_glossary_term' = 'PHI Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `redaction_required` SET TAGS ('pii_business_glossary_term' = 'Redaction Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `resubmission_count` SET TAGS ('pii_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_subdomain' = 'denial_audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_association_edges' = 'claim.claim,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_research' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `study_attribution_id` SET TAGS ('pii_business_glossary_term' = 'Study Attribution Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_amount` SET TAGS ('pii_business_glossary_term' = 'Attribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_rationale` SET TAGS ('pii_business_glossary_term' = 'Attribution Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_rationale` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_status` SET TAGS ('pii_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `billing_responsibility` SET TAGS ('pii_business_glossary_term' = 'Billing Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `coverage_determination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_only_flag` SET TAGS ('pii_business_glossary_term' = 'Research Only Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `service_attribution_percentage` SET TAGS ('pii_business_glossary_term' = 'Service Attribution Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `sponsor_invoice_number` SET TAGS ('pii_business_glossary_term' = 'Sponsor Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `standard_of_care_flag` SET TAGS ('pii_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_subdomain' = 'denial_audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_association_edges' = 'claim.claim,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_sample_id` SET TAGS ('pii_business_glossary_term' = 'Audit Sample Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_scope_reason` SET TAGS ('pii_business_glossary_term' = 'Audit Scope Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_review_status` SET TAGS ('pii_business_glossary_term' = 'Claim Review Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_severity` SET TAGS ('pii_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_selection_method` SET TAGS ('pii_business_glossary_term' = 'Sample Selection Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Sample Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `selected_date` SET TAGS ('pii_business_glossary_term' = 'Selected Date');
