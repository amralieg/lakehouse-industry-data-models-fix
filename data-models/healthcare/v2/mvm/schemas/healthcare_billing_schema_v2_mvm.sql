-- Schema for Domain: billing | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for each charge record.',
    `cdm_entry_id` BIGINT COMMENT 'Charge Description Master entry defining the charge code and price.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code for the service.',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Pharmacy drug charges are triggered by dispense events. Revenue cycle teams reconcile charges against dispense records for drug billing accuracy, duplicate charge detection, and 340B compliance audits',
    `drug_master_id` BIGINT COMMENT 'Drug master record for medication charges.',
    `fulfillment_id` BIGINT COMMENT 'Order fulfillment event that triggered the charge.',
    `guarantor_id` BIGINT COMMENT 'Guarantor responsible for payment.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for supplies, DME, or other services.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: A charge is the atomic billable unit that gets rolled up onto an invoice during the billing cycle. In RCM, charges are captured first (at time of service) and then invoiced. Adding invoice_id to charg',
    `mpi_record_id` BIGINT COMMENT 'Master Patient Index record for the patient.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medicaid Drug Rebate Program and 340B compliance require charge-level NDC linkage to the drug reference master. Claim submission for pharmacy charges mandates validated NDC codes. ndc_code on charge i',
    `original_charge_id` BIGINT COMMENT 'Original charge if this is a correction or reversal.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Charges are posted to patient financial accounts in RCM systems (Epic Resolute, Cerner Revenue Cycle). The patient_account is the financial aggregation entity that tracks all charges, payments, and ad',
    `clinician_id` BIGINT COMMENT 'Clinician who performed or is responsible for the service.',
    `icd_code_id` BIGINT COMMENT 'Primary diagnosis code for the charge.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Charges must be tied to the rendering facility for facility-fee billing, CMS place-of-service compliance, and cost-center revenue reporting. charge.place_of_service_code is a denormalized code; a dire',
    `specialty_id` BIGINT COMMENT 'Clinical specialty associated with the charge.',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Standing orders (recurring labs, daily vitals, chronic infusions) generate repeated charges over time. Utilization review, recurring charge audits, and bundled payment reconciliation require linking e',
    `treatment_consent_id` BIGINT COMMENT 'Consent record for the treatment or procedure.',
    `visit_id` BIGINT COMMENT 'Patient visit or encounter for the charge.',
    `charge_category` STRING COMMENT 'Category of charge (e.g., Professional, Technical, Facility).',
    `charge_number` STRING COMMENT 'Unique charge transaction number.',
    `charge_status` STRING COMMENT 'Status of the charge (e.g., Posted, Billed, Voided, On Hold).',
    `charge_type` STRING COMMENT 'Type of charge (e.g., Service, Supply, Medication, Procedure).',
    `charge_code` STRING COMMENT 'Internal charge code from CDM.',
    `correction_reason` STRING COMMENT 'Reason for charge correction if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the charge was created.',
    `diagnosis_pointer` STRING COMMENT 'Pointer linking charge to diagnosis codes (e.g., A, B, C, D).',
    `drug_unit_of_measure` STRING COMMENT 'Unit of measure for medication charges (e.g., ML, MG, UNIT).',
    `expected_reimbursement_amount` DECIMAL(18,2) COMMENT 'Expected reimbursement amount based on payer contract.',
    `gross_charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount before adjustments.',
    `hold_date` DATE COMMENT 'Date the charge was placed on hold.',
    `hold_reason` STRING COMMENT 'Reason the charge is on hold.',
    `implant_flag` BOOLEAN COMMENT 'Indicates if the charge is for an implantable device.',
    `is_billable` BOOLEAN COMMENT 'Indicates if the charge is billable to payer or patient.',
    `is_corrected` BOOLEAN COMMENT 'Indicates if the charge has been corrected.',
    `is_patient_responsible` BOOLEAN COMMENT 'Indicates if the charge is patient responsibility.',
    `is_voided` BOOLEAN COMMENT 'Indicates if the charge has been voided.',
    `modifier_1` STRING COMMENT 'First CPT/HCPCS modifier.',
    `modifier_2` STRING COMMENT 'Second CPT/HCPCS modifier.',
    `modifier_3` STRING COMMENT 'Third CPT/HCPCS modifier.',
    `modifier_4` STRING COMMENT 'Fourth CPT/HCPCS modifier.',
    `place_of_service_code` STRING COMMENT 'CMS Place of Service code (e.g., 11=Office, 21=Inpatient Hospital).',
    `posting_date` DATE COMMENT 'Date the charge was posted to the patient account.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of service or supply charged.',
    `quantity_used` DECIMAL(18,2) COMMENT 'Actual quantity used or consumed.',
    `released_date` DATE COMMENT 'Date the charge was released from hold.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code (e.g., 0450=Emergency Room).',
    `service_date` DATE COMMENT 'Date the service was provided.',
    `service_end_time` TIMESTAMP COMMENT 'End time of the service.',
    `service_start_time` TIMESTAMP COMMENT 'Start time of the service.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of service or supply.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the charge was last updated.',
    `void_date` DATE COMMENT 'Date the charge was voided.',
    `void_reason` STRING COMMENT 'Reason the charge was voided.',
    `waste_flag` BOOLEAN COMMENT 'Indicates if the charge is for wasted medication or supply.',
    CONSTRAINT pk_charge PRIMARY KEY(`charge_id`)
) COMMENT 'Individual billable service or supply charge captured during patient care delivery. Links clinical activity to revenue cycle and supports charge capture, coding, and claim submission workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` (
    `cdm_entry_id` BIGINT COMMENT 'Unique identifier for each CDM entry.',
    `cpt_code_id` BIGINT COMMENT 'CPT code associated with this CDM entry.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for supplies or DME.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: CMS Price Transparency Rule requires CDM drug entries to reference validated NDC codes. Linking cdm_entry to ndc_drug enables formulary validation, 340B drug identification, and drug charge master mai',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Chargemaster entries are facility-specific: each hospital maintains its own CDM with facility-specific pricing, revenue codes, and charge capture rules. Multi-facility health systems require org_provi',
    `active_flag` BOOLEAN COMMENT 'Indicates if the CDM entry is currently active.',
    `apc_code` STRING COMMENT 'Ambulatory Payment Classification code for outpatient services.',
    `bundled_payment_flag` BOOLEAN COMMENT 'Indicates if the service is part of a bundled payment arrangement.',
    `cdm_code` STRING COMMENT 'Internal charge code from the Charge Description Master.',
    `cdm_description` STRING COMMENT 'Full description of the service or supply.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Standard charge amount for this CDM entry.',
    `charge_capture_method` STRING COMMENT 'Method of charge capture (e.g., Manual, Interface, Automated).',
    `charge_category` STRING COMMENT 'Category of charge (e.g., Professional, Technical, Facility).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Standard cost for this service or supply.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CDM entry was created.',
    `default_quantity` DECIMAL(18,2) COMMENT 'Default quantity for charge capture.',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight for inpatient services.',
    `effective_date` DATE COMMENT 'Date the CDM entry becomes effective.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date the CDM entry expires or is inactivated.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue posting.',
    `item_type` STRING COMMENT 'Type of item (e.g., Service, Supply, Medication, Procedure).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the CDM entry was last modified.',
    `last_price_update_date` DATE COMMENT 'Date the price was last updated.',
    `modifier_1` STRING COMMENT 'Default first CPT/HCPCS modifier.',
    `modifier_2` STRING COMMENT 'Default second CPT/HCPCS modifier.',
    `notes` STRING COMMENT 'Additional notes or instructions for this CDM entry.',
    `place_of_service_code` STRING COMMENT 'Default CMS Place of Service code.',
    `price_transparency_flag` BOOLEAN COMMENT 'Indicates if this item is included in price transparency reporting.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates if this service is tied to quality measures.',
    `requires_authorization_flag` BOOLEAN COMMENT 'Indicates if prior authorization is typically required.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code for this service or supply.',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice Relative Value Unit.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice Expense Relative Value Unit.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work Relative Value Unit.',
    `short_description` STRING COMMENT 'Abbreviated description for display.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates if the item is subject to sales tax.',
    `type_of_bill_code` STRING COMMENT 'UB-04 Type of Bill code (e.g., 111=Inpatient Hospital).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity (e.g., EACH, ML, HOUR).',
    CONSTRAINT pk_cdm_entry PRIMARY KEY(`cdm_entry_id`)
) COMMENT 'Charge Description Master (CDM) entry defining billable services, supplies, and procedures with pricing, revenue codes, and GL mapping. Central to charge capture and pricing transparency.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for each invoice.',
    `clinician_id` BIGINT COMMENT 'Primary clinician for the invoice.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Claim submission and denial management require knowing which coverage policy governed the invoice. Billing staff reference the specific coverage policy when filing appeals and documenting medical nece',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient MS-DRG payment calculation and CMS cost reporting require the invoice to reference the validated DRG master for relative weight, geometric mean LOS, and outlier threshold. drg_code and drg_w',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Group billing is a standard revenue cycle process: invoices are submitted under a group practice NPI. Billing analysts and payers require invoice-to-group linkage for group-level AR reporting, group N',
    `guarantor_id` BIGINT COMMENT 'Guarantor responsible for payment.',
    `health_plan_id` BIGINT COMMENT 'Health plan for the invoice.',
    `mpi_record_id` BIGINT COMMENT 'Master Patient Index record for the patient.',
    `org_provider_id` BIGINT COMMENT 'Organizational provider for the invoice.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: An invoice is generated against a patient financial account. This is a fundamental RCM relationship — invoices (CMS-1500, UB-04) are associated with the patient account that owns the financial respons',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Managed care contract compliance reporting and underpayment identification require linking each invoice to the specific payer contract under which it was adjudicated. Invoice has payer_id but not the ',
    `payer_id` BIGINT COMMENT 'Primary insurance payer.',
    `referral_order_id` BIGINT COMMENT 'Referral order associated with this invoice.',
    `tertiary_payer_id` BIGINT COMMENT 'Tertiary insurance payer.',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Revenue cycle compliance requires verifying a valid treatment consent existed before finalizing and submitting an invoice. Billing auditors and compliance teams routinely validate consent-to-invoice a',
    `visit_id` BIGINT COMMENT 'Patient visit or encounter for the invoice.',
    `admission_source_code` STRING COMMENT 'Source of admission (e.g., Emergency, Physician Referral).',
    `admission_type_code` STRING COMMENT 'Type of admission (e.g., Elective, Emergency, Urgent).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Payer-allowed amount for the invoice.',
    `appeal_date` DATE COMMENT 'Date an appeal was filed for this invoice.',
    `appeal_status` STRING COMMENT 'Status of the appeal (e.g., Pending, Approved, Denied).',
    `bad_debt_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt.',
    `bad_debt_date` DATE COMMENT 'Date the invoice was written off as bad debt.',
    `bill_type_code` STRING COMMENT 'UB-04 Type of Bill code (e.g., 111=Inpatient Hospital).',
    `claim_control_number` STRING COMMENT 'Payer-assigned claim control number.',
    `clearinghouse_name` STRING COMMENT 'Name of the clearinghouse used for claim submission.',
    `collection_status` STRING COMMENT 'Collection status (e.g., Active, Referred, Closed).',
    `contractual_adjustment` DECIMAL(18,2) COMMENT 'Contractual adjustment amount per payer contract.',
    `covered_charges` DECIMAL(18,2) COMMENT 'Total covered charges per payer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was created.',
    `denial_reason_code` STRING COMMENT 'Payer denial reason code.',
    `denial_reason_description` STRING COMMENT 'Description of the denial reason.',
    `discharge_status_code` STRING COMMENT 'Patient discharge status code (e.g., 01=Home, 20=Expired).',
    `form_type` STRING COMMENT 'Type of billing form (e.g., UB-04, CMS-1500).',
    `insurance_payment` DECIMAL(18,2) COMMENT 'Total insurance payments received.',
    `invoice_date` DATE COMMENT 'Date the invoice was generated.',
    `invoice_number` STRING COMMENT 'Unique invoice number.',
    `invoice_status` STRING COMMENT 'Status of the invoice (e.g., Draft, Submitted, Paid, Denied).',
    `invoice_type` STRING COMMENT 'Type of invoice (e.g., Professional, Facility, Pharmacy).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was last modified.',
    `non_covered_charges` DECIMAL(18,2) COMMENT 'Total non-covered charges per payer.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Outstanding balance due on the invoice.',
    `patient_payment` DECIMAL(18,2) COMMENT 'Total patient payments received.',
    `patient_responsibility` DECIMAL(18,2) COMMENT 'Total patient responsibility amount.',
    `place_of_service_code` STRING COMMENT 'CMS Place of Service code.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code.',
    `service_from_date` DATE COMMENT 'Start date of service period.',
    `service_through_date` DATE COMMENT 'End date of service period.',
    `statement_date` DATE COMMENT 'Date the patient statement was generated.',
    `submission_date` DATE COMMENT 'Date the invoice was submitted to payer.',
    `submission_method` STRING COMMENT 'Method of submission (e.g., Electronic, Paper, Clearinghouse).',
    `total_charges` DECIMAL(18,2) COMMENT 'Total charges on the invoice.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Patient invoice or bill summarizing charges, payments, adjustments, and outstanding balance for a visit or account period. Supports patient billing, collections, and revenue cycle reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for each invoice line item.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: EOB generation, cost-sharing calculation, and benefit utilization reporting require linking each invoice line to the specific benefit that covers it. Adjudication systems resolve benefit applicability',
    `cdm_entry_id` BIGINT COMMENT 'CDM entry for this line item.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: An invoice line item traces back to the original charge that generated it. This is the critical audit trail link in RCM — connecting the billed line item (what was submitted to payer) back to the capt',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Each invoice line item represents a billed service traceable to a specific clinical order. Claim accuracy validation, denial root-cause analysis, and CMS itemized billing requirements mandate this ord',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Invoice line-level drug billing reconciliation requires linking each billed line to the specific dispense event. Payer audits and pharmacy billing accuracy reports depend on tracing invoice lines back',
    `drug_master_id` BIGINT COMMENT 'Drug master record for medication line items.',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Revenue integrity and underpayment detection require comparing each billed line against the contracted fee schedule line. This is the foundational link for expected-vs-actual reimbursement analysis an',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for this line item.',
    `invoice_id` BIGINT COMMENT 'Parent invoice for this line item.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: NCPDP and CMS claim line-level NDC requirements mandate validated NDC on pharmacy claim lines for adjudication and drug rebate processing. invoice_line.ndc_code is a denormalized representation of the',
    `icd_code_id` BIGINT COMMENT 'Primary diagnosis code for this line item.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code for this line item.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Line-level charge reconciliation: each invoice line represents a billed service that must trace to the performed procedure_event for dispute resolution, underpayment recovery, and compliance audits. R',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Rendering provider at the line level is required for split-billing, provider-level remittance reconciliation, and MIPS/quality reporting. invoice_line.rendering_provider_npi is a denormalized NPI stri',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: HIPAA claim submission and payer credentialing validation require the rendering provider NPI on each claim line to be validated against the NPPES NPI Registry. rendering_provider_npi on invoice_line i',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Medical necessity audit at line level: invoice_line.diagnosis_pointer is a positional text reference; a direct FK to visit_diagnosis enables automated medical necessity validation per claim line, supp',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Claim line reconciliation: each invoice line represents a billed procedure; linking to visit_procedure enables procedure-level claim accuracy audits, underpayment identification, and remittance reconc',
    `adjudicated_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was adjudicated by payer.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Payer-allowed amount for this line.',
    `authorization_number` STRING COMMENT 'Prior authorization number for this service.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Charge amount for this line item.',
    `claim_adjustment_group_code` STRING COMMENT 'CARC group code (e.g., CO=Contractual Obligation).',
    `claim_adjustment_reason_code` STRING COMMENT 'CARC reason code for adjustment.',
    `contractual_adjustment_amount` DECIMAL(18,2) COMMENT 'Contractual adjustment amount per payer contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line item was created.',
    `denial_reason_code` STRING COMMENT 'Payer denial reason code.',
    `denial_reason_description` STRING COMMENT 'Description of the denial reason.',
    `diagnosis_pointer` STRING COMMENT 'Pointer linking line to diagnosis codes (e.g., A, B, C, D).',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight for this line.',
    `drug_quantity` DECIMAL(18,2) COMMENT 'Quantity of medication dispensed.',
    `drug_unit_of_measure` STRING COMMENT 'Unit of measure for medication (e.g., ML, MG, UNIT).',
    `line_number` STRING COMMENT 'Sequential line number on the invoice.',
    `line_status` STRING COMMENT 'Status of the line item (e.g., Billed, Paid, Denied, Adjusted).',
    `modifier_1` STRING COMMENT 'First CPT/HCPCS modifier.',
    `modifier_2` STRING COMMENT 'Second CPT/HCPCS modifier.',
    `modifier_3` STRING COMMENT 'Third CPT/HCPCS modifier.',
    `modifier_4` STRING COMMENT 'Fourth CPT/HCPCS modifier.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by payer for this line.',
    `paid_timestamp` TIMESTAMP COMMENT 'Timestamp when payment was received.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Patient responsibility amount for this line.',
    `place_of_service_code` STRING COMMENT 'CMS Place of Service code.',
    `procedure_description` STRING COMMENT 'Description of the procedure or service.',
    `remittance_advice_remark_code` STRING COMMENT 'RARC code from payer remittance.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code.',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice Relative Value Unit.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice Expense Relative Value Unit.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work Relative Value Unit.',
    `service_date` DATE COMMENT 'Date the service was provided.',
    `service_from_date` DATE COMMENT 'Start date of service period.',
    `service_location_code` STRING COMMENT 'Code for the service location.',
    `service_to_date` DATE COMMENT 'End date of service period.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the line was submitted to payer.',
    `units` DECIMAL(18,2) COMMENT 'Number of units of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the line item was last updated.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a patient invoice detailing a specific charge, procedure, or service with associated codes, amounts, and adjudication details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` (
    `coding_assignment_id` BIGINT COMMENT 'Unique identifier for each coding assignment.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: DRG reconciliation between clinical grouping and billing coding: coding_assignment produces the billed DRG while drg_assignment captures the clinical grouper result. Linking them is essential for CDI ',
    `drg_id` BIGINT COMMENT 'Diagnosis Related Group assigned.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: HCC/risk adjustment coding: chronic conditions on the problem list drive HCC category capture for value-based payment programs (Medicare Advantage, ACO). Coding assignments must reference the specific',
    `invoice_id` BIGINT COMMENT 'Invoice associated with this coding.',
    `icd_code_id` BIGINT COMMENT 'Principal diagnosis code assigned.',
    `cpt_code_id` BIGINT COMMENT 'Principal procedure code assigned.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: DRG grouping requires the principal procedure to be traceable to the actual procedure_event record. Coding accuracy audits and CDI reviews verify that the coded principal procedure matches the documen',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: CDI physician queries (cdi_physician_response, cdi_query_date on coding_assignment) are directed at the responsible attending physician. HIM departments require clinician-level coding accuracy scoring',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: CDI query workflow: coding specialists reference specific clinical notes (H&P, discharge summary, operative notes) as the documentation basis for coding assignments. Regulatory audits (RAC, OIG) requi',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: CDI (Clinical Documentation Improvement) workflows require verifying that coded procedures align with documented treatment consents. Coding accuracy audits and compliance reviews depend on tracing eac',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: CDI and coding accuracy workflow: coders assign billing codes directly from clinical visit_diagnosis records. Linking coding_assignment to visit_diagnosis enables coding accuracy scoring, CDI query im',
    `visit_id` BIGINT COMMENT 'Patient visit for which coding was performed.',
    `admission_source_code` STRING COMMENT 'Source of admission.',
    `admission_type_code` STRING COMMENT 'Type of admission.',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'Arithmetic mean length of stay for the DRG.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Timestamp when coding was assigned.',
    `audit_flag` BOOLEAN COMMENT 'Indicates if this coding was audited.',
    `cdi_drg_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact of CDI query on DRG assignment.',
    `cdi_physician_response` STRING COMMENT 'Physician response to CDI query.',
    `cdi_query_date` DATE COMMENT 'Date CDI query was issued.',
    `cdi_query_topic` STRING COMMENT 'Topic of the CDI query.',
    `cdi_query_type` STRING COMMENT 'Type of CDI query (e.g., Leading, Multiple Choice, Open-Ended).',
    `cdi_response_date` DATE COMMENT 'Date physician responded to CDI query.',
    `cdi_response_deadline` DATE COMMENT 'Deadline for physician response to CDI query.',
    `cdi_resulting_code_change` STRING COMMENT 'Code change resulting from CDI query.',
    `coding_accuracy_score` DECIMAL(18,2) COMMENT 'Accuracy score for this coding assignment.',
    `coding_date` DATE COMMENT 'Date coding was completed.',
    `coding_method` STRING COMMENT 'Method of coding (e.g., Manual, CAC-Assisted, Automated).',
    `coding_status` STRING COMMENT 'Status of coding (e.g., In Progress, Complete, Audited).',
    `complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates presence of CC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coding assignment was created.',
    `discharge_disposition_code` STRING COMMENT 'Patient discharge disposition code.',
    `expected_reimbursement_amount` DECIMAL(18,2) COMMENT 'Expected reimbursement based on DRG assignment.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'Geometric mean length of stay for the DRG.',
    `grouper_version` STRING COMMENT 'Version of DRG grouper software used.',
    `hcpcs_codes` STRING COMMENT 'HCPCS codes assigned (comma-separated).',
    `major_complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates presence of MCC.',
    `mdc_code` STRING COMMENT 'Major Diagnostic Category code.',
    `mdc_description` STRING COMMENT 'Description of the Major Diagnostic Category.',
    `outlier_threshold_amount` DECIMAL(18,2) COMMENT 'Outlier threshold amount for high-cost cases.',
    `present_on_admission_indicators` STRING COMMENT 'POA indicators for each diagnosis (Y/N/U/W).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the coding assignment was last updated.',
    CONSTRAINT pk_coding_assignment PRIMARY KEY(`coding_assignment_id`)
) COMMENT 'Assignment of diagnosis and procedure codes to a patient visit or claim by certified coders. Supports DRG assignment, CDI queries, and coding compliance workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the payment, if different from the patient.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or account balance against which this payment is applied.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the payment transaction.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Payments in RCM are applied to patient accounts, not just individual invoices. Unapplied payments, advance payments, and account-level payment postings require a direct patient_account_id FK. Payment ',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Contract-level payment variance analysis and underpayment recovery require linking ERA payments to the specific payer contract. Payment has payer_id but not the contract; managed care analysts use thi',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or third-party organization making the payment.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Insurance payments must link to the specific coverage policy under which payment was remitted for EOB reconciliation, contract rate verification, and coordination of benefits processing. Essential for',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Payments made as part of a payment plan should link to the plan. FK allows tracking which payments are plan installments vs. ad-hoc payments. Cardinality: N payments : 1 payment plan (one plan receive',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Payments are posted from remittance advices (835 transactions). Cash application, payment reconciliation, and bank deposit matching require linking payments to the remittance that authorized them. Ess',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.restriction_request. Business justification: HIPAA §164.522 out-of-pocket restriction is triggered by full patient payment. The payment record must link to the restriction request to document that the restriction condition was satisfied, support',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this payment, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary amount of the payment received, in US dollars (USD). This is the gross payment before any adjustments or allocations.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied or allocated to specific charges or account balances, in US dollars (USD).',
    `batch_number` STRING COMMENT 'The identifier of the payment batch or deposit batch in which this payment was grouped for processing and reconciliation.',
    `payment_category` STRING COMMENT 'The financial category or classification of the payment based on patient responsibility and insurance coverage: copay, coinsurance, deductible, full payment, or partial payment.. Valid values are `copay|coinsurance|deductible|full_payment|partial_payment`',
    `channel` STRING COMMENT 'The interface or channel through which the payment was received: web portal, mobile app, mail, in-person at facility, phone, or lockbox service.. Valid values are `web_portal|mobile_app|mail|in_person|phone|lockbox`',
    `check_number` STRING COMMENT 'The check number for payments made by check. Null for non-check payment methods.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `credit_card_last_four` STRING COMMENT 'The last four digits of the credit or debit card number used for the payment, stored for reference and reconciliation purposes. Full card numbers are never stored per PCI DSS compliance.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'The type or brand of credit or debit card used for the payment: Visa, MasterCard, American Express, Discover, or other. Null for non-card payment methods.. Valid values are `visa|mastercard|amex|discover|other`',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited into the healthcare organizations bank account or financial system.',
    `eft_trace_number` STRING COMMENT 'The trace or reference number for Electronic Funds Transfer (EFT) payments, used for reconciliation and tracking. Null for non-EFT payment methods.',
    `era_file_reference` STRING COMMENT 'The identifier of the ERA 835 file from which this payment record was extracted, used for audit and reconciliation purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified or updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lockbox_number` STRING COMMENT 'The identifier of the lockbox service or location through which the payment was received, if applicable. Null for non-lockbox payments.',
    `method` STRING COMMENT 'The financial instrument or mechanism used to make the payment: Electronic Funds Transfer (EFT), check, credit card, debit card, cash, or wire transfer.. Valid values are `eft|check|credit_card|debit_card|cash|wire_transfer`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment, including special instructions, reconciliation notes, or explanations for exceptions.',
    `payment_date` DATE COMMENT 'The date on which the payment was made or received by the healthcare organization. This is the business event date for the payment transaction.',
    `payment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the payment transaction, used for tracking and reconciliation.',
    `payment_status` STRING COMMENT 'The current lifecycle status of the payment: pending (received but not yet posted), posted (recorded in system), applied (allocated to charges), reversed (payment reversed), refunded (payment returned to payer), or voided (payment cancelled).. Valid values are `pending|posted|applied|reversed|refunded|voided`',
    `payment_type` STRING COMMENT 'The classification or category of the payment: standard (regular payment against charges), prepayment (payment before service), overpayment (excess payment requiring refund), adjustment (correction or write-off), or settlement (negotiated payment).. Valid values are `standard|prepayment|overpayment|adjustment|settlement`',
    `posting_date` DATE COMMENT 'The date on which the payment was posted or recorded in the revenue cycle management system and applied to patient or payer accounts.',
    `posting_status` STRING COMMENT 'The status of the payment posting and application process: unposted (not yet recorded), posted (recorded but not applied), partially applied (some amount applied), or fully applied (entire amount allocated).. Valid values are `unposted|posted|partially_applied|fully_applied`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount of this payment that has been refunded to the payer or patient, in US dollars (USD). Null if no refund has been issued.',
    `refund_date` DATE COMMENT 'The date on which the refund was issued to the payer or patient. Null if no refund has been issued.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether a refund has been issued for this payment. True if refunded, False otherwise.',
    `refund_reason` STRING COMMENT 'The business reason or explanation for issuing the refund, such as overpayment, duplicate payment, or service cancellation. Null if no refund has been issued.',
    `reversal_date` DATE COMMENT 'The date on which the payment was reversed or cancelled. Null if the payment has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reversed or cancelled. True if reversed, False otherwise.',
    `reversal_reason` STRING COMMENT 'The business reason or explanation for reversing the payment, such as duplicate payment, incorrect amount, or payer request. Null if the payment has not been reversed.',
    `source` STRING COMMENT 'The origin or source of the payment: insurance payer, patient self-pay, guarantor, third-party, government program, or charity care.. Valid values are `insurance|patient|guarantor|third_party|government|charity`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied or unallocated to specific charges, held as credit on the account, in US dollars (USD).',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Patient or payer payment received and applied to invoices or accounts. Supports payment posting, reconciliation, and cash management workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the financial adjustment record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claim.appeal. Business justification: Appeal resolution workflow: a successful appeal outcome triggers a billing adjustment to reverse a prior write-off or post recovered amounts. Revenue cycle operations require appeal-to-adjustment link',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adjustments frequently result from claim adjudication outcomes—payer denials, contractual adjustments, or underpayments. Revenue integrity and denial management workflows require linking adjustments t',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Denial-driven contractual adjustments and write-offs must reference the coverage policy that triggered the denial. Appeals management and denial root-cause analysis require this link. Adjustment has p',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Adjustments reference procedure codes when correcting billing errors or disputing payment variances. Existing cpt_code is denormalized string; FK enables validation, supports contractual adjustment ca',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Denial management workflow: when a denial is resolved via write-off or partial recovery, a billing adjustment is created referencing the originating denial. Denial-to-adjustment traceability is requir',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Adjustments reference DRG codes when disputing inpatient payment variances or DRG downgrades. Existing drg_code is denormalized string; FK enables lookup of expected payment, supports DRG validation a',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Contractual adjustments are coverage-specific and must reference the exact insurance coverage policy to apply correct contract rates, validate allowable amounts, and maintain audit trails for payer co',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim to which this adjustment applies.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account is being adjusted.',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record that this transaction reverses, if this is a reversal adjustment.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Financial adjustments in RCM are applied at both the invoice level (already linked via adjustment.invoice_id) and the patient account level. Account-level adjustments include bad debt write-offs, fina',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Contractual adjustments are calculated per payer contract terms (contracted rates, write-off rules). Contract compliance reporting and underpayment identification require linking adjustments to the sp',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or guarantor associated with this adjustment, if applicable.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Adjustments may reference diagnosis codes when disputing medical necessity denials or coding-related payment variances. FK enables validation of diagnosis-driven adjustment reasons and supports appeal',
    `remittance_line_id` BIGINT COMMENT 'Foreign key linking to claim.remittance_line. Business justification: ERA posting workflow: each contractual adjustment in billing is sourced from a specific remittance lines CARC/RARC codes. Revenue cycle analysts require this link for underpayment variance analysis a',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this adjustment.',
    `adjustment_date` DATE COMMENT 'The business date on which the adjustment was applied to the account, used for financial period assignment and reporting.',
    `adjustment_number` STRING COMMENT 'Business-facing unique identifier or control number for the adjustment transaction, used for tracking and reconciliation.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment transaction, indicating whether it is pending approval, posted, reversed, or reconciled.. Valid values are `pending|posted|approved|reversed|voided|reconciled`',
    `adjustment_type` STRING COMMENT 'High-level classification of the adjustment indicating the nature of the balance modification (contractual write-down, bad debt write-off, charity care, etc.). [ENUM-REF-CANDIDATE: contractual|administrative|bad_debt|charity_care|small_balance|courtesy_discount|recoupment|refund|other — 9 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment applied to the account balance. Positive values indicate reductions in patient or payer liability; negative values indicate increases.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is subject to an active appeal or dispute process. True if under appeal, False otherwise.',
    `approval_date` DATE COMMENT 'The date on which the adjustment was formally approved by the authorizing authority.',
    `authorization_code` STRING COMMENT 'Approval or authorization code assigned when the adjustment was authorized, used for audit trail and compliance.',
    `bad_debt_referral_date` DATE COMMENT 'The date the account was referred to collections or classified as bad debt, relevant for bad debt write-off adjustments.',
    `adjustment_category` STRING COMMENT 'Broader grouping of adjustments for financial reporting and variance analysis (contractual vs. non-contractual, write-off vs. discount).. Valid values are `contractual|non_contractual|write_off|charity|discount|recoupment`',
    `contract_rate` DECIMAL(18,2) COMMENT 'The contracted reimbursement rate or allowed amount that drove the contractual adjustment, used for rate variance analysis.',
    `contractual_payer_name` STRING COMMENT 'Name of the insurance payer or contract under which a contractual adjustment was applied, used for variance analysis and contract performance tracking.',
    `cost_center_code` STRING COMMENT 'Cost center or department code associated with the adjustment, used for internal financial allocation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was first created in the system.',
    `era_trace_number` STRING COMMENT 'Trace or reference number from the payers Electronic Remittance Advice (ERA) or Explanation of Benefits (EOB) that corresponds to this adjustment.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this adjustment is posted for financial reporting and accounting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or documentation for the adjustment.',
    `posting_date` DATE COMMENT 'The date the adjustment transaction was posted to the general ledger or financial system, which may differ from the adjustment date.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the adjustment, aligned with payer remittance advice codes or internal reason code sets.',
    `reason_description` STRING COMMENT 'Human-readable explanation of the reason for the adjustment, providing additional context beyond the reason code.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the adjustment has been reconciled with payer remittance advice (ERA/EOB) or internal financial records.. Valid values are `unreconciled|reconciled|disputed|pending_review`',
    `revenue_code` STRING COMMENT 'Standard revenue code (UB-04 revenue code) associated with the charge or service line to which this adjustment applies.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previous adjustment transaction. True if reversal, False otherwise.',
    `reversal_reason` STRING COMMENT 'Explanation of why the original adjustment was reversed, required for audit and compliance purposes.',
    `service_date` DATE COMMENT 'The date of service to which this adjustment applies, relevant for period-specific adjustments and reconciliation.',
    `source` STRING COMMENT 'Indicates the origin or trigger of the adjustment (manual entry, automated contract adjustment, ERA posting, audit finding, etc.). [ENUM-REF-CANDIDATE: manual|automated|era_posting|contract_adjustment|patient_request|payer_request|audit|other — 8 candidates stripped; promote to reference product]',
    `vibe_placeholder` STRING COMMENT '',
    `write_off_classification` STRING COMMENT 'Specific classification for write-off adjustments, distinguishing between bad debt, charity care, small balance write-offs, RAC recoupments, and other categories.. Valid values are `bad_debt|charity_care|small_balance|rac_recoupment|administrative|other`',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment to a charge, invoice, or account balance. Includes contractual adjustments, write-offs, refunds, and corrections.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`patient_account` (
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient financial account. Primary key for the patient account entity.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this account. May be the patient or another party.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Patient accounts are owned by a specific facility in multi-facility health systems. Facility-level AR aging, bad-debt reporting, IRS 501(r) financial assistance compliance, and collection agency refer',
    `mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Patient financial accounts must link to the patient master for statement generation, collections, and financial counseling workflows.',
    `account_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed on this account after all payments, adjustments, and write-offs have been applied.',
    `account_closed_date` DATE COMMENT 'Date when this patient financial account was closed due to zero balance, write-off, or administrative closure.',
    `account_number` STRING COMMENT 'Externally-known unique account number assigned to this patient financial account for billing and collections purposes.',
    `account_opened_date` DATE COMMENT 'Date when this patient financial account was first established in the billing system.',
    `account_status` STRING COMMENT 'Current lifecycle status of the patient account in the revenue cycle management workflow.. Valid values are `open|closed|collections|bad_debt|charity|pending`',
    `account_type` STRING COMMENT 'Classification of the account based on primary payment responsibility and payer relationship. [ENUM-REF-CANDIDATE: self_pay|insured|charity_care|medicaid|medicare|workers_compensation|third_party_liability — 7 candidates stripped; promote to reference product]',
    `aging_bucket` STRING COMMENT 'Classification of account receivable age based on days outstanding since last statement or service date, used for collections prioritization.. Valid values are `current|30_days|60_days|90_days|120_plus_days`',
    `approved_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount approved for this account under the financial assistance program, applied to eligible charges.',
    `bad_debt_amount` DECIMAL(18,2) COMMENT 'Dollar amount written off as uncollectible bad debt for this account.',
    `bad_debt_flag` BOOLEAN COMMENT 'Indicator of whether this account has been classified as uncollectible bad debt for financial reporting purposes.',
    `bad_debt_write_off_date` DATE COMMENT 'Date when the outstanding balance on this account was written off as uncollectible bad debt.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency currently handling this account.',
    `collection_recall_date` DATE COMMENT 'Date when this account was recalled from the external collection agency back to internal management.',
    `collection_recall_reason` STRING COMMENT 'Business reason for recalling the account from external collections, such as payment arrangement, dispute resolution, or financial assistance approval.',
    `collection_referral_date` DATE COMMENT 'Date when this account was referred to an external collection agency for recovery of outstanding balance.',
    `collection_status` STRING COMMENT 'Current state of the account within the collections workflow, indicating whether it has been referred to external collections and the outcome.. Valid values are `not_in_collections|referred|active|recalled|resolved|legal_action`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this patient account record was first created in the database.',
    `days_outstanding` STRING COMMENT 'Number of days since the first unpaid charge on this account, used to calculate aging and collection priority.',
    `family_size` STRING COMMENT 'Number of individuals in the household used to calculate Federal Poverty Level (FPL) percentage for financial assistance eligibility.',
    `financial_assistance_application_date` DATE COMMENT 'Date when the patient or guarantor submitted an application for charity care or financial assistance for this account.',
    `financial_assistance_approval_status` STRING COMMENT 'Final determination status of the financial assistance application for this account.. Valid values are `pending|approved|denied|expired|revoked`',
    `financial_assistance_effective_date` DATE COMMENT 'Date when the approved financial assistance discount becomes effective for charges on this account.',
    `financial_assistance_eligibility` STRING COMMENT 'Current determination status of the patient or guarantor eligibility for charity care or financial assistance programs.. Valid values are `not_evaluated|eligible|ineligible|pending|approved|denied`',
    `financial_assistance_expiration_date` DATE COMMENT 'Date when the approved financial assistance eligibility expires and must be re-evaluated.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of the Federal Poverty Level based on household income and family size, used to determine financial assistance eligibility tier.',
    `household_income` DECIMAL(18,2) COMMENT 'Total annual household income reported by the patient or guarantor for financial assistance eligibility determination.',
    `insurance_balance` DECIMAL(18,2) COMMENT 'Portion of the account balance that is the responsibility of insurance payers.',
    `irs_501r_compliance_flag` BOOLEAN COMMENT 'Indicator of whether all IRS 501(r) requirements have been met for this account, including financial assistance screening and extraordinary collection action restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this patient account record was most recently updated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent payment received and posted to this account.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was posted to this account from any source (patient, insurance, or third party).',
    `last_statement_date` DATE COMMENT 'Date when the most recent patient billing statement was generated and sent for this account.',
    `original_balance` DECIMAL(18,2) COMMENT 'Initial total charges assigned to this account before any payments or adjustments.',
    `patient_balance` DECIMAL(18,2) COMMENT 'Portion of the account balance that is the direct financial responsibility of the patient or guarantor.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicator of whether the patient or guarantor has an active payment plan arrangement for this account.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total dollar amount successfully recovered by the collection agency on this account to date.',
    `referred_balance` DECIMAL(18,2) COMMENT 'Dollar amount of the outstanding balance that was referred to the collection agency at the time of referral.',
    `total_adjustments` DECIMAL(18,2) COMMENT 'Cumulative sum of all contractual adjustments, write-offs, and other balance reductions applied to this account.',
    `total_payments` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received on this account from all sources since account inception.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_patient_account PRIMARY KEY(`patient_account_id`)
) COMMENT 'Patient financial account aggregating charges, payments, adjustments, and balances across visits. Supports patient billing, collections, and financial assistance workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`statement` (
    `statement_id` BIGINT COMMENT 'Unique identifier for the patient billing statement. Primary key.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor or patient responsible for payment of this statement.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom services were rendered and billed on this statement.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Patient billing statements are generated FOR patient accounts. Statement is the periodic communication of account status to the guarantor. FK links statement to the authoritative patient account recor',
    `payment_plan_id` BIGINT COMMENT 'Reference to an active payment plan or financial assistance arrangement associated with this statement.',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.restriction_request. Business justification: Patient statement generation must check active restriction requests to suppress or modify content (e.g., omit insurance references when patient paid OOP under HIPAA §164.522 restriction). Statement su',
    `adjustments_applied` DECIMAL(18,2) COMMENT 'Total adjustments (credits, write-offs, contractual adjustments) applied during the current statement cycle.',
    `aging_bucket` STRING COMMENT 'The aging category of the outstanding balance based on the number of days since the original service date or first statement.. Valid values are `current|30_days|60_days|90_days|120_plus_days`',
    `billing_address_line_1` STRING COMMENT 'The first line of the guarantor or patient billing address to which the statement was sent.',
    `billing_address_line_2` STRING COMMENT 'The second line of the guarantor or patient billing address (apartment, suite, unit number).',
    `billing_city` STRING COMMENT 'The city of the guarantor or patient billing address.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO country code of the guarantor or patient billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal code or ZIP code of the guarantor or patient billing address.',
    `billing_state` STRING COMMENT 'The state or province of the guarantor or patient billing address.',
    `collection_status` STRING COMMENT 'The current collection status indicating whether the account is in collections, legal action, or bad debt.. Valid values are `none|pending|active|legal|bad_debt|write_off`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this statement record was first created in the system.',
    `current_charges` DECIMAL(18,2) COMMENT 'New charges added during the current statement cycle that are included in this statement.',
    `cycle` STRING COMMENT 'The billing cycle or period identifier for this statement (e.g., monthly cycle, weekly cycle, ad-hoc).',
    `delivery_method` STRING COMMENT 'The method or channel used to deliver the statement to the guarantor or patient.. Valid values are `mail|email|portal|sms|fax`',
    `delivery_status` STRING COMMENT 'The current delivery status indicating whether the statement successfully reached the guarantor or patient.. Valid values are `pending|sent|delivered|failed|returned|bounced`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the statement was delivered or sent to the guarantor or patient.',
    `email_address` STRING COMMENT 'The email address to which electronic statements or notifications were sent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `financial_assistance_flag` BOOLEAN COMMENT 'Indicates whether the guarantor or patient has been approved for financial assistance or charity care that applies to this statement.',
    `insurance_pending` DECIMAL(18,2) COMMENT 'Amount currently pending adjudication or payment from insurance payers, not yet reflected in patient responsibility.',
    `language_preference` STRING COMMENT 'The two-letter ISO language code indicating the preferred language for statement communication.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this statement record was last updated or modified.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent payment received from the guarantor or patient.',
    `last_payment_date` DATE COMMENT 'The date of the most recent payment received from the guarantor or patient on this account.',
    `message` STRING COMMENT 'Custom message or note printed on the statement for the guarantor or patient (e.g., payment reminders, financial assistance information).',
    `minimum_payment_due` DECIMAL(18,2) COMMENT 'The minimum payment amount requested from the guarantor or patient for this statement cycle.',
    `payment_due_date` DATE COMMENT 'The date by which payment is requested or expected from the guarantor or patient.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the guarantor or patient is enrolled in a payment plan for the balance on this statement.',
    `payments_received` DECIMAL(18,2) COMMENT 'Total payments received from the guarantor or patient during the current statement cycle.',
    `phone_number` STRING COMMENT 'The contact phone number of the guarantor or patient for statement inquiries and follow-up.',
    `previous_balance` DECIMAL(18,2) COMMENT 'The outstanding balance carried forward from the prior statement cycle before current charges and payments.',
    `returned_mail_date` DATE COMMENT 'The date when a mailed statement was returned as undeliverable.',
    `returned_mail_flag` BOOLEAN COMMENT 'Indicates whether a mailed paper statement was returned as undeliverable by the postal service.',
    `returned_mail_reason` STRING COMMENT 'The reason provided by the postal service for returning the statement (e.g., address unknown, moved, refused).',
    `statement_date` DATE COMMENT 'The date the statement was generated and issued to the guarantor or patient.',
    `statement_number` STRING COMMENT 'Externally-known unique statement number printed on the billing statement and used for patient reference and payment tracking.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the statement indicating its processing and delivery state. [ENUM-REF-CANDIDATE: generated|sent|delivered|returned|paid|partial_paid|outstanding — 7 candidates stripped; promote to reference product]',
    `statement_type` STRING COMMENT 'The format or medium of the statement delivery (paper mailed, electronic via portal, email, SMS notification).. Valid values are `paper|electronic|portal|email|sms`',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether statement generation and delivery has been suppressed for this account due to patient request, legal hold, or other reason.',
    `suppression_reason` STRING COMMENT 'The reason why statement delivery was suppressed (e.g., patient request, deceased, legal hold, bankruptcy).',
    `total_balance_due` DECIMAL(18,2) COMMENT 'The total outstanding balance owed by the guarantor or patient as of the statement date, including all charges, adjustments, and prior payments.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Patient billing statement summarizing charges, payments, adjustments, and balance due for a billing cycle. Supports patient communication and collections.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan. Primary key.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor who is financially responsible for this payment plan.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the primary party responsible for this payment plan.',
    `patient_account_id` BIGINT COMMENT 'Reference to the patient account for which this payment plan was established.',
    `actual_completion_date` DATE COMMENT 'Actual date when the payment plan was completed, either through full payment or early payoff. Null if plan is still active or was cancelled/defaulted.',
    `agreement_signed_date` DATE COMMENT 'Date when the payment plan agreement was signed by the patient or guarantor.',
    `agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether the patient or guarantor has signed the payment plan agreement. True means a signed agreement is on file, false means signature is pending or not required.',
    `approval_date` DATE COMMENT 'Date when the payment plan was reviewed and approved by authorized staff.',
    `auto_pay_flag` BOOLEAN COMMENT 'Indicates whether automatic recurring payments are enabled for this payment plan. True means installments are automatically charged to the stored payment method on the due date, false means manual payment is required.',
    `cancellation_date` DATE COMMENT 'Date when the payment plan was cancelled by either the patient or the healthcare organization.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the payment plan was cancelled, including patient request, non-compliance, account paid in full, or administrative reasons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was first created in the system. Represents the audit trail for record creation.',
    `default_date` DATE COMMENT 'Date when the payment plan was declared in default due to missed payments exceeding the grace period.',
    `default_reason` STRING COMMENT 'Explanation of why the payment plan defaulted, such as consecutive missed payments, insufficient funds, or patient non-response.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment made at the time of plan enrollment, if required. This amount is applied to the balance before installments begin. Expressed in USD.',
    `effective_end_date` DATE COMMENT 'Scheduled date when the payment plan is expected to be completed based on the original terms. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the payment plan becomes active and the first installment is due. This is the binding start date of the agreement.',
    `enrollment_channel` STRING COMMENT 'Channel through which the patient or guarantor enrolled in the payment plan. Patient portal indicates online self-service enrollment, phone indicates enrollment via call center, in-person indicates enrollment at a facility registration or billing desk, mail indicates paper application, email indicates enrollment via email correspondence, and mobile app indicates enrollment through a mobile application.. Valid values are `patient_portal|phone|in_person|mail|email|mobile_app`',
    `enrollment_date` DATE COMMENT 'Date when the patient or guarantor enrolled in the payment plan.',
    `finance_charge_amount` DECIMAL(18,2) COMMENT 'Total finance charges or interest applied to the payment plan over its lifetime. Zero for interest-free plans. Expressed in USD.',
    `financial_assistance_program_code` STRING COMMENT 'Code identifying the financial assistance or charity care program under which this payment plan was approved, if applicable. Links to the organizations financial assistance policy and eligibility criteria.',
    `grace_period_days` STRING COMMENT 'Number of days after the installment due date during which a late payment can be made without penalty or default.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount due for each scheduled installment payment. Expressed in USD.',
    `installment_frequency` STRING COMMENT 'Frequency at which installment payments are scheduled. Weekly indicates every 7 days, biweekly every 14 days, monthly on the same day each month, quarterly every 3 months, and custom indicates a non-standard schedule.. Valid values are `weekly|biweekly|monthly|quarterly|custom`',
    `installments_paid` STRING COMMENT 'Count of installment payments that have been successfully received and posted to date.',
    `installments_remaining` STRING COMMENT 'Count of installment payments still outstanding to complete the payment plan.',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'Annual percentage rate (APR) applied to the payment plan balance, if applicable. Zero for interest-free plans. Expressed as a percentage (e.g., 5.00 for 5%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was most recently updated. Represents the audit trail for record modification.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent installment payment received. Expressed in USD.',
    `last_payment_date` DATE COMMENT 'Date when the most recent installment payment was received and posted.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee charged for each missed or late installment payment, as defined in the payment plan agreement. Expressed in USD.',
    `missed_payments_count` STRING COMMENT 'Total number of installment payments that were missed or not received by the due date during the life of the payment plan.',
    `next_payment_due_date` DATE COMMENT 'Date when the next scheduled installment payment is due. Null if plan is completed, cancelled, or defaulted.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the payment plan, including special arrangements, patient circumstances, or administrative instructions.',
    `number_of_installments` STRING COMMENT 'Total number of scheduled installment payments required to complete the payment plan.',
    `original_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding patient balance at the time the payment plan was established. This is the starting principal amount before any plan payments are applied. Expressed in USD.',
    `payment_method` STRING COMMENT 'Primary payment instrument used for installment payments. Credit card and debit card indicate card-based payments, ACH (Automated Clearing House) indicates electronic bank transfer, check indicates paper check, cash indicates in-person cash payment, and money order indicates certified payment instrument.. Valid values are `credit_card|debit_card|ach|check|cash|money_order`',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan, used in patient communications and statements.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan. Pending indicates awaiting approval or first payment, active indicates plan is in good standing with payments being made, completed indicates all installments paid in full, defaulted indicates missed payments beyond grace period, cancelled indicates plan was terminated by patient or organization, suspended indicates temporarily paused by mutual agreement.. Valid values are `pending|active|completed|defaulted|cancelled|suspended`',
    `plan_type` STRING COMMENT 'Classification of the payment plan based on terms and eligibility criteria. Standard plans follow default terms, interest-free plans waive interest charges, hardship plans are for patients with demonstrated financial need, extended plans have longer durations, short-term plans are for smaller balances, and custom plans have negotiated terms.. Valid values are `standard|interest_free|hardship|extended|short_term|custom`',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Current outstanding balance on the payment plan after all payments to date have been applied. Expressed in USD.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received and applied to this payment plan to date, including down payment and all installments. Expressed in USD.',
    `total_plan_amount` DECIMAL(18,2) COMMENT 'Total amount to be paid under the payment plan, including any interest, fees, or finance charges. May equal original balance for interest-free plans. Expressed in USD.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Patient payment plan agreement for installment payments on outstanding balances. Tracks payment schedule, compliance, and default status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Clinician');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_business_glossary_term' = 'Charge Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `gross_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `implant_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_corrected` SET TAGS ('dbx_business_glossary_term' = 'Is Corrected');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('dbx_business_glossary_term' = 'Is Patient Responsible');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service End Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'CDM Entry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `apc_code` SET TAGS ('dbx_business_glossary_term' = 'APC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `bundled_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundled Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_code` SET TAGS ('dbx_business_glossary_term' = 'CDM Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_description` SET TAGS ('dbx_business_glossary_term' = 'CDM Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_capture_method` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_price_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `price_transparency_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Transparency Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `requires_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `type_of_bill_code` SET TAGS ('dbx_business_glossary_term' = 'Type of Bill Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'patient_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_type_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bill_type_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Type Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `contractual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `covered_charges` SET TAGS ('dbx_business_glossary_term' = 'Covered Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Form Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `non_covered_charges` SET TAGS ('dbx_business_glossary_term' = 'Non-Covered Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('dbx_business_glossary_term' = 'Patient Payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_through_date` SET TAGS ('dbx_business_glossary_term' = 'Service Through Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `total_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'patient_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `adjudicated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudicated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_quantity` SET TAGS ('dbx_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_location_code` SET TAGS ('dbx_business_glossary_term' = 'Service Location Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Units');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coding Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Source Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_type_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Arithmetic Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_drg_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'CDI DRG Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_physician_response` SET TAGS ('dbx_business_glossary_term' = 'CDI Physician Response');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_topic` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Topic');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_type` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Response Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'CDI Response Deadline');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_resulting_code_change` SET TAGS ('dbx_business_glossary_term' = 'CDI Resulting Code Change');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Coding Accuracy Score');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_date` SET TAGS ('dbx_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_method` SET TAGS ('dbx_business_glossary_term' = 'Coding Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication Comorbidity Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Geometric Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `grouper_version` SET TAGS ('dbx_business_glossary_term' = 'Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `hcpcs_codes` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `major_complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Complication Comorbidity Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'MDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_description` SET TAGS ('dbx_business_glossary_term' = 'MDC Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `outlier_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Outlier Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `present_on_admission_indicators` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission Indicators');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('dbx_business_glossary_term' = 'Payment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|deductible|full_payment|partial_payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|mail|in_person|phone|lockbox');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `era_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) File Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'eft|check|credit_card|debit_card|cash|wire_transfer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|applied|reversed|refunded|voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|prepayment|overpayment|adjustment|settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'unposted|posted|partially_applied|fully_applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'insurance|patient|guarantor|third_party|government|charity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|approved|reversed|voided|reconciled');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `bad_debt_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_value_regex' = 'contractual|non_contractual|write_off|charity|discount|recoupment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contract_rate` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contract_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('dbx_business_glossary_term' = 'Contractual Payer Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Classification');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_value_regex' = 'bad_debt|charity_care|small_balance|rac_recoupment|administrative|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Patient Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_balance` SET TAGS ('dbx_business_glossary_term' = 'Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'open|closed|collections|bad_debt|charity|pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_flag` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Collection Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_in_collections|referred|active|recalled|resolved|legal_action');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `family_size` SET TAGS ('dbx_business_glossary_term' = 'Family Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_application_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_application_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|expired|revoked');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_effective_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('dbx_value_regex' = 'not_evaluated|eligible|ineligible|pending|approved|denied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('dbx_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('dbx_business_glossary_term' = 'Insurance Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `irs_501r_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS 501(r) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `original_balance` SET TAGS ('dbx_business_glossary_term' = 'Original Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('dbx_business_glossary_term' = 'Patient Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `referred_balance` SET TAGS ('dbx_business_glossary_term' = 'Referred Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_payments` SET TAGS ('dbx_business_glossary_term' = 'Total Payments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_subdomain' = 'patient_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `adjustments_applied` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'none|pending|active|legal|bad_debt|write_off');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `current_charges` SET TAGS ('dbx_business_glossary_term' = 'Current Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal|sms|fax');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|failed|returned|bounced');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `financial_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `financial_assistance_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('dbx_business_glossary_term' = 'Insurance Pending Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Statement Message');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `minimum_payment_due` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payments_received` SET TAGS ('dbx_business_glossary_term' = 'Payments Received');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `previous_balance` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_reason` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'paper|electronic|portal|email|sms');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `total_balance_due` SET TAGS ('dbx_business_glossary_term' = 'Total Balance Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Default Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_reason` SET TAGS ('dbx_business_glossary_term' = 'Default Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'patient_portal|phone|in_person|mail|email|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `finance_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Finance Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `financial_assistance_program_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Program Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `financial_assistance_program_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_business_glossary_term' = 'Installments Remaining');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `missed_payments_count` SET TAGS ('dbx_business_glossary_term' = 'Missed Payments Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `original_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|ach|check|cash|money_order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|defaulted|cancelled|suspended');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'standard|interest_free|hardship|extended|short_term|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Plan Amount');
