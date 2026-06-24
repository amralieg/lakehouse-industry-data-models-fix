-- Schema for Domain: quality | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`quality` COMMENT 'Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT '',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality budget planning: inspection plans define recurring quality activities whose costs must be budgeted against cost centers. Consumer Goods quality departments use inspection plan-to-cost-center l',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Inspection plans are defined for raw materials and packaging components as well as finished SKUs — standard in GMP-regulated consumer goods manufacturing. inspection_plan.material_id enables quality t',
    `sku_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `aql_level` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `gmp_critical_flag` BOOLEAN COMMENT '',
    `inspection_frequency` STRING COMMENT '',
    `inspection_plan_status` STRING COMMENT '',
    `inspection_stage` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `plan_code` STRING COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `regulatory_requirement_reference` STRING COMMENT '',
    `sample_size` STRING COMMENT '',
    `sampling_procedure` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master plan defining inspection procedures, sampling strategies, and acceptance criteria for materials, in-process, and finished goods';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT '',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: GMP/regulatory incoming material control: at inspection lot creation, quality must verify the supplier is on the approved supplier list for that material. This link supports supplier qualification sta',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality inspection cost allocation: inspection labor and equipment costs are charged to cost centers for overhead absorption and product costing. Consumer Goods standard costing requires inspection ac',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Incoming goods inspection workflow: a goods_receipt with quality_inspection_required=true directly triggers creation of an inspection_lot. Quality teams and GMP auditors need to trace every inspection',
    `inspection_plan_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Incoming material inspection lots are created when raw materials or packaging components arrive from suppliers — a core GMP and SAP QM process. Linking inspection_lot.material_id to the material maste',
    `production_order_id` BIGINT COMMENT '',
    `return_order_id` BIGINT COMMENT 'Foreign key linking to sales.return_order. Business justification: Returns Inspection Process: when customer-returned goods arrive, a quality inspection lot is created to assess condition and disposition. Linking inspection_lot to the originating return_order enables',
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
    `specification_id` BIGINT COMMENT '',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Inspection results are collected at specific work centers during in-process control. Linking inspection_result to work_center enables work-center-level quality performance analytics (defect rates, pas',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Nonconformances are detected during batch manufacturing and must reference the batch record for GMP deviation management. nonconformance.batch_number is a denormalized plain attribute; replacing with ',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality cost management: nonconformance cost_impact_amount must be charged to a cost center for financial accountability, variance reporting, and quality cost KPI dashboards. Consumer Goods finance te',
    `inspection_lot_id` BIGINT COMMENT '',
    `inspection_result_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_result. Business justification: A nonconformance event is frequently triggered by a specific failed inspection result (e.g., a characteristic measurement outside specification limits). Adding inspection_result_id to nonconformance f',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Financial audit trail for quality losses: scrap, rework, and write-off costs from nonconformances generate GL journal entries. SOX compliance and financial audits require traceability from the quality',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Nonconformances are raised against raw materials and packaging components (e.g., out-of-spec ingredient, defective packaging). Linking nonconformance.material_id to the material master is essential fo',
    `return_order_id` BIGINT COMMENT 'Foreign key linking to sales.return_order. Business justification: Customer Return Quality Investigation: when a trade account returns goods, quality raises a nonconformance to investigate the defect. Linking nonconformance to the originating return_order enables end',
    `sku_id` BIGINT COMMENT '',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Scrap and rework valuation: nonconformance cost_impact_amount is calculated using standard cost rates for affected SKUs. Consumer Goods financial reporting requires nonconformance losses to be valued ',
    `supplier_id` BIGINT COMMENT '',
    `actual_closure_date` DATE COMMENT '',
    `affected_quantity` DECIMAL(18,2) COMMENT '',
    `affected_quantity_uom` STRING COMMENT '',
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
    `nonconformance_status` STRING COMMENT '',
    `nonconformance_type` STRING COMMENT '',
    `occurrence_date` DATE COMMENT '',
    `regulatory_reportable_flag` BOOLEAN COMMENT '',
    `root_cause` STRING COMMENT '',
    `severity_level` STRING COMMENT '',
    `target_closure_date` DATE COMMENT '',
    CONSTRAINT pk_nonconformance PRIMARY KEY(`nonconformance_id`)
) COMMENT 'Record of quality defect, deviation, or non-compliance event requiring investigation and corrective action';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT '',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA cost tracking: capa.cost_estimate_amount must be assigned to a cost center for budget planning, actual vs. estimated cost variance reporting, and SOX-compliant quality cost management. Consumer G',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: CAPAs frequently target specific equipment for recalibration, maintenance, or replacement as corrective actions in consumer goods manufacturing. Linking capa to equipment enables equipment-level CAPA ',
    `nonconformance_id` BIGINT COMMENT '',
    `product_complaint_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: CAPAs are initiated for specific SKUs in consumer goods regulatory compliance (FDA 21 CFR, ISO 9001). Regulators require CAPA records to identify affected products directly. capa.sku_id enables produc',
    `actual_completion_date` DATE COMMENT '',
    `approval_date` DATE COMMENT '',
    `capa_number` STRING COMMENT '',
    `capa_status` STRING COMMENT '',
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
    `target_completion_date` DATE COMMENT '',
    `title` STRING COMMENT '',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action record to address root causes of quality issues and prevent recurrence';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` (
    `batch_release_id` BIGINT COMMENT '',
    `inspection_lot_id` BIGINT COMMENT '',
    `production_order_id` BIGINT COMMENT '',
    `sku_id` BIGINT COMMENT '',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: A batch release decision is directly predicated on the usage decision (accept/reject/conditional release) made for the associated inspection lot. Adding usage_decision_id to batch_release formalizes t',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: CoA is issued per manufactured batch and must reference the batch record for manufacturing data (dates, equipment, yield, operator). certificate_of_analysis.batch_number is denormalized. Direct FK ena',
    `inspection_lot_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Supplier Certificates of Analysis are issued for incoming raw materials and packaging components, not only finished goods. certificate_of_analysis.material_id links supplier CoAs to the material maste',
    `sku_id` BIGINT COMMENT '',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: A Certificate of Analysis certifies that a batch meets all quality specifications. The CoA currently carries specification_reference as a free-text string, which is a denormalized reference to the qua',
    `allergen_statement` STRING COMMENT '',
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
    `test_results_summary` STRING COMMENT '',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Official document certifying that a batch meets all quality specifications and regulatory requirements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` (
    `product_complaint_id` BIGINT COMMENT '',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Product complaints reference specific manufactured batches for investigation. product_complaint.batch_number is a denormalized plain attribute. Direct FK to batch_record enables complaint investigatio',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A product complaint is typically associated with a specific manufactured batch or lot. Adding inspection_lot_id to product_complaint enables direct traceability from the complaint to the inspection lo',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Complaint-to-Order Traceability: consumer goods quality teams link product complaints to the originating sales order for regulatory reporting, recall scope determination, and customer service resoluti',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Store-Level Complaint Analysis: consumer goods companies track product complaints by retail store for field quality management and retail partner reporting. purchase_location is a denormalized text fi',
    `sku_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT '',
    `adverse_event_flag` BOOLEAN COMMENT '',
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
    `product_complaint_status` STRING COMMENT '',
    `purchase_date` DATE COMMENT '',
    `recall_potential_flag` BOOLEAN COMMENT '',
    `regulatory_reportable_flag` BOOLEAN COMMENT '',
    `resolution_date` DATE COMMENT '',
    `root_cause` STRING COMMENT '',
    `severity_level` STRING COMMENT '',
    CONSTRAINT pk_product_complaint PRIMARY KEY(`product_complaint_id`)
) COMMENT 'Customer or consumer complaint regarding product quality, safety, or performance requiring investigation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Quality specifications cover raw materials and packaging components, not just finished SKUs. GMP-regulated consumer goods require material-level quality specifications for incoming goods inspection an',
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
    `specification_status` STRING COMMENT '',
    `specification_type` STRING COMMENT '',
    `test_method_reference` STRING COMMENT '',
    `version_number` STRING COMMENT '',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Quality specification defining acceptance criteria, test methods, and limits for materials and products';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_result_id` FOREIGN KEY (`inspection_result_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_result`(`inspection_result_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`specification`(`specification_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ADD CONSTRAINT `fk_quality_product_complaint_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_consumer_goods_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_plan` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_lot` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`inspection_result` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`nonconformance` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`capa` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`batch_release` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`product_complaint` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `vibe_consumer_goods_v1`.`quality`.`specification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
