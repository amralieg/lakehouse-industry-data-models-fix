-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for each charge record.',
    `bed_id` BIGINT COMMENT 'Bed where service was rendered (for inpatient charges).',
    `billing_coverage_id` BIGINT COMMENT 'Insurance coverage used for this charge.',
    `care_site_id` BIGINT COMMENT 'Facility or care site where the charge was incurred.',
    `case_cart_id` BIGINT COMMENT 'Surgical case cart associated with supply charges.',
    `cdm_entry_id` BIGINT COMMENT 'Charge Description Master entry defining the charge code and price.',
    `claim_id` BIGINT COMMENT 'Claim to which this charge has been submitted.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial accounting and reporting.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code for the service.',
    `drug_master_id` BIGINT COMMENT 'Drug master record for medication charges.',
    `employee_id` BIGINT COMMENT 'Employee who posted or created the charge.',
    `fulfillment_id` BIGINT COMMENT 'Order fulfillment event that triggered the charge.',
    `guarantor_id` BIGINT COMMENT 'Guarantor responsible for payment.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for supplies, DME, or other services.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage at time of service.',
    `material_master_id` BIGINT COMMENT 'Supply or material item charged.',
    `mpi_record_id` BIGINT COMMENT 'Master Patient Index record for the patient.',
    `original_charge_id` BIGINT COMMENT 'Original charge if this is a correction or reversal.',
    `prescription_id` BIGINT COMMENT 'Prescription associated with medication charge.',
    `clinician_id` BIGINT COMMENT 'Clinician who performed or is responsible for the service.',
    `icd_code_id` BIGINT COMMENT 'Primary diagnosis code for the charge.',
    `room_id` BIGINT COMMENT 'Room where service was rendered.',
    `specialty_id` BIGINT COMMENT 'Clinical specialty associated with the charge.',
    `treatment_consent_id` BIGINT COMMENT 'Consent record for the treatment or procedure.',
    `unit_id` BIGINT COMMENT 'Clinical unit where service was rendered.',
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
    `ndc_code` STRING COMMENT 'National Drug Code for medication charges.',
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
    `material_master_id` BIGINT COMMENT 'Supply or material item linked to this CDM entry.',
    `org_unit_id` BIGINT COMMENT 'Organizational unit responsible for this CDM entry.',
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
    `ndc_code` STRING COMMENT 'National Drug Code for medication items.',
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
    `ar_account_id` BIGINT COMMENT 'Accounts receivable account for this invoice.',
    `claim_id` BIGINT COMMENT 'Claim submitted for this invoice.',
    `clinician_id` BIGINT COMMENT 'Primary clinician for the invoice.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial accounting.',
    `fhir_resource_log_id` BIGINT COMMENT 'FHIR resource log for interoperability tracking.',
    `guarantor_id` BIGINT COMMENT 'Guarantor responsible for payment.',
    `health_plan_id` BIGINT COMMENT 'Health plan for the invoice.',
    `mpi_record_id` BIGINT COMMENT 'Master Patient Index record for the patient.',
    `org_provider_id` BIGINT COMMENT 'Organizational provider for the invoice.',
    `payer_id` BIGINT COMMENT 'Primary insurance payer.',
    `provider_location_id` BIGINT COMMENT 'Provider location for the invoice.',
    `referral_order_id` BIGINT COMMENT 'Referral order associated with this invoice.',
    `tertiary_payer_id` BIGINT COMMENT 'Tertiary insurance payer.',
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
    `drg_code` STRING COMMENT 'Diagnosis Related Group code for inpatient billing.',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight for reimbursement calculation.',
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
    `cdm_entry_id` BIGINT COMMENT 'CDM entry for this line item.',
    `drug_master_id` BIGINT COMMENT 'Drug master record for medication line items.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for this line item.',
    `invoice_id` BIGINT COMMENT 'Parent invoice for this line item.',
    `icd_code_id` BIGINT COMMENT 'Primary diagnosis code for this line item.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code for this line item.',
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
    `ndc_code` STRING COMMENT 'National Drug Code for medication line items.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by payer for this line.',
    `paid_timestamp` TIMESTAMP COMMENT 'Timestamp when payment was received.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Patient responsibility amount for this line.',
    `place_of_service_code` STRING COMMENT 'CMS Place of Service code.',
    `procedure_description` STRING COMMENT 'Description of the procedure or service.',
    `remittance_advice_remark_code` STRING COMMENT 'RARC code from payer remittance.',
    `rendering_provider_npi` STRING COMMENT 'NPI of the rendering provider.',
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
    `audit_finding_id` BIGINT COMMENT 'Audit finding if this coding was audited.',
    `care_site_id` BIGINT COMMENT 'Facility where the coding was performed.',
    `cda_document_id` BIGINT COMMENT 'CDA document associated with this coding.',
    `claim_id` BIGINT COMMENT 'Claim for which coding was performed.',
    `drg_id` BIGINT COMMENT 'Diagnosis Related Group assigned.',
    `employee_id` BIGINT COMMENT 'Coder who performed the coding assignment.',
    `invoice_id` BIGINT COMMENT 'Invoice associated with this coding.',
    `icd_code_id` BIGINT COMMENT 'Principal diagnosis code assigned.',
    `cpt_code_id` BIGINT COMMENT 'Principal procedure code assigned.',
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
    `secondary_diagnosis_codes` STRING COMMENT 'Secondary diagnosis codes assigned (comma-separated).',
    `secondary_procedure_codes` STRING COMMENT 'Secondary procedure codes assigned (comma-separated).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the coding assignment was last updated.',
    CONSTRAINT pk_coding_assignment PRIMARY KEY(`coding_assignment_id`)
) COMMENT 'Assignment of diagnosis and procedure codes to a patient visit or claim by certified coders. Supports DRG assignment, CDI queries, and coding compliance workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Insurance payments are made under specific coverage. Payment already has payer_id, but coverage is the patient-specific coverage instance. FK links payment to coverage for insurance payments. Cardinal',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Payment reconciliation requires facility-level attribution for multi-site health systems to match remittances to the correct entity, support facility-specific cash flow analysis, and enable accurate r',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: ERA reconciliation: payments are created from inbound 835 ERA messages. Linking payment records to the source message_log enables reconciliation, reprocessing failed ERAs, and auditing payment posting',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the payment, if different from the patient.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or account balance against which this payment is applied.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the payment transaction.',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Payment notification workflow: significant payments (e.g., large patient payments, insurance settlements) trigger Direct messages to care coordinators or referring providers for care coordination. Tra',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or third-party organization making the payment.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Insurance payments must link to the specific coverage policy under which payment was remitted for EOB reconciliation, contract rate verification, and coordination of benefits processing. Essential for',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Payments made as part of a payment plan should link to the plan. FK allows tracking which payments are plan installments vs. ad-hoc payments. Cardinality: N payments : 1 payment plan (one plan receive',
    `ar_transaction_id` BIGINT COMMENT 'The unique transaction identifier provided by the payment processor or gateway for electronic payments (credit card, EFT). Used for reconciliation and dispute resolution.',
    `employee_id` BIGINT COMMENT 'The identifier of the user or system account that posted the payment to the revenue cycle management system.',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Payments are posted from remittance advices (835 transactions). Cash application, payment reconciliation, and bank deposit matching require linking payments to the remittance that authorized them. Ess',
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
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Billing adjustments (contractual, denials, write-offs) must create offsetting AR transactions for accurate revenue reporting, GAAP compliance, allowance for doubtful accounts, and financial statement ',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Adjustments resulting from audit findings (RAC overpayment determinations, MAC medical necessity denials, internal compliance audit corrections) must trace to the specific finding for regulatory repor',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Contractual adjustments are coverage-specific (based on payer contract rates for specific plans). FK links adjustment to the coverage under which the contractual adjustment was calculated. Cardinality',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Contractual adjustments and write-offs must be tracked by facility for financial reporting, payer contract compliance audits, and revenue integrity analysis. Essential for understanding facility-speci',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Charity care adjustments are based on approved financial assistance applications. FK links adjustment to the authoritative charity care application record. Cardinality: N adjustments : 1 application (',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adjustments frequently result from claim adjudication outcomes—payer denials, contractual adjustments, or underpayments. Revenue integrity and denial management workflows require linking adjustments t',
    `collection_account_id` BIGINT COMMENT 'Foreign key linking to billing.collection_account. Business justification: Adjustments related to collection activities (e.g., collection fees, recovery adjustments) link to the collection account. FK provides context for collection-related adjustments. Cardinality: N adjust',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Adjustments reference procedure codes when correcting billing errors or disputing payment variances. Existing cpt_code is denormalized string; FK enables validation, supports contractual adjustment ca',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Adjustments reference DRG codes when disputing inpatient payment variances or DRG downgrades. Existing drg_code is denormalized string; FK enables lookup of expected payment, supports DRG validation a',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: ERA adjustment reconciliation: adjustments (contractual, denial) are posted from 835 ERA messages. Linking adjustments to source message_log enables reconciliation, dispute resolution, and auditing ad',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Contractual adjustments are coverage-specific and must reference the exact insurance coverage policy to apply correct contract rates, validate allowable amounts, and maintain audit trails for payer co',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim to which this adjustment applies.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account is being adjusted.',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record that this transaction reverses, if this is a reversal adjustment.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or guarantor associated with this adjustment, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this adjustment record in the system.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Adjustments may reference diagnosis codes when disputing medical necessity denials or coding-related payment variances. FK enables validation of diagnosis-driven adjustment reasons and supports appeal',
    `rac_audit_id` BIGINT COMMENT 'Identifier for the RAC audit or recoupment action that triggered this adjustment, used for tracking and appeal management.',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.consent_restriction_request. Business justification: Patient-imposed restrictions on PHI disclosure (e.g., self-pay for specific services, restrict billing to insurance) trigger contractual adjustments when services cannot be billed to restricted partie',
    `sanction_id` BIGINT COMMENT 'Foreign key linking to provider.sanction. Business justification: Billing adjustments and write-offs are triggered by provider sanctions (OIG/SAM exclusions, state license suspensions, Medicare revocations). Adjustment records must reference sanction_id to document ',
    `tertiary_adjustment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this adjustment record.',
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
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Patient accounts in revenue cycle map to AR accounts in finance for aging analysis, collection tracking, financial reporting, and reconciliation. This is the master link between billing system and gen',
    `care_site_id` BIGINT COMMENT 'Reference to the primary healthcare facility where services associated with this account were rendered.',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Patient accounts with approved financial assistance link to the charity care application. FK provides access to detailed application data (household_income, fpl_percentage, approval_status, effective_',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this account. May be the patient or another party.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with this financial account. Links to the clinical patient record in the patient domain.',
    `primary_patient_mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Patient financial accounts must link to the patient master for statement generation, collections, and financial counseling workflows.',
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
    `employee_id` BIGINT COMMENT 'The system user or process identifier that created this statement record.',
    `vendor_id` BIGINT COMMENT 'Reference to the external collection agency to which this account has been referred, if applicable.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`collection_account` (
    `collection_account_id` BIGINT COMMENT 'Unique identifier for the collection account record. Primary key.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Collection accounts must link to AR accounts for tracking recovered amounts, write-offs, bad debt expense, and financial statement impact when accounts are referred to external agencies. Required for ',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Bad debt must be attributed to the originating facility for financial statement preparation (allowance for doubtful accounts by entity), collection agency coordination, and facility-level bad debt rat',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the outstanding balance referred to collections.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with this collection account.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account has been referred to collections.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Collection accounts are created when patient accounts are referred to collections for bad debt recovery. FK links collection record to the originating patient account. Cardinality: N collection accoun',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this collection account record.',
    `vendor_id` BIGINT COMMENT 'Reference to the external collection agency assigned to this account, if applicable.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this collection account.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the collection account, including settlements, discounts, or contractual adjustments negotiated during collections.',
    `aging_days` STRING COMMENT 'Number of days the account has been in collections, calculated from the referral date to the current date or closed date.',
    `closed_date` DATE COMMENT 'Date when the collection account was closed, either due to full recovery, write-off, settlement, or recall.',
    `collection_account_number` STRING COMMENT 'Externally-known unique identifier assigned to this collection account by the collection agency or internal collections department.',
    `collection_agency_name` STRING COMMENT 'Name of the collection agency or internal collections department handling this account.',
    `collection_fee_amount` DECIMAL(18,2) COMMENT 'Fees charged by the collection agency for their services, which may be passed to the patient or absorbed by the organization.',
    `collection_notes` STRING COMMENT 'Free-text notes documenting collection activities, patient communications, special circumstances, or other relevant information.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the collection account indicating its position in the collections workflow. [ENUM-REF-CANDIDATE: referred|active|in_progress|payment_plan|settled|recovered|recalled|written_off|closed — 9 candidates stripped; promote to reference product]',
    `collection_type` STRING COMMENT 'Classification of the collection effort indicating whether it is handled internally, by an external agency, or through legal action.. Valid values are `internal|external|legal|pre_collection|bad_debt`',
    `contact_attempt_count` STRING COMMENT 'Total number of contact attempts made to the patient or guarantor since the account was referred to collections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this collection account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `interest_amount` DECIMAL(18,2) COMMENT 'Total interest charges accrued on the outstanding balance during the collections period, if applicable per state regulations.',
    `judgment_amount` DECIMAL(18,2) COMMENT 'Court-ordered judgment amount awarded in favor of the organization, if legal action resulted in a judgment.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt or communication with the patient or guarantor regarding this collection account.',
    `last_contact_method` STRING COMMENT 'Method used for the most recent contact attempt with the patient or guarantor.. Valid values are `phone|mail|email|sms|in_person|portal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection account record was last modified or updated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received on this collection account.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received on this collection account.',
    `legal_action_date` DATE COMMENT 'Date when legal action was initiated on this collection account, if applicable.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal action (lawsuit, judgment, garnishment) has been initiated or taken on this collection account.',
    `monthly_payment_amount` DECIMAL(18,2) COMMENT 'Agreed-upon monthly payment amount for the payment plan, if applicable.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current remaining balance owed after applying any recovered amounts, adjustments, or write-offs.',
    `payment_plan_end_date` DATE COMMENT 'Scheduled end date for the payment plan arrangement, if applicable.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the patient or guarantor has entered into a payment plan arrangement with the collection agency.',
    `payment_plan_start_date` DATE COMMENT 'Date when the payment plan arrangement became effective, if applicable.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original principal balance owed, excluding interest, fees, or adjustments applied during the collections process.',
    `recall_date` DATE COMMENT 'Date when the account was recalled from the collection agency back to the organization, if applicable.',
    `recall_reason` STRING COMMENT 'Business reason for recalling the account from collections, such as patient dispute, billing error discovered, or payment received directly.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total amount successfully recovered from the patient or guarantor through the collections process.',
    `referral_date` DATE COMMENT 'Date when the account was referred to collections. This is the principal business event timestamp for this transaction.',
    `referral_reason` STRING COMMENT 'Business reason or justification for referring this account to collections, such as non-payment after multiple statements or patient unresponsiveness.',
    `referred_balance` DECIMAL(18,2) COMMENT 'Total outstanding balance amount referred to collections at the time of referral. Represents the gross amount owed.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Agreed-upon settlement amount paid to resolve the collection account for less than the full balance, if applicable.',
    `settlement_date` DATE COMMENT 'Date when a settlement agreement was reached with the patient or guarantor, if applicable.',
    `settlement_flag` BOOLEAN COMMENT 'Indicates whether the collection account was settled for less than the full amount owed through negotiation.',
    `vibe_placeholder` STRING COMMENT '',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt when the account is deemed uncollectible and closed.',
    `write_off_date` DATE COMMENT 'Date when the outstanding balance was written off as bad debt and the account was closed as uncollectible.',
    `write_off_reason` STRING COMMENT 'Business reason or justification for writing off the balance as bad debt, such as patient bankruptcy, deceased patient, or account deemed uncollectible.',
    CONSTRAINT pk_collection_account PRIMARY KEY(`collection_account_id`)
) COMMENT 'Account referred to collections agency for unpaid patient balances. Tracks collection activity, payments, and resolution status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` (
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the insurance coverage record. Primary key for the coverage entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this coverage record. Used for audit trail and accountability.',
    `billing_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that most recently modified this coverage record. Used for audit trail and accountability.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identifier assigned by the insurance payer to the patient for this coverage. Used for claims submission and eligibility verification.',
    `billing_mpi_record_id` BIGINT COMMENT 'Identifier of the patient who holds this insurance coverage. Links to the patient master record.',
    `billing_subscriber_mpi_record_id` BIGINT COMMENT 'Foreign key to the MPI record of the primary subscriber/policyholder if this patient is a dependent. NULL if relationship_to_subscriber = self.',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: Real-time eligibility verification: coverage records are verified via FHIR Coverage/$eligibility operations. Linking coverage to the fhir_resource_log that performed verification enables audit trails,',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Patient coverage records must link to applicable formulary for real-time benefit checks at point of prescription. Enables determination of covered drugs, tier placement, prior authorization requiremen',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Coverage records store denormalized plan_name and plan_type. Proper FK to health_plan enables eligibility verification, benefit lookups, accumulator tracking, and formulary checks. Revenue cycle syste',
    `insurance_coverage_id` BIGINT COMMENT 'Unique identifier for this patient-plan coverage record. Primary key for the coverage association.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Payers contract with organizational providers (hospitals, health systems) for network participation. Coverage records must track which org_provider the members plan is associated with to determine ne',
    `patient_coverage_id` BIGINT COMMENT 'FK pointing this superseded billing coverage row at the canonical patient.patient_coverage record (SSOT consolidation).',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer organization providing this coverage. Links to the payer master record.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (policyholder) for this coverage. May differ from member_id if patient is a dependent.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Payer coverage policies often mandate specific vendor contracts for high-cost implants and devices (e.g., "covered only if using contracted vendor"). Required for prior authorization, coverage determi',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this coverage is currently active and eligible for claims submission. Derived from coverage_status and verification results. True if coverage is active.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether this coverage requires prior authorization for certain services. True if authorization workflows must be followed.',
    `bin_number` STRING COMMENT 'Bank Identification Number used for pharmacy benefit claims routing. Six-digit number identifying the pharmacy benefit manager or payer for prescription drug coverage.',
    `cob_priority` STRING COMMENT 'The order in which this plan pays when the patient has multiple active coverages. 1 = primary, 2 = secondary, 3 = tertiary. Determines claims adjudication sequence and liability calculation.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered service costs the patient is responsible for after the deductible is met. Expressed as a percentage (e.g., 20.00 for 20% coinsurance).',
    `coordination_of_benefits_order` STRING COMMENT 'Priority order for this coverage when patient has multiple insurance plans. Primary coverage is billed first, secondary and tertiary follow COB rules.. Valid values are `Primary|Secondary|Tertiary`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the patient must pay at the time of service for covered services under this plan. Varies by service type.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the insurance coverage record. Active indicates coverage is in force and eligible for claims.. Valid values are `Active|Inactive|Suspended|Terminated|Pending`',
    `coverage_tier` STRING COMMENT 'The tier of coverage indicating who is covered under this enrollment (individual, employee+spouse, employee+children, family). Determines premium amounts and deductible aggregation rules.',
    `coverage_type` STRING COMMENT 'Category of healthcare services covered by this insurance plan. A patient may have multiple coverage records for different service types.. Valid values are `Medical|Dental|Vision|Pharmacy|Behavioral Health|Long-Term Care`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was first created in the system. Represents the initial capture of this coverage information.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Total annual deductible amount the patient must pay out-of-pocket before insurance begins covering costs under this plan.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Amount of the annual deductible that has been satisfied by the patient as of the most recent eligibility verification. Updated through real-time and batch eligibility checks.',
    `effective_date` DATE COMMENT 'Date when the insurance coverage becomes active and benefits are available. Start of the benefit period.',
    `eligibility_last_verified_date` DATE COMMENT 'The date on which this coverage was last verified with the payer via real-time eligibility transaction (270/271) or batch file. Used to determine staleness of coverage information.',
    `eligibility_verification_count` STRING COMMENT 'Total number of eligibility verification transactions performed for this coverage record. Includes real-time, batch, and manual verifications.',
    `eligibility_verification_status` STRING COMMENT 'Result of the most recent eligibility verification attempt. Verified = payer confirmed active coverage. Rejected = payer indicates no active coverage. Pending = verification in progress.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The portion of the monthly premium paid by the employer (for employer-sponsored plans). NULL for individual/marketplace plans.',
    `employer_name` STRING COMMENT 'Name of the employer or organization sponsoring this insurance coverage. Applicable for employer-sponsored group health plans.',
    `enrollment_effective_date` DATE COMMENT 'The date on which this patients coverage under this health plan became effective. Used for eligibility determination and claims adjudication date-of-service validation.',
    `enrollment_source` STRING COMMENT 'The channel or mechanism through which this coverage was obtained (employer-sponsored, ACA marketplace, Medicaid enrollment, Medicare enrollment, direct purchase, COBRA continuation).',
    `enrollment_termination_date` DATE COMMENT 'The date on which this patients coverage under this health plan ended or will end. NULL for active ongoing coverage. Used for eligibility determination and retroactive claims processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was most recently updated. Tracks the latest change to any field in the record.',
    `last_verification_date` DATE COMMENT 'Date when eligibility for this coverage was most recently verified with the payer. Updated through real-time 270/271 transactions, manual verification, or batch processes.',
    `last_verification_method` STRING COMMENT 'Method used for the most recent eligibility verification. Real-Time 270/271 indicates automated EDI transaction, Manual indicates phone or fax verification, Batch indicates scheduled bulk verification, Portal indicates payer web portal lookup.. Valid values are `Real-Time 270/271|Manual|Batch|Portal`',
    `last_verification_status` STRING COMMENT 'Result status of the most recent eligibility verification attempt. Verified Active indicates coverage is confirmed and active. Verification Failed indicates payer did not confirm coverage.. Valid values are `Verified Active|Verified Inactive|Verification Failed|Pending`',
    `merged_with_patient_patient_coverage` STRING COMMENT 'Captures the merge linkage to the canonical patient.patient_coverage SSOT used during consolidation.',
    `network_status` STRING COMMENT 'Indicates whether this coverage applies to in-network providers, out-of-network providers, or both. Affects reimbursement rates and patient cost-sharing.. Valid values are `In-Network|Out-of-Network|Both`',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum total amount the patient must pay out-of-pocket in a benefit period before insurance covers 100% of covered services.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Amount of the out-of-pocket maximum that has been satisfied by the patient as of the most recent eligibility verification. Updated through real-time and batch eligibility checks.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The portion of the monthly premium paid by the patient/member. Calculated as premium_amount minus employer_contribution_amount.',
    `payer_response_code` STRING COMMENT 'Response code returned by the payer during the most recent eligibility verification. Indicates coverage status, limitations, or error conditions per HIPAA 271 transaction standards.',
    `payer_response_message` STRING COMMENT 'Human-readable message returned by the payer during the most recent eligibility verification. Provides additional context for the response code.',
    `pcn_number` STRING COMMENT 'Processor Control Number used in conjunction with BIN for pharmacy claims routing. Identifies specific benefit plan or processing rules within the payer system.',
    `plan_year_end_date` DATE COMMENT 'End date of the plan year for this coverage. Marks the end of the benefit period before deductibles and out-of-pocket maximums reset.',
    `plan_year_start_date` DATE COMMENT 'Start date of the plan year for this coverage. Deductibles and out-of-pocket maximums typically reset on this date annually.',
    `policy_number` STRING COMMENT 'Unique policy identifier assigned by the insurance payer. May be the same as member_id or a separate contract identifier.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The monthly premium amount in USD for this specific patients coverage under this plan. May vary by coverage_tier and subscriber vs dependent status.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether this coverage requires a referral from a Primary Care Physician (PCP) for specialist visits. Common in HMO plans.',
    `relationship_to_subscriber` STRING COMMENT 'The relationship of this patient to the primary subscriber/policyholder. self indicates the patient is the subscriber. Used for dependent eligibility verification and COB determination.',
    `rx_group_number` STRING COMMENT 'Group number specific to pharmacy benefits. May differ from the medical group_number for plans with separate pharmacy benefit managers.',
    `source_system_code` STRING COMMENT 'Unique identifier for this coverage record in the source operational system. Used for data lineage and reconciliation.',
    `ssot_canonical_reference` STRING COMMENT 'Logical reference to the canonical coverage SSOT table patient.patient_coverage.',
    `ssot_reconciliation_status` STRING COMMENT 'Reconciliation status of this row against the canonical patient.patient_coverage SSOT (e.g. consolidated, pending, conflict).',
    `subscriber_relationship` STRING COMMENT 'Relationship of the patient to the primary subscriber (policyholder). Determines dependent status and coverage rules.. Valid values are `Self|Spouse|Child|Other`',
    `termination_date` DATE COMMENT 'Date when the insurance coverage ends and benefits are no longer available. Null for open-ended active coverage.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this coverage record was last modified. Audit field for change tracking.',
    `verification_source_system` STRING COMMENT 'Name of the system or clearinghouse used to perform the most recent eligibility verification (e.g., Change Healthcare, Availity, Epic Resolute, Cerner Revenue Cycle).',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_billing_coverage PRIMARY KEY(`billing_coverage_id`)
) COMMENT 'Insurance coverage snapshot at time of billing, including eligibility verification, benefit details, and coordination of benefits. Supports claim submission and payment posting. | Consolidated into SSOT patient.patient_coverage';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the write-off record. Primary key.',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Write-offs must post to AR transactions for bad debt expense recognition, allowance for doubtful accounts adjustment, financial statement accuracy, and regulatory reporting (e.g., charity care, bad de',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Write-offs resulting from compliance audit findings (unallowable charges, medical necessity failures, billing compliance violations) must reference the finding for regulatory reporting, trend analysis',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Charity care write-offs are based on approved financial assistance applications. Same pattern as adjustment → charity_care_application. FK links write-off to the authoritative application. Cardinality',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Write-offs often follow claim denials or partial payments where recovery is deemed uneconomical. Bad debt reporting, charity care tracking, and revenue cycle KPIs require linking write-offs to the cla',
    `collection_account_id` BIGINT COMMENT 'Foreign key linking to billing.collection_account. Business justification: Bad debt write-offs often result from failed collection efforts. FK links write-off to the collection account record. Cardinality: N write-offs : 1 collection account (one collection account can resul',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Write-offs reference procedure codes for financial reporting and variance analysis. Existing cpt_code is denormalized string; FK enables procedure-level write-off analysis, supports revenue cycle KPIs',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Write-offs reference DRG codes for inpatient financial analysis. Existing drg_code is denormalized string; FK enables DRG-level write-off analysis, supports case mix variance reporting, and identifies',
    `financial_assistance_id` BIGINT COMMENT 'Foreign key linking to patient.financial_assistance. Business justification: Write-offs resulting from approved financial assistance must reference the specific assistance application for IRS 501(r) compliance reporting, community benefit tracking, and regulatory audits. Requi',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the account balance being written off.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim from which this balance was written off.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account balance is being written off.',
    `original_write_off_id` BIGINT COMMENT 'Reference to the original write-off record if this is a reversal or correction entry, creating an audit trail.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer associated with this write-off, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the user or manager who authorized this write-off, for audit trail and accountability.',
    `rac_audit_id` BIGINT COMMENT 'Reference to the RAC audit case or finding that resulted in this recoupment write-off, if applicable.',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.consent_restriction_request. Business justification: Write-offs result from inability to bill insurance when patient exercises HIPAA right to restrict PHI disclosure and pays out-of-pocket. Financial reporting and compliance audits require documenting t',
    `tertiary_write_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this write-off record, for audit trail and accountability.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this write-off.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the balance permanently written off from the patient account or invoice, expressed in US dollars (USD). This is the principal amount forgiven or deemed uncollectible.',
    `appeal_date` DATE COMMENT 'The date on which an appeal was filed to contest or reverse this write-off.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether this write-off is subject to an active appeal or dispute process. True if under appeal, False otherwise.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process: pending (under review), approved (write-off reversed), denied (write-off upheld), or withdrawn (appeal abandoned).. Valid values are `pending|approved|denied|withdrawn`',
    `approval_date` DATE COMMENT 'The date on which the write-off was formally approved by the authorizing user or manager.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this write-off requires managerial or executive approval based on amount thresholds or policy rules. True if approval is required, False otherwise.',
    `bad_debt_referral_date` DATE COMMENT 'The date on which the account was referred to a collection agency or written off as bad debt, marking the transition from active collection to write-off.',
    `write_off_category` STRING COMMENT 'Broader categorization of the write-off for financial reporting and analytics: patient responsibility (self-pay), insurance denial (payer refusal), uncompensated care (charity or bad debt), policy adjustment (internal policy), or audit adjustment (external audit finding).. Valid values are `patient_responsibility|insurance_denial|uncompensated_care|policy_adjustment|audit_adjustment`',
    `cost_center_code` STRING COMMENT 'The cost center or department code associated with this write-off for internal financial tracking and allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the original balance as part of the charity care or financial assistance program. For example, 100.00 represents a full write-off, 50.00 represents a 50% discount.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'The patient or guarantor household income expressed as a percentage of the Federal Poverty Level, used to determine charity care eligibility. For example, 150.00 represents 150% of FPL.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this write-off is posted for financial reporting, such as bad debt expense or charity care.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was last updated or modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notes` STRING COMMENT 'Free-text notes providing additional context, justification, or documentation for this write-off, used for audit and compliance purposes.',
    `original_balance` DECIMAL(18,2) COMMENT 'The original outstanding balance on the account or invoice before the write-off was applied, providing context for the write-off magnitude.',
    `posting_date` DATE COMMENT 'The date on which the write-off was posted to the general ledger and financial reporting systems.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the write-off, aligned with internal revenue cycle coding standards or external regulatory codes.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of why the balance was written off, providing context for audit and compliance review.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The balance remaining on the account or invoice after this write-off is applied. May be zero if the write-off clears the account.',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with the original charges being written off, providing service line detail.',
    `reversal_date` DATE COMMENT 'The date on which this write-off was reversed, restoring the balance to the account.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this write-off has been reversed or undone. True if reversed, False if still active.',
    `reversal_reason` STRING COMMENT 'Explanation of why the write-off was reversed, such as Patient payment received or Insurance appeal successful.',
    `service_date` DATE COMMENT 'The date of service or encounter for which the charges were originally incurred, providing historical context for the write-off.',
    `vibe_placeholder` STRING COMMENT '',
    `write_off_date` DATE COMMENT 'The business date on which the write-off was officially recorded and the balance was removed from active accounts receivable.',
    `write_off_number` STRING COMMENT 'Business-facing unique identifier or control number for this write-off transaction, used for tracking and audit purposes.',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off: pending (awaiting approval), approved (authorized but not yet posted), posted (applied to account), reversed (undone), or under review (being audited or appealed).. Valid values are `pending|approved|posted|reversed|under_review`',
    `write_off_type` STRING COMMENT 'Classification of the write-off by its nature: bad debt (uncollectible patient balance), charity care (financial assistance), small balance (below collection threshold), administrative (system correction), RAC recoupment (Recovery Audit Contractor adjustment), or contractual dispute (payer disagreement).. Valid values are `bad_debt|charity_care|small_balance|administrative|rac_recoupment|contractual_dispute`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Write-off of uncollectible patient or payer balance. Includes bad debt, charity care, and contractual write-offs with approval workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Payment plans must comply with financial assistance policies, state regulations governing patient billing practices, and IRS 501(r) requirements. Required for demonstrating compliant billing practices',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor who is financially responsible for this payment plan.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the primary party responsible for this payment plan.',
    `patient_account_id` BIGINT COMMENT 'Reference to the patient account for which this payment plan was established.',
    `employee_id` BIGINT COMMENT 'Reference to the user or staff member who approved the payment plan, typically a financial counselor, billing manager, or revenue cycle specialist.',
    `tertiary_payment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system process that most recently modified the payment plan record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` (
    `rac_audit_id` BIGINT COMMENT 'Unique identifier for the RAC audit record. Primary key for the rac_audit product.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: RAC audits target specific Medicare provider numbers (facilities). Tracking the facility is essential for audit response coordination, corrective action plan implementation, and monitoring facility-sp',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: RAC audits are compliance audits conducted by Recovery Audit Contractors. Linking to compliance.audit enables unified audit finding tracking, corrective action plan management, and regulatory reportin',
    `invoice_id` BIGINT COMMENT 'Foreign key reference to the invoice or claim that was subject to audit review.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient whose care or billing was audited.',
    `payer_id` BIGINT COMMENT 'Foreign key reference to the insurance payer or government program that initiated or sponsored the audit (e.g., Medicare, Medicaid, commercial payer).',
    `employee_id` BIGINT COMMENT 'Internal user ID of the compliance officer, revenue cycle analyst, or HIM professional assigned to manage the audit response and resolution.',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: RAC audit response workflow: audits request clinical documentation, which is submitted as CDA documents. Tracking which CDA document was submitted in response to each audit enables audit management, r',
    `tertiary_rac_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the individual who last modified this audit record.',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter associated with the audited claim or billing record.',
    `appeal_decision_date` DATE COMMENT 'Date the appeal decision was issued by the reviewing authority (MAC, QIC, ALJ, Appeals Council, or Federal Court).',
    `appeal_filed_date` DATE COMMENT 'Date the organization filed an appeal of the audit findings. Typically must be within 120 days of determination letter for Medicare RAC audits.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the organization filed an appeal of the audit findings. True if appeal was filed, False if no appeal.',
    `appeal_level` STRING COMMENT 'Current level in the Medicare appeals process. Redetermination (Level 1), Reconsideration by QIC (Level 2), ALJ Hearing (Level 3), Medicare Appeals Council Review (Level 4), Federal Court (Level 5).. Valid values are `redetermination|reconsideration|alj_hearing|mac_review|federal_court`',
    `appeal_outcome_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after appeal resolution. May differ from original finding_amount if appeal was partially or fully favorable.',
    `appeal_status` STRING COMMENT 'Current status or outcome of the appeal. Pending (under review), upheld (original finding affirmed), overturned (finding reversed), partially favorable (partial reversal), withdrawn, or dismissed.. Valid values are `pending|upheld|overturned|partially_favorable|withdrawn|dismissed`',
    `audit_notes` STRING COMMENT 'Free-text notes documenting audit details, correspondence with auditor, internal review findings, and resolution activities.',
    `audit_number` STRING COMMENT 'External audit reference number assigned by the auditing contractor or agency. Business identifier for tracking and correspondence.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the service period under audit review. Defines the temporal scope of claims and billing records subject to audit.',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the service period under audit review. Defines the temporal scope of claims and billing records subject to audit.',
    `audit_request_date` DATE COMMENT 'Date the audit request or Additional Documentation Request (ADR) was received by the organization. Principal business event timestamp for the audit lifecycle.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Tracks progression from initial request through resolution and closure. [ENUM-REF-CANDIDATE: requested|in_progress|findings_issued|appeal_filed|appeal_pending|resolved|closed — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit program. RAC (Recovery Audit Contractor), MAC (Medicare Administrative Contractor), OIG (Office of Inspector General), ZPIC (Zone Program Integrity Contractor), UPIC (Unified Program Integrity Contractor), internal compliance, payer audit, state Medicaid, or quality review. [ENUM-REF-CANDIDATE: rac|mac|oig|zpic|upic|internal_compliance|payer_audit|state_medicaid|quality_review — 9 candidates stripped; promote to reference product]',
    `compliance_resolution_status` STRING COMMENT 'Status of internal compliance remediation activities in response to audit findings. Tracks corrective action plan development, implementation, and validation.. Valid values are `open|corrective_action_plan_submitted|corrective_action_implemented|validated|closed`',
    `contractor_jurisdiction` STRING COMMENT 'Geographic or organizational jurisdiction of the auditing contractor (e.g., Region A, Region B, statewide, national).',
    `contractor_name` STRING COMMENT 'Name of the auditing organization or contractor conducting the audit (e.g., Cotiviti, Performant, HMS, or internal compliance department).',
    `corrective_action_description` STRING COMMENT 'Narrative description of corrective actions taken to remediate audit findings and prevent recurrence (e.g., staff training, policy updates, system enhancements, coding review process changes).',
    `corrective_action_plan_date` DATE COMMENT 'Date the organization submitted or finalized a corrective action plan to address systemic issues identified in the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Audit trail for record creation.',
    `extrapolation_flag` BOOLEAN COMMENT 'Indicates whether the auditor applied statistical extrapolation to project findings from a sample to a larger population of claims. True if extrapolation was used, False otherwise.',
    `extrapolation_sample_size` STRING COMMENT 'Number of claims in the statistical sample used for extrapolation, if extrapolation_flag is True.',
    `extrapolation_universe_size` STRING COMMENT 'Total number of claims in the population to which sample findings were extrapolated, if extrapolation_flag is True.',
    `finding_amount` DECIMAL(18,2) COMMENT 'Total monetary amount identified in the audit finding. Positive for overpayments (amounts owed to payer), negative for underpayments (amounts owed to provider).',
    `finding_type` STRING COMMENT 'Classification of the audit finding. Overpayment (provider must refund), underpayment (provider owed additional payment), no finding (claim upheld), documentation deficiency, coding error, medical necessity denial, or coverage denial. [ENUM-REF-CANDIDATE: overpayment|underpayment|no_finding|documentation_deficiency|coding_error|medical_necessity|coverage_denial — 7 candidates stripped; promote to reference product]',
    `findings_issued_date` DATE COMMENT 'Date the auditor issued formal findings, determination letter, or demand letter communicating audit results.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest charges applied to overpayment amounts per statutory requirements. Calculated from date of overpayment to date of recoupment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated. Audit trail for record modification.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'Amount determined to have been overpaid to the provider and subject to recoupment. Subset of finding_amount when finding_type is overpayment.',
    `records_requested_count` STRING COMMENT 'Number of medical records, claims, or billing documents requested by the auditor for review.',
    `records_submitted_count` STRING COMMENT 'Number of medical records, claims, or billing documents actually submitted to the auditor in response to the request.',
    `recoupment_amount` DECIMAL(18,2) COMMENT 'Actual amount recouped or offset from future payments by the payer. May differ from overpayment_amount if partial recoupment, payment plan, or appeal adjustments occurred.',
    `recoupment_date` DATE COMMENT 'Date the payer initiated recoupment or offset of the overpayment amount from provider payments.',
    `recoupment_method` STRING COMMENT 'Method by which the overpayment was recovered. Offset (deducted from future payments), direct payment (check or EFT), installment plan (extended payment agreement), settlement (negotiated amount), or waived.. Valid values are `offset|direct_payment|installment_plan|settlement|waived`',
    `response_due_date` DATE COMMENT 'Deadline by which the organization must submit requested documentation to the auditor. Typically 45 days from ADR receipt for RAC audits.',
    `response_submitted_date` DATE COMMENT 'Date the organization submitted the requested documentation to the auditor.',
    `underpayment_amount` DECIMAL(18,2) COMMENT 'Amount determined to have been underpaid to the provider and subject to additional reimbursement. Subset of finding_amount when finding_type is underpayment.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_rac_audit PRIMARY KEY(`rac_audit_id`)
) COMMENT 'Recovery Audit Contractor (RAC) audit record tracking audit requests, findings, appeals, and recoupments. Supports compliance and revenue integrity workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` (
    `charity_care_application_id` BIGINT COMMENT 'Unique identifier for the charity care application. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the authorized user who approved the charity care application.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Financial assistance programs must reference governing policies for eligibility determination, discount schedules, and IRS 501(r) compliance. Required for regulatory audits, presumptive eligibility do',
    `guarantor_id` BIGINT COMMENT 'Identifier of the guarantor responsible for the account associated with this application.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient submitting the financial assistance application.',
    `primary_charity_employee_id` BIGINT COMMENT 'Identifier of the financial counselor or staff member who reviewed and processed the application.',
    `tertiary_charity_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the charity care application record.',
    `visit_id` BIGINT COMMENT 'Identifier of the visit or encounter for which financial assistance is requested. May be null for prospective applications.',
    `appeal_date` DATE COMMENT 'Date the patient submitted an appeal of the denied charity care application.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the patient has filed an appeal of a denied charity care application.',
    `appeal_status` STRING COMMENT 'Current status of the charity care application appeal process.. Valid values are `pending|approved|denied|withdrawn`',
    `application_date` DATE COMMENT 'Date the charity care application was submitted by the patient or guarantor.',
    `application_method` STRING COMMENT 'Method by which the charity care application was submitted (online portal, paper form, phone interview, in-person, mail, fax).. Valid values are `online_portal|paper_form|phone|in_person|mail|fax`',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned to this charity care request for tracking and reference purposes.',
    `application_source` STRING COMMENT 'Source or origin of the charity care application (patient-initiated, staff-initiated during screening, automated presumptive eligibility, third-party referral).. Valid values are `patient_initiated|staff_initiated|screening_tool|presumptive_eligibility|third_party`',
    `application_status` STRING COMMENT 'Current lifecycle status of the charity care application in the review and approval workflow. [ENUM-REF-CANDIDATE: pending|under_review|approved|denied|withdrawn|expired|incomplete — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date the charity care application was approved by the financial counselor or review committee.',
    `approval_status` STRING COMMENT 'Final approval decision for the charity care application after review and documentation verification.. Valid values are `pending|approved|denied|conditional`',
    `approved_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount approved for the patients account charges under the financial assistance program. 100% indicates full charity care.',
    `coverage_period_months` STRING COMMENT 'Number of months for which the approved financial assistance is valid before requiring renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the charity care application record was first created in the system.',
    `denial_date` DATE COMMENT 'Date the charity care application was denied.',
    `denial_reason` STRING COMMENT 'Reason for denial of the charity care application (e.g., income exceeds threshold, incomplete documentation, failure to respond).',
    `documentation_status` STRING COMMENT 'Status of supporting documentation (income verification, tax returns, pay stubs, etc.) required for the application review process.. Valid values are `not_submitted|submitted|verified|incomplete|rejected`',
    `documentation_type` STRING COMMENT 'Type of supporting documentation provided (e.g., tax return, pay stub, unemployment statement, social security statement, bank statement).',
    `effective_date` DATE COMMENT 'Date from which the approved financial assistance discount becomes effective and can be applied to patient charges.',
    `expiration_date` DATE COMMENT 'Date on which the approved financial assistance eligibility expires and requires re-application or re-verification.',
    `family_size` STRING COMMENT 'Number of individuals in the applicants household, used in conjunction with household income to calculate Federal Poverty Level (FPL) percentage.',
    `fap_notification_date` DATE COMMENT 'Date the patient was notified of the availability of the Financial Assistance Policy (FAP) as required by IRS 501(r).',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of the Federal Poverty Level based on household income and family size, used to determine eligibility tier for financial assistance.',
    `household_income` DECIMAL(18,2) COMMENT 'Total annual household income reported by the applicant, used to determine eligibility for financial assistance programs.',
    `irs_501r_compliance_flag` BOOLEAN COMMENT 'Indicates whether this charity care application and its processing comply with IRS 501(r) community benefit requirements for tax-exempt hospitals.',
    `language_preference` STRING COMMENT 'Preferred language for application materials and communication with the patient (e.g., English, Spanish, Chinese).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the charity care application record was last modified or updated.',
    `medicaid_application_date` DATE COMMENT 'Date the patient submitted their Medicaid application, if applicable.',
    `medicaid_pending_flag` BOOLEAN COMMENT 'Indicates whether the patient has a pending Medicaid application at the time of charity care application submission.',
    `notes` STRING COMMENT 'Free-text notes and comments from financial counselors or reviewers regarding the application, documentation, or special circumstances.',
    `plain_language_summary_provided_flag` BOOLEAN COMMENT 'Indicates whether the patient was provided with a plain language summary of the Financial Assistance Policy as required by IRS 501(r).',
    `presumptive_eligibility_basis` STRING COMMENT 'Basis for granting presumptive eligibility (e.g., SNAP enrollment, Medicaid pending, homelessness, state assistance program participation).',
    `presumptive_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the patient was granted presumptive eligibility for charity care based on participation in other assistance programs (SNAP, WIC, Medicaid pending, homelessness) without full income documentation.',
    `program_type` STRING COMMENT 'Type of financial assistance program for which the patient is applying (full charity care, partial charity, sliding scale discount, Medicaid presumptive eligibility, or other assistance).. Valid values are `full_charity|partial_charity|sliding_scale|medicaid_presumptive|emergency_medicaid|prompt_pay_discount`',
    `screening_score` DECIMAL(18,2) COMMENT 'Automated financial screening score calculated from initial patient information to predict eligibility for financial assistance.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_charity_care_application PRIMARY KEY(`charity_care_application_id`)
) COMMENT 'Patient application for charity care or financial assistance. Tracks application status, eligibility determination, and approval workflow per IRS 501(r) requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction. Primary key for the refund product.',
    `ar_transaction_id` BIGINT COMMENT 'External transaction identifier from the payment processor or banking system for the refund transaction.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CMS requires quarterly credit balance reporting by provider (facility). Refunds must be tracked by facility for regulatory compliance, financial reconciliation, and audit trails. Essential for Medicar',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Refunds result from claim overpayments identified during remittance processing or post-payment audits. CMS credit balance reporting and payer refund workflows require linking refunds to the claims tha',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is the recipient of the refund.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor or financially responsible party receiving the refund.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with the original payment being refunded.',
    `original_refund_id` BIGINT COMMENT 'Self-referencing FK on refund (original_refund_id)',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer receiving the refund if the refund is issued to an insurance company.',
    `payment_id` BIGINT COMMENT 'Reference to the original payment transaction that is being refunded.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Refunds may reference diagnosis codes when overpayments result from medical necessity denials or coding corrections. FK enables diagnosis-driven refund analysis, supports RAC audit response, and docum',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the refund record in the system.',
    `quaternary_refund_voided_by_user_employee_id` BIGINT COMMENT 'Reference to the user who voided or cancelled the refund, used for audit trail purposes.',
    `rac_audit_id` BIGINT COMMENT 'Reference to the RAC audit that mandated or triggered this refund, if applicable.',
    `tertiary_refund_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the refund record in the system.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with the original payment being refunded.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount being refunded to the recipient. Represents the gross refund value before any adjustments.',
    `approval_date` DATE COMMENT 'The date when the refund was officially approved by the authorized approver.',
    `refund_category` STRING COMMENT 'High-level classification of the refund reason category for reporting and analytics purposes.. Valid values are `overpayment|duplicate|credit_balance|rac_ordered|patient_request|payer_request`',
    `check_number` STRING COMMENT 'The check number if the refund was issued via paper check, used for reconciliation and tracking.',
    `cleared_date` DATE COMMENT 'The date when the refund payment cleared the bank or payment processor and was successfully received by the recipient.',
    `cms_credit_balance_report_flag` BOOLEAN COMMENT 'Boolean indicator showing whether this refund must be reported on the CMS credit balance report for Medicare compliance.',
    `cms_report_date` DATE COMMENT 'The date when this refund was reported to CMS as part of credit balance reporting requirements.',
    `cost_center_code` STRING COMMENT 'Cost center or department code associated with the refund for internal financial tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the refund record was first created in the system.',
    `credit_card_last_four` STRING COMMENT 'Last four digits of the credit card number if the refund was issued as a credit card reversal, used for identification without exposing full card number.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'The type or brand of credit card if the refund was issued as a credit card reversal.. Valid values are `visa|mastercard|amex|discover|other`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `disbursement_date` DATE COMMENT 'The date when the refund payment was actually issued or disbursed to the recipient.',
    `eft_trace_number` STRING COMMENT 'The trace or confirmation number for electronic funds transfer refunds, used for payment tracking and reconciliation.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the refund transaction is posted for financial accounting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the refund record was last updated or modified in the system.',
    `method` STRING COMMENT 'The payment instrument or mechanism used to disburse the refund (e.g., check, electronic funds transfer, credit card reversal).. Valid values are `check|eft|wire|credit_card_reversal|cash|offset`',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or details about the refund transaction.',
    `original_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the original payment transaction that is being refunded, used for reconciliation and audit purposes.',
    `payee_address_line_1` STRING COMMENT 'First line of the mailing address where the refund is sent.',
    `payee_address_line_2` STRING COMMENT 'Second line of the mailing address where the refund is sent (suite, apartment, etc.).',
    `payee_city` STRING COMMENT 'City name for the refund payee mailing address.',
    `payee_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the refund payee mailing address.. Valid values are `^[A-Z]{3}$`',
    `payee_name` STRING COMMENT 'The name of the individual or organization receiving the refund, as it appears on the refund instrument.',
    `payee_postal_code` STRING COMMENT 'Postal or ZIP code for the refund payee mailing address.',
    `payee_state` STRING COMMENT 'Two-letter state or province code for the refund payee mailing address.. Valid values are `^[A-Z]{2}$`',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for issuing the refund.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of the reason for issuing the refund, providing context beyond the reason code.',
    `reconciliation_date` DATE COMMENT 'The date when the refund was reconciled with bank statements and financial records.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the refund has been successfully reconciled with bank statements and financial records.. Valid values are `pending|reconciled|unreconciled|exception`',
    `refund_number` STRING COMMENT 'Externally visible unique business identifier for the refund transaction, used for tracking and reconciliation.',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction indicating its progression through the refund workflow. [ENUM-REF-CANDIDATE: requested|pending_approval|approved|issued|cleared|voided|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `refund_type` STRING COMMENT 'Classification of the refund recipient type indicating whether the refund is issued to a patient, guarantor, insurance payer, or vendor.. Valid values are `patient|guarantor|payer|vendor`',
    `request_date` DATE COMMENT 'The date when the refund was initially requested or identified as necessary.',
    `vibe_placeholder` STRING COMMENT '',
    `void_date` DATE COMMENT 'The date when the refund was voided or cancelled.',
    `void_flag` BOOLEAN COMMENT 'Boolean indicator showing whether the refund has been voided or cancelled after issuance.',
    `void_reason` STRING COMMENT 'Explanation of why the refund was voided or cancelled after issuance.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Refund issued to patient or payer for overpayment. Tracks refund amount, reason, approval, and payment method.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` (
    `invoice_coverage_billing_id` BIGINT COMMENT 'Primary key for the invoice_coverage_billing association',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to the insurance coverage to which this invoice is being billed',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the invoice being submitted for payment',
    `adjudication_date` DATE COMMENT 'The date this payer completed adjudication and issued payment or denial for this invoice. Received from remittance advice (835).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The amount this specific payer determined as allowable for this invoice based on their contract or fee schedule. Returned in the remittance advice (835).',
    `check_eft_number` STRING COMMENT 'The check number or electronic funds transfer trace number for the payment received from this payer for this invoice.',
    `claim_filing_indicator_code` STRING COMMENT 'Two-character code indicating the type of insurance plan for this specific claim submission (e.g., MA=Medicare Part A, MB=Medicare Part B, MC=Medicaid, 09=Self Pay, 11=Other Non-Federal Programs).',
    `claim_status` STRING COMMENT 'The current lifecycle status of this specific claim submission to this payer. Tracks the claim through submission, adjudication, payment, and potential appeal.',
    `clearinghouse_trace_number` STRING COMMENT 'Unique identifier assigned by the clearinghouse for this specific claim submission. Used for claim status inquiries (276/277) and troubleshooting.',
    `contractual_adjustment` DECIMAL(18,2) COMMENT 'The write-off amount for this specific payer representing the difference between submitted charges and allowed amount per contract terms.',
    `coordination_of_benefits_order` STRING COMMENT 'The sequence in which this coverage is billed for this invoice in the COB waterfall. Primary is billed first, secondary after primary adjudication, tertiary after secondary.',
    `coverage_status_at_billing` STRING COMMENT 'The eligibility status of the coverage at the time this invoice was submitted to this payer. Captures point-in-time status for audit and denial management.',
    `denial_reason_code` STRING COMMENT 'The reason code provided by this payer if the claim was denied or partially denied. Used for denial management and appeal workflows.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of why this payer denied or partially denied this claim. Supports denial management and staff training.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by this specific payer for this invoice. Posted from remittance advice (835) or manual payment posting.',
    `patient_responsibility` DECIMAL(18,2) COMMENT 'The amount this specific payer determined the patient is responsible for (copay, coinsurance, deductible) for this invoice. Used to calculate patient statements.',
    `payer_claim_control_number` STRING COMMENT 'Unique identifier assigned by this payer for this claim submission. Returned in acknowledgment (999/277) and used in all correspondence with the payer.',
    `remittance_advice_number` STRING COMMENT 'The 835 remittance advice transaction number that contained the payment or denial information for this claim submission.',
    `submission_date` DATE COMMENT 'The date this invoice was submitted to this specific payer. Used for timely filing tracking and aging reports.',
    `submitted_amount` DECIMAL(18,2) COMMENT 'The total charge amount submitted to this specific payer for this invoice. May differ from invoice total_charges based on COB order and prior payer payments.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_invoice_coverage_billing PRIMARY KEY(`invoice_coverage_billing_id`)
) COMMENT 'Link between invoice and insurance coverage for coordination of benefits and multi-payer billing. Tracks billing sequence and payer responsibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique surrogate key for each invoice line item record. Primary key for the association.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the parent invoice record. Each line item belongs to exactly one invoice.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the supply item being billed. References the material master record for item identification and attributes.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The payer-approved reimbursement amount for this line item based on contract terms. May be less than line_amount due to contractual adjustments.',
    `denial_reason_code` STRING COMMENT 'Payer-provided reason code if this line item was denied or rejected. Used for denial management and resubmission workflows.',
    `hcpcs_code` STRING COMMENT 'Healthcare Common Procedure Coding System (HCPCS) code for the supply item. Used for reimbursement and regulatory reporting. May be Level I (CPT) or Level II (national codes).',
    `line_amount` DECIMAL(18,2) COMMENT 'The total charge amount for this line item, calculated as quantity_billed × unit_price. Contributes to the invoice total_charges.',
    `line_number` BIGINT COMMENT 'Sequential line number within the parent invoice. Used for ordering and referencing specific line items on the claim form.',
    `line_status` STRING COMMENT 'Status of this individual line item in the billing workflow. Examples: draft, ready, submitted, accepted, rejected, denied, paid. Allows line-level tracking independent of invoice status.',
    `modifier_codes` STRING COMMENT 'Two-character CPT/HCPCS modifier codes appended to the procedure or supply code to provide additional information about the service. Multiple modifiers separated by commas. Examples: LT=Left side, RT=Right side, 59=Distinct procedural service.',
    `ndc_code` STRING COMMENT 'National Drug Code for pharmaceutical supply items billed on this line. Required for drug billing under many payer contracts. Denormalized from material_master for claim submission convenience.',
    `ndc_quantity` DECIMAL(18,2) COMMENT 'Quantity in NDC units (e.g., milliliters, grams) for pharmaceutical items. May differ from quantity_billed if billing unit differs from NDC unit.',
    `ndc_unit_of_measure` STRING COMMENT 'Unit of measure for NDC quantity. Examples: ML=milliliters, GR=grams, UN=units. Required for drug billing.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by the payer for this line item. May differ from allowed_amount due to deductibles, copays, or coinsurance.',
    `quantity_billed` DECIMAL(18,2) COMMENT 'The quantity of the supply item billed on this line. Represents units consumed or implanted during the service period. Critical for reimbursement calculation.',
    `revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code indicating the type of service or accommodation for this line item. Examples: 0272=Medical/Surgical Supplies, 0278=Implants, 0636=Drugs. Required for facility billing.',
    `service_date` DATE COMMENT 'The specific date this supply item was used or implanted. May differ from the invoice service_from_date/service_through_date for multi-day encounters. Required for accurate claim adjudication.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for implantable devices billed on this line. Required for implant tracking and adverse event reporting. Denormalized from material_master for regulatory compliance.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit for this supply item on this specific invoice line. May differ from catalog price based on contract terms, patient type, or service context.',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Granular line item detail for invoice lines, supporting itemized billing and charge detail reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` (
    `study_service_coverage_id` BIGINT COMMENT 'Unique identifier for this study-service coverage record. Primary key.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to the CDM entry representing the billable service or supply item',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study for which this billing rule applies',
    `billing_notes` STRING COMMENT 'Free-text notes documenting special billing instructions, coverage rationale, or protocol-specific guidance for this service within this study. Used by billing staff during charge review.',
    `coverage_determination` STRING COMMENT 'Indicates who is responsible for payment of this service within the context of this research study. Determines billing routing and payer assignment for charges incurred during study participation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this coverage record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this coverage determination and billing rule becomes effective for this study-service combination. Supports protocol amendments that change billing policies mid-study.',
    `expiration_date` DATE COMMENT 'The date on which this coverage determination expires or was superseded by a protocol amendment. Null if currently active. Maintains billing rule version history for audit and compliance.',
    `last_updated_by` STRING COMMENT 'User ID of the person who last modified this coverage determination record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this coverage record was last modified.',
    `reimbursement_rate` DECIMAL(18,2) COMMENT 'The negotiated reimbursement rate for this CDM item within this specific research study. May differ from the standard CDM charge amount based on sponsor agreements or institutional research billing policies.',
    `sponsor_approval_date` DATE COMMENT 'Date on which the study sponsor approved this billing arrangement for this service. Required for sponsor-funded studies to document financial agreement.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates whether this service is considered standard of care (billable to insurance) versus research-only (billable to sponsor or not billable) within the context of this study protocol.',
    `vibe_placeholder` STRING COMMENT '',
    `created_by` STRING COMMENT 'User ID of the person who created this coverage determination record.',
    CONSTRAINT pk_study_service_coverage PRIMARY KEY(`study_service_coverage_id`)
) COMMENT 'Coverage determination for research study services. Tracks which services are billable to insurance vs. research sponsor per Medicare NCD and protocol.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` (
    `site_cdm_pricing_id` BIGINT COMMENT 'Unique identifier for this site-specific CDM pricing configuration record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to the care site where this CDM pricing configuration applies',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to the CDM entry being priced at this care site',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center associated with this pricing; supports financial reporting and cost allocation.',
    `fee_schedule_id` BIGINT COMMENT 'Associated payer fee schedule that governs reimbursement for this CDM item at this site.',
    `payer_contract_id` BIGINT COMMENT 'FK to the payer contract governing this site-specific price; links pricing to contractual obligations.',
    `employee_id` BIGINT COMMENT 'Finance or revenue cycle leader who approved the site-specific pricing.',
    `site_employee_id` BIGINT COMMENT 'Identifier of the revenue cycle user who last updated this site-specific pricing configuration.',
    `site_price_approved_by_employee_id` BIGINT COMMENT 'Employee who approved this site-specific price',
    `superseded_by_site_cdm_pricing_id` BIGINT COMMENT 'ID of pricing record that supersedes this one',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this CDM item is active and available for charge capture at this specific care site. A CDM entry may be active at some sites but inactive at others based on service capability.',
    `apc_weight` DECIMAL(18,2) COMMENT 'APC weight if this item is part of an outpatient APC',
    `approval_date` DATE COMMENT 'Date when the pricing was formally approved.',
    `approval_status` STRING COMMENT 'Workflow status of the pricing entry (e.g., draft, pending review, approved, expired).',
    `base_price` DECIMAL(18,2) COMMENT 'Base or standard price before site-specific adjustments',
    `benchmark_price` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for billing.site_cdm_pricing.',
    `bundled_payment_code` STRING COMMENT 'Bundled payment or episode code if applicable',
    `bundled_payment_flag` BOOLEAN COMMENT 'Flag indicating whether this item is part of a bundled payment arrangement',
    `cash_pay_discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied for self-pay/cash-pay patients at this site (0.0000-1.0000); supports financial counseling.',
    `charge_capture_method` STRING COMMENT 'Method by which charges are captured at this site (e.g., Order-based, Procedure-based, Time-based, Per Diem).',
    `chargemaster_sync_flag` BOOLEAN COMMENT 'Whether this pricing has been synced to billing system chargemaster',
    `chargemaster_sync_timestamp` TIMESTAMP COMMENT 'Timestamp when pricing was synced to chargemaster',
    `charity_care_discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied for charity care patients',
    `commercial_contracted_rate` DECIMAL(18,2) COMMENT 'Average or representative commercial contracted rate for this item at this site',
    `commercial_negotiated_rate` DECIMAL(18,2) COMMENT 'Typical commercial negotiated rate for comparison',
    `cost_basis` DECIMAL(18,2) COMMENT 'Cost basis used for pricing calculation',
    `cost_to_charge_ratio` DECIMAL(18,2) COMMENT 'Ratio of cost to charge for this item at this site, used in cost accounting and DSH calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing record was created.',
    `department_code` STRING COMMENT 'Department code for this site-specific pricing',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG weight if this item is part of an inpatient DRG',
    `effective_date` DATE COMMENT 'Date on which this site-specific CDM pricing configuration becomes effective. Supports site-specific pricing changes and rollouts.',
    `effective_margin_pct` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for billing.site_cdm_pricing.',
    `expiration_date` DATE COMMENT 'Date on which this site-specific CDM pricing configuration expires. Supports time-bound pricing agreements and service line changes.',
    `geographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Geographic practice cost index (GPCI) or other geographic adjustment factor for this site',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue posting',
    `last_price_review_date` DATE COMMENT 'Date price was last reviewed',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this site-specific CDM pricing configuration was last modified. Supports audit and change tracking.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied over cost to derive the site-specific charge, supporting price transparency compliance.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge cap for this service at this site',
    `maximum_negotiated_rate` DECIMAL(18,2) COMMENT 'Highest negotiated rate across all payer contracts for this service at this site.',
    `maximum_price` DECIMAL(18,2) COMMENT 'Maximum allowable price for this item at this site',
    `medicaid_allowable_amount` DECIMAL(18,2) COMMENT 'Medicaid allowable amount for this site',
    `medicaid_rate` DECIMAL(18,2) COMMENT 'State Medicaid reimbursement rate for this service at this site.',
    `medicare_allowable_amount` DECIMAL(18,2) COMMENT 'Medicare allowable amount for this item at this site',
    `medicare_rate` DECIMAL(18,2) COMMENT 'Medicare allowable rate for this service at this site, used as benchmark for commercial pricing.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum charge amount regardless of calculated price',
    `minimum_negotiated_rate` DECIMAL(18,2) COMMENT 'Lowest negotiated rate across all payer contracts for this service at this site, per CMS price transparency requirements.',
    `minimum_price` DECIMAL(18,2) COMMENT 'Minimum allowable price for this item at this site',
    `negotiated_rate_flag` BOOLEAN COMMENT 'Indicates this is a payer-negotiated rate rather than a gross charge; required for price transparency classification.',
    `next_price_review_date` DATE COMMENT 'Date price is scheduled for next review',
    `notes` STRING COMMENT 'Free-text notes about this site-specific pricing record for operational context.',
    `price_approval_date` DATE COMMENT 'Date price was approved',
    `price_approval_required_flag` BOOLEAN COMMENT 'Flag indicating whether price changes require approval',
    `price_change_reason` STRING COMMENT 'Reason for most recent price change',
    `price_review_status` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for billing.site_cdm_pricing.',
    `price_source` STRING COMMENT 'Source of price (internal cost accounting, payer contract, regulatory fee schedule, market survey)',
    `price_transparency_flag` BOOLEAN COMMENT 'Indicates whether this item must be published in the machine-readable file per CMS Hospital Price Transparency Rule.',
    `price_transparency_published_flag` BOOLEAN COMMENT 'Indicates whether this price has been published in the CMS-required machine-readable price transparency file.',
    `price_type` STRING COMMENT 'Type of pricing (standard, discounted, charity, self-pay)',
    `pricing_method` STRING COMMENT 'Method used to determine site-specific pricing (e.g., cost-plus, market-based, Medicare multiplier, negotiated rate).',
    `pricing_methodology` STRING COMMENT 'Methodology used to set price (cost-plus, market-based, payer-negotiated, regulatory)',
    `pricing_tier` STRING COMMENT 'Pricing tier or level (standard, discounted, charity care, self-pay, contracted rate)',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice RVU for this item',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense RVU for this item',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work RVU for this item',
    `self_pay_discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied for self-pay patients',
    `self_pay_discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage for self-pay patients',
    `self_pay_price` DECIMAL(18,2) COMMENT 'Discounted cash/self-pay price for uninsured patients, required for price transparency and No Surprises Act compliance.',
    `shoppable_service_flag` BOOLEAN COMMENT 'Indicates if this is a CMS-defined shoppable service',
    `site_adjustment_amount` DECIMAL(18,2) COMMENT 'Fixed dollar adjustment applied for this site',
    `site_adjustment_percent` DECIMAL(18,2) COMMENT 'Percentage adjustment applied for this site (positive for markup, negative for discount)',
    `site_cost_amount` DECIMAL(18,2) COMMENT 'Estimated cost to provide this service or supply at this specific care site, which may vary due to local labor costs, supply chain agreements, or operational efficiency.',
    `site_specific_cpt_code` STRING COMMENT 'CPT/HCPCS code override for this site; supports site-level coding variation for the same service.',
    `site_specific_modifier` STRING COMMENT 'Site-specific CPT/HCPCS modifier if applicable',
    `site_specific_price` DECIMAL(18,2) COMMENT 'The charge amount for this CDM item at this specific care site, which may differ from the standard CDM charge_amount due to site-specific cost structures, payer contracts, or market conditions.',
    `site_specific_revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code that may vary by site due to different service delivery models or billing requirements at this care site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing record.',
    `version_number` STRING COMMENT 'Version number of this pricing record',
    `vibe_enriched_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for billing.site_cdm_pricing.',
    `volume_discount_eligible_flag` BOOLEAN COMMENT 'Whether this CDM item qualifies for volume-based pricing adjustments at this site.',
    `volume_discount_tier` STRING COMMENT 'Volume discount tier if applicable (e.g., high-volume site receives lower unit cost)',
    `site_id` BIGINT COMMENT 'site for which pricing applies',
    `price_amount` DECIMAL(18,2) COMMENT 'site-specific price amount',
    `currency_code` STRING COMMENT 'currency of the price',
    `price_status` STRING COMMENT 'active|pending|retired',
    CONSTRAINT pk_site_cdm_pricing PRIMARY KEY(`site_cdm_pricing_id`)
) COMMENT 'Site-specific chargemaster pricing: re-derived from business context to capture facility-level price variation, payer-contracted rates, transparency/shoppable-service disclosure (CMS price transparency), RVU/DRG/APC weighting, cost-to-charge ratios, approval governance, and versioned supersession for multi-facility health systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` (
    `billing_network_participation_id` BIGINT COMMENT 'Primary key for billing network participation record.',
    `care_site_id` BIGINT COMMENT 'FK to the care site.',
    `clinician_id` BIGINT COMMENT 'FK to the provider clinician.',
    `fee_schedule_id` BIGINT COMMENT 'FK to the fee schedule governing reimbursement.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `org_provider_id` BIGINT COMMENT 'FK to the organizational provider.',
    `payer_id` BIGINT COMMENT 'FK to the payer.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Whether provider is accepting new patients under this network.',
    `contract_number` STRING COMMENT 'Payer contract number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_status` STRING COMMENT 'Credentialing status with this payer.',
    `effective_date` DATE COMMENT 'Date participation becomes effective.',
    `merged_with_insurance_network_participation` STRING COMMENT 'Superseded by insurance.network_participation (participant_type discriminator)',
    `network_status` STRING COMMENT 'Current network participation status (in_network, out_of_network, pending).',
    `npi` STRING COMMENT 'National Provider Identifier.',
    `par_flag` BOOLEAN COMMENT 'Participating provider flag.',
    `participant_type` STRING COMMENT 'Type of participant (individual_provider, group, facility).',
    `ssot_canonical_reference` STRING COMMENT 'Canonical SSOT table: insurance.network_participation',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT reconciliation: consolidated into insurance.network_participation via participant_type',
    `tax_identification_number` STRING COMMENT 'Tax identification number for billing.',
    `termination_date` DATE COMMENT 'Date participation terminates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_billing_network_participation PRIMARY KEY(`billing_network_participation_id`)
) COMMENT 'Provider participation in payer networks for billing purposes. Tracks network status, effective dates, and contracted rates. [SSOT: consolidated into insurance.network_participation with participant_type discriminator; retained as deprecated alias.]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_collection_account_id` FOREIGN KEY (`collection_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`collection_account`(`collection_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_collection_account_id` FOREIGN KEY (`collection_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`collection_account`(`collection_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_original_write_off_id` FOREIGN KEY (`original_write_off_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`write_off`(`write_off_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_original_refund_id` FOREIGN KEY (`original_refund_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`refund`(`refund_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ADD CONSTRAINT `fk_billing_invoice_coverage_billing_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ADD CONSTRAINT `fk_billing_invoice_coverage_billing_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ADD CONSTRAINT `fk_billing_invoice_line_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ADD CONSTRAINT `fk_billing_study_service_coverage_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_superseded_by_site_cdm_pricing_id` FOREIGN KEY (`superseded_by_site_cdm_pricing_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`site_cdm_pricing`(`site_cdm_pricing_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('pii_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_core' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Billing Coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `case_cart_id` SET TAGS ('pii_business_glossary_term' = 'Case Cart');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `fulfillment_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `original_charge_id` SET TAGS ('pii_business_glossary_term' = 'Original Charge');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('pii_business_glossary_term' = 'Prescription');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Charge Clinician');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_category` SET TAGS ('pii_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_number` SET TAGS ('pii_business_glossary_term' = 'Charge Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_status` SET TAGS ('pii_business_glossary_term' = 'Charge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('pii_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_code` SET TAGS ('pii_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `correction_reason` SET TAGS ('pii_business_glossary_term' = 'Correction Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('pii_business_glossary_term' = 'Expected Reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `gross_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_date` SET TAGS ('pii_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `implant_flag` SET TAGS ('pii_business_glossary_term' = 'Implant Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_billable` SET TAGS ('pii_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_corrected` SET TAGS ('pii_business_glossary_term' = 'Is Corrected');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('pii_business_glossary_term' = 'Is Patient Responsible');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_voided` SET TAGS ('pii_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity_used` SET TAGS ('pii_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `released_date` SET TAGS ('pii_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_end_time` SET TAGS ('pii_business_glossary_term' = 'Service End Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_start_time` SET TAGS ('pii_business_glossary_term' = 'Service Start Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_date` SET TAGS ('pii_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_reason` SET TAGS ('pii_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `waste_flag` SET TAGS ('pii_business_glossary_term' = 'Waste Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_pricing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'CDM Entry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `apc_code` SET TAGS ('pii_business_glossary_term' = 'APC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `bundled_payment_flag` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_code` SET TAGS ('pii_business_glossary_term' = 'CDM Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_description` SET TAGS ('pii_business_glossary_term' = 'CDM Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_capture_method` SET TAGS ('pii_business_glossary_term' = 'Charge Capture Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_category` SET TAGS ('pii_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `default_quantity` SET TAGS ('pii_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `item_type` SET TAGS ('pii_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_price_update_date` SET TAGS ('pii_business_glossary_term' = 'Last Price Update Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `price_transparency_flag` SET TAGS ('pii_business_glossary_term' = 'Price Transparency Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `requires_authorization_flag` SET TAGS ('pii_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_malpractice` SET TAGS ('pii_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_practice_expense` SET TAGS ('pii_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_work` SET TAGS ('pii_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `short_description` SET TAGS ('pii_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `taxable_flag` SET TAGS ('pii_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `type_of_bill_code` SET TAGS ('pii_business_glossary_term' = 'Type of Bill Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_core' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'AR Account');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Log');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Org Provider');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `provider_location_id` SET TAGS ('pii_business_glossary_term' = 'Provider Location');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `tertiary_payer_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_source_code` SET TAGS ('pii_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_type_code` SET TAGS ('pii_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_amount` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_date` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bill_type_code` SET TAGS ('pii_business_glossary_term' = 'Bill Type Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `contractual_adjustment` SET TAGS ('pii_business_glossary_term' = 'Contractual Adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `covered_charges` SET TAGS ('pii_business_glossary_term' = 'Covered Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('pii_business_glossary_term' = 'Discharge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('pii_business_glossary_term' = 'Form Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('pii_business_glossary_term' = 'Insurance Payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('pii_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `non_covered_charges` SET TAGS ('pii_business_glossary_term' = 'Non-Covered Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('pii_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('pii_business_glossary_term' = 'Patient Payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_through_date` SET TAGS ('pii_business_glossary_term' = 'Service Through Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `statement_date` SET TAGS ('pii_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `total_charges` SET TAGS ('pii_business_glossary_term' = 'Total Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_detail' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `adjudicated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjudicated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_group_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_quantity` SET TAGS ('pii_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_timestamp` SET TAGS ('pii_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_malpractice` SET TAGS ('pii_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_practice_expense` SET TAGS ('pii_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_work` SET TAGS ('pii_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_location_code` SET TAGS ('pii_business_glossary_term' = 'Service Location Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `units` SET TAGS ('pii_business_glossary_term' = 'Units');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_coding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Coding Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'CDA Document');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Principal Procedure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_source_code` SET TAGS ('pii_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_type_code` SET TAGS ('pii_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('pii_business_glossary_term' = 'Arithmetic Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `audit_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_drg_impact_amount` SET TAGS ('pii_business_glossary_term' = 'CDI DRG Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_physician_response` SET TAGS ('pii_business_glossary_term' = 'CDI Physician Response');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_date` SET TAGS ('pii_business_glossary_term' = 'CDI Query Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_topic` SET TAGS ('pii_business_glossary_term' = 'CDI Query Topic');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_type` SET TAGS ('pii_business_glossary_term' = 'CDI Query Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_date` SET TAGS ('pii_business_glossary_term' = 'CDI Response Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('pii_business_glossary_term' = 'CDI Response Deadline');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_resulting_code_change` SET TAGS ('pii_business_glossary_term' = 'CDI Resulting Code Change');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_accuracy_score` SET TAGS ('pii_business_glossary_term' = 'Coding Accuracy Score');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_date` SET TAGS ('pii_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_method` SET TAGS ('pii_business_glossary_term' = 'Coding Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_status` SET TAGS ('pii_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('pii_business_glossary_term' = 'Complication Comorbidity Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `discharge_disposition_code` SET TAGS ('pii_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('pii_business_glossary_term' = 'Expected Reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_business_glossary_term' = 'Geometric Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `grouper_version` SET TAGS ('pii_business_glossary_term' = 'Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `hcpcs_codes` SET TAGS ('pii_business_glossary_term' = 'HCPCS Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `major_complication_comorbidity_flag` SET TAGS ('pii_business_glossary_term' = 'Major Complication Comorbidity Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_code` SET TAGS ('pii_business_glossary_term' = 'MDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_description` SET TAGS ('pii_business_glossary_term' = 'MDC Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `outlier_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Outlier Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `present_on_admission_indicators` SET TAGS ('pii_business_glossary_term' = 'Present on Admission Indicators');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Diagnosis Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Procedure Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_core' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('pii_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `direct_message_id` SET TAGS ('pii_business_glossary_term' = 'Notification Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Payer Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Posted By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `remittance_id` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('pii_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('pii_business_glossary_term' = 'Payment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('pii_value_regex' = 'copay|coinsurance|deductible|full_payment|partial_payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('pii_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('pii_value_regex' = 'web_portal|mobile_app|mail|in_person|phone|lockbox');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('pii_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('pii_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('pii_business_glossary_term' = 'Deposit Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `era_file_reference` SET TAGS ('pii_business_glossary_term' = 'Electronic Remittance Advice (ERA) File Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('pii_business_glossary_term' = 'Lockbox Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'eft|check|credit_card|debit_card|cash|wire_transfer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('pii_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('pii_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('pii_value_regex' = 'pending|posted|applied|reversed|refunded|voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('pii_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('pii_value_regex' = 'standard|prepayment|overpayment|adjustment|settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('pii_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('pii_value_regex' = 'unposted|posted|partially_applied|fully_applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_date` SET TAGS ('pii_business_glossary_term' = 'Refund Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_flag` SET TAGS ('pii_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('pii_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'insurance|patient|guarantor|third_party|government|charity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('pii_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `charity_care_application_id` SET TAGS ('pii_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `collection_account_id` SET TAGS ('pii_business_glossary_term' = 'Collection Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('pii_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `rac_audit_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `restriction_request_id` SET TAGS ('pii_business_glossary_term' = 'Consent Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `sanction_id` SET TAGS ('pii_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `tertiary_adjustment_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `tertiary_adjustment_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `tertiary_adjustment_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('pii_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('pii_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('pii_value_regex' = 'pending|posted|approved|reversed|voided|reconciled');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `appeal_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `authorization_code` SET TAGS ('pii_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `bad_debt_referral_date` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('pii_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('pii_value_regex' = 'contractual|non_contractual|write_off|charity|discount|recoupment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contract_rate` SET TAGS ('pii_business_glossary_term' = 'Contract Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contract_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('pii_business_glossary_term' = 'Contractual Payer Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('pii_business_glossary_term' = 'Electronic Remittance Advice (ERA) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'unreconciled|reconciled|disputed|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('pii_business_glossary_term' = 'Write-Off Classification');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('pii_value_regex' = 'bad_debt|charity_care|small_balance|rac_recoupment|administrative|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Primary Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `charity_care_application_id` SET TAGS ('pii_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `primary_patient_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Primary Patient Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `primary_patient_mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `primary_patient_mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_balance` SET TAGS ('pii_business_glossary_term' = 'Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_closed_date` SET TAGS ('pii_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('pii_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_opened_date` SET TAGS ('pii_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('pii_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('pii_value_regex' = 'open|closed|collections|bad_debt|charity|pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_type` SET TAGS ('pii_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_amount` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_flag` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_write_off_date` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_date` SET TAGS ('pii_business_glossary_term' = 'Collection Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_reason` SET TAGS ('pii_business_glossary_term' = 'Collection Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_referral_date` SET TAGS ('pii_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'not_in_collections|referred|active|recalled|resolved|legal_action');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `days_outstanding` SET TAGS ('pii_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `family_size` SET TAGS ('pii_business_glossary_term' = 'Family Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_application_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_application_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|expired|revoked');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_effective_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_effective_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('pii_value_regex' = 'not_evaluated|eligible|ineligible|pending|approved|denied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('pii_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('pii_business_glossary_term' = 'Insurance Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `irs_501r_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'IRS 501(r) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_statement_date` SET TAGS ('pii_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `original_balance` SET TAGS ('pii_business_glossary_term' = 'Original Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('pii_business_glossary_term' = 'Patient Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `recovered_amount` SET TAGS ('pii_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `referred_balance` SET TAGS ('pii_business_glossary_term' = 'Referred Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_adjustments` SET TAGS ('pii_business_glossary_term' = 'Total Adjustments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_payments` SET TAGS ('pii_business_glossary_term' = 'Total Payments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_business_glossary_term' = 'Statement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_id` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `adjustments_applied` SET TAGS ('pii_business_glossary_term' = 'Adjustments Applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('pii_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('pii_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('pii_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('pii_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('pii_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('pii_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('pii_value_regex' = 'none|pending|active|legal|bad_debt|write_off');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `current_charges` SET TAGS ('pii_business_glossary_term' = 'Current Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `cycle` SET TAGS ('pii_business_glossary_term' = 'Statement Cycle');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'mail|email|portal|sms|fax');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'pending|sent|delivered|failed|returned|bounced');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `financial_assistance_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `financial_assistance_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('pii_business_glossary_term' = 'Insurance Pending Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `message` SET TAGS ('pii_business_glossary_term' = 'Statement Message');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `minimum_payment_due` SET TAGS ('pii_business_glossary_term' = 'Minimum Payment Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payments_received` SET TAGS ('pii_business_glossary_term' = 'Payments Received');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `previous_balance` SET TAGS ('pii_business_glossary_term' = 'Previous Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_date` SET TAGS ('pii_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_flag` SET TAGS ('pii_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_reason` SET TAGS ('pii_business_glossary_term' = 'Returned Mail Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('pii_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_number` SET TAGS ('pii_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('pii_business_glossary_term' = 'Statement Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('pii_value_regex' = 'paper|electronic|portal|email|sms');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_flag` SET TAGS ('pii_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('pii_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `total_balance_due` SET TAGS ('pii_business_glossary_term' = 'Total Balance Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_collections' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_id` SET TAGS ('pii_business_glossary_term' = 'Collection Account Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `aging_days` SET TAGS ('pii_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `closed_date` SET TAGS ('pii_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_number` SET TAGS ('pii_business_glossary_term' = 'Collection Account Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_agency_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Collection Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_notes` SET TAGS ('pii_business_glossary_term' = 'Collection Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_status` SET TAGS ('pii_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_type` SET TAGS ('pii_business_glossary_term' = 'Collection Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_type` SET TAGS ('pii_value_regex' = 'internal|external|legal|pre_collection|bad_debt');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Contact Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `interest_amount` SET TAGS ('pii_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `judgment_amount` SET TAGS ('pii_business_glossary_term' = 'Judgment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_date` SET TAGS ('pii_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('pii_business_glossary_term' = 'Last Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('pii_value_regex' = 'phone|mail|email|sms|in_person|portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `legal_action_date` SET TAGS ('pii_business_glossary_term' = 'Legal Action Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `legal_action_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `monthly_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Monthly Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `outstanding_balance` SET TAGS ('pii_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_end_date` SET TAGS ('pii_business_glossary_term' = 'Payment Plan End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_start_date` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `principal_amount` SET TAGS ('pii_business_glossary_term' = 'Principal Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recall_date` SET TAGS ('pii_business_glossary_term' = 'Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recall_reason` SET TAGS ('pii_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recovered_amount` SET TAGS ('pii_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referral_date` SET TAGS ('pii_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referral_reason` SET TAGS ('pii_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referred_balance` SET TAGS ('pii_business_glossary_term' = 'Referred Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_amount` SET TAGS ('pii_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_date` SET TAGS ('pii_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_flag` SET TAGS ('pii_business_glossary_term' = 'Settlement Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_reason` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_subdomain' = 'coverage_compliance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_insurance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_role' = 'superseded');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_superseded_by' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_resolution' = 'consolidate_to_canonical');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_subscriber_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber MPI Record ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_subscriber_mpi_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_subscriber_mpi_record_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_ssot_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Coverage Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `bin_number` SET TAGS ('pii_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `cob_priority` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits Priority');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('pii_value_regex' = 'Primary|Secondary|Tertiary');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Suspended|Terminated|Pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_type` SET TAGS ('pii_value_regex' = 'Medical|Dental|Vision|Pharmacy|Behavioral Health|Long-Term Care');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `eligibility_last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Eligibility Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `eligibility_verification_count` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `eligibility_verification_status` SET TAGS ('pii_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_name` SET TAGS ('pii_business_glossary_term' = 'Employer Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `enrollment_effective_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `enrollment_termination_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_date` SET TAGS ('pii_business_glossary_term' = 'Last Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_method` SET TAGS ('pii_business_glossary_term' = 'Last Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_method` SET TAGS ('pii_value_regex' = 'Real-Time 270/271|Manual|Batch|Portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_status` SET TAGS ('pii_business_glossary_term' = 'Last Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_status` SET TAGS ('pii_value_regex' = 'Verified Active|Verified Inactive|Verification Failed|Pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `merged_with_patient_patient_coverage` SET TAGS ('pii_ssot_merge' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `merged_with_patient_patient_coverage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `merged_with_patient_patient_coverage` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `network_status` SET TAGS ('pii_value_regex' = 'In-Network|Out-of-Network|Both');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_response_code` SET TAGS ('pii_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_response_message` SET TAGS ('pii_business_glossary_term' = 'Payer Response Message');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `pcn_number` SET TAGS ('pii_business_glossary_term' = 'Processor Control Number (PCN)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `plan_year_end_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `plan_year_start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `policy_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `policy_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `referral_required_flag` SET TAGS ('pii_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `rx_group_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Group Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `rx_group_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_ssot_status' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_value_regex' = 'Self|Spouse|Child|Other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `verification_source_system` SET TAGS ('pii_business_glossary_term' = 'Verification Source System');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('pii_business_glossary_term' = 'Write-Off Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `charity_care_application_id` SET TAGS ('pii_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `collection_account_id` SET TAGS ('pii_business_glossary_term' = 'Collection Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `drg_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `financial_assistance_id` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `financial_assistance_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `original_write_off_id` SET TAGS ('pii_business_glossary_term' = 'Original Write-Off Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approving User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `rac_audit_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `restriction_request_id` SET TAGS ('pii_business_glossary_term' = 'Consent Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `bad_debt_referral_date` SET TAGS ('pii_business_glossary_term' = 'Bad Debt Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('pii_business_glossary_term' = 'Write-Off Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('pii_value_regex' = 'patient_responsibility|insurance_denial|uncompensated_care|policy_adjustment|audit_adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `discount_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Write-Off Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `original_balance` SET TAGS ('pii_business_glossary_term' = 'Original Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `remaining_balance` SET TAGS ('pii_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('pii_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_flag` SET TAGS ('pii_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('pii_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('pii_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('pii_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('pii_value_regex' = 'pending|approved|posted|reversed|under_review');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('pii_business_glossary_term' = 'Write-Off Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('pii_value_regex' = 'bad_debt|charity_care|small_balance|administrative|rac_recoupment|contractual_dispute');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_patient_financial_services' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_flag` SET TAGS ('pii_business_glossary_term' = 'Agreement Signed Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `auto_pay_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Pay Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_date` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_date` SET TAGS ('pii_business_glossary_term' = 'Default Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_reason` SET TAGS ('pii_business_glossary_term' = 'Default Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('pii_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('pii_value_regex' = 'patient_portal|phone|in_person|mail|email|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `finance_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Finance Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `financial_assistance_program_code` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Program Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `financial_assistance_program_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('pii_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('pii_business_glossary_term' = 'Installment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('pii_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('pii_value_regex' = 'weekly|biweekly|monthly|quarterly|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_paid` SET TAGS ('pii_business_glossary_term' = 'Installments Paid');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_remaining` SET TAGS ('pii_business_glossary_term' = 'Installments Remaining');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_date` SET TAGS ('pii_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `missed_payments_count` SET TAGS ('pii_business_glossary_term' = 'Missed Payments Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `next_payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `number_of_installments` SET TAGS ('pii_business_glossary_term' = 'Number of Installments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `original_balance_amount` SET TAGS ('pii_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'credit_card|debit_card|ach|check|cash|money_order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'pending|active|completed|defaulted|cancelled|suspended');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'standard|interest_free|hardship|extended|short_term|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `remaining_balance_amount` SET TAGS ('pii_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('pii_business_glossary_term' = 'Total Payment Plan Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_subdomain' = 'coverage_compliance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `rac_audit_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Reviewer User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'Response Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_decision_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_level` SET TAGS ('pii_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_level` SET TAGS ('pii_value_regex' = 'redetermination|reconsideration|alj_hearing|mac_review|federal_court');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_outcome_amount` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'pending|upheld|overturned|partially_favorable|withdrawn|dismissed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_request_date` SET TAGS ('pii_business_glossary_term' = 'Audit Request Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `compliance_resolution_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `compliance_resolution_status` SET TAGS ('pii_value_regex' = 'open|corrective_action_plan_submitted|corrective_action_implemented|validated|closed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Contractor Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('pii_business_glossary_term' = 'Audit Contractor Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `corrective_action_plan_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_flag` SET TAGS ('pii_business_glossary_term' = 'Extrapolation Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_sample_size` SET TAGS ('pii_business_glossary_term' = 'Extrapolation Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_universe_size` SET TAGS ('pii_business_glossary_term' = 'Extrapolation Universe Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `finding_amount` SET TAGS ('pii_business_glossary_term' = 'Finding Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `findings_issued_date` SET TAGS ('pii_business_glossary_term' = 'Findings Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `interest_amount` SET TAGS ('pii_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `overpayment_amount` SET TAGS ('pii_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `records_requested_count` SET TAGS ('pii_business_glossary_term' = 'Records Requested Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `records_submitted_count` SET TAGS ('pii_business_glossary_term' = 'Records Submitted Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_amount` SET TAGS ('pii_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_date` SET TAGS ('pii_business_glossary_term' = 'Recoupment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_method` SET TAGS ('pii_business_glossary_term' = 'Recoupment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_method` SET TAGS ('pii_value_regex' = 'offset|direct_payment|installment_plan|settlement|waived');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `response_due_date` SET TAGS ('pii_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `response_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `underpayment_amount` SET TAGS ('pii_business_glossary_term' = 'Underpayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_subdomain' = 'coverage_compliance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_patient_financial_services' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `charity_care_application_id` SET TAGS ('pii_business_glossary_term' = 'Charity Care Application ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_method` SET TAGS ('pii_business_glossary_term' = 'Application Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_method` SET TAGS ('pii_value_regex' = 'online_portal|paper_form|phone|in_person|mail|fax');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_source` SET TAGS ('pii_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_source` SET TAGS ('pii_value_regex' = 'patient_initiated|staff_initiated|screening_tool|presumptive_eligibility|third_party');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|conditional');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approved_discount_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `coverage_period_months` SET TAGS ('pii_business_glossary_term' = 'Coverage Period Months');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_status` SET TAGS ('pii_business_glossary_term' = 'Documentation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_status` SET TAGS ('pii_value_regex' = 'not_submitted|submitted|verified|incomplete|rejected');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_type` SET TAGS ('pii_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `family_size` SET TAGS ('pii_business_glossary_term' = 'Family Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fap_notification_date` SET TAGS ('pii_business_glossary_term' = 'Financial Assistance Policy (FAP) Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fpl_percentage` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('pii_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `irs_501r_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'IRS 501(r) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_application_date` SET TAGS ('pii_business_glossary_term' = 'Medicaid Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_application_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_pending_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Pending Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_pending_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `plain_language_summary_provided_flag` SET TAGS ('pii_business_glossary_term' = 'Plain Language Summary Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `presumptive_eligibility_basis` SET TAGS ('pii_business_glossary_term' = 'Presumptive Eligibility Basis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `presumptive_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Presumptive Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `program_type` SET TAGS ('pii_value_regex' = 'full_charity|partial_charity|sliding_scale|medicaid_presumptive|emergency_medicaid|prompt_pay_discount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `screening_score` SET TAGS ('pii_business_glossary_term' = 'Screening Score');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_subdomain' = 'revenue_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_id` SET TAGS ('pii_business_glossary_term' = 'Refund Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `demographics_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `guarantor_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `guarantor_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_refund_id` SET TAGS ('pii_business_glossary_term' = 'Original Refund Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_refund_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('pii_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `quaternary_refund_voided_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Voided By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `quaternary_refund_voided_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `quaternary_refund_voided_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `rac_audit_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `tertiary_refund_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `tertiary_refund_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `tertiary_refund_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `amount` SET TAGS ('pii_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Refund Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_category` SET TAGS ('pii_business_glossary_term' = 'Refund Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_category` SET TAGS ('pii_value_regex' = 'overpayment|duplicate|credit_balance|rac_ordered|patient_request|payer_request');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cleared_date` SET TAGS ('pii_business_glossary_term' = 'Refund Cleared Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cms_credit_balance_report_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Credit Balance Report Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cms_credit_balance_report_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cms_report_date` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('pii_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('pii_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `disbursement_date` SET TAGS ('pii_business_glossary_term' = 'Refund Disbursement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Refund Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'check|eft|wire|credit_card_reversal|cash|offset');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Refund Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Original Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('pii_business_glossary_term' = 'Payee Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('pii_business_glossary_term' = 'Payee Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('pii_business_glossary_term' = 'Payee City');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('pii_business_glossary_term' = 'Payee Country Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('pii_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('pii_business_glossary_term' = 'Payee Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('pii_business_glossary_term' = 'Payee State');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|reconciled|unreconciled|exception');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_number` SET TAGS ('pii_business_glossary_term' = 'Refund Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_status` SET TAGS ('pii_business_glossary_term' = 'Refund Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('pii_business_glossary_term' = 'Refund Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('pii_value_regex' = 'patient|guarantor|payer|vendor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Refund Request Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_date` SET TAGS ('pii_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_flag` SET TAGS ('pii_business_glossary_term' = 'Void Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_reason` SET TAGS ('pii_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_association_edges' = 'billing.invoice,billing.coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_insurance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `invoice_coverage_billing_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Coverage Billing - Invoice Coverage Billing Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `billing_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Coverage Billing - Coverage Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Coverage Billing - Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `adjudication_date` SET TAGS ('pii_business_glossary_term' = 'Claim Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `check_eft_number` SET TAGS ('pii_business_glossary_term' = 'Check or EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('pii_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `contractual_adjustment` SET TAGS ('pii_business_glossary_term' = 'Contractual Adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `coverage_status_at_billing` SET TAGS ('pii_business_glossary_term' = 'Coverage Status at Billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Claim Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Claim Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `patient_responsibility` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `remittance_advice_number` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `submitted_amount` SET TAGS ('pii_business_glossary_term' = 'Submitted Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_subdomain' = 'patient_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_association_edges' = 'billing.invoice,supply.material_master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_detail' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `invoice_line_item_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line Item Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line Item - Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Invoice Line Item - Material Master Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `hcpcs_code` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `hcpcs_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `line_amount` SET TAGS ('pii_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `modifier_codes` SET TAGS ('pii_business_glossary_term' = 'Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `ndc_quantity` SET TAGS ('pii_business_glossary_term' = 'NDC Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `ndc_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'NDC Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `quantity_billed` SET TAGS ('pii_business_glossary_term' = 'Quantity Billed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `udi` SET TAGS ('pii_business_glossary_term' = 'Unique Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_subdomain' = 'coverage_compliance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_association_edges' = 'billing.cdm_entry,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_transactional' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_research' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `study_service_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Study Service Coverage Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'Study Service Coverage - Cdm Entry Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Study Service Coverage - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `billing_notes` SET TAGS ('pii_business_glossary_term' = 'Study Service Billing Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `coverage_determination` SET TAGS ('pii_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `reimbursement_rate` SET TAGS ('pii_business_glossary_term' = 'Study-Specific Reimbursement Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `reimbursement_rate` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `sponsor_approval_date` SET TAGS ('pii_business_glossary_term' = 'Sponsor Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `standard_of_care_flag` SET TAGS ('pii_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_association_edges' = 'billing.cdm_entry,facility.care_site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_pricing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_cdm_pricing_id` SET TAGS ('pii_business_glossary_term' = 'Site CDM Pricing Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Site Cdm Pricing - Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'Site Cdm Pricing - Cdm Entry Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_employee_id` SET TAGS ('pii_business_glossary_term' = 'Configuration Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_price_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_price_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Site Activation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `cost_to_charge_ratio` SET TAGS ('pii_business_glossary_term' = 'Cost-to-Charge Ratio');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Site Configuration Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Site Configuration Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Configuration Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `markup_percentage` SET TAGS ('pii_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `maximum_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `maximum_negotiated_rate` SET TAGS ('pii_business_glossary_term' = 'Maximum Negotiated Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `medicaid_rate` SET TAGS ('pii_business_glossary_term' = 'Medicaid Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `medicare_rate` SET TAGS ('pii_business_glossary_term' = 'Medicare Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `minimum_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `minimum_negotiated_rate` SET TAGS ('pii_business_glossary_term' = 'Minimum Negotiated Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_transparency_flag` SET TAGS ('pii_business_glossary_term' = 'Price Transparency Required');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_type` SET TAGS ('pii_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `pricing_method` SET TAGS ('pii_business_glossary_term' = 'Pricing Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `self_pay_price` SET TAGS ('pii_business_glossary_term' = 'Self-Pay Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `shoppable_service_flag` SET TAGS ('pii_business_glossary_term' = 'Shoppable Service');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Site-Specific Cost');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_specific_price` SET TAGS ('pii_business_glossary_term' = 'Site-Specific Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_specific_revenue_code` SET TAGS ('pii_business_glossary_term' = 'Site-Specific Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `volume_discount_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Volume Discount Eligible');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_amount` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_amount` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `currency_code` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `currency_code` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_status` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `price_status` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_subdomain' = 'coverage_compliance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_revenue_cycle' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_insurance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_vibe_billing_domain' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_deprecated_merged_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_participant_type' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_vreq' = 'VREQ-029');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `merged_with_insurance_network_participation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `merged_with_insurance_network_participation` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_pii' = 'true');
