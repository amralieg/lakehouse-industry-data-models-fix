-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`quality` COMMENT 'Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `aql_level` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gmp_critical_flag` BOOLEAN COMMENT '',
    `inspection_frequency` STRING COMMENT '',
    `inspection_stage` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `plan_code` STRING COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `regulatory_requirement_reference` STRING COMMENT '',
    `sample_size` STRING COMMENT '',
    `sampling_procedure` STRING COMMENT '',
    `inspection_plan_status` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master plan defining inspection procedures, sampling strategies, and acceptance criteria for materials, in-process, and finished goods';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT '',
    `inspection_plan_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `lot_batch_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `production_order_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `defect_count` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `inspection_completion_date` DATE COMMENT '',
    `inspection_lot_number` STRING COMMENT '',
    `inspection_start_date` DATE COMMENT '',
    `inspection_status` STRING COMMENT '',
    `inspection_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lot_size_quantity` DECIMAL(18,2) COMMENT '',
    `lot_size_uom` STRING COMMENT '',
    `manufacturing_date` DATE COMMENT '',
    `overall_result` STRING COMMENT '',
    `sample_quantity` DECIMAL(18,2) COMMENT '',
    `usage_decision_code` STRING COMMENT '',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Specific batch or lot of material/product subject to quality inspection per the inspection plan';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT '',
    `equipment_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `lab_test_request_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT '',
    `calibration_due_date` DATE COMMENT '',
    `characteristic_code` STRING COMMENT '',
    `characteristic_name` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `deviation_percentage` DECIMAL(18,2) COMMENT '',
    `lower_specification_limit` DECIMAL(18,2) COMMENT '',
    `measured_value` DECIMAL(18,2) COMMENT '',
    `measurement_uom` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `pass_fail_flag` BOOLEAN COMMENT '',
    `result_status` STRING COMMENT '',
    `retest_required_flag` BOOLEAN COMMENT '',
    `target_value` DECIMAL(18,2) COMMENT '',
    `test_date` DATE COMMENT '',
    `test_method` STRING COMMENT '',
    `test_timestamp` TIMESTAMP COMMENT '',
    `upper_specification_limit` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Individual test or inspection characteristic result recorded during quality inspection';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` (
    `usage_decision_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `accepted_quantity` DECIMAL(18,2) COMMENT '',
    `concession_reference` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `decision_code` STRING COMMENT '',
    `decision_date` DATE COMMENT '',
    `decision_description` STRING COMMENT '',
    `decision_timestamp` TIMESTAMP COMMENT '',
    `deviation_reference` STRING COMMENT '',
    `disposition_notes` STRING COMMENT '',
    `disposition_reason_code` STRING COMMENT '',
    `quality_hold_flag` BOOLEAN COMMENT '',
    `quantity_uom` STRING COMMENT '',
    `regulatory_notification_required` BOOLEAN COMMENT '',
    `rejected_quantity` DECIMAL(18,2) COMMENT '',
    `rework_quantity` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_usage_decision PRIMARY KEY(`usage_decision_id`)
) COMMENT 'Disposition decision for inspected lot: accept, reject, rework, or conditional release';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` (
    `nonconformance_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `nonconformance_reported_by_employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `capa_id` BIGINT COMMENT '',
    `actual_closure_date` DATE COMMENT '',
    `affected_quantity` DECIMAL(18,2) COMMENT '',
    `affected_quantity_uom` STRING COMMENT '',
    `batch_number` STRING COMMENT '',
    `containment_action` STRING COMMENT '',
    `corrective_action` STRING COMMENT '',
    `cost_currency_code` STRING COMMENT '',
    `cost_impact_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_notification_required` BOOLEAN COMMENT '',
    `nonconformance_description` STRING COMMENT '',
    `detection_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `nonconformance_number` STRING COMMENT '',
    `nonconformance_type` STRING COMMENT '',
    `occurrence_date` DATE COMMENT '',
    `regulatory_reportable_flag` BOOLEAN COMMENT '',
    `root_cause` STRING COMMENT '',
    `severity_level` STRING COMMENT '',
    `nonconformance_status` STRING COMMENT '',
    `target_closure_date` DATE COMMENT '',
    CONSTRAINT pk_nonconformance PRIMARY KEY(`nonconformance_id`)
) COMMENT 'Record of quality defect, deviation, or non-compliance event requiring investigation and corrective action';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `capa_assigned_to_employee_id` BIGINT COMMENT '',
    `capa_initiated_by_employee_id` BIGINT COMMENT '',
    `nonconformance_id` BIGINT COMMENT '',
    `audit_finding_id` BIGINT COMMENT '',
    `product_complaint_id` BIGINT COMMENT '',
    `actual_completion_date` DATE COMMENT '',
    `approval_date` DATE COMMENT '',
    `capa_number` STRING COMMENT '',
    `capa_type` STRING COMMENT '',
    `closure_date` DATE COMMENT '',
    `corrective_action_plan` STRING COMMENT '',
    `cost_currency_code` STRING COMMENT '',
    `cost_estimate_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `capa_description` STRING COMMENT '',
    `effectiveness_check_date` DATE COMMENT '',
    `effectiveness_verified_flag` BOOLEAN COMMENT '',
    `initiation_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `preventive_action_plan` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `root_cause_analysis` STRING COMMENT '',
    `capa_status` STRING COMMENT '',
    `target_completion_date` DATE COMMENT '',
    `title` STRING COMMENT '',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action record to address root causes of quality issues and prevent recurrence';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` (
    `batch_release_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `production_order_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `certificate_of_analysis_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT '',
    `conditional_release_flag` BOOLEAN COMMENT '',
    `conditional_release_reason` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gmp_compliant_flag` BOOLEAN COMMENT '',
    `manufacturing_date` DATE COMMENT '',
    `quantity_uom` STRING COMMENT '',
    `regulatory_approval_reference` STRING COMMENT '',
    `release_date` DATE COMMENT '',
    `release_notes` STRING COMMENT '',
    `release_number` STRING COMMENT '',
    `release_status` STRING COMMENT '',
    `release_timestamp` TIMESTAMP COMMENT '',
    `released_quantity` DECIMAL(18,2) COMMENT '',
    `retest_date` DATE COMMENT '',
    `shelf_life_days` STRING COMMENT '',
    CONSTRAINT pk_batch_release PRIMARY KEY(`batch_release_id`)
) COMMENT 'Final quality approval authorizing a manufactured batch for distribution and sale';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` (
    `certificate_of_analysis_id` BIGINT COMMENT '',
    `batch_release_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `allergen_statement` STRING COMMENT '',
    `batch_number` STRING COMMENT '',
    `batch_size_quantity` DECIMAL(18,2) COMMENT '',
    `batch_size_uom` STRING COMMENT '',
    `coa_number` STRING COMMENT '',
    `compliance_statement` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `digital_signature` STRING COMMENT '',
    `document_url` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gmp_statement` STRING COMMENT '',
    `halal_certified_flag` BOOLEAN COMMENT '',
    `issue_date` DATE COMMENT '',
    `kosher_certified_flag` BOOLEAN COMMENT '',
    `manufacturing_date` DATE COMMENT '',
    `organic_certified_flag` BOOLEAN COMMENT '',
    `product_code` STRING COMMENT '',
    `product_name` STRING COMMENT '',
    `specification_reference` STRING COMMENT '',
    `test_results_summary` STRING COMMENT '',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Official document certifying that a batch meets all quality specifications and regulatory requirements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` (
    `quality_stability_study_id` BIGINT COMMENT '',
    `research_stability_study_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `light_exposure_condition` STRING COMMENT '',
    `manufacturing_date` DATE COMMENT '',
    `packaging_configuration` STRING COMMENT '',
    `protocol_reference` STRING COMMENT '',
    `regulatory_requirement_reference` STRING COMMENT '',
    `relative_humidity_percent` DECIMAL(18,2) COMMENT '',
    `sample_size` STRING COMMENT '',
    `quality_stability_study_status` STRING COMMENT '',
    `storage_condition` STRING COMMENT '',
    `study_duration_months` STRING COMMENT '',
    `study_end_date` DATE COMMENT '',
    `study_number` STRING COMMENT '',
    `study_purpose` STRING COMMENT '',
    `study_start_date` DATE COMMENT '',
    `study_title` STRING COMMENT '',
    `study_type` STRING COMMENT '',
    `temperature_celsius` DECIMAL(18,2) COMMENT '',
    `testing_frequency` STRING COMMENT '',
    CONSTRAINT pk_quality_stability_study PRIMARY KEY(`quality_stability_study_id`)
) COMMENT 'Long-term study monitoring product quality attributes over time under defined storage conditions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` (
    `stability_result_id` BIGINT COMMENT '',
    `quality_stability_study_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `change_from_initial_percent` DECIMAL(18,2) COMMENT '',
    `characteristic_code` STRING COMMENT '',
    `characteristic_name` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `elapsed_time_days` STRING COMMENT '',
    `initial_value` DECIMAL(18,2) COMMENT '',
    `lower_specification_limit` DECIMAL(18,2) COMMENT '',
    `measured_value` DECIMAL(18,2) COMMENT '',
    `measurement_uom` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `out_of_specification_flag` BOOLEAN COMMENT '',
    `pass_fail_flag` BOOLEAN COMMENT '',
    `result_status` STRING COMMENT '',
    `test_date` DATE COMMENT '',
    `test_method` STRING COMMENT '',
    `timepoint_description` STRING COMMENT '',
    `timepoint_number` STRING COMMENT '',
    `upper_specification_limit` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_stability_result PRIMARY KEY(`stability_result_id`)
) COMMENT 'Individual timepoint measurement from a stability study tracking product degradation over time';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` (
    `gmp_audit_id` BIGINT COMMENT '',
    `audit_program_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `audit_end_date` DATE COMMENT '',
    `audit_number` STRING COMMENT '',
    `audit_report_url` STRING COMMENT '',
    `audit_scope` STRING COMMENT '',
    `audit_standard` STRING COMMENT '',
    `audit_start_date` DATE COMMENT '',
    `audit_status` STRING COMMENT '',
    `audit_title` STRING COMMENT '',
    `audit_type` STRING COMMENT '',
    `certification_body` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `critical_findings_count` STRING COMMENT '',
    `follow_up_due_date` DATE COMMENT '',
    `follow_up_required_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `major_findings_count` STRING COMMENT '',
    `minor_findings_count` STRING COMMENT '',
    `observations_count` STRING COMMENT '',
    `overall_rating` STRING COMMENT '',
    `regulatory_authority` STRING COMMENT '',
    CONSTRAINT pk_gmp_audit PRIMARY KEY(`gmp_audit_id`)
) COMMENT 'Good Manufacturing Practice audit assessing compliance with quality system regulations and standards';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `capa_id` BIGINT COMMENT '',
    `gmp_audit_id` BIGINT COMMENT '',
    `actual_closure_date` DATE COMMENT '',
    `clause_reference` STRING COMMENT '',
    `corrective_action_plan` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `audit_finding_description` STRING COMMENT '',
    `detection_date` DATE COMMENT '',
    `finding_category` STRING COMMENT '',
    `finding_number` STRING COMMENT '',
    `finding_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `objective_evidence` STRING COMMENT '',
    `requirement_reference` STRING COMMENT '',
    `severity_level` STRING COMMENT '',
    `audit_finding_status` STRING COMMENT '',
    `target_closure_date` DATE COMMENT '',
    `verification_date` DATE COMMENT '',
    `verification_method` STRING COMMENT '',
    `verified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Specific non-conformance or observation identified during a quality audit requiring corrective action';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` (
    `supplier_assessment_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT '',
    `supplier_site_id` BIGINT COMMENT '',
    `approved_supplier_flag` BOOLEAN COMMENT '',
    `assessment_date` DATE COMMENT '',
    `assessment_method` STRING COMMENT '',
    `assessment_number` STRING COMMENT '',
    `assessment_report_url` STRING COMMENT '',
    `assessment_type` STRING COMMENT '',
    `compliance_score` DECIMAL(18,2) COMMENT '',
    `corrective_actions_required` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `critical_findings_count` STRING COMMENT '',
    `delivery_score` DECIMAL(18,2) COMMENT '',
    `findings_count` STRING COMMENT '',
    `gmp_certified_flag` BOOLEAN COMMENT '',
    `iso_9001_certified_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_assessment_due_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `overall_score` DECIMAL(18,2) COMMENT '',
    `quality_score` DECIMAL(18,2) COMMENT '',
    `rating` STRING COMMENT '',
    `scope` STRING COMMENT '',
    CONSTRAINT pk_supplier_assessment PRIMARY KEY(`supplier_assessment_id`)
) COMMENT 'Quality evaluation of supplier performance, capability, and compliance with quality standards';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` (
    `product_complaint_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `capa_id` BIGINT COMMENT '',
    `shopper_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `adverse_event_flag` BOOLEAN COMMENT '',
    `batch_number` STRING COMMENT '',
    `complaint_category` STRING COMMENT '',
    `complaint_date` DATE COMMENT '',
    `complaint_number` STRING COMMENT '',
    `complaint_source` STRING COMMENT '',
    `complaint_type` STRING COMMENT '',
    `corrective_action` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_response` STRING COMMENT '',
    `product_complaint_description` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `investigation_findings` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `manufacturing_date` DATE COMMENT '',
    `purchase_date` DATE COMMENT '',
    `purchase_location` STRING COMMENT '',
    `recall_potential_flag` BOOLEAN COMMENT '',
    `regulatory_reportable_flag` BOOLEAN COMMENT '',
    `resolution_date` DATE COMMENT '',
    `root_cause` STRING COMMENT '',
    `severity_level` STRING COMMENT '',
    `product_complaint_status` STRING COMMENT '',
    CONSTRAINT pk_product_complaint PRIMARY KEY(`product_complaint_id`)
) COMMENT 'Customer or consumer complaint regarding product quality, safety, or performance requiring investigation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` (
    `regulatory_hold_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `regulatory_released_by_employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `affected_quantity` DECIMAL(18,2) COMMENT '',
    `batch_number` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `disposition_decision` STRING COMMENT '',
    `hold_date` DATE COMMENT '',
    `hold_number` STRING COMMENT '',
    `hold_reason_code` STRING COMMENT '',
    `hold_reason_description` STRING COMMENT '',
    `hold_timestamp` TIMESTAMP COMMENT '',
    `hold_type` STRING COMMENT '',
    `investigation_reference` STRING COMMENT '',
    `lot_numbers` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quantity_uom` STRING COMMENT '',
    `regulatory_authority` STRING COMMENT '',
    `regulatory_reference` STRING COMMENT '',
    `release_date` DATE COMMENT '',
    `release_timestamp` TIMESTAMP COMMENT '',
    `regulatory_hold_status` STRING COMMENT '',
    CONSTRAINT pk_regulatory_hold PRIMARY KEY(`regulatory_hold_id`)
) COMMENT 'Quality or regulatory hold preventing release or distribution of product pending investigation or approval';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `document_url` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gmp_critical_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `material_type` STRING COMMENT '',
    `specification_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `pharmacopoeia_reference` STRING COMMENT '',
    `regulatory_requirement_reference` STRING COMMENT '',
    `sampling_plan` STRING COMMENT '',
    `specification_number` STRING COMMENT '',
    `specification_type` STRING COMMENT '',
    `specification_status` STRING COMMENT '',
    `test_method_reference` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Quality specification defining acceptance criteria, test methods, and limits for materials and products';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` (
    `lab_test_request_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `lab_requested_by_employee_id` BIGINT COMMENT '',
    `laboratory_id` BIGINT COMMENT '',
    `sample_id` BIGINT COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `due_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `pass_fail_flag` BOOLEAN COMMENT '',
    `priority` STRING COMMENT '',
    `report_url` STRING COMMENT '',
    `request_date` DATE COMMENT '',
    `request_number` STRING COMMENT '',
    `request_type` STRING COMMENT '',
    `lab_test_request_status` STRING COMMENT '',
    `test_method` STRING COMMENT '',
    `test_parameters` STRING COMMENT '',
    `test_result_summary` STRING COMMENT '',
    CONSTRAINT pk_lab_test_request PRIMARY KEY(`lab_test_request_id`)
) COMMENT 'Request for laboratory testing of samples to verify quality specifications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`notification` (
    `notification_id` BIGINT COMMENT '',
    `nonconformance_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `notification_created_by_employee_id` BIGINT COMMENT '',
    `product_complaint_id` BIGINT COMMENT '',
    `regulatory_hold_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `notification_description` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `escalation_date` DATE COMMENT '',
    `escalation_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notification_date` DATE COMMENT '',
    `notification_number` STRING COMMENT '',
    `notification_timestamp` TIMESTAMP COMMENT '',
    `notification_type` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `resolution_date` DATE COMMENT '',
    `resolution_notes` STRING COMMENT '',
    `notification_status` STRING COMMENT '',
    `subject` STRING COMMENT '',
    CONSTRAINT pk_notification PRIMARY KEY(`notification_id`)
) COMMENT 'Quality event notification alerting stakeholders of issues, deviations, or required actions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` (
    `control_chart_id` BIGINT COMMENT '',
    `production_line_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT '',
    `center_line_value` DECIMAL(18,2) COMMENT '',
    `characteristic_code` STRING COMMENT '',
    `characteristic_name` STRING COMMENT '',
    `chart_name` STRING COMMENT '',
    `chart_number` STRING COMMENT '',
    `chart_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT '',
    `lower_control_limit` DECIMAL(18,2) COMMENT '',
    `lower_specification_limit` DECIMAL(18,2) COMMENT '',
    `measurement_uom` STRING COMMENT '',
    `out_of_control_flag` BOOLEAN COMMENT '',
    `sample_size` STRING COMMENT '',
    `sampling_frequency` STRING COMMENT '',
    `control_chart_status` STRING COMMENT '',
    `upper_control_limit` DECIMAL(18,2) COMMENT '',
    `upper_specification_limit` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_control_chart PRIMARY KEY(`control_chart_id`)
) COMMENT 'Statistical process control chart monitoring quality characteristic variation over time';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` (
    `change_control_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `change_initiated_by_employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `product_formulation_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `actual_implementation_date` DATE COMMENT '',
    `approval_date` DATE COMMENT '',
    `change_category` STRING COMMENT '',
    `change_control_number` STRING COMMENT '',
    `change_description` STRING COMMENT '',
    `change_title` STRING COMMENT '',
    `change_type` STRING COMMENT '',
    `closure_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_notification_required` BOOLEAN COMMENT '',
    `effectiveness_check_date` DATE COMMENT '',
    `impact_assessment` STRING COMMENT '',
    `initiation_date` DATE COMMENT '',
    `justification` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `regulatory_impact_flag` BOOLEAN COMMENT '',
    `risk_level` STRING COMMENT '',
    `change_control_status` STRING COMMENT '',
    `target_implementation_date` DATE COMMENT '',
    `validation_reference` STRING COMMENT '',
    `validation_required_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_change_control PRIMARY KEY(`change_control_id`)
) COMMENT 'Formal change management record for modifications to products, processes, or quality systems';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` (
    `audit_program_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `audit_standard` STRING COMMENT '',
    `budget_amount` DECIMAL(18,2) COMMENT '',
    `completed_audits_count` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `end_date` DATE COMMENT '',
    `fiscal_year` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `planned_audits_count` STRING COMMENT '',
    `program_name` STRING COMMENT '',
    `program_number` STRING COMMENT '',
    `program_scope` STRING COMMENT '',
    `program_type` STRING COMMENT '',
    `start_date` DATE COMMENT '',
    `audit_program_status` STRING COMMENT '',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Planned schedule and scope of quality audits for facilities, suppliers, and processes';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` (
    `audit_checklist_id` BIGINT COMMENT '',
    `audit_program_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `audit_standard` STRING COMMENT '',
    `checklist_name` STRING COMMENT '',
    `checklist_number` STRING COMMENT '',
    `checklist_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `document_url` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `question_count` STRING COMMENT '',
    `audit_checklist_status` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_audit_checklist PRIMARY KEY(`audit_checklist_id`)
) COMMENT 'Standardized checklist of audit questions and criteria used during quality audits';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` (
    `laboratory_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `accreditation_body` STRING COMMENT '',
    `accreditation_expiry_date` DATE COMMENT '',
    `accreditation_number` STRING COMMENT '',
    `address_line_1` STRING COMMENT '',
    `address_line_2` STRING COMMENT '',
    `city` STRING COMMENT '',
    `laboratory_code` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `email_address` STRING COMMENT '',
    `gmp_certified_flag` BOOLEAN COMMENT '',
    `iso_17025_certified_flag` BOOLEAN COMMENT '',
    `laboratory_type` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `laboratory_name` STRING COMMENT '',
    `operational_status` STRING COMMENT '',
    `phone_number` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `test_capabilities` STRING COMMENT '',
    `compliance_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Quality control or analytical laboratory facility performing product testing';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `batch_number` STRING COMMENT '',
    `collection_date` DATE COMMENT '',
    `collection_location` STRING COMMENT '',
    `collection_timestamp` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `sample_description` STRING COMMENT '',
    `disposal_date` DATE COMMENT '',
    `lot_number` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `quantity_uom` STRING COMMENT '',
    `retention_period_days` STRING COMMENT '',
    `sample_number` STRING COMMENT '',
    `sample_type` STRING COMMENT '',
    `sample_status` STRING COMMENT '',
    `storage_condition` STRING COMMENT '',
    `storage_location` STRING COMMENT '',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Physical sample collected for quality testing and analysis';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_lab_test_request_id` FOREIGN KEY (`lab_test_request_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`lab_test_request`(`lab_test_request_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_batch_release_id` FOREIGN KEY (`batch_release_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`batch_release`(`batch_release_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_quality_stability_study_id` FOREIGN KEY (`quality_stability_study_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`quality_stability_study`(`quality_stability_study_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ADD CONSTRAINT `fk_quality_gmp_audit_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_gmp_audit_id` FOREIGN KEY (`gmp_audit_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`gmp_audit`(`gmp_audit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`capa`(`capa_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ADD CONSTRAINT `fk_quality_regulatory_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ADD CONSTRAINT `fk_quality_lab_test_request_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`sample`(`sample_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_regulatory_hold_id` FOREIGN KEY (`regulatory_hold_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`regulatory_hold`(`regulatory_hold_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ADD CONSTRAINT `fk_quality_control_chart_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ADD CONSTRAINT `fk_quality_audit_checklist_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `capa_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_subdomain' = 'product_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'product_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_subdomain' = 'product_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`quality_stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_subdomain' = 'product_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`gmp_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`supplier_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_subdomain' = 'product_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_released_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`regulatory_hold` ALTER COLUMN `regulatory_released_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`lab_test_request` ALTER COLUMN `lab_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`notification` ALTER COLUMN `notification_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`control_chart` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`change_control` ALTER COLUMN `change_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`audit_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_reviewer_approved' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_domain_certified' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` SET TAGS ('dbx_quality_score' = '80');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
