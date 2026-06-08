-- Schema for Domain: laboratory | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Primary key for lab_order',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Lab orders are frequently scheduled appointments (fasting blood work, timed specimen collection). Enables appointment-based lab workflow, no-show reconciliation, and collection verification. Standard ',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Care plans include lab monitoring requirements (e.g., quarterly INR for anticoagulation, HbA1c for diabetes management). Linking lab orders to care plans supports population health management, chronic',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Lab orders are the source documents for laboratory claims in revenue cycle management. Each lab order generates billable claim lines with procedure codes. Essential for charge capture, claim reconcili',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: CPOE order traceability: lab_order is the laboratory execution of a clinical_order. Linking them enables result reconciliation, order completion tracking, and regulatory audit trails (CMS, Joint Commi',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: CLIA and state regulations require traceable informed consent for genetic panels, HIV testing, and research specimens. lab_order.consent_reference_id links the specific order to the documented consent',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Lab orders must be validated against the payers coverage policy to determine medical necessity, PA requirements, and covered diagnoses. Revenue cycle and prior authorization workflows require knowing',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient for whom the laboratory test was ordered. Links to the patient master data.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Lab orders require structured ICD-10 linkage for clinical indication validation, medical necessity determination, billing compliance, and quality measure reporting. The diagnosis_code text field shoul',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Lab orders are placed to confirm, monitor, or rule out specific diagnoses (e.g., HbA1c for diabetes, CBC for anemia). This link supports CDI workflows, clinical decision support, and quality measure r',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Specific health plan determines coverage policies, prior authorization requirements, and fee schedules for lab services. Utilization management and authorization workflows require plan-level rules, no',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Lab orders often specify required reagent kits or test consumables for supply chain fulfillment and charge capture. Healthcare operations track which material items are consumed per order for cost acc',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Lab orders require payer identification for prior authorization determination, coverage verification, and billing submission. Revenue cycle operations depend on knowing which payer will adjudicate the',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Lab order routing and workload reporting require knowing which care site performs the test. CLIA compliance and payer billing require the performing facility. performing_lab_location is a denormalized',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Send-out lab billing, reference lab routing, and payer authorization require the performing lab as a structured org_provider entity. performing_lab_location is a denormalized text field; replacing w',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider (physician, nurse practitioner, physician assistant) who ordered the laboratory test via CPOE (Computerized Physician Order Entry).',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: lab_order already carries authorization_number and authorization_required fields, confirming PA workflows exist. Linking to the specific prior_auth_rule that triggered the PA requirement supports deni',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Lab orders must comply with regulatory programs (CLIA, CAP accreditation). Healthcare operations require tracking which compliance program governs each test order for regulatory reporting and audit tr',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Send-out lab orders are fulfilled by reference laboratories under vendor contracts. Contract compliance reporting, GPO pricing validation, and reference lab performance management require linking send',
    `set_id` BIGINT COMMENT 'Foreign key linking to order.set. Business justification: Order set compliance reporting: lab_order has plain order_set_name text, a denormalized reference to the order set. FK to order.set enables order set adherence analytics, evidence-based protocol com',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider who cancelled or discontinued the laboratory order. Used for audit trail and accountability.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Lab orders request specific catalog tests. Currently lab_order has test_code/test_name/test_category but no FK. Business reality: orders reference catalog tests for what to perform. Adding test_catalo',
    `triage_assessment_id` BIGINT COMMENT 'Foreign key linking to encounter.triage_assessment. Business justification: ED triage-driven lab ordering: stat lab orders placed during triage (sepsis protocol, trauma activation, stroke alert) must reference the triggering triage assessment for ED throughput metrics, sepsis',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter or visit during which the laboratory order was placed. Links to the visit/encounter record.',
    `authorization_number` STRING COMMENT 'Authorization or pre-certification number obtained from the insurance payer approving coverage for this laboratory test. Required for claim submission when authorization_required is True.',
    `authorization_required` BOOLEAN COMMENT 'Boolean flag indicating whether payer prior authorization is required before performing this laboratory test. True for high-cost or specialized tests that require pre-approval for reimbursement.',
    `billing_code` STRING COMMENT 'CPT or HCPCS (Healthcare Common Procedure Coding System) code used for billing and reimbursement of the laboratory test. Links laboratory orders to revenue cycle and supports charge capture.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason why the laboratory order was cancelled. Examples: duplicate order, ordered in error, patient refused, specimen quality insufficient, test no longer clinically indicated. Used for quality improvement and utilization review.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory order was cancelled or discontinued. Populated only when order_status is cancelled or discontinued.',
    `clinical_indication` STRING COMMENT 'Free-text clinical reason or diagnosis justifying the laboratory order. Provides context for medical necessity, supports appropriate utilization, and may be required for insurance authorization and reimbursement.',
    `collection_date` DATE COMMENT 'Calendar date when the specimen was collected from the patient. May differ from order date for scheduled or delayed collections.',
    `collection_method` STRING COMMENT 'Technique or procedure used to collect the specimen. Examples: venipuncture, capillary stick, clean catch, catheterized, biopsy. Affects specimen quality and test validity.',
    `collection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the specimen was collected from the patient. Critical for time-sensitive tests and stability calculations. Used as the start point for laboratory turnaround time measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this laboratory order record was first created in the data lakehouse. Audit field for data lineage and record lifecycle tracking.',
    `expected_turnaround_time_hours` STRING COMMENT 'Expected number of hours from specimen collection to result availability, based on test type and performing laboratory. Used for result expectation management and delay identification. For send-out orders, includes shipping and reference lab processing time.',
    `fasting_required` BOOLEAN COMMENT 'Boolean flag indicating whether the patient must fast prior to specimen collection for accurate test results. True for tests such as fasting glucose, lipid panel. Used for patient preparation instructions.',
    `is_send_out` BOOLEAN COMMENT 'Boolean flag indicating whether this laboratory order is sent to an external reference laboratory for testing (True) or performed internally (False). Send-out orders require additional tracking for shipping and result receipt.',
    `order_date` DATE COMMENT 'Calendar date when the laboratory order was placed by the ordering provider via CPOE (Computerized Physician Order Entry). Used for turnaround time calculations and operational metrics.',
    `order_number` STRING COMMENT 'The externally-known unique order number or accession number assigned to this laboratory order by the LIS (Laboratory Information System) such as Epic Beaker or Cerner PathNet. Used for tracking and reference across systems.',
    `order_priority` STRING COMMENT 'Clinical priority level assigned to the laboratory order. STAT indicates immediate/emergency processing, routine for standard turnaround, ASAP for expedited but not emergency, timed for specific collection time requirements, urgent for high-priority processing.. Valid values are `STAT|routine|ASAP|timed|urgent`',
    `order_status` STRING COMMENT 'Current lifecycle status of the laboratory order. Tracks progression from order placement through specimen collection, processing, and result delivery. For send-out orders, includes sent_out status when specimen is shipped to reference laboratory. [ENUM-REF-CANDIDATE: ordered|collected|in_process|sent_out|resulted|cancelled|discontinued|on_hold — 8 candidates stripped; promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory order was electronically placed in the system. The principal business event timestamp for this transaction. Critical for STAT order tracking and turnaround time analysis.',
    `point_of_care_test` BOOLEAN COMMENT 'Boolean flag indicating whether this is a point-of-care test performed at or near the patient location (bedside, clinic exam room, emergency department) rather than in the central laboratory. Examples: glucose meter, rapid strep test, blood gas analyzer.',
    `reference_lab_accession_number` STRING COMMENT 'Unique accession or tracking number assigned by the external reference laboratory to this specimen. Used for result reconciliation and inquiry. Populated only for send-out orders.',
    `result_integration_status` STRING COMMENT 'Status of electronic result integration from the reference laboratory into the internal LIS and EHR (Electronic Health Record). Tracks whether results were successfully auto-imported or require manual intervention. Populated only for send-out orders.. Valid values are `pending|integrated|failed|manual_entry_required`',
    `result_received_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory result was received back from the reference laboratory and integrated into the LIS (Laboratory Information System). Populated only for send-out orders. Marks completion of the send-out order lifecycle.',
    `shipping_carrier` STRING COMMENT 'Name of the courier or shipping service used to transport the specimen to the reference laboratory. Examples: FedEx, UPS, DHL, courier service. Populated only for send-out orders.',
    `shipping_tracking_number` STRING COMMENT 'Carrier-provided tracking number for the specimen shipment. Enables real-time tracking of specimen in transit and confirmation of delivery to reference laboratory. Populated only for send-out orders.',
    `source_system` STRING COMMENT 'Name of the source operational system from which this laboratory order record originated. Examples: Epic Beaker, Cerner PathNet, MEDITECH Laboratory. Used for data lineage and troubleshooting.',
    `source_system_order_number` STRING COMMENT 'Unique identifier for this laboratory order in the source operational system (Epic Beaker, Cerner PathNet). Used for cross-system reconciliation and drill-back to source records.',
    `specimen_shipped_timestamp` TIMESTAMP COMMENT 'Date and time when the specimen was shipped or dispatched to the external reference laboratory. Used to track send-out order logistics and calculate total turnaround time. Populated only for send-out orders.',
    `specimen_source` STRING COMMENT 'Anatomical site or body location from which the specimen was collected. Examples: left arm venipuncture, throat swab, wound site, right knee joint. Important for pathology and microbiology orders.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for the laboratory test. Examples: blood, serum, plasma, urine, tissue, swab, cerebrospinal fluid. Determines handling and processing requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this laboratory order record was last modified in the data lakehouse. Audit field for change tracking and data freshness monitoring.',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Specimens collected during scheduled appointments require linkage for workflow tracking, collection verification, and no-show reconciliation. Critical for outpatient phlebotomy operations where patien',
    `lab_order_id` BIGINT COMMENT 'Identifier of the clinical order that requested the laboratory tests for which this specimen was collected. Links specimen to ordering workflow.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Specimen collection requires specific containers, tubes, swabs, and transport media tracked in material_master. Lab supply chain management, specimen integrity compliance, and reagent/container recall',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient from whom the specimen was collected. Links specimen to patient master record.',
    `parent_specimen_id` BIGINT COMMENT 'Identifier of the parent specimen if this specimen is an aliquot or derivative. Supports specimen lineage tracking.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Specimen chain of custody, biohazard handling, and retention policies are governed by CLIA and CAP compliance programs. Linking specimen to its governing compliance program enables chain-of-custody au',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Chain-of-custody tracking and specimen management require knowing which care site received the specimen. Regulatory compliance (CAP/CLIA) and TAT reporting depend on the receiving facility. receiving_',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Specimen storage tracking requires linking to the specific room (cold storage, freezer room) for environmental monitoring compliance, chain-of-custody, and CAP inspection readiness. storage_location i',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Intraoperative specimen collection: tissue biopsies, frozen sections, and wound cultures collected during surgery must reference the surgical case for chain-of-custody, CAP accreditation compliance, a',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: Specimen collection and handling requires documented competency training per CLIA. Healthcare operations link specimens to training records for quality investigations and competency verification durin',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter or visit during which the specimen was collected. Provides clinical context and billing linkage.',
    `accession_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received and accessioned into the Laboratory Information System (LIS). Marks the beginning of laboratory custody and processing.',
    `accession_number` STRING COMMENT 'Laboratory Information System (LIS) assigned unique work-unit identifier for the specimen. This is the operational identity in Epic Beaker and Cerner PathNet, used to track the specimen through the laboratory workflow from receipt through testing and disposal.',
    `accession_status` STRING COMMENT 'Current lifecycle status of the specimen in the laboratory workflow. Tracks progression from receipt through testing to final disposition.. Valid values are `received|processing|resulted|archived|rejected`',
    `biohazard_level` STRING COMMENT 'Biohazard risk classification of the specimen based on known or suspected infectious agents. Determines safety precautions and handling protocols.. Valid values are `standard|high_risk|unknown`',
    `chain_of_custody_status` STRING COMMENT 'Indicates whether the chain of custody has been maintained throughout specimen handling. Critical for forensic, toxicology, and legal specimens.. Valid values are `intact|broken|not_applicable`',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was collected from the patient. Critical for time-sensitive tests and stability assessments.',
    `collection_duration_minutes` STRING COMMENT 'Duration of specimen collection in minutes. Relevant for timed collections such as 24-hour urine or glucose tolerance tests.',
    `collection_method` STRING COMMENT 'Technique or procedure used to collect the specimen (e.g., venipuncture, clean catch, biopsy, swab). Critical for quality assessment and result interpretation.',
    `collector_role` STRING COMMENT 'Professional role or title of the person who collected the specimen (e.g., phlebotomist, registered nurse, physician). Provides context for collection quality and training requirements.',
    `comments` STRING COMMENT 'Free-text comments or notes about the specimen, collection circumstances, or quality observations. Provides additional context for laboratory staff and clinicians.',
    `condition_at_receipt` STRING COMMENT 'Assessment of specimen quality and integrity upon receipt at the laboratory. Documents any pre-analytical issues that may affect test results.. Valid values are `acceptable|hemolyzed|clotted|insufficient|contaminated|unlabeled`',
    `container_type` STRING COMMENT 'Type of collection container or tube used (e.g., red top, lavender top EDTA, sterile cup). Determines appropriate tests and handling requirements.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this specimen record was first created in the system. Supports audit trail and data lineage tracking.',
    `disposal_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was disposed of or destroyed. Supports retention policy compliance and inventory management.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the specimen (e.g., biohazard waste, incineration, autoclave). Ensures compliance with safety and environmental regulations.',
    `fasting_status` STRING COMMENT 'Indicates whether the patient was fasting at the time of specimen collection. Critical for interpretation of glucose, lipid, and metabolic tests.. Valid values are `fasting|non_fasting|unknown`',
    `number_of_aliquots` STRING COMMENT 'Count of aliquots or sub-specimens created from the original specimen for distribution to different testing sections or for storage.',
    `priority` STRING COMMENT 'Processing priority level assigned to the specimen. Determines turnaround time expectations and workflow sequencing.. Valid values are `routine|urgent|stat|asap`',
    `rejection_reason` STRING COMMENT 'Reason for specimen rejection if not acceptable for testing (e.g., hemolyzed, insufficient quantity, unlabeled, expired). Supports quality improvement and recollection requests.',
    `retention_expiration_date` DATE COMMENT 'Date when the specimen retention period expires and the specimen may be disposed of per laboratory policy.',
    `retention_status` STRING COMMENT 'Current retention status of the specimen relative to laboratory retention policies. Indicates whether specimen is available for additional testing or has been disposed.. Valid values are `active|retained|disposed|archived`',
    `special_handling_instructions` STRING COMMENT 'Any special handling requirements or precautions for the specimen (e.g., keep frozen, protect from light, handle as infectious). Ensures proper specimen management.',
    `specimen_source` STRING COMMENT 'Anatomical site or body location from which the specimen was collected (e.g., left antecubital vein, throat, wound site). Provides clinical context for interpretation of test results.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected (e.g., blood, urine, tissue, cerebrospinal fluid, swab, stool). Defines the nature of the material submitted for laboratory analysis.. Valid values are `blood|urine|tissue|csf|swab|stool`',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the specimen is stored, measured in degrees Celsius. Critical for specimen stability and quality assurance.',
    `transport_duration_minutes` STRING COMMENT 'Time elapsed between specimen collection and laboratory receipt, measured in minutes. Critical for time-sensitive analytes and quality assessment.',
    `transport_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the specimen was transported from collection site to laboratory, measured in degrees Celsius. Affects specimen stability and quality.',
    `updated_datetime` TIMESTAMP COMMENT 'Date and time when this specimen record was last modified. Supports audit trail and change tracking.',
    `volume_collected_ml` DECIMAL(18,2) COMMENT 'Volume of specimen collected, measured in milliliters. Used to determine test feasibility and aliquot planning.',
    CONSTRAINT pk_specimen PRIMARY KEY(`specimen_id`)
) COMMENT 'Master record for every biological specimen collected for laboratory testing and the SSOT for specimen identity, accessioning, chain of custody, and full specimen lifecycle. Tracks specimen type (blood, urine, tissue, CSF, swab), collection method, collection date/time, collector identity and role, collection site (body location), container type, volume, accession number (LIS-assigned unique work-unit identifier), accession date/time, accession status (received, processing, resulted, archived), receiving lab location, priority, chain-of-custody status, storage location, specimen condition at receipt, number of aliquots, and disposal/retention status. Consolidates the former accession and specimen collection event concepts — the accession is the specimens operational identity in Epic Beaker and Cerner PathNet. Supports CLIA-compliant specimen tracking from collection through accessioning, testing, and disposal.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the laboratory test result record. Primary key for the test result entity.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Test results confirm or establish clinical diagnoses (e.g., HbA1c result confirming diabetes). CDI query workflows and diagnosis validation reporting require linking results to confirmed diagnoses. Ro',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this test was performed. Links to the master patient record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Test results linked to diagnosis codes enable outcomes tracking, quality measure calculation (e.g., HbA1c results for diabetes patients), and clinical correlation analysis. Required for value-based ca',
    `instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument or analyzer that produced the result. Used for quality control, calibration tracking, and troubleshooting.',
    `lab_order_id` BIGINT COMMENT 'Reference to the parent laboratory order that requested this test. Links to the clinical order that initiated the test.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test results require LOINC linkage for standardized result reporting, HIE exchange, quality measure calculation, and clinical decision support. Enables semantic interoperability for result interpretat',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CLIA compliance requires results to be attributed to the performing facility. Quality metrics, result routing, and payer billing all depend on the performing care site. performing_lab_facility is a de',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Result routing, billing reconciliation, and CLIA compliance require the performing lab as a structured org_provider. performing_lab_facility is a denormalized text field; FK to org_provider enables ',
    `clinician_id` BIGINT COMMENT 'Reference to the pathologist who reviewed and verified the result, particularly for complex tests requiring physician oversight. Required for certain test categories under CLIA.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: CLIA compliance requires test results to be traceable to the governing compliance program for regulatory audits and proficiency testing reporting. A healthcare compliance officer expects test_result t',
    `reference_range_id` BIGINT COMMENT 'Foreign key linking to laboratory.reference_range. Business justification: Test results are interpreted using reference ranges. Currently test_result has reference_range_low/high/text embedded. Business reality: reference ranges are applied to results for interpretation and ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test results with coded values require SNOMED CT linkage for semantic interoperability and clinical decision support. The result_value_coded field needs structured terminology; proper FK enables autom',
    `specimen_id` BIGINT COMMENT 'Reference to the specimen from which this test result was derived. Links to the specimen collection and tracking record.',
    `tertiary_test_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the laboratory test. Used for result routing and clinical communication.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Test results are instances of tests defined in the catalog. Currently test_result has loinc_code/loinc_display_name but no FK to test_catalog. Business reality: every result is for a cataloged test. A',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which this test was ordered or resulted. Links to the visit record.',
    `abnormal_flag` STRING COMMENT 'Indicator of whether the result falls outside the normal reference range. Values include normal, low, high, critical_low, critical_high, or abnormal for non-numeric results.. Valid values are `normal|low|high|critical_low|critical_high|abnormal`',
    `amendment_datetime` TIMESTAMP COMMENT 'Date and time when the result was amended or corrected. Critical for audit trail and understanding result history.',
    `amendment_reason` STRING COMMENT 'Documented reason for amending or correcting the result (e.g., transcription error, instrument malfunction, specimen mix-up, calculation error). Required for CLIA compliance.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system. Audit timestamp for data lineage and compliance.',
    `critical_value_acknowledgment_datetime` TIMESTAMP COMMENT 'Date and time when the provider acknowledged receipt and understanding of the critical value. Completes the critical value notification loop.',
    `critical_value_alert_generated_datetime` TIMESTAMP COMMENT 'Date and time when the critical value alert was generated by the Laboratory Information System (LIS). Marks the start of the critical value notification workflow.',
    `critical_value_escalation_action` STRING COMMENT 'Description of escalation actions taken if initial notification was unsuccessful (e.g., contacted backup provider, notified charge nurse, paged on-call physician).',
    `critical_value_notification_datetime` TIMESTAMP COMMENT 'Date and time when the critical value notification was successfully delivered to the provider. Used to calculate notification turnaround time.',
    `critical_value_notification_method` STRING COMMENT 'Method used to notify the provider of the critical value (e.g., phone, secure message, EHR alert, page). Required for compliance documentation.. Valid values are `phone|secure_message|ehr_alert|page|fax|in_person`',
    `critical_value_resolution_note` STRING COMMENT 'Free-text note documenting the resolution of the critical value alert, including any clinical actions taken or follow-up orders placed.',
    `is_amended` BOOLEAN COMMENT 'Boolean flag indicating whether this result has been amended or corrected after initial release. Triggers amendment tracking and notification workflows.',
    `is_critical_value` BOOLEAN COMMENT 'Boolean flag indicating whether this result exceeds critical thresholds requiring immediate clinical notification. Triggers critical value alert workflow.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this test result record was last modified. Audit timestamp for tracking changes and data quality.',
    `original_result_value_numeric` DECIMAL(18,2) COMMENT 'Original numeric result value before amendment or correction. Preserved for audit trail and compliance purposes.',
    `original_result_value_text` STRING COMMENT 'Original text result value before amendment or correction. Preserved for audit trail and compliance purposes.',
    `performing_lab_section` STRING COMMENT 'Laboratory section or department that performed the test (e.g., Chemistry, Hematology, Microbiology, Pathology). Used for operational tracking and quality control.',
    `result_comment` STRING COMMENT 'Additional comments, notes, or observations about the test result. May include technical notes, specimen quality issues, or other relevant information.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the laboratory test result was produced or finalized. Represents the official result timestamp for clinical and regulatory purposes.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation or commentary provided by the laboratory professional regarding the result. May include clinical significance, recommendations, or contextual notes.',
    `result_released_datetime` TIMESTAMP COMMENT 'Date and time when the result was officially released from the laboratory and made available to clinicians. Used for turnaround time calculations.',
    `result_status` STRING COMMENT 'Current lifecycle status of the test result. Tracks progression from preliminary through final, and captures corrections or cancellations. Critical for clinical decision-making and compliance.. Valid values are `preliminary|final|corrected|cancelled|entered_in_error`',
    `result_unit` STRING COMMENT 'Unit of measure for the numeric result value (e.g., mg/dL, mmol/L, cells/uL). Critical for clinical interpretation and comparison against reference ranges.',
    `result_value_coded` STRING COMMENT 'Standardized coded value for the test result using terminology systems such as SNOMED CT. Enables structured data exchange and analytics.',
    `result_value_numeric` DECIMAL(18,2) COMMENT 'Numeric value of the laboratory test result for quantitative tests. Stores the measured value with precision appropriate for clinical decision-making.',
    `result_value_text` STRING COMMENT 'Text or string value of the laboratory test result for qualitative tests, narrative findings, or coded results. Used when result cannot be expressed numerically.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received in the laboratory. Used for tracking specimen handling and turnaround time metrics.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Transactional record of every individual laboratory test result produced for a specimen, including result amendments and critical value notifications. Stores LOINC-coded test identifier, result value (numeric, text, coded), result unit of measure, reference range applied, result status lifecycle (preliminary, final, corrected, cancelled), abnormal flag (normal, low, high, critical low, critical high), result date/time, performing lab section, instrument identifier, verifying technologist. Owns the full amendment/correction history: original value, amended value, amendment reason, amending user, amendment timestamp. When a result exceeds critical thresholds, owns the critical value alert lifecycle: alert generation timestamp, notified provider, notification method (phone, secure message, EHR alert), acknowledgment timestamp, acknowledging clinician, escalation actions, and resolution notes. Consolidates the former critical_value_alert and result_amendment concepts. Supports CLIA critical value compliance, Joint Commission NPSG requirements, HIM audit requirements, and downstream clinical decision-making.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`reference_range` (
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the laboratory reference range record. Primary key.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Reference ranges in clinical laboratories are often instrument-specific — the same analyte may have different normal ranges depending on the analyzer platform used (e.g., Beckman Coulter vs. Roche Cob',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Reference ranges are LOINC-specific and vary by test methodology. Structured linkage enables proper result interpretation across systems, supports automated abnormal flag generation, and ensures clini',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Specialty-specific reference ranges (e.g., cardiology troponin thresholds vs. general medicine) are standard lab practice. Linking reference_range to provider.specialty enables specialty-driven result',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Reference ranges are defined FOR specific tests in the catalog. Currently reference_range has test_code/test_name but no FK to test_catalog. Business reality: reference ranges are test-specific and sh',
    `age_group` STRING COMMENT 'Age group or age range for which this reference range applies (e.g., Neonate, Infant, Child, Adolescent, Adult, Geriatric, or specific age ranges like 0-1 years, 1-12 years, 18-65 years). Reference ranges are age-dependent for many tests.',
    `alert_priority` STRING COMMENT 'Priority level for clinical alerts triggered when results fall outside this reference range. Critical priority requires immediate notification within minutes; urgent within hours; routine for next business day review.. Valid values are `routine|urgent|critical|stat`',
    `alert_trigger_flag` BOOLEAN COMMENT 'Indicates whether results outside this reference range should trigger automated clinical alerts or notifications. True for critical value ranges requiring immediate provider notification per Joint Commission requirements.',
    `clinical_significance` STRING COMMENT 'Clinical interpretation guidance describing the significance of values outside this reference range. Provides context for clinicians interpreting abnormal results (e.g., elevated values may indicate infection, dehydration, or malignancy).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reference range record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_high_threshold` DECIMAL(18,2) COMMENT 'The critical high value threshold (panic value) above which immediate clinical notification is required. Represents life-threatening high values requiring urgent intervention.',
    `critical_low_threshold` DECIMAL(18,2) COMMENT 'The critical low value threshold (panic value) below which immediate clinical notification is required. Represents life-threatening low values requiring urgent intervention.',
    `effective_end_date` DATE COMMENT 'The date through which this reference range remains valid. Null indicates the range is currently active with no planned end date. Supports historical tracking and periodic review requirements.',
    `effective_start_date` DATE COMMENT 'The date from which this reference range becomes valid and should be used for result interpretation. Supports versioning of reference ranges over time.',
    `interpretation_code` STRING COMMENT 'Standardized code used by result interpretation logic to assign abnormal flags when test results fall outside this reference range. Maps to HL7 observation interpretation codes.. Valid values are `normal|low|high|critical_low|critical_high|abnormal`',
    `last_review_date` DATE COMMENT 'Date when this reference range was last reviewed and validated by the laboratory medical director or quality team. CLIA and CAP require periodic review of reference ranges at least annually or when methodology changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reference range record was last modified. Supports change tracking and audit compliance.',
    `lis_system_code` STRING COMMENT 'Internal system code or identifier used by the Laboratory Information System (Epic Beaker, Cerner PathNet) to reference this range in result interpretation logic and reporting.',
    `lower_normal_limit` DECIMAL(18,2) COMMENT 'The lower boundary of the normal reference range. Values below this threshold are typically flagged as low or abnormal.',
    `medical_director_override_flag` BOOLEAN COMMENT 'Indicates whether this reference range represents an institutional medical director override of standard published ranges. True if the laboratory medical director has approved a deviation from manufacturer or published ranges based on local population characteristics.',
    `methodology` STRING COMMENT 'The analytical method or instrument platform used to establish this reference range (e.g., Spectrophotometry, Immunoassay, Mass Spectrometry, PCR). Reference ranges may vary by methodology for the same test.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this reference range. Supports compliance with CLIA and CAP requirements for annual review and documentation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this reference range. May include information about interfering substances, pre-analytical requirements, or special patient populations.',
    `override_justification` STRING COMMENT 'Clinical justification and documentation for medical director override of standard reference ranges. Required when medical_director_override_flag is true. Includes rationale, supporting data, and approval documentation.',
    `population_basis` STRING COMMENT 'Description of the reference population used to establish this range (e.g., healthy adult volunteers, local patient population, manufacturer validation study). Documents the basis for the reference interval per CLSI guidelines.',
    `pregnancy_status` STRING COMMENT 'Pregnancy status for which this reference range applies. Certain laboratory values have distinct reference ranges during pregnancy (e.g., thyroid function tests, hemoglobin).. Valid values are `pregnant|not_pregnant|not_applicable|unknown`',
    `race_ethnicity` STRING COMMENT 'Race or ethnicity group for which this reference range applies, when clinically validated differences exist (e.g., creatinine clearance adjustments for African American patients). Only populated when evidence-based clinical guidelines support race-specific ranges.',
    `review_status` STRING COMMENT 'Current review and approval status of this reference range. Tracks lifecycle state for quality management and compliance purposes.. Valid values are `current|pending_review|under_revision|retired`',
    `sample_size` STRING COMMENT 'Number of individuals in the reference population used to establish this range. CLSI recommends minimum 120 samples for robust reference intervals. Documents statistical validity of the range.',
    `sex` STRING COMMENT 'Biological sex for which this reference range applies. Many laboratory tests have sex-specific reference ranges (e.g., hemoglobin, creatinine).. Valid values are `male|female|all|unknown`',
    `source_citation` STRING COMMENT 'Detailed citation or reference to the authoritative source document (e.g., CAP guideline version, manufacturer package insert identifier, peer-reviewed journal article, institutional policy document). Required for CLIA compliance and periodic review.',
    `source_type` STRING COMMENT 'The type of authoritative source from which this reference range was derived. CLIA requires documentation of reference range sources.. Valid values are `cap|clia|manufacturer|institutional|peer_reviewed`',
    `statistical_method` STRING COMMENT 'Statistical method used to calculate the reference interval (e.g., parametric 95% confidence interval, non-parametric percentile method, robust method). Documents the analytical approach per CLSI standards.',
    `unit_of_measure` STRING COMMENT 'The standardized unit of measure for the reference range values (e.g., mg/dL, mmol/L, g/dL, cells/mcL, IU/L). Must match the unit used in test results for proper interpretation.',
    `upper_normal_limit` DECIMAL(18,2) COMMENT 'The upper boundary of the normal reference range. Values above this threshold are typically flagged as high or abnormal.',
    CONSTRAINT pk_reference_range PRIMARY KEY(`reference_range_id`)
) COMMENT 'Reference data defining normal, abnormal, and critical value thresholds for each laboratory test, stratified by patient demographics (age group, sex, pregnancy status, race/ethnicity where clinically validated) and specimen type. Includes lower and upper normal limits, critical low and critical high thresholds, panic value definitions, unit of measure, effective date range, and the authoritative source (CAP, CLIA, manufacturer insert, institutional medical director override). Used by result interpretation logic to assign abnormal flags and trigger critical value alerts in test_result. Supports CLIA-required documentation of reference range sources and periodic review.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`pathology_report` (
    `pathology_report_id` BIGINT COMMENT 'Unique identifier for the pathology report. Primary key for this entity.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Pathology reports are billable professional services generating claims with CPT codes for surgical pathology, cytology, and molecular pathology. Essential for pathology billing, professional fee captu',
    `coding_assignment_id` BIGINT COMMENT 'Foreign key linking to billing.coding_assignment. Business justification: Pathology reports are the primary source document for ICD-10 and CPT coding assignments in the revenue cycle. Coders use final pathology diagnoses (cancer staging, histologic type, TNM stage) to assig',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Pathology reports confirm diagnoses (e.g., biopsy confirming cancer diagnosis). Cancer registry reporting, tumor board workflows, and surgical pathology correlation require linking pathology reports t',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Pathology services — especially molecular testing, IHC, and cancer synoptic reports — are governed by payer coverage policies defining medical necessity and reimbursable procedures. Oncology billing a',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this pathology report was generated.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Pathology reports require structured ICD-10 linkage for cancer registry reporting, tumor board case selection, billing compliance, and outcomes research. The diagnosis_code text field is denormalized;',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pathology reports are generated in response to lab orders. Currently no FK exists. Business reality: pathology work is ordered via CPOE as lab orders. This links the report back to the original order ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Pathology reports use LOINC document codes (e.g., LOINC 11529-5 for surgical pathology report) for structured document exchange in HL7 FHIR DiagnosticReport resources. Required for EHR integration, ca',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Pathology services are high-cost and frequently require prior authorization. Cancer registry reporting, tumor board reviews, and molecular testing authorization all require payer tracking for coverage',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CAP accreditation, cancer registry reporting, and CLIA compliance require pathology reports to be linked to the performing facility. performing_laboratory is a denormalized text field. Pathologists an',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Pathology billing, CAP/CLIA accreditation compliance, and cancer registry reporting require the performing laboratory as a structured org_provider. performing_laboratory is a denormalized text field',
    `clinician_id` BIGINT COMMENT 'Reference to the physician or provider who ordered the pathology examination.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Advanced pathology procedures (molecular testing, IHC panels, FISH) frequently require prior authorization. Linking pathology_report to the governing prior_auth_rule supports PA audit trails, denial r',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Surgical pathology and biopsy procedures frequently require prior authorization. Linking pathology_report to prior_authorization supports PA compliance validation, denial prevention for pathology clai',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Pathology labs operate under CAP/CLIA compliance programs. Linking pathology_report to its governing compliance program enables CAP accreditation audit trails and cancer registry regulatory reporting.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Pathology reports require structured SNOMED CT linkage for cancer registry reporting, tumor board analytics, and pathology data exchange. The snomed_code text field is denormalized; proper FK enables ',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Pathology reports are generated FROM specimens. Currently no FK exists. Business reality: pathology reports analyze specific specimens (tissue, cytology). Adding specimen_id FK allows joining to get s',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical pathology is core workflow - tissue specimens from surgery require pathology analysis for cancer staging, margin assessment, and tumor boards. Essential for surgical quality metrics, cancer r',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Pathology reports are generated for catalog tests. Currently pathology_report has report_type but no FK. Business reality: pathology work (surgical path, cytology) is ordered as catalog tests. Adding ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which the specimen was collected.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Surgical pathology correlation: pathology reports are generated from specific surgical procedures (biopsies, excisions, resections). Linking pathology_report to visit_procedure enables procedure-speci',
    `accession_number` STRING COMMENT 'The unique laboratory accession number assigned when the specimen was received by the laboratory. Links to the specimen tracking system.',
    `addendum_history` STRING COMMENT 'Complete chronological record of all addenda added to the original report, including dates and content of each addendum.',
    `amended_timestamp` TIMESTAMP COMMENT 'The date and time when the report was amended or corrected after initial sign-out.',
    `amendment_reason` STRING COMMENT 'Explanation for why the pathology report was amended or corrected. Required for regulatory compliance and quality assurance.',
    `cancer_registry_reportable_flag` BOOLEAN COMMENT 'Indicates whether this case meets criteria for mandatory reporting to the cancer registry per state and federal requirements.',
    `case_number` STRING COMMENT 'The externally-known unique case identifier assigned by the pathology laboratory for tracking and reference purposes. This is the business identifier used in clinical workflows and correspondence.',
    `comment` STRING COMMENT 'Additional interpretive comments, clinical correlation, recommendations for further testing, or clarifications provided by the pathologist.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pathology report record was first created in the system.',
    `critical_value_flag` BOOLEAN COMMENT 'Indicates whether this report contains a critical or life-threatening finding that requires immediate physician notification per laboratory policy.',
    `critical_value_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the critical finding was communicated to the ordering provider or responsible clinician.',
    `final_diagnosis` STRING COMMENT 'The conclusive diagnostic interpretation rendered by the pathologist based on gross and microscopic examination. This is the primary clinical finding of the report.',
    `gross_description` STRING COMMENT 'Detailed macroscopic description of the specimen as observed during gross examination by the pathologist or pathology assistant. Includes measurements, appearance, and dissection details.',
    `histologic_grade` STRING COMMENT 'The degree of differentiation of the tumor cells, indicating how closely the tumor resembles normal tissue. Used for prognosis and treatment planning.. Valid values are `well_differentiated|moderately_differentiated|poorly_differentiated|undifferentiated|not_applicable`',
    `histologic_type` STRING COMMENT 'The microscopic classification of the tumor based on cell type and tissue architecture (e.g., adenocarcinoma, squamous cell carcinoma).',
    `immunohistochemistry_results` STRING COMMENT 'Results of immunohistochemical staining performed to identify specific antigens or markers in the tissue. Includes marker names and interpretation (positive/negative/equivocal).',
    `lymph_nodes_examined` STRING COMMENT 'Total count of lymph nodes identified and examined microscopically in the specimen.',
    `lymph_nodes_positive` STRING COMMENT 'Count of lymph nodes containing metastatic tumor. Used for N classification in cancer staging.',
    `margin_status` STRING COMMENT 'Indicates whether tumor cells are present at the surgical resection margins. Critical for determining completeness of excision and need for additional treatment.. Valid values are `negative|positive|close|indeterminate|not_applicable`',
    `microscopic_description` STRING COMMENT 'Detailed microscopic findings observed during histological examination of the tissue sections. Describes cellular architecture, morphology, and pathological changes.',
    `molecular_testing_results` STRING COMMENT 'Results of molecular or genetic testing performed on the specimen (e.g., EGFR mutation, KRAS, HER2, MSI status). Critical for targeted therapy decisions.',
    `preliminary_report_timestamp` TIMESTAMP COMMENT 'The date and time when a preliminary or interim report was issued, if applicable. Used for urgent or critical findings that require immediate communication.',
    `received_date` DATE COMMENT 'The date on which the specimen was received by the pathology laboratory.',
    `report_status` STRING COMMENT 'Current lifecycle status of the pathology report indicating whether it is preliminary, finalized, or has been amended.. Valid values are `preliminary|final|amended|corrected|cancelled`',
    `report_type` STRING COMMENT 'The category of pathology report indicating the subspecialty or type of examination performed.. Valid values are `surgical_pathology|cytology|hematopathology|dermatopathology|neuropathology|autopsy`',
    `sign_out_timestamp` TIMESTAMP COMMENT 'The date and time when the pathologist finalized and electronically signed the pathology report, making it available for clinical use.',
    `special_stains_performed` STRING COMMENT 'List of special histochemical stains performed on the tissue sections to aid in diagnosis (e.g., PAS, GMS, AFB, trichrome).',
    `synoptic_report_elements` STRING COMMENT 'Structured data elements from CAP cancer protocol checklists presented in a standardized format. Includes all required synoptic reporting fields for the specific tumor type.',
    `tnm_stage` STRING COMMENT 'The combined TNM (Tumor, Node, Metastasis) stage classification for cancer cases following AJCC staging guidelines.',
    `tumor_board_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this case was presented and discussed at a multidisciplinary tumor board conference.',
    `tumor_site` STRING COMMENT 'Specific anatomical location of the tumor or lesion, used for cancer staging and registry reporting.',
    `tumor_size_cm` DECIMAL(18,2) COMMENT 'The greatest dimension of the tumor measured in centimeters. Critical for cancer staging (T classification).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this pathology report record was last modified in the system.',
    CONSTRAINT pk_pathology_report PRIMARY KEY(`pathology_report_id`)
) COMMENT 'Master record for surgical pathology and cytology reports generated by pathologists. Includes case number, specimen source, gross description, microscopic description, final diagnosis (ICD-10 coded), synoptic reporting elements (CAP cancer protocols), pathologist of record, sign-out date/time, report status (preliminary, final, amended), and addendum history. Supports oncology care coordination, tumor board workflows, and cancer registry reporting.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` (
    `microbiology_culture_id` BIGINT COMMENT 'Unique identifier for the microbiology culture and sensitivity test record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the laboratory facility or department that performed the culture and susceptibility testing.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who ordered the microbiology culture test.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient from whom the specimen was collected.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Microbiology cultures require ICD-10 linkage for HAI surveillance, infection control reporting, antibiotic stewardship program analytics, and public health case reporting. Enables stratification of cu',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Infection diagnoses (sepsis, pneumonia, UTI) are directly linked to microbiology culture results. Antibiotic stewardship programs, HAI surveillance, and infection control reporting require linking cul',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Culture processing may use specific instruments (automated culture systems). Currently no FK exists. Business reality: automated microbiology systems (e.g., BACTEC, VITEK) are instruments. Adding inst',
    `lab_order_id` BIGINT COMMENT 'Reference to the parent laboratory order that requested this microbiology culture test.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Microbiology culture results are reported with LOINC observation codes (e.g., LOINC 600-7 for blood culture) in HL7 lab result messages. Required for EHR integration, public health reporting (HAI surv',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Culture media, plates, and reagents are material master items consumed per test. Linking enables microbiology supply usage tracking, cost allocation, and inventory management—critical for infection co',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Microbiology cultures with public_health_reportable_flag are tied to specific mandatory reporting obligations (state/federal notifiable disease regulations). Linking to the specific obligation enables',
    `organism_id` BIGINT COMMENT 'Foreign key linking to laboratory.organism. Business justification: Microbiology culture currently stores organism_name and organism_category as free-text STRING attributes, but the domain has a master organism reference table. This FK normalizes organism identificati',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Microbiology cultures require SNOMED CT linkage for organism identification, infection surveillance, and antibiotic stewardship reporting. The organism_code text field is denormalized; proper FK enabl',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Microbiology cultures with HAI, MDRO, and public health reportable flags are governed by infection control compliance programs (CDC NHSN, state health department). Linking to the compliance program en',
    `specimen_id` BIGINT COMMENT 'Reference to the biological specimen collected and submitted for culture testing.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical site infection (SSI) surveillance: intraoperative cultures and post-surgical wound cultures must be linked to the originating surgical case for CDC NHSN SSI reporting, infection control inves',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Microbiology cultures are catalog tests. Currently microbiology_culture has culture_type but no FK to test_catalog. Business reality: cultures are ordered as catalog tests (e.g., blood culture, urine ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which the culture was ordered.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned identifier for tracking the specimen and associated tests throughout the laboratory workflow. Business identifier for external reference.',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'Indicates whether this culture result triggered an antibiotic stewardship program intervention or review.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the biological specimen was collected from the patient. Critical for interpreting culture growth timing and clinical relevance.',
    `colony_count` BIGINT COMMENT 'Quantitative count of colony forming units per milliliter or per plate, used to assess infection severity and clinical significance.',
    `colony_count_unit` STRING COMMENT 'Unit of measure for the colony count (e.g., CFU/mL for urine cultures, CFU/plate for wound cultures).. Valid values are `CFU/mL|CFU/plate|CFU/gram`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this microbiology culture record was first created in the laboratory information system.',
    `critical_value_flag` BOOLEAN COMMENT 'Indicates whether this culture result represents a critical or panic value requiring immediate clinical notification (e.g., positive blood culture, multi-drug resistant organism).',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Date and time when the critical value was communicated to the ordering provider or clinical team.',
    `culture_status` STRING COMMENT 'Current lifecycle status of the culture test indicating workflow stage and result availability.. Valid values are `ordered|in_progress|preliminary|final|corrected|cancelled`',
    `culture_type` STRING COMMENT 'Classification of the microbiology culture method and target organism category (e.g., aerobic bacteria, anaerobic bacteria, fungal, acid-fast bacilli, viral). [ENUM-REF-CANDIDATE: aerobic|anaerobic|fungal|mycobacterial|viral|blood|urine|wound|respiratory — 9 candidates stripped; promote to reference product]',
    `gram_stain_result` STRING COMMENT 'Result of Gram staining procedure used for preliminary bacterial classification (gram-positive, gram-negative, or gram-variable).. Valid values are `gram_positive|gram_negative|gram_variable|not_applicable`',
    `growth_result` STRING COMMENT 'Qualitative assessment of organism growth observed in the culture (e.g., no growth, light growth, moderate growth, heavy growth, mixed flora).. Valid values are `no_growth|light_growth|moderate_growth|heavy_growth|mixed_flora|contaminated`',
    `hai_associated_flag` BOOLEAN COMMENT 'Indicates whether this culture is associated with a healthcare-associated infection event for quality reporting and surveillance.',
    `hai_event_type` STRING COMMENT 'Specific type of healthcare-associated infection event linked to this culture (e.g., CLABSI, CAUTI, SSI, VAP, CDI) for regulatory reporting.. Valid values are `CLABSI|CAUTI|SSI|VAP|CDI`',
    `incubation_start_datetime` TIMESTAMP COMMENT 'Date and time when the culture was inoculated and incubation began.',
    `infection_control_notified_flag` BOOLEAN COMMENT 'Indicates whether the infection control department was notified of this culture result for surveillance or outbreak investigation.',
    `isolation_datetime` TIMESTAMP COMMENT 'Date and time when the organism was first isolated and identified from the culture medium.',
    `mdro_flag` BOOLEAN COMMENT 'Indicates whether the isolated organism is classified as a multi-drug resistant organism, triggering infection control protocols and antibiotic stewardship interventions.',
    `mdro_type` STRING COMMENT 'Specific classification of the multi-drug resistant organism (e.g., MRSA, VRE, ESBL, CRE) for infection control surveillance and reporting.. Valid values are `MRSA|VRE|ESBL|CRE|MDR_Acinetobacter|MDR_Pseudomonas`',
    `morphology` STRING COMMENT 'Microscopic morphological characteristics of the organism (e.g., cocci, bacilli, yeast, hyphae).',
    `public_health_reportable_flag` BOOLEAN COMMENT 'Indicates whether this culture result represents a notifiable disease or condition requiring reporting to public health authorities.',
    `quality_control_passed_flag` BOOLEAN COMMENT 'Indicates whether the culture test passed all required quality control checks and validation procedures per CLIA requirements.',
    `received_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received and accessioned by the laboratory.',
    `result_comments` STRING COMMENT 'Free-text comments, notes, or additional observations provided by laboratory staff regarding the culture result, methodology, or clinical context.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the culture result was finalized and released for clinical use.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation or commentary provided by the microbiologist regarding the significance of the culture result and recommended actions.',
    `specimen_source_code` STRING COMMENT 'Standardized SNOMED CT code for the specimen source site.',
    `susceptibility_method` STRING COMMENT 'Laboratory method used to perform antimicrobial susceptibility testing (e.g., disk diffusion, broth microdilution, E-test, automated system).. Valid values are `disk_diffusion|broth_microdilution|etest|automated_system`',
    `susceptibility_panel_performed` BOOLEAN COMMENT 'Indicates whether antimicrobial susceptibility testing was performed on the isolated organism to guide antibiotic therapy.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from specimen collection to final result reporting, used for laboratory performance monitoring and quality improvement.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this microbiology culture record was last modified or updated.',
    CONSTRAINT pk_microbiology_culture PRIMARY KEY(`microbiology_culture_id`)
) COMMENT 'Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` (
    `susceptibility_result_id` BIGINT COMMENT 'Unique identifier for the antimicrobial susceptibility test result record. Primary key for the susceptibility result entity.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Antibiotic stewardship programs require linking susceptibility results to formulary NDC drug records to trigger prescribing alerts, validate antibiotic selection against formulary, and generate stewar',
    `clinician_id` BIGINT COMMENT 'Reference to the laboratory professional (medical technologist, clinical pathologist, or microbiologist) who verified and approved the susceptibility result. Links to the provider entity.',
    `instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument or analyzer used to perform the susceptibility test (e.g., VITEK 2, Phoenix M50, manual bench). Used for quality control and troubleshooting.',
    `lab_order_id` BIGINT COMMENT 'Reference to the originating laboratory order that requested the culture and susceptibility testing. Links to the lab order entity.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Susceptibility results are transmitted via HL7/FHIR using LOINC observation codes (e.g., LOINC 18769-0 for microbial susceptibility). Required for lab interoperability, EHR integration, and public hea',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Susceptibility testing uses specific antibiotic panels (Vitek cards, Sensititre plates, disc diffusion kits) tracked in material_master. CAP/CLIA compliance requires lot-level traceability of testing ',
    `microbiology_culture_id` BIGINT COMMENT 'Reference to the parent microbiology culture workup that this susceptibility result belongs to. Links to the culture entity.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient from whom the specimen was collected. Links to the patient master entity.',
    `organism_id` BIGINT COMMENT 'Reference to the specific organism isolated from the culture for which this susceptibility test was performed. Links to the organism entity.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Antibiotic stewardship programs and public health MDRO surveillance require susceptibility results attributed to the performing facility. performing_lab_name and performing_lab_code are denormalized t',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Antibiotic stewardship program reporting and public health reportable result submissions require the performing lab as a structured org_provider. performing_lab_code and performing_lab_name are de',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Antibiotic susceptibility results drive formal Antibiotic Stewardship Programs (ASPs), which are CMS-mandated compliance programs. Linking susceptibility_result to its governing ASP compliance program',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Susceptibility interpretations (susceptible, resistant, intermediate) are encoded with SNOMED CT concepts for clinical decision support and interoperability. Required for infection control reporting a',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Susceptibility tests are catalog tests. Currently susceptibility_result has antibiotic_agent_code/name but no FK to test_catalog. Business reality: susceptibility panels are catalog tests (e.g., Gram-',
    `antibiotic_agent_code` STRING COMMENT 'Standardized code identifying the antimicrobial agent tested. May be NDC (National Drug Code), SNOMED CT, or local laboratory code.',
    `antibiotic_agent_name` STRING COMMENT 'Human-readable name of the antimicrobial agent tested (e.g., Penicillin, Vancomycin, Ciprofloxacin).',
    `antibiotic_class` STRING COMMENT 'Therapeutic class or category of the antimicrobial agent (e.g., Beta-lactam, Fluoroquinolone, Aminoglycoside, Glycopeptide).',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'Indicates whether this result has been flagged for antibiotic stewardship program review due to resistance pattern, restricted antimicrobial use, or other stewardship criteria. True indicates flagged for review.',
    `clsi_breakpoint_version` STRING COMMENT 'Version of the CLSI M100 Performance Standards document used to interpret the susceptibility result. Breakpoints are updated annually and version is critical for accurate interpretation (e.g., M100-Ed31, M100-Ed32).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this susceptibility result record was first created in the data platform. Audit trail for data lineage and compliance.',
    `disk_diffusion_zone_diameter_mm` DECIMAL(18,2) COMMENT 'Zone of inhibition diameter measured in millimeters for disk diffusion (Kirby-Bauer) susceptibility testing method. Larger zones indicate greater susceptibility.',
    `inducible_resistance_flag` BOOLEAN COMMENT 'Indicates whether inducible resistance was detected (e.g., inducible clindamycin resistance in Staphylococcus, inducible AmpC in Enterobacteriaceae). True indicates inducible resistance detected; False indicates not detected.',
    `infection_control_alert_flag` BOOLEAN COMMENT 'Indicates whether this result triggered an infection control alert due to detection of multidrug-resistant organism (MDRO), reportable organism, or outbreak-associated pathogen. True indicates alert generated.',
    `mic_operator` STRING COMMENT 'Comparison operator for the MIC value when the exact value is at or beyond the test range limits (e.g., <=0.5 indicates at or below the lowest tested concentration).. Valid values are `=|<=|>=|<|>`',
    `mic_unit` STRING COMMENT 'Unit of measure for the MIC value, typically micrograms per milliliter (mcg/mL) or milligrams per liter (mg/L).. Valid values are `mcg/mL|mg/L|IU/mL`',
    `mic_value` DECIMAL(18,2) COMMENT 'Minimum inhibitory concentration value representing the lowest concentration of antimicrobial agent that inhibits visible growth of the organism. Expressed as a numeric value with unit of measure.',
    `panel_code` STRING COMMENT 'Code identifying the standardized panel or battery of antimicrobial agents tested together (e.g., Gram Positive Panel, Gram Negative Panel, Anaerobe Panel). Panels are organism-specific.',
    `panel_name` STRING COMMENT 'Human-readable name of the antimicrobial susceptibility panel tested (e.g., Gram Positive Cocci Panel, Enterobacteriaceae Panel, Pseudomonas Panel).',
    `quality_control_status` STRING COMMENT 'Status of quality control testing performed concurrently with patient susceptibility testing. Passed indicates QC organisms yielded expected results; Failed indicates out-of-range QC results requiring investigation.. Valid values are `passed|failed|not applicable`',
    `reportable_to_public_health_flag` BOOLEAN COMMENT 'Indicates whether this susceptibility result is reportable to public health authorities (e.g., state health department, CDC) due to detection of notifiable disease or antimicrobial resistance pattern. True indicates reportable.',
    `resistance_gene` STRING COMMENT 'Specific resistance gene detected through molecular testing (e.g., mecA, vanA, blaNDM, blaKPC). Used for epidemiological tracking and infection control.',
    `resistance_mechanism` STRING COMMENT 'Known or suspected mechanism of antimicrobial resistance detected (e.g., ESBL, Carbapenemase, MRSA, VRE, AmpC). Critical for infection control and antibiotic stewardship.',
    `resistant_breakpoint` DECIMAL(18,2) COMMENT 'MIC breakpoint value at or above which the organism is classified as resistant according to CLSI guidelines. Used for automated interpretation.',
    `result_comment` STRING COMMENT 'Free-text comment or interpretive note from the laboratory regarding the susceptibility result. May include recommendations for therapy, warnings about resistance patterns, or technical notes.',
    `result_status` STRING COMMENT 'Current status of the susceptibility result in its lifecycle. Preliminary results may be released before final verification; Final results have been verified and released; Corrected indicates an amendment to a previously final result.. Valid values are `preliminary|final|corrected|cancelled|entered in error`',
    `result_timestamp` TIMESTAMP COMMENT 'Date and time when the susceptibility test result was generated or finalized by the laboratory information system. Represents the business event time of result availability.',
    `source_system_code` STRING COMMENT 'Code identifying the source laboratory information system (LIS) that generated this susceptibility result (e.g., Epic Beaker, Cerner PathNet, Sunquest). Used for data lineage and integration troubleshooting.',
    `susceptibility_interpretation` STRING COMMENT 'Clinical interpretation of the susceptibility test result based on CLSI breakpoints. Susceptible indicates the organism is inhibited by achievable drug concentrations; Intermediate indicates uncertain efficacy; Resistant indicates the organism is not inhibited by normally achievable concentrations; Susceptible-dose dependent indicates efficacy depends on dosing regimen.. Valid values are `susceptible|intermediate|resistant|susceptible-dose dependent|not tested|indeterminate`',
    `susceptible_breakpoint` DECIMAL(18,2) COMMENT 'MIC breakpoint value at or below which the organism is classified as susceptible according to CLSI guidelines. Used for automated interpretation.',
    `synergy_test_result` STRING COMMENT 'Result of synergy testing for combination antimicrobial therapy (e.g., beta-lactam/beta-lactamase inhibitor combinations). Positive indicates synergistic effect detected.. Valid values are `positive|negative|not performed`',
    `testing_method` STRING COMMENT 'Laboratory method used to perform the susceptibility test. Common methods include broth microdilution (gold standard for MIC), disk diffusion (Kirby-Bauer), E-test (gradient diffusion), and automated systems (e.g., VITEK, Phoenix).. Valid values are `broth microdilution|disk diffusion|E-test|automated system|agar dilution|gradient diffusion`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this susceptibility result record was last modified in the data platform. Audit trail for data lineage and compliance.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the susceptibility result was verified and approved for clinical use by authorized laboratory personnel (medical technologist or pathologist).',
    CONSTRAINT pk_susceptibility_result PRIMARY KEY(`susceptibility_result_id`)
) COMMENT 'Transactional record of individual antimicrobial susceptibility test results within a microbiology culture workup. Captures the antibiotic agent (NDC or SNOMED coded), minimum inhibitory concentration (MIC) value, disk diffusion zone diameter, interpretation (susceptible, intermediate, resistant, susceptible-dose dependent), testing method (Kirby-Bauer, broth microdilution, E-test), and CLSI breakpoint version applied. Supports antibiotic stewardship and infection control programs.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` (
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood product unit. Primary key for the blood bank unit record.',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Blood bank units are crossmatched against patient specimens. Currently no FK exists. Business reality: crossmatch requires patient specimen (type and screen). Adding crossmatch_specimen_id FK (nullabl',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Blood product units require HCPCS linkage for billing, inventory valuation, and utilization reporting. The hcpcs_code text field is denormalized; proper FK enables automated charge capture, payer cont',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Blood bank inventory management and hemovigilance reporting require tracking which care site a blood unit was issued to. issued_to_location is a denormalized text field. FDA hemovigilance regulations ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Blood products and transfusion supplies (filters, tubing, warmers, collection sets) are inventory items in the material master. This link enables blood bank inventory management, charge capture, and r',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Blood bank reservation workflow: units are reserved for specific patients pre-surgery or for chronic transfusion programs. reserved_for_patient_mrn is a denormalized patient reference; replacing with ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Blood bank operations are governed by FDA 21 CFR 606 and AABB compliance programs. Linking blood_bank_unit to its governing compliance program enables blood product traceability audits, FDA inspection',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Blood bank units are stored in specific temperature-controlled rooms (blood bank refrigerators). AABB standards and FDA regulations require precise physical location tracking for inventory management,',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical blood product reservation: blood bank units are cross-matched and reserved against specific surgical cases pre-operatively. Hospital blood bank operations require tracking which unit is reser',
    `abo_blood_group` STRING COMMENT 'ABO blood type of the unit. Critical for compatibility matching with recipient to prevent hemolytic transfusion reactions.. Valid values are `A|B|AB|O`',
    `bacterial_contamination_testing_status` STRING COMMENT 'Status of bacterial detection testing, primarily for platelet units which are stored at room temperature. Positive results require unit quarantine and discard.. Valid values are `tested_negative|tested_positive|pending|not_applicable`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Amount charged to the patient or payer for this blood unit. Used for revenue cycle management and billing.',
    `cmv_status` STRING COMMENT 'CMV serology status of the donor. CMV-negative or CMV-safe (leukoreduced) units are required for immunocompromised patients, neonates, and pregnant women.. Valid values are `cmv_negative|cmv_positive|cmv_safe`',
    `collection_facility_code` STRING COMMENT 'Identifier of the blood center or facility where the donation was collected. Required for traceability and recall management.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Acquisition or production cost of the blood unit. Used for inventory valuation, cost accounting, and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was first created in the system. Used for audit trail and data lineage.',
    `crossmatch_required_flag` BOOLEAN COMMENT 'Indicates whether a serologic crossmatch is required before issuing this unit. May be waived for type O emergency release or for patients with negative antibody screens.',
    `discard_reason` STRING COMMENT 'Reason why the unit was discarded. Used for quality improvement, waste reduction initiatives, and regulatory reporting. [ENUM-REF-CANDIDATE: expired|temperature_excursion|positive_test_result|damaged|contaminated|outdated|quality_control_failure|other — 8 candidates stripped; promote to reference product]',
    `discard_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was discarded. Triggers waste tracking and quality review processes.',
    `donation_date` DATE COMMENT 'Date when the blood was collected from the donor. Used to calculate product age and expiration date.',
    `donation_identification_number` STRING COMMENT 'Unique identifier assigned to the original blood donation from which this unit was derived. Links unit to donor record for traceability and recall purposes.',
    `expiration_date` DATE COMMENT 'Date after which the blood product is no longer suitable for transfusion. Varies by product type and storage conditions (e.g., 42 days for packed red cells, 5 days for platelets).',
    `extended_phenotype` STRING COMMENT 'Additional red blood cell antigen profile beyond ABO/Rh (e.g., Kell, Duffy, Kidd, MNS). Used for patients with alloantibodies or those requiring antigen-matched units.',
    `hemoglobin_s_status` STRING COMMENT 'Indicates presence of sickle hemoglobin in the donor unit. Some institutions avoid sickle trait units for neonatal or exchange transfusions.. Valid values are `negative|trait|positive|unknown`',
    `infectious_disease_testing_status` STRING COMMENT 'Overall status of mandatory infectious disease testing (HIV, HBV, HCV, syphilis, HTLV, West Nile Virus, Zika, Chagas). Only units testing negative are released for transfusion.. Valid values are `tested_negative|tested_positive|pending|not_tested`',
    `irradiation_date` DATE COMMENT 'Date when the blood unit was irradiated. Irradiated units have reduced shelf life (typically 28 days from irradiation or original expiration, whichever is sooner).',
    `irradiation_status` STRING COMMENT 'Indicates whether the unit has been gamma-irradiated to prevent transfusion-associated graft-versus-host disease (TA-GVHD) in immunocompromised patients.. Valid values are `irradiated|non_irradiated`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was issued from the blood bank to the clinical area for transfusion. Starts the clock for return or transfusion completion.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was last modified. Supports change tracking and audit compliance.',
    `leukoreduction_status` STRING COMMENT 'Indicates whether white blood cells have been removed from the unit. Leukoreduction reduces febrile reactions, CMV transmission risk, and HLA alloimmunization.. Valid values are `leukoreduced|non_leukoreduced`',
    `lot_number` STRING COMMENT 'Lot number for pooled products (e.g., pooled platelets, pooled cryoprecipitate) or for products manufactured from multiple donations. Required for recall management.',
    `product_code` STRING COMMENT 'Standardized code identifying the specific blood product type. Used for inventory management, ordering, and billing.. Valid values are `^[A-Z0-9]{4,10}$`',
    `product_type` STRING COMMENT 'Classification of the blood component or product. Determines storage requirements, shelf life, and clinical indications for transfusion.. Valid values are `packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes`',
    `quarantine_reason` STRING COMMENT 'Reason why the unit has been placed in quarantine status (e.g., pending investigation, donor callback, positive test result, temperature deviation). Prevents inadvertent release.',
    `quarantine_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was placed into quarantine status. Initiates investigation and documentation requirements.',
    `reservation_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was reserved for a specific patient. Used to manage hold times and release units if not transfused within policy timeframe.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when an issued unit was returned to the blood bank unused. Units returned within acceptable time and temperature may be re-entered into inventory.',
    `rh_type` STRING COMMENT 'Rh (D antigen) status of the blood unit. Essential for preventing Rh alloimmunization, especially in Rh-negative recipients.. Valid values are `positive|negative`',
    `source_system` STRING COMMENT 'Identifier of the Laboratory Information System (LIS) or blood bank system from which this record originated (e.g., Epic Beaker, Cerner PathNet). Supports data integration and troubleshooting.',
    `special_processing_codes` STRING COMMENT 'Comma-separated list of special processing or modifications applied to the unit (e.g., washed, volume-reduced, split, pooled). Affects clinical use and billing.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Current storage temperature in Celsius. Must be maintained within product-specific ranges (e.g., 1-6°C for red cells, 20-24°C for platelets, ≤-18°C for FFP).',
    `supplier_facility_code` STRING COMMENT 'Identifier of the external blood supplier or blood center if the unit was not collected in-house. Used for vendor management and recall coordination.',
    `temperature_alarm_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion alarm has been triggered for this unit. Temperature deviations may render the unit unsuitable for transfusion.',
    `transfusion_timestamp` TIMESTAMP COMMENT 'Date and time when the transfusion was started. Critical for hemovigilance reporting and adverse event investigation.',
    `unit_number` STRING COMMENT 'Globally unique blood unit identifier encoded using ISBT 128 standard barcode format. Enables worldwide traceability of blood products from donor to recipient.. Valid values are `^[A-Z0-9]{13,14}$`',
    `unit_status` STRING COMMENT 'Current lifecycle status of the blood unit. Tracks the unit from availability through final disposition (transfused, discarded, or returned). [ENUM-REF-CANDIDATE: available|reserved|crossmatched|issued|transfused|returned|discarded|quarantined|expired — 9 candidates stripped; promote to reference product]',
    `volume_ml` DECIMAL(18,2) COMMENT 'Volume of the blood product in milliliters. Used for dosing calculations and inventory management.',
    CONSTRAINT pk_blood_bank_unit PRIMARY KEY(`blood_bank_unit_id`)
) COMMENT 'Master record for each blood product unit managed by the transfusion medicine / blood bank service. Tracks unit number (ISBT 128 coded), product type (packed red cells, platelets, FFP, cryoprecipitate, whole blood, granulocytes), ABO/Rh type, donation date, expiration date, irradiation status, leukoreduction status, CMV status, sickle trait status, unit status lifecycle (available, reserved, crossmatched, issued, transfused, discarded, returned, quarantined), storage location, and temperature monitoring. SSOT for blood product inventory, traceability, and regulatory compliance. Supports AABB standards, FDA blood establishment regulations, and hemovigilance reporting.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` (
    `transfusion_event_id` BIGINT COMMENT 'Unique identifier for the transfusion event record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Scheduled outpatient transfusion appointments: patients with chronic anemia, sickle cell disease, or chemotherapy-related needs have recurring scheduled transfusion appointments. Linking transfusion_e',
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the specific blood product unit transfused. Links to blood bank inventory.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the healthcare facility where the transfusion was performed.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Transfusion events generate billable charges for blood products and administration services. Direct link supports charge capture at point of transfusion, enables blood bank revenue tracking, facilitat',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Blood transfusions are high-cost billable events generating claims for blood products, administration, and compatibility testing. Critical for blood bank revenue capture, transfusion service billing, ',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order authorizing the transfusion.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: AABB and Joint Commission accreditation standards require documented informed consent for every transfusion. transfusion_event has consent_obtained and consent_datetime as plain columns but no FK to t',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient receiving the transfusion. Links to the patient master record.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Transfusion events require HCPCS linkage for billing, hemovigilance reporting, and utilization management. Enables automated charge capture for blood administration, supports transfusion reaction cost',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Transfusions are ordered for specific diagnoses (e.g., anemia, hemorrhage, thrombocytopenia). Hemovigilance reporting, transfusion appropriateness review, and blood utilization management require link',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: A transfusion event is clinically initiated by a laboratory order (type and crossmatch, blood product order). Adding lab_order_id to transfusion_event creates a direct in-domain link from the transfus',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Hemovigilance reporting (AABB/Joint Commission) and transfusion reaction investigation require tracking the ordering clinician for each transfusion event. No existing clinician FK exists on transfusio',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Blood product transfusions are high-cost events requiring prior authorization and coverage verification. Utilization review programs monitor transfusion appropriateness, and billing requires payer ide',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Transfusions frequently require prior authorization from payers. Linking transfusion_event to the specific prior_auth_rule governing the authorization supports hemovigilance reporting, denial manageme',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Certain blood product transfusions (e.g., IVIG, factor concentrates, high-volume RBC transfusions) require prior authorization from payers. Linking transfusion_event to prior_authorization enables PA ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Transfusion events with hemovigilance_reported flag are governed by hemovigilance compliance programs (AABB, FDA MedWatch). Linking to the compliance program enables hemovigilance regulatory reporting',
    `specimen_id` BIGINT COMMENT 'Identifier for the patient blood specimen used for compatibility testing. Critical for ensuring correct patient-unit matching.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Blood transfusions during surgery are common and require tracking for blood bank management, surgical quality metrics, and hemovigilance reporting. Essential for linking intra-operative transfusions t',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter during which the transfusion occurred.',
    `antibody_screen_result` STRING COMMENT 'Result of the antibody screening test to detect unexpected antibodies in patient serum that could cause transfusion reactions.. Valid values are `positive|negative|not_performed|indeterminate`',
    `clinical_indication` STRING COMMENT 'Medical reason or clinical indication for the transfusion (e.g., acute blood loss, anemia, thrombocytopenia, coagulopathy). Supports appropriateness review and utilization management.',
    `consent_datetime` TIMESTAMP COMMENT 'Date and time when informed consent for transfusion was obtained.',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether informed consent for transfusion was obtained from the patient or authorized representative prior to administration.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was first created in the system. Audit trail timestamp.',
    `crossmatch_datetime` TIMESTAMP COMMENT 'Date and time when the crossmatch compatibility testing was completed.',
    `crossmatch_result` STRING COMMENT 'Outcome of the compatibility testing between donor unit and patient sample. Compatible indicates safe to transfuse, incompatible indicates potential reaction risk.. Valid values are `compatible|incompatible|not_performed|indeterminate`',
    `crossmatch_type` STRING COMMENT 'Type of compatibility testing performed prior to transfusion. Electronic crossmatch uses computer verification, immediate spin is abbreviated testing, full serologic is complete antiglobulin testing.. Valid values are `electronic|immediate_spin|full_serologic|type_and_screen|emergency_release`',
    `hemovigilance_reported` BOOLEAN COMMENT 'Boolean flag indicating whether this transfusion event was reported to the institutional or national hemovigilance surveillance system, typically for adverse reactions.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was most recently modified. Audit trail timestamp.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the transfusion event, including any special circumstances, patient tolerance, or follow-up actions.',
    `post_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured after transfusion completion. Used to detect respiratory complications.',
    `post_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured after transfusion completion. Used to detect febrile reactions.',
    `pre_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured immediately before transfusion start. Baseline for reaction monitoring.',
    `reaction_description` STRING COMMENT 'Free-text clinical description of the transfusion reaction signs, symptoms, and clinical course. May include fever, chills, rash, dyspnea, hypotension, or other manifestations.',
    `reaction_onset_datetime` TIMESTAMP COMMENT 'Date and time when the transfusion reaction symptoms were first observed. Critical for determining reaction type and causality.',
    `reaction_severity` STRING COMMENT 'Clinical severity classification of the transfusion reaction. Mild reactions may require monitoring only, severe and life-threatening reactions require immediate intervention.. Valid values are `mild|moderate|severe|life_threatening`',
    `special_requirements` STRING COMMENT 'Any special processing or handling requirements for the transfusion (e.g., irradiated, CMV-negative, leukoreduced, washed). Critical for immunocompromised patients.',
    `transfusion_end_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was completed or discontinued.',
    `transfusion_number` STRING COMMENT 'Human-readable business identifier for the transfusion event, often used for tracking and audit purposes.',
    `transfusion_rate` DECIMAL(18,2) COMMENT 'Rate at which the blood product was administered (e.g., 100 mL/hour, slow infusion over 4 hours). Important for patient safety and reaction prevention.',
    `transfusion_reaction_occurred` BOOLEAN COMMENT 'Boolean flag indicating whether any adverse transfusion reaction was observed during or after the transfusion.',
    `transfusion_reaction_type` STRING COMMENT 'Classification of the adverse transfusion reaction type if one occurred. Includes febrile non-hemolytic reaction (FNHTR), allergic, anaphylactic, acute hemolytic, delayed hemolytic, transfusion-related acute lung injury (TRALI), and transfusion-associated circulatory overload (TACO). [ENUM-REF-CANDIDATE: febrile_non_hemolytic|allergic|anaphylactic|acute_hemolytic|delayed_hemolytic|transfusion_related_acute_lung_injury|transfusion_associated_circulatory_overload — 7 candidates stripped; promote to reference product]',
    `transfusion_site` STRING COMMENT 'Anatomical location or clinical area where the transfusion was administered (e.g., right antecubital, left hand, central line).',
    `transfusion_start_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was initiated. Critical for monitoring transfusion duration and reaction timing.',
    `transfusion_status` STRING COMMENT 'Current lifecycle status of the transfusion event. Tracks progression from order through completion or discontinuation.. Valid values are `ordered|prepared|in_progress|completed|discontinued|cancelled`',
    `unexpected_antibody_identified` STRING COMMENT 'Specific antibody or antibodies identified during antibody identification testing, if antibody screen was positive. May include multiple antibodies separated by commas.',
    `volume_transfused_ml` STRING COMMENT 'Total volume of blood product transfused in milliliters. Used for dosing verification and fluid balance monitoring.',
    CONSTRAINT pk_transfusion_event PRIMARY KEY(`transfusion_event_id`)
) COMMENT 'Transactional record of the full blood product transfusion lifecycle from crossmatch/compatibility testing through administration and post-transfusion monitoring. Owns crossmatch and compatibility testing: crossmatch type (electronic, immediate spin, full serologic), compatibility result (compatible, incompatible), antibody screen result, unexpected antibody identification, patient blood sample reference, performing technologist, crossmatch date/time. Owns transfusion administration: blood bank unit transfused, transfusion start and end date/time, transfusion site, administering nurse, pre- and post-transfusion vital signs, transfusion reaction indicator and type, reaction severity, and clinical indication. Consolidates the former crossmatch product. Supports hemovigilance reporting, AABB compliance, blood bank audit trails, and patient safety surveillance.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the laboratory instrument. Primary key.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Instruments must operate under compliance programs (CLIA quality systems, proficiency testing). Required for tracking regulatory obligations, audit scope, and quality control program alignment per CLI',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Laboratory instruments are capital equipment acquired via purchase orders. Tracking the originating PO supports asset lifecycle management, warranty validation, depreciation calculation, and capital b',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Laboratory instruments are fixed assets installed in specific rooms. CLIA/CAP accreditation requires documented physical location for inspections, preventive maintenance scheduling, and operational pl',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Laboratory instruments are governed by vendor service/maintenance contracts. Instrument service contract management, warranty compliance, preventive maintenance scheduling, and capital equipment renew',
    `vendor_id` BIGINT COMMENT 'FK to supply.vendor',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the instrument, including purchase price, shipping, installation, and initial setup fees. Expressed in USD.',
    `asset_tag` STRING COMMENT 'Internal asset tracking identifier assigned by the healthcare organization for inventory and fixed asset management.',
    `calibration_frequency` STRING COMMENT 'Required frequency for calibration verification or full calibration per manufacturer specifications, CLIA requirements, or laboratory policy.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the instrument was permanently removed from service and decommissioned.',
    `decommission_reason` STRING COMMENT 'Business or technical justification for decommissioning the instrument (e.g., end of life, obsolescence, replacement, irreparable failure).',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned for use in the laboratory.',
    `instrument_name` STRING COMMENT 'Human-readable name or designation of the laboratory instrument as known to laboratory staff.',
    `instrument_type` STRING COMMENT 'Classification of the instrument by its primary analytical or operational function within the laboratory.. Valid values are `analyzer|centrifuge|microscope|incubator|spectrophotometer|other`',
    `lab_section` STRING COMMENT 'The laboratory department or section to which this instrument is assigned (e.g., Chemistry, Hematology, Microbiology).. Valid values are `chemistry|hematology|microbiology|immunology|blood_bank|molecular`',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was last calibrated to ensure measurement accuracy and precision.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration verification indicating whether the instrument met accuracy and precision specifications.. Valid values are `pass|fail|conditional`',
    `last_corrective_maintenance_date` DATE COMMENT 'Date when the most recent unscheduled corrective maintenance or repair was performed on the instrument.',
    `last_preventive_maintenance_date` DATE COMMENT 'Date when the most recent scheduled preventive maintenance was performed on the instrument.',
    `last_quality_control_date` DATE COMMENT 'Date when the most recent quality control testing was performed on the instrument.',
    `last_quality_control_result` STRING COMMENT 'Outcome of the most recent quality control testing indicating whether the instrument met performance specifications.. Valid values are `pass|fail|conditional`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was most recently modified.',
    `lis_connectivity_status` STRING COMMENT 'Current status of the bidirectional interface connection between the instrument and the Laboratory Information System.. Valid values are `connected|disconnected|error|not_applicable`',
    `lis_interface_code` STRING COMMENT 'Unique identifier used by the Laboratory Information System to communicate with and receive results from this instrument.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the laboratory instrument.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or designation for the instrument type.',
    `next_calibration_date` DATE COMMENT 'Scheduled date for the next calibration verification or full calibration of the instrument.',
    `next_preventive_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the instrument.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, known issues, or operational considerations for the instrument.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument indicating its availability for testing and analysis.. Valid values are `active|down|maintenance|decommissioned|pending_installation|calibration`',
    `preventive_maintenance_frequency` STRING COMMENT 'Scheduled frequency at which preventive maintenance must be performed on the instrument per manufacturer specifications or laboratory policy.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `quality_control_frequency` STRING COMMENT 'Required frequency for running quality control samples on the instrument to verify ongoing analytical performance.. Valid values are `per_shift|daily|weekly|per_run`',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit.',
    `service_contract_expiration_date` DATE COMMENT 'Date when the current service or maintenance contract for the instrument expires.',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'Cumulative hours the instrument has been non-operational due to maintenance, repair, or malfunction since installation or last reset period.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage for the instrument expires.',
    CONSTRAINT pk_instrument PRIMARY KEY(`instrument_id`)
) COMMENT 'Master record for every analytical instrument and analyzer operated within the laboratory, including its full maintenance, calibration, and service lifecycle. Tracks instrument identity: name, manufacturer, model, serial number, asset tag, lab section assignment, location (lab room/bench), CLIA certificate association, installation date, current operational status (active, down, maintenance, decommissioned), LIS interface connectivity. Owns all maintenance events: preventive maintenance schedules (daily, weekly, monthly), corrective maintenance events, calibration verification results, maintenance date/time, performing technician or vendor, tasks completed, parts replaced, downtime duration, and return-to-service authorization. Consolidates the former instrument_maintenance product. SSOT for laboratory instrument inventory, operational readiness, and CLIA/CAP maintenance documentation.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the laboratory test catalog entry. Primary key for the test catalog product.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Test catalog entries require structured CPT linkage for charge master maintenance, billing compliance, RVU-based productivity reporting, and payer contract validation. The cpt_code text field is denor',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test catalog entries require structured LOINC linkage for interoperability, HIE result exchange, quality measure reporting, and EHR integration. The loinc_code text field is denormalized; proper FK en',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each test catalog entry requires specific reagent kits, cartridges, or consumables. Linking to material master enables automated inventory planning, par level calculation, and test cost modeling—core ',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Therapeutic drug monitoring (TDM) and pharmacogenomics test catalogs are directly associated with specific drugs (NDC codes) for clinical decision support — e.g., vancomycin level test linked to vanco',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Specific tests in the catalog are mandated by regulatory obligations (e.g., newborn screening panels, mandatory STI reporting tests, CLIA-required QC panels). Linking test_catalog to the specific regu',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Test catalog orderable status and routing rules are scoped to specific performing care sites. Lab compendium management and order routing configuration require this FK. performing_lab_location is a de',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Lab test catalogs must document primary covered diagnosis codes per CMS Local Coverage Determinations (LCDs) and National Coverage Determinations (NCDs) for medical necessity validation. A primary ind',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Test catalog entries governed by compliance programs defining CLIA complexity levels, regulatory requirements, and authorization scope. Essential for maintaining compliant test menus and regulatory su',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test catalog entries require SNOMED CT linkage for clinical terminology standardization, order set management, and semantic interoperability. Enables precise test ordering, supports clinical decision ',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether payer prior authorization is typically required before performing this test due to cost or medical necessity criteria. Supports revenue cycle management.',
    `clia_complexity` STRING COMMENT 'CLIA complexity classification of the test: waived (simple, low risk), moderate complexity, or high complexity. Determines regulatory requirements and personnel qualifications.. Valid values are `waived|moderate|high`',
    `clinical_indication` STRING COMMENT 'Primary clinical use case, indication, or purpose for ordering this test. Supports clinical decision support and appropriate test utilization.',
    `collection_instructions` STRING COMMENT 'Detailed instructions for phlebotomy or specimen collection staff, including special handling, order of draw, collection technique, or timing requirements.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether informed patient consent is required before performing this test (e.g., genetic testing, HIV testing, research testing). Supports regulatory compliance and patient rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was first created in the system. Supports audit trail and historical tracking.',
    `critical_high_value` DECIMAL(18,2) COMMENT 'Upper threshold for critical value alerting. Results at or above this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `critical_low_value` DECIMAL(18,2) COMMENT 'Lower threshold for critical value alerting. Results at or below this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `effective_date` DATE COMMENT 'Date when this test catalog entry became or will become active and available for ordering. Supports test catalog version control and historical tracking.',
    `expiration_date` DATE COMMENT 'Date when this test catalog entry was or will be retired or inactivated. Null for currently active tests with no planned retirement date.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was last modified. Supports audit trail and change tracking for regulatory compliance.',
    `methodology` STRING COMMENT 'Analytical method or technology used to perform the test (e.g., immunoassay, PCR, mass spectrometry, flow cytometry, enzymatic assay, culture). Important for result interpretation and quality control.',
    `minimum_volume` STRING COMMENT 'Minimum volume of specimen required to perform the test, typically expressed with units (e.g., 2 mL, 5 mL, 0.5 mL). Critical for specimen adequacy assessment.',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this test is currently available for ordering by clinicians through CPOE (Computerized Physician Order Entry) systems. False for retired, suspended, or component-only tests.',
    `orderable_status` STRING COMMENT 'Current lifecycle status of the test in the catalog. Active tests are available for ordering; inactive/retired tests are no longer available; suspended tests are temporarily unavailable; pending validation tests are under review.. Valid values are `active|inactive|suspended|retired|pending_validation`',
    `ordering_instructions` STRING COMMENT 'Special instructions or requirements for ordering this test, including patient preparation (e.g., fasting required, medication restrictions), timing considerations, or authorization requirements.',
    `panic_value_flag` BOOLEAN COMMENT 'Indicates whether this test can produce panic or critical values requiring immediate clinical notification and documentation of provider acknowledgment.',
    `patient_preparation` STRING COMMENT 'Specific patient preparation requirements prior to specimen collection (e.g., 8-hour fast, discontinue medications, timed collection, dietary restrictions). Critical for accurate test results.',
    `preferred_volume` STRING COMMENT 'Preferred or optimal volume of specimen for best test performance and to allow for repeat testing if needed.',
    `reference_lab_code` STRING COMMENT 'Test code used by the external reference laboratory for ordering and tracking. Used for send-out test routing and result reconciliation.',
    `reference_lab_name` STRING COMMENT 'Name of the external reference laboratory if this is a send-out test not performed in-house. Null for tests performed internally.',
    `reference_range_adult` STRING COMMENT 'Normal reference range for adult patients, typically expressed as a range (e.g., 3.5-5.0, <10, negative). May vary by gender and age subgroups.',
    `reference_range_pediatric` STRING COMMENT 'Normal reference range for pediatric patients. May be age-stratified (e.g., neonate, infant, child, adolescent) due to developmental physiology differences.',
    `result_type` STRING COMMENT 'Type of result produced by the test: quantitative (numeric with units), qualitative (positive/negative/detected), semi-quantitative (titers, grades), narrative (free text interpretation), culture results, or microscopic findings.. Valid values are `quantitative|qualitative|semi_quantitative|narrative|culture|microscopic`',
    `specimen_container` STRING COMMENT 'Type of collection container or tube required (e.g., red top, lavender top EDTA, green top heparin, yellow top ACD, sterile container). Includes tube color and additive information.',
    `specimen_stability` STRING COMMENT 'Duration for which the specimen remains stable under specified storage conditions before testing must be performed (e.g., 24 hours at room temperature, 7 days refrigerated).',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for the test (e.g., blood, serum, plasma, urine, CSF, tissue, swab). Critical for specimen collection and handling.',
    `storage_temperature` STRING COMMENT 'Required storage temperature for the specimen prior to testing (e.g., room temperature, refrigerated 2-8°C, frozen -20°C, frozen -80°C). Critical for specimen stability.',
    `test_abbreviation` STRING COMMENT 'Short abbreviation or mnemonic for the test used in clinical documentation and reporting (e.g., CBC, BMP, CMP, TSH).',
    `test_category` STRING COMMENT 'High-level classification of the test by laboratory discipline or department (e.g., chemistry, hematology, microbiology, immunology, molecular diagnostics, anatomic pathology). [ENUM-REF-CANDIDATE: chemistry|hematology|microbiology|immunology|molecular|pathology|blood_bank|coagulation|toxicology|urinalysis — 10 candidates stripped; promote to reference product]',
    `test_code` STRING COMMENT 'Internal laboratory test code used for ordering and identification within the Laboratory Information System (LIS). Unique business identifier for the test or panel.',
    `test_name` STRING COMMENT 'Full descriptive name of the laboratory test or panel as displayed to clinicians and in order entry systems.',
    `test_type` STRING COMMENT 'Indicates whether this catalog entry represents an individual test, a panel (group of related tests), a profile, a reflex test (automatically triggered based on results), or an add-on test.. Valid values are `individual_test|panel|profile|reflex_test|add_on_test`',
    `transport_conditions` STRING COMMENT 'Special transport requirements for the specimen (e.g., transport on ice, ambient temperature, protect from light, transport immediately). Ensures specimen integrity during transport.',
    `turnaround_time_routine` STRING COMMENT 'Expected turnaround time for routine test orders from specimen receipt to result availability, typically expressed in hours or days (e.g., 4 hours, 24 hours, 3-5 days).',
    `turnaround_time_stat` STRING COMMENT 'Expected turnaround time for STAT (urgent) test orders requiring expedited processing, typically expressed in minutes or hours (e.g., 30 minutes, 1 hour, 2 hours).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantitative test results (e.g., mg/dL, mmol/L, IU/mL, cells/mcL, %). Aligned with UCUM (Unified Code for Units of Measure) standards.',
    CONSTRAINT pk_test_catalog PRIMARY KEY(`test_catalog_id`)
) COMMENT 'Reference master of all laboratory tests and test panels offered by the health system, serving as the SSOT for the laboratory test compendium. For individual tests: captures LOINC code, test name, CPT code(s) for billing, specimen requirements, container type, minimum volume, storage and transport conditions, turnaround time targets (routine and STAT), performing lab (internal section or reference lab name), methodology, and orderable flag. For panels and profiles (e.g., BMP, CMP, CBC with differential, lipid panel, hepatic function panel): captures panel LOINC code, panel name, component test relationships, clinical use case, panel-specific ordering rules, and orderable status. Also covers send-out test catalog entries with reference lab routing information. Consolidates the former test_panel product. Used by clinicians, order entry systems (CPOE), clinical decision support, and CDM charge alignment.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`laboratory`.`organism` (
    `organism_id` BIGINT COMMENT 'Primary key for organism',
    `parent_organism_id` BIGINT COMMENT 'Self-referencing FK on organism (parent_organism_id)',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Organisms are identified by SNOMED CT codes (hierarchy: 410607006 Organism) for clinical decision support, infection control surveillance, and public health reporting. Normalizing the plain snomed_ct',
    `aerobic_requirement` STRING COMMENT 'Oxygen requirement for organism growth, critical for culture media selection and incubation conditions in microbiology laboratories.',
    `antibiotic_resistance_profile` STRING COMMENT 'Known or typical antibiotic resistance patterns for this organism, including multidrug-resistant (MDR), extensively drug-resistant (XDR), or pan-drug-resistant (PDR) classifications.',
    `biosafety_level` STRING COMMENT 'Required biosafety containment level for handling this organism in laboratory settings, ranging from BSL-1 (minimal risk) to BSL-4 (maximum containment).',
    `clinical_significance` STRING COMMENT 'Description of the clinical importance and disease associations of this organism, including typical presentations and severity of infections.',
    `common_infection_sites` STRING COMMENT 'Typical anatomical sites or body systems where this organism causes infection (e.g., respiratory, urinary tract, bloodstream, skin), used for clinical correlation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this organism reference record was first created in the system.',
    `culture_media_requirements` STRING COMMENT 'Specific culture media and growth conditions required for laboratory isolation and identification of this organism (e.g., blood agar, chocolate agar, selective media).',
    `effective_date` DATE COMMENT 'Date when this organism reference record became effective and available for use in laboratory information systems.',
    `environmental_reservoir` STRING COMMENT 'Natural environmental sources or reservoirs where this organism is commonly found (e.g., soil, water, animals, plants, healthcare environment).',
    `expiration_date` DATE COMMENT 'Date when this organism reference record is no longer valid for use, typically due to taxonomy reclassification or nomenclature updates.',
    `gram_stain_result` STRING COMMENT 'Gram staining classification of bacterial organisms, critical for initial identification and antibiotic selection. Not applicable for non-bacterial organisms.',
    `identification_methods` STRING COMMENT 'Laboratory methods and techniques used for definitive identification of this organism (e.g., biochemical tests, mass spectrometry, molecular methods, sequencing).',
    `incubation_duration_hours` STRING COMMENT 'Typical incubation time in hours required for visible growth or detection of this organism in laboratory cultures.',
    `incubation_temperature_celsius` DECIMAL(18,2) COMMENT 'Optimal temperature in degrees Celsius for culturing and growing this organism in laboratory settings.',
    `isolation_precautions` STRING COMMENT 'Recommended infection control precautions for patients infected with this organism (e.g., standard, contact, droplet, airborne, protective environment).',
    `loinc_code` STRING COMMENT 'LOINC code associated with laboratory tests for identifying or detecting this organism, supporting standardized test result reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this organism reference record was last modified or updated.',
    `morphology` STRING COMMENT 'Microscopic morphological characteristics of the organism (e.g., cocci, bacilli, spiral, yeast, hyphae) used in laboratory identification.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special considerations related to this organism for laboratory staff reference.',
    `organism_code` STRING COMMENT 'Standardized code representing the organism, typically aligned with SNOMED CT or laboratory information system coding standards.',
    `organism_name` STRING COMMENT 'Common or scientific name of the organism as used in clinical and laboratory contexts.',
    `organism_status` STRING COMMENT 'Current lifecycle status of this organism reference record, indicating whether it is actively used in laboratory systems or has been deprecated due to taxonomy updates.',
    `organism_type` STRING COMMENT 'High-level classification of the organism into major biological categories relevant to laboratory diagnostics and infection control.',
    `pathogenicity_level` STRING COMMENT 'Classification of the organisms disease-causing potential, used for infection control, biosafety protocols, and clinical interpretation.',
    `reportable_status` STRING COMMENT 'Indicates whether detection of this organism requires mandatory reporting to public health authorities at state, national, or international levels.',
    `scientific_name` STRING COMMENT 'Full binomial or trinomial scientific name of the organism following taxonomic nomenclature standards (genus, species, subspecies).',
    `specimen_types` STRING COMMENT 'Types of clinical specimens from which this organism is typically isolated or detected (e.g., blood, urine, sputum, wound, stool, cerebrospinal fluid).',
    `taxonomy_class` STRING COMMENT 'Class-level taxonomic classification of the organism within the biological hierarchy.',
    `taxonomy_family` STRING COMMENT 'Family-level taxonomic classification of the organism, grouping related genera together.',
    `taxonomy_genus` STRING COMMENT 'Genus-level taxonomic classification, the first part of the binomial scientific name (e.g., Staphylococcus, Escherichia).',
    `taxonomy_kingdom` STRING COMMENT 'Highest taxonomic rank classification of the organism (e.g., Bacteria, Archaea, Eukarya, Viruses) per biological taxonomy standards.',
    `taxonomy_order` STRING COMMENT 'Order-level taxonomic classification of the organism, further refining the biological classification hierarchy.',
    `taxonomy_phylum` STRING COMMENT 'Phylum-level taxonomic classification of the organism, providing intermediate hierarchical context for biological classification.',
    `taxonomy_species` STRING COMMENT 'Species-level taxonomic classification, the second part of the binomial scientific name (e.g., aureus, coli).',
    `transmission_mode` STRING COMMENT 'Primary modes of transmission for this organism (e.g., airborne, droplet, contact, vector-borne, foodborne, waterborne), critical for infection prevention and control.',
    `zoonotic_potential` BOOLEAN COMMENT 'Indicates whether this organism can be transmitted between animals and humans, important for occupational health and epidemiological tracking.',
    CONSTRAINT pk_organism PRIMARY KEY(`organism_id`)
) COMMENT 'Master reference table for organism. Referenced by organism_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `healthcare_ecm`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `healthcare_ecm`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `healthcare_ecm`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_organism_id` FOREIGN KEY (`organism_id`) REFERENCES `healthcare_ecm`.`laboratory`.`organism`(`organism_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_blood_bank_unit_id` FOREIGN KEY (`blood_bank_unit_id`) REFERENCES `healthcare_ecm`.`laboratory`.`blood_bank_unit`(`blood_bank_unit_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_parent_organism_id` FOREIGN KEY (`parent_organism_id`) REFERENCES `healthcare_ecm`.`laboratory`.`organism`(`organism_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` SET TAGS ('dbx_subdomain' = 'test_operations');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lab Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Set Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Provider ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Billing Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `expected_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Expected Turnaround Time Hours');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_business_glossary_term' = 'Fasting Required Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `is_send_out` SET TAGS ('dbx_business_glossary_term' = 'Is Send-Out Order Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Priority');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|ASAP|timed|urgent');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `point_of_care_test` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Care Test Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_accession_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Accession Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Result Integration Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_value_regex' = 'pending|integrated|failed|manual_entry_required');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Received Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Tracking Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `source_system_order_number` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Shipped Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`lab_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` SET TAGS ('dbx_subdomain' = 'test_operations');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Specimen Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `accession_datetime` SET TAGS ('dbx_business_glossary_term' = 'Accession Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('dbx_business_glossary_term' = 'Accession Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('dbx_value_regex' = 'received|processing|resulted|archived|rejected');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_business_glossary_term' = 'Biohazard Level');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_value_regex' = 'standard|high_risk|unknown');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'intact|broken|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Collection Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Collection Duration (Minutes)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `collector_role` SET TAGS ('dbx_business_glossary_term' = 'Collector Role');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Specimen Comments');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition at Receipt');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_value_regex' = 'acceptable|hemolyzed|clotted|insufficient|contaminated|unlabeled');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `disposal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_business_glossary_term' = 'Fasting Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_value_regex' = 'fasting|non_fasting|unknown');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `number_of_aliquots` SET TAGS ('dbx_business_glossary_term' = 'Number of Aliquots');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Specimen Priority');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('dbx_value_regex' = 'active|retained|disposed|archived');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `specimen_source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|urine|tissue|csf|swab|stool');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Transport Duration (Minutes)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `transport_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Transport Temperature (Celsius)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`specimen` ALTER COLUMN `volume_collected_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected (Milliliters)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` SET TAGS ('dbx_subdomain' = 'test_operations');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Instrument Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pathologist Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Result Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_business_glossary_term' = 'Abnormal Flag Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_value_regex' = 'normal|low|high|critical_low|critical_high|abnormal');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `amendment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Amendment Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Result Amendment Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_acknowledgment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Acknowledgment Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Alert Generated Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_escalation_action` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Escalation Action');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('dbx_value_regex' = 'phone|secure_message|ehr_alert|page|fax|in_person');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `critical_value_resolution_note` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Resolution Note');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Result Amended Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `is_critical_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Original Numeric Result Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Original Text Result Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `performing_lab_section` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Section');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment or Note');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Clinical Interpretation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Released Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status Lifecycle');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|corrected|cancelled|entered_in_error');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('dbx_business_glossary_term' = 'Coded Result Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Result Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Text Result Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Received Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` SET TAGS ('dbx_subdomain' = 'test_operations');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Patient Age Group');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority Level');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|stat');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `alert_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Trigger Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `critical_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `critical_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_value_regex' = 'normal|low|high|critical_low|critical_high|abnormal');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `lis_system_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) System Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `lower_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Normal Limit');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Override Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Notes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `population_basis` SET TAGS ('dbx_business_glossary_term' = 'Reference Population Basis');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_value_regex' = 'pregnant|not_pregnant|not_applicable|unknown');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race and Ethnicity');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'current|pending_review|under_revision|retired');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Reference Population Sample Size');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Patient Sex');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|all|unknown');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `source_citation` SET TAGS ('dbx_business_glossary_term' = 'Source Citation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Source Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'cap|clia|manufacturer|institutional|peer_reviewed');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`reference_range` ALTER COLUMN `upper_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Normal Limit');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` SET TAGS ('dbx_subdomain' = 'diagnostic_reporting');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `coding_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coding Assignment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `addendum_history` SET TAGS ('dbx_business_glossary_term' = 'Addendum History');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Amendment Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `cancer_registry_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancer Registry Reportable Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Pathology Case Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Pathologist Comment');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Final Pathological Diagnosis');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('dbx_business_glossary_term' = 'Gross Description');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_business_glossary_term' = 'Histologic Grade');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_value_regex' = 'well_differentiated|moderately_differentiated|poorly_differentiated|undifferentiated|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('dbx_business_glossary_term' = 'Histologic Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('dbx_business_glossary_term' = 'Immunohistochemistry (IHC) Results');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('dbx_business_glossary_term' = 'Number of Lymph Nodes Examined');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('dbx_business_glossary_term' = 'Number of Lymph Nodes Positive for Metastasis');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_business_glossary_term' = 'Surgical Margin Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_value_regex' = 'negative|positive|close|indeterminate|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('dbx_business_glossary_term' = 'Microscopic Description');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_business_glossary_term' = 'Molecular Testing Results');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `preliminary_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Report Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Received Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|corrected|cancelled');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'surgical_pathology|cytology|hematopathology|dermatopathology|neuropathology|autopsy');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `sign_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Sign-Out Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `special_stains_performed` SET TAGS ('dbx_business_glossary_term' = 'Special Stains Performed');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('dbx_business_glossary_term' = 'Synoptic Report Elements');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('dbx_business_glossary_term' = 'TNM Stage');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_board_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tumor Board Reviewed Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('dbx_business_glossary_term' = 'Tumor Site');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('dbx_business_glossary_term' = 'Tumor Size in Centimeters');
ALTER TABLE `healthcare_ecm`.`laboratory`.`pathology_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_subdomain' = 'diagnostic_reporting');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_business_glossary_term' = 'Microbiology Culture Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory (Lab) Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `organism_id` SET TAGS ('dbx_business_glossary_term' = 'Organism Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Organism Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Stewardship Program (ASP) Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units (CFU) Count');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('dbx_business_glossary_term' = 'Colony Count Unit of Measure');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('dbx_value_regex' = 'CFU/mL|CFU/plate|CFU/gram');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Alert Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_business_glossary_term' = 'Culture Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_value_regex' = 'ordered|in_progress|preliminary|final|corrected|cancelled');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('dbx_business_glossary_term' = 'Culture Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_business_glossary_term' = 'Gram Stain Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_value_regex' = 'gram_positive|gram_negative|gram_variable|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_business_glossary_term' = 'Culture Growth Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_value_regex' = 'no_growth|light_growth|moderate_growth|heavy_growth|mixed_flora|contaminated');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_associated_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('dbx_value_regex' = 'CLABSI|CAUTI|SSI|VAP|CDI');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `incubation_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incubation Start Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `infection_control_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Notification Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `isolation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Organism Isolation Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Drug Resistant Organism (MDRO) Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('dbx_business_glossary_term' = 'Multi-Drug Resistant Organism (MDRO) Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('dbx_value_regex' = 'MRSA|VRE|ESBL|CRE|MDR_Acinetobacter|MDR_Pseudomonas');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('dbx_business_glossary_term' = 'Organism Morphology');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Reportable Condition Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `quality_control_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Passed Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Receipt Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('dbx_business_glossary_term' = 'Result Comments and Notes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Finalization Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Clinical Interpretation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source SNOMED CT Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Testing Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_value_regex' = 'disk_diffusion|broth_microdilution|etest|automated_system');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('dbx_business_glossary_term' = 'Antimicrobial Susceptibility Testing (AST) Performed Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Turnaround Time in Hours');
ALTER TABLE `healthcare_ecm`.`laboratory`.`microbiology_culture` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` SET TAGS ('dbx_subdomain' = 'diagnostic_reporting');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_result_id` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Result Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Instrument Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory (Lab) Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_business_glossary_term' = 'Culture Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `organism_id` SET TAGS ('dbx_business_glossary_term' = 'Organism Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_code` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Agent Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Agent Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_class` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Class');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Stewardship Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `clsi_breakpoint_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical and Laboratory Standards Institute (CLSI) Breakpoint Version');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `disk_diffusion_zone_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Disk Diffusion Zone Diameter (Millimeters)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `inducible_resistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Inducible Resistance Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `infection_control_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Alert Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_operator` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Operator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_operator` SET TAGS ('dbx_value_regex' = '=|<=|>=|<|>');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Unit of Measure');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_unit` SET TAGS ('dbx_value_regex' = 'mcg/mL|mg/L|IU/mL');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `mic_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inhibitory Concentration (MIC) Value');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_code` SET TAGS ('dbx_business_glossary_term' = 'Antimicrobial Panel Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Antimicrobial Panel Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable to Public Health Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `reportable_to_public_health_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistance_gene` SET TAGS ('dbx_business_glossary_term' = 'Resistance Gene');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistance_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Resistance Mechanism');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `resistant_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Resistant Breakpoint Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|corrected|cancelled|entered in error');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Interpretation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptibility_interpretation` SET TAGS ('dbx_value_regex' = 'susceptible|intermediate|resistant|susceptible-dose dependent|not tested|indeterminate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `susceptible_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Susceptible Breakpoint Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('dbx_business_glossary_term' = 'Synergy Test Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `synergy_test_result` SET TAGS ('dbx_value_regex' = 'positive|negative|not performed');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('dbx_business_glossary_term' = 'Antimicrobial Susceptibility Testing (AST) Method');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `testing_method` SET TAGS ('dbx_value_regex' = 'broth microdilution|disk diffusion|E-test|automated system|agar dilution|gradient diffusion');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`susceptibility_result` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Specimen Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_business_glossary_term' = 'ABO Blood Group');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_value_regex' = 'A|B|AB|O');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Bacterial Contamination Testing Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_value_regex' = 'tested_negative|tested_positive|pending|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Charge Amount');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('dbx_business_glossary_term' = 'Cytomegalovirus (CMV) Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('dbx_value_regex' = 'cmv_negative|cmv_positive|cmv_safe');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `collection_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Blood Collection Facility Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Cost Amount');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `crossmatch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Required Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_reason` SET TAGS ('dbx_business_glossary_term' = 'Discard Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discard Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_date` SET TAGS ('dbx_business_glossary_term' = 'Blood Donation Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Donation Identification Number (DIN)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Expiration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `extended_phenotype` SET TAGS ('dbx_business_glossary_term' = 'Extended Red Cell Phenotype');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('dbx_business_glossary_term' = 'Hemoglobin S (Sickle Cell) Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('dbx_value_regex' = 'negative|trait|positive|unknown');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Infectious Disease Testing Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_value_regex' = 'tested_negative|tested_positive|pending|not_tested');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_date` SET TAGS ('dbx_business_glossary_term' = 'Irradiation Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('dbx_business_glossary_term' = 'Irradiation Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('dbx_value_regex' = 'irradiated|non_irradiated');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('dbx_business_glossary_term' = 'Leukoreduction Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('dbx_value_regex' = 'leukoreduced|non_leukoreduced');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Lot Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Blood Product Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Blood Product Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('dbx_business_glossary_term' = 'Rh Factor Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('dbx_value_regex' = 'positive|negative');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `special_processing_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Processing Codes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `supplier_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Facility Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `temperature_alarm_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Alarm Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `transfusion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Number (ISBT 128)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{13,14}$');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`blood_bank_unit` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Volume (Milliliters)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Event Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Blood Sample Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Antibody Screen Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('dbx_value_regex' = 'positive|negative|not_performed|indeterminate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_datetime` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('dbx_value_regex' = 'compatible|incompatible|not_performed|indeterminate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('dbx_value_regex' = 'electronic|immediate_spin|full_serologic|type_and_screen|emergency_release');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `hemovigilance_reported` SET TAGS ('dbx_business_glossary_term' = 'Hemovigilance Reported Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Notes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Blood Pressure Diastolic');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Blood Pressure Systolic');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_pulse` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Pulse Rate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_respiratory_rate` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Respiratory Rate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_temperature` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Temperature');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Blood Pressure Diastolic');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Blood Pressure Systolic');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_pulse` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Pulse Rate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_respiratory_rate` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Respiratory Rate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_temperature` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Temperature');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_description` SET TAGS ('dbx_business_glossary_term' = 'Reaction Description');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_onset_datetime` SET TAGS ('dbx_business_glossary_term' = 'Reaction Onset Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('dbx_business_glossary_term' = 'Reaction Severity');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transfusion End Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_number` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_rate` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Rate');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_occurred` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Occurred Indicator');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_site` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Site');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Start Date and Time');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('dbx_value_regex' = 'ordered|prepared|in_progress|completed|discontinued|cancelled');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `unexpected_antibody_identified` SET TAGS ('dbx_business_glossary_term' = 'Unexpected Antibody Identified');
ALTER TABLE `healthcare_ecm`.`laboratory`.`transfusion_event` ALTER COLUMN `volume_transfused_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Transfused in Milliliters (mL)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'analyzer|centrifuge|microscope|incubator|spectrophotometer|other');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Section');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `lab_section` SET TAGS ('dbx_value_regex' = 'chemistry|hematology|microbiology|immunology|blood_bank|molecular');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_corrective_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Corrective Maintenance Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Control (QC) Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Control (QC) Result');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_quality_control_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) Connectivity Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `lis_connectivity_status` SET TAGS ('dbx_value_regex' = 'connected|disconnected|error|not_applicable');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `lis_interface_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) Interface ID');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|down|maintenance|decommissioned|pending_installation|calibration');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Frequency');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `preventive_maintenance_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Frequency');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `quality_control_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|daily|weekly|per_run');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `total_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime Hours');
ALTER TABLE `healthcare_ecm`.`laboratory`.`instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` SET TAGS ('dbx_subdomain' = 'test_operations');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Indication Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Complexity Level');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `collection_instructions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Instructions');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Required Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `critical_high_value` SET TAGS ('dbx_business_glossary_term' = 'Critical High Value Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `critical_low_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Value Threshold');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `minimum_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Specimen Volume');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_business_glossary_term' = 'Orderable Status');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|pending_validation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `ordering_instructions` SET TAGS ('dbx_business_glossary_term' = 'Ordering Instructions');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `panic_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Panic Value Flag');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Requirements');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `preferred_volume` SET TAGS ('dbx_business_glossary_term' = 'Preferred Specimen Volume');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Test Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_adult` SET TAGS ('dbx_business_glossary_term' = 'Adult Reference Range');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_pediatric` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Reference Range');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Result Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|semi_quantitative|narrative|culture|microscopic');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_business_glossary_term' = 'Specimen Container Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_business_glossary_term' = 'Specimen Stability Duration');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Specimen Storage Temperature');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Abbreviation');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Category');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Code');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Name');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Type');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'individual_test|panel|profile|reflex_test|add_on_test');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Transport Conditions');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_business_glossary_term' = 'Routine Turnaround Time (TAT)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_stat` SET TAGS ('dbx_business_glossary_term' = 'STAT Turnaround Time (TAT)');
ALTER TABLE `healthcare_ecm`.`laboratory`.`test_catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` SET TAGS ('dbx_subdomain' = 'diagnostic_reporting');
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` ALTER COLUMN `organism_id` SET TAGS ('dbx_business_glossary_term' = 'Organism Identifier');
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` ALTER COLUMN `parent_organism_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `healthcare_ecm`.`laboratory`.`organism` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
