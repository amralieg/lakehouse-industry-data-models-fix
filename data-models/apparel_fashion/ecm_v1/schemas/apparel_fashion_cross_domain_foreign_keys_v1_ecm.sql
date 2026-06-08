-- Cross-Domain Foreign Keys for Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:39
-- Total cross-domain FK constraints: 1610
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: compliance, customer, design, ecommerce, finance, inventory, logistics, marketing, merchandising, order, product, production, quality, shared, sourcing, store, supplier, sustainability, workforce

-- ========= compliance --> design (13 constraint(s)) =========
-- Requires: compliance schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_cad_file_id` FOREIGN KEY (`cad_file_id`) REFERENCES `apparel_fashion_ecm`.`design`.`cad_file`(`cad_file_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_collaboration_id` FOREIGN KEY (`collaboration_id`) REFERENCES `apparel_fashion_ecm`.`design`.`collaboration`(`collaboration_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ADD CONSTRAINT `fk_compliance_restricted_substance_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ADD CONSTRAINT `fk_compliance_restricted_substance_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);

-- ========= compliance --> product (18 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_product_sample_id` FOREIGN KEY (`product_sample_id`) REFERENCES `apparel_fashion_ecm`.`product`.`product_sample`(`product_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ADD CONSTRAINT `fk_compliance_restricted_substance_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ADD CONSTRAINT `fk_compliance_labeling_requirement_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);

-- ========= compliance --> production (7 constraint(s)) =========
-- Requires: compliance schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= compliance --> supplier (8 constraint(s)) =========
-- Requires: compliance schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_testing_laboratory_vendor_id` FOREIGN KEY (`testing_laboratory_vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= compliance --> sustainability (11 constraint(s)) =========
-- Requires: compliance schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_higg_index_assessment_id` FOREIGN KEY (`higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_esg_disclosure_metric_id` FOREIGN KEY (`esg_disclosure_metric_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_disclosure_metric`(`esg_disclosure_metric_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ADD CONSTRAINT `fk_compliance_restricted_substance_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);

-- ========= compliance --> workforce (1 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> ecommerce (2 constraint(s)) =========
-- Requires: customer schema, ecommerce schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);

-- ========= customer --> finance (2 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= customer --> logistics (1 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= customer --> marketing (7 constraint(s)) =========
-- Requires: customer schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`referral` ADD CONSTRAINT `fk_customer_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`attendance` ADD CONSTRAINT `fk_customer_attendance_event_id` FOREIGN KEY (`event_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`targeting` ADD CONSTRAINT `fk_customer_targeting_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= customer --> merchandising (6 constraint(s)) =========
-- Requires: customer schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`cltv_record` ADD CONSTRAINT `fk_customer_cltv_record_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ADD CONSTRAINT `fk_customer_size_profile_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);

-- ========= customer --> order (6 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `apparel_fashion_ecm`.`order`.`quote`(`quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`referral` ADD CONSTRAINT `fk_customer_referral_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);

-- ========= customer --> sourcing (3 constraint(s)) =========
-- Requires: customer schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);

-- ========= customer --> store (9 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`referral` ADD CONSTRAINT `fk_customer_referral_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= customer --> supplier (4 constraint(s)) =========
-- Requires: customer schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= customer --> sustainability (6 constraint(s)) =========
-- Requires: customer schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_circular_enrollment_id` FOREIGN KEY (`circular_enrollment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_enrollment`(`circular_enrollment_id`);

-- ========= customer --> workforce (2 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= design --> finance (11 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ADD CONSTRAINT `fk_design_print_design_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= design --> merchandising (2 constraint(s)) =========
-- Requires: design schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= design --> product (20 constraint(s)) =========
-- Requires: design schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ADD CONSTRAINT `fk_design_mood_board_asset_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ADD CONSTRAINT `fk_design_color_palette_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= design --> quality (1 constraint(s)) =========
-- Requires: design schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_fit_session_id` FOREIGN KEY (`fit_session_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`fit_session`(`fit_session_id`);

-- ========= design --> supplier (12 constraint(s)) =========
-- Requires: design schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_embellishment_vendor_id` FOREIGN KEY (`embellishment_vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_supplier_mill_vendor_id` FOREIGN KEY (`supplier_mill_vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= design --> sustainability (12 constraint(s)) =========
-- Requires: design schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_higg_index_assessment_id` FOREIGN KEY (`higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);

-- ========= design --> workforce (47 constraint(s)) =========
-- Requires: design schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_concept_employee_id` FOREIGN KEY (`concept_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_concept_modified_by_employee_id` FOREIGN KEY (`concept_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ADD CONSTRAINT `fk_design_mood_board_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ADD CONSTRAINT `fk_design_print_design_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ADD CONSTRAINT `fk_design_pattern_block_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ADD CONSTRAINT `fk_design_pattern_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_review_created_by_employee_id` FOREIGN KEY (`review_created_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_review_employee_id` FOREIGN KEY (`review_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_review_last_modified_by_employee_id` FOREIGN KEY (`review_last_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_review_next_action_owner_employee_id` FOREIGN KEY (`review_next_action_owner_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_tertiary_review_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_review_last_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_brief_employee_id` FOREIGN KEY (`brief_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_brief_modified_by_employee_id` FOREIGN KEY (`brief_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_calendar_employee_id` FOREIGN KEY (`calendar_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_calendar_modified_by_employee_id` FOREIGN KEY (`calendar_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_milestone_employee_id` FOREIGN KEY (`milestone_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_milestone_last_modified_by_user_employee_id` FOREIGN KEY (`milestone_last_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_collaboration_employee_id` FOREIGN KEY (`collaboration_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_collaboration_merchandising_contact_employee_id` FOREIGN KEY (`collaboration_merchandising_contact_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_collaboration_modified_by_employee_id` FOREIGN KEY (`collaboration_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_embellishment_modified_by_user_employee_id` FOREIGN KEY (`embellishment_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ADD CONSTRAINT `fk_design_color_palette_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ADD CONSTRAINT `fk_design_color_palette_tertiary_color_modified_by_employee_id` FOREIGN KEY (`tertiary_color_modified_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_handoff_employee_id` FOREIGN KEY (`handoff_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_handoff_modified_by_user_employee_id` FOREIGN KEY (`handoff_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_revision_employee_id` FOREIGN KEY (`revision_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_asset_uploaded_by_user_employee_id` FOREIGN KEY (`asset_uploaded_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ADD CONSTRAINT `fk_design_designer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ADD CONSTRAINT `fk_design_designer_designer_employee_id` FOREIGN KEY (`designer_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ADD CONSTRAINT `fk_design_designer_designer_last_modified_by_user_employee_id` FOREIGN KEY (`designer_last_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ecommerce --> compliance (8 constraint(s)) =========
-- Requires: ecommerce schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= ecommerce --> customer (14 constraint(s)) =========
-- Requires: ecommerce schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ADD CONSTRAINT `fk_ecommerce_checkout_session_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ADD CONSTRAINT `fk_ecommerce_wishlist_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);

-- ========= ecommerce --> design (4 constraint(s)) =========
-- Requires: ecommerce schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ADD CONSTRAINT `fk_ecommerce_ab_test_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);

-- ========= ecommerce --> finance (7 constraint(s)) =========
-- Requires: ecommerce schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_finance_payment_id` FOREIGN KEY (`finance_payment_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`finance_payment`(`finance_payment_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ADD CONSTRAINT `fk_ecommerce_site_promotion_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget_line`(`budget_line_id`);

-- ========= ecommerce --> inventory (5 constraint(s)) =========
-- Requires: ecommerce schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_inventory_pool_id` FOREIGN KEY (`inventory_pool_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_pool`(`inventory_pool_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_inventory_pool_id` FOREIGN KEY (`inventory_pool_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_pool`(`inventory_pool_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ADD CONSTRAINT `fk_ecommerce_storefront_fulfillment_assignment_inventory_pool_id` FOREIGN KEY (`inventory_pool_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_pool`(`inventory_pool_id`);

-- ========= ecommerce --> logistics (11 constraint(s)) =========
-- Requires: ecommerce schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ADD CONSTRAINT `fk_ecommerce_checkout_session_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ADD CONSTRAINT `fk_ecommerce_site_promotion_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_source_distribution_center_id` FOREIGN KEY (`source_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ADD CONSTRAINT `fk_ecommerce_storefront_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ADD CONSTRAINT `fk_ecommerce_storefront_fulfillment_assignment_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= ecommerce --> marketing (9 constraint(s)) =========
-- Requires: ecommerce schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ADD CONSTRAINT `fk_ecommerce_site_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ADD CONSTRAINT `fk_ecommerce_wishlist_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= ecommerce --> merchandising (8 constraint(s)) =========
-- Requires: ecommerce schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_book`(`price_book_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_book`(`price_book_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);

-- ========= ecommerce --> order (8 constraint(s)) =========
-- Requires: ecommerce schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ADD CONSTRAINT `fk_ecommerce_checkout_session_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ADD CONSTRAINT `fk_ecommerce_digital_payment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);

-- ========= ecommerce --> product (8 constraint(s)) =========
-- Requires: ecommerce schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= ecommerce --> production (5 constraint(s)) =========
-- Requires: ecommerce schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ADD CONSTRAINT `fk_ecommerce_product_review_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ADD CONSTRAINT `fk_ecommerce_storefront_factory_allocation_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= ecommerce --> quality (7 constraint(s)) =========
-- Requires: ecommerce schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_hold`(`quality_hold_id`);

-- ========= ecommerce --> store (1 constraint(s)) =========
-- Requires: ecommerce schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= ecommerce --> supplier (5 constraint(s)) =========
-- Requires: ecommerce schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= ecommerce --> sustainability (6 constraint(s)) =========
-- Requires: ecommerce schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_traceability_record_id` FOREIGN KEY (`traceability_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`traceability_record`(`traceability_record_id`);

-- ========= ecommerce --> workforce (6 constraint(s)) =========
-- Requires: ecommerce schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ADD CONSTRAINT `fk_ecommerce_digital_storefront_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ADD CONSTRAINT `fk_ecommerce_digital_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ADD CONSTRAINT `fk_ecommerce_site_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ADD CONSTRAINT `fk_ecommerce_ab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> compliance (8 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= finance --> customer (4 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= finance --> inventory (6 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= finance --> logistics (1 constraint(s)) =========
-- Requires: finance schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= finance --> order (6 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= finance --> product (1 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= finance --> store (1 constraint(s)) =========
-- Requires: finance schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= finance --> supplier (6 constraint(s)) =========
-- Requires: finance schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`tax_item` ADD CONSTRAINT `fk_finance_tax_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`letter_of_credit` ADD CONSTRAINT `fk_finance_letter_of_credit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= finance --> sustainability (7 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`landed_cost` ADD CONSTRAINT `fk_finance_landed_cost_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`margin_record` ADD CONSTRAINT `fk_finance_margin_record_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ADD CONSTRAINT `fk_finance_cost_center_initiative_participation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center_initiative_participation` ADD CONSTRAINT `fk_finance_cost_center_initiative_participation_sustainability_initiative_id` FOREIGN KEY (`sustainability_initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= finance --> workforce (8 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`finance_payment` ADD CONSTRAINT `fk_finance_finance_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`asset_transaction` ADD CONSTRAINT `fk_finance_asset_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`finance`.`consolidation_entry` ADD CONSTRAINT `fk_finance_consolidation_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> compliance (8 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ADD CONSTRAINT `fk_inventory_rfid_tag_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);

-- ========= inventory --> customer (3 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);

-- ========= inventory --> ecommerce (10 constraint(s)) =========
-- Requires: inventory schema, ecommerce schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_digital_return_id` FOREIGN KEY (`digital_return_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_return`(`digital_return_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_checkout_session_id` FOREIGN KEY (`checkout_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`checkout_session`(`checkout_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_digital_return_id` FOREIGN KEY (`digital_return_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_return`(`digital_return_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ADD CONSTRAINT `fk_inventory_storefront_fulfillment_network_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);

-- ========= inventory --> logistics (38 constraint(s)) =========
-- Requires: inventory schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_packing_list_id` FOREIGN KEY (`packing_list_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`packing_list`(`packing_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_packing_list_id` FOREIGN KEY (`packing_list_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`packing_list`(`packing_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= inventory --> merchandising (20 constraint(s)) =========
-- Requires: inventory schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_allocation_plan_id` FOREIGN KEY (`allocation_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`allocation_plan`(`allocation_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= inventory --> order (9 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_order_purchase_order_line_id` FOREIGN KEY (`order_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order_line`(`order_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `apparel_fashion_ecm`.`order`.`allocation`(`allocation_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= inventory --> product (14 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= inventory --> production (6 constraint(s)) =========
-- Requires: inventory schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ADD CONSTRAINT `fk_inventory_rfid_tag_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= inventory --> quality (13 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_hold`(`quality_hold_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_quality_hold_id` FOREIGN KEY (`quality_hold_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_hold`(`quality_hold_id`);

-- ========= inventory --> shared (1 constraint(s)) =========
-- Requires: inventory schema, shared schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` ADD CONSTRAINT `fk_inventory_inventory_pool_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `apparel_fashion_ecm`.`shared`.`organization`(`organization_id`);

-- ========= inventory --> sourcing (6 constraint(s)) =========
-- Requires: inventory schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= inventory --> store (15 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ADD CONSTRAINT `fk_inventory_rfid_tag_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ADD CONSTRAINT `fk_inventory_rfid_tag_return_transaction_id` FOREIGN KEY (`return_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`return_transaction`(`return_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= inventory --> supplier (11 constraint(s)) =========
-- Requires: inventory schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= inventory --> sustainability (13 constraint(s)) =========
-- Requires: inventory schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_energy_consumption_id` FOREIGN KEY (`energy_consumption_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`energy_consumption`(`energy_consumption_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_water_usage_id` FOREIGN KEY (`water_usage_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`water_usage`(`water_usage_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`facility`(`facility_id`);

-- ========= inventory --> workforce (12 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_tertiary_transfer_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_transfer_cancelled_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> compliance (6 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ADD CONSTRAINT `fk_logistics_hs_code_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);

-- ========= logistics --> customer (2 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);

-- ========= logistics --> finance (12 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= logistics --> order (7 constraint(s)) =========
-- Requires: logistics schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= logistics --> production (11 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ADD CONSTRAINT `fk_logistics_carrier_service_agreement_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= logistics --> quality (4 constraint(s)) =========
-- Requires: logistics schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);

-- ========= logistics --> sourcing (9 constraint(s)) =========
-- Requires: logistics schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= logistics --> supplier (10 constraint(s)) =========
-- Requires: logistics schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);

-- ========= logistics --> sustainability (5 constraint(s)) =========
-- Requires: logistics schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);

-- ========= logistics --> workforce (12 constraint(s)) =========
-- Requires: logistics schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> compliance (9 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ADD CONSTRAINT `fk_marketing_campaign_certification_usage_certification_compliance_certification_id` FOREIGN KEY (`certification_compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_certification_usage` ADD CONSTRAINT `fk_marketing_campaign_certification_usage_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);

-- ========= marketing --> customer (10 constraint(s)) =========
-- Requires: marketing schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_send_event` ADD CONSTRAINT `fk_marketing_email_send_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= marketing --> design (8 constraint(s)) =========
-- Requires: marketing schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);

-- ========= marketing --> ecommerce (3 constraint(s)) =========
-- Requires: marketing schema, ecommerce schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ADD CONSTRAINT `fk_marketing_social_engagement_event_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);

-- ========= marketing --> finance (13 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_survey` ADD CONSTRAINT `fk_marketing_brand_health_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ADD CONSTRAINT `fk_marketing_pr_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= marketing --> inventory (5 constraint(s)) =========
-- Requires: marketing schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sku_location_id` FOREIGN KEY (`sku_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`sku_location`(`sku_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_sku_location_id` FOREIGN KEY (`sku_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`sku_location`(`sku_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= marketing --> order (4 constraint(s)) =========
-- Requires: marketing schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`attribution_touchpoint` ADD CONSTRAINT `fk_marketing_attribution_touchpoint_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`affiliate_conversion` ADD CONSTRAINT `fk_marketing_affiliate_conversion_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);

-- ========= marketing --> product (23 constraint(s)) =========
-- Requires: marketing schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_engagement_event` ADD CONSTRAINT `fk_marketing_social_engagement_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`paid_media_placement` ADD CONSTRAINT `fk_marketing_paid_media_placement_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_health_result` ADD CONSTRAINT `fk_marketing_brand_health_result_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);

-- ========= marketing --> production (6 constraint(s)) =========
-- Requires: marketing schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_seeding` ADD CONSTRAINT `fk_marketing_influencer_seeding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= marketing --> quality (2 constraint(s)) =========
-- Requires: marketing schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_quality_sample_id` FOREIGN KEY (`quality_sample_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_sample`(`quality_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ADD CONSTRAINT `fk_marketing_pr_placement_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_certification`(`quality_certification_id`);

-- ========= marketing --> sourcing (5 constraint(s)) =========
-- Requires: marketing schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_sourcing_tna_calendar_id` FOREIGN KEY (`sourcing_tna_calendar_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar`(`sourcing_tna_calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);

-- ========= marketing --> store (3 constraint(s)) =========
-- Requires: marketing schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_redemption` ADD CONSTRAINT `fk_marketing_promo_redemption_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`nps_response` ADD CONSTRAINT `fk_marketing_nps_response_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= marketing --> supplier (3 constraint(s)) =========
-- Requires: marketing schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= marketing --> sustainability (12 constraint(s)) =========
-- Requires: marketing schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_engagement` ADD CONSTRAINT `fk_marketing_influencer_engagement_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`promo_code` ADD CONSTRAINT `fk_marketing_promo_code_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_social_impact_program_id` FOREIGN KEY (`social_impact_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`social_impact_program`(`social_impact_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ADD CONSTRAINT `fk_marketing_campaign_initiative_promotion_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign_initiative_promotion` ADD CONSTRAINT `fk_marketing_campaign_initiative_promotion_sustainability_initiative_id` FOREIGN KEY (`sustainability_initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ADD CONSTRAINT `fk_marketing_influencer_initiative_partnership_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`influencer_initiative_partnership` ADD CONSTRAINT `fk_marketing_influencer_initiative_partnership_sustainability_initiative_id` FOREIGN KEY (`sustainability_initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= marketing --> workforce (6 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`seasonal_launch` ADD CONSTRAINT `fk_marketing_seasonal_launch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`pr_placement` ADD CONSTRAINT `fk_marketing_pr_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= merchandising --> compliance (12 constraint(s)) =========
-- Requires: merchandising schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy` ADD CONSTRAINT `fk_merchandising_merchandise_hierarchy_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);

-- ========= merchandising --> customer (7 constraint(s)) =========
-- Requires: merchandising schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= merchandising --> design (1 constraint(s)) =========
-- Requires: merchandising schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);

-- ========= merchandising --> finance (23 constraint(s)) =========
-- Requires: merchandising schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= merchandising --> logistics (5 constraint(s)) =========
-- Requires: merchandising schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_destination_distribution_center_id` FOREIGN KEY (`destination_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);

-- ========= merchandising --> marketing (8 constraint(s)) =========
-- Requires: merchandising schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_seasonal_launch_id` FOREIGN KEY (`seasonal_launch_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`seasonal_launch`(`seasonal_launch_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_seeding` ADD CONSTRAINT `fk_merchandising_collection_seeding_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`influencer`(`influencer_id`);

-- ========= merchandising --> order (4 constraint(s)) =========
-- Requires: merchandising schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_order_purchase_order_line_id` FOREIGN KEY (`order_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order_line`(`order_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= merchandising --> product (12 constraint(s)) =========
-- Requires: merchandising schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `apparel_fashion_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`size_curve` ADD CONSTRAINT `fk_merchandising_size_curve_size_scale_id` FOREIGN KEY (`size_scale_id`) REFERENCES `apparel_fashion_ecm`.`product`.`size_scale`(`size_scale_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= merchandising --> production (12 constraint(s)) =========
-- Requires: merchandising schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`capacity_booking` ADD CONSTRAINT `fk_merchandising_capacity_booking_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= merchandising --> quality (12 constraint(s)) =========
-- Requires: merchandising schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_quality_audit_id` FOREIGN KEY (`quality_audit_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_audit`(`quality_audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_quality_sample_id` FOREIGN KEY (`quality_sample_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_sample`(`quality_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`season` ADD CONSTRAINT `fk_merchandising_season_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);

-- ========= merchandising --> sourcing (13 constraint(s)) =========
-- Requires: merchandising schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_vendor_quote_id` FOREIGN KEY (`vendor_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_rfq_line_id` FOREIGN KEY (`rfq_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq_line`(`rfq_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_sourcing_purchase_order_line_id` FOREIGN KEY (`sourcing_purchase_order_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`(`sourcing_purchase_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= merchandising --> store (6 constraint(s)) =========
-- Requires: merchandising schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`otb_budget` ADD CONSTRAINT `fk_merchandising_otb_budget_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= merchandising --> supplier (5 constraint(s)) =========
-- Requires: merchandising schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_master` ADD CONSTRAINT `fk_merchandising_price_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`seasonal_vendor_capacity_agreement` ADD CONSTRAINT `fk_merchandising_seasonal_vendor_capacity_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= merchandising --> sustainability (9 constraint(s)) =========
-- Requires: merchandising schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`season` ADD CONSTRAINT `fk_merchandising_season_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`season` ADD CONSTRAINT `fk_merchandising_season_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);

-- ========= merchandising --> workforce (12 constraint(s)) =========
-- Requires: merchandising schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`assortment_plan` ADD CONSTRAINT `fk_merchandising_assortment_plan_tertiary_assortment_approved_by_employee_id` FOREIGN KEY (`tertiary_assortment_approved_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`collection_plan` ADD CONSTRAINT `fk_merchandising_collection_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan` ADD CONSTRAINT `fk_merchandising_buy_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`buy_plan_line` ADD CONSTRAINT `fk_merchandising_buy_plan_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`promotion` ADD CONSTRAINT `fk_merchandising_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_plan` ADD CONSTRAINT `fk_merchandising_allocation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`allocation_detail` ADD CONSTRAINT `fk_merchandising_allocation_detail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan` ADD CONSTRAINT `fk_merchandising_merchandise_financial_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`price_change_event` ADD CONSTRAINT `fk_merchandising_price_change_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`vendor_allowance` ADD CONSTRAINT `fk_merchandising_vendor_allowance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`merchandising`.`region` ADD CONSTRAINT `fk_merchandising_region_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= order --> compliance (10 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= order --> customer (14 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ADD CONSTRAINT `fk_order_installment_plan_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`payment_method`(`payment_method_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`installment_plan` ADD CONSTRAINT `fk_order_installment_plan_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);

-- ========= order --> design (2 constraint(s)) =========
-- Requires: order schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);

-- ========= order --> inventory (12 constraint(s)) =========
-- Requires: order schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_primary_order_warehouse_location_id` FOREIGN KEY (`primary_order_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_nos_policy_id` FOREIGN KEY (`nos_policy_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`nos_policy`(`nos_policy_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= order --> logistics (6 constraint(s)) =========
-- Requires: order schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);

-- ========= order --> marketing (1 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= order --> merchandising (5 constraint(s)) =========
-- Requires: order schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_backorder_substitute_sku_id` FOREIGN KEY (`backorder_substitute_sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> production (2 constraint(s)) =========
-- Requires: order schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= order --> sourcing (1 constraint(s)) =========
-- Requires: order schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ADD CONSTRAINT `fk_order_edi_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);

-- ========= order --> supplier (5 constraint(s)) =========
-- Requires: order schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`otif_metric` ADD CONSTRAINT `fk_order_otif_metric_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= order --> sustainability (9 constraint(s)) =========
-- Requires: order schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`esg_report`(`esg_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order_line` ADD CONSTRAINT `fk_order_sales_order_line_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`backorder` ADD CONSTRAINT `fk_order_backorder_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_circular_enrollment_id` FOREIGN KEY (`circular_enrollment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_enrollment`(`circular_enrollment_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);

-- ========= order --> workforce (13 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`order`.`sales_order` ADD CONSTRAINT `fk_order_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order` ADD CONSTRAINT `fk_order_order_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_purchase_order_line` ADD CONSTRAINT `fk_order_order_purchase_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`allocation` ADD CONSTRAINT `fk_order_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_employee_id` FOREIGN KEY (`rma_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`edi_transaction` ADD CONSTRAINT `fk_order_edi_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_payment` ADD CONSTRAINT `fk_order_order_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`order_hold` ADD CONSTRAINT `fk_order_order_hold_tertiary_order_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_order_last_modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`order`.`quote` ADD CONSTRAINT `fk_order_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> customer (6 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection_allocation` ADD CONSTRAINT `fk_product_collection_allocation_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`wholesale_style_agreement` ADD CONSTRAINT `fk_product_wholesale_style_agreement_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= product --> design (8 constraint(s)) =========
-- Requires: product schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_color_palette_id` FOREIGN KEY (`color_palette_id`) REFERENCES `apparel_fashion_ecm`.`design`.`color_palette`(`color_palette_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`size_scale` ADD CONSTRAINT `fk_product_size_scale_pattern_block_id` FOREIGN KEY (`pattern_block_id`) REFERENCES `apparel_fashion_ecm`.`design`.`pattern_block`(`pattern_block_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_pattern_block_id` FOREIGN KEY (`pattern_block_id`) REFERENCES `apparel_fashion_ecm`.`design`.`pattern_block`(`pattern_block_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_fabric_swatch_id` FOREIGN KEY (`fabric_swatch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`fabric_swatch`(`fabric_swatch_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `apparel_fashion_ecm`.`design`.`milestone`(`milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);

-- ========= product --> ecommerce (4 constraint(s)) =========
-- Requires: product schema, ecommerce schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_catalog_product_listing` ADD CONSTRAINT `fk_product_product_catalog_product_listing_ecommerce_catalog_product_listing_id` FOREIGN KEY (`ecommerce_catalog_product_listing_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing`(`ecommerce_catalog_product_listing_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_catalog_product_listing` ADD CONSTRAINT `fk_product_product_catalog_product_listing_site_catalog_id` FOREIGN KEY (`site_catalog_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`site_catalog`(`site_catalog_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_storefront_availability` ADD CONSTRAINT `fk_product_product_storefront_availability_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_storefront_availability` ADD CONSTRAINT `fk_product_product_storefront_availability_ecommerce_storefront_availability_id` FOREIGN KEY (`ecommerce_storefront_availability_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability`(`ecommerce_storefront_availability_id`);

-- ========= product --> finance (11 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> logistics (6 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_duty_calculation_id` FOREIGN KEY (`duty_calculation_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`duty_calculation`(`duty_calculation_id`);

-- ========= product --> merchandising (7 constraint(s)) =========
-- Requires: product schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_list`(`price_list_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= product --> production (8 constraint(s)) =========
-- Requires: product schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `apparel_fashion_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_production_tna_milestone_id` FOREIGN KEY (`production_tna_milestone_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_tna_milestone`(`production_tna_milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_material_sourcing` ADD CONSTRAINT `fk_product_product_material_sourcing_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style_factory_allocation` ADD CONSTRAINT `fk_product_style_factory_allocation_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= product --> quality (2 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_compliance` ADD CONSTRAINT `fk_product_material_compliance_quality_standard_id` FOREIGN KEY (`quality_standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_compliance` ADD CONSTRAINT `fk_product_material_compliance_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);

-- ========= product --> sourcing (2 constraint(s)) =========
-- Requires: product schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_material_sourcing` ADD CONSTRAINT `fk_product_product_material_sourcing_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_rfq_line` ADD CONSTRAINT `fk_product_material_rfq_line_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);

-- ========= product --> supplier (6 constraint(s)) =========
-- Requires: product schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_material_supplier` ADD CONSTRAINT `fk_product_product_material_supplier_supplier_material_supplier_id` FOREIGN KEY (`supplier_material_supplier_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier`(`supplier_material_supplier_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_material_supplier` ADD CONSTRAINT `fk_product_product_material_supplier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style_sourcing` ADD CONSTRAINT `fk_product_style_sourcing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_rfq_line` ADD CONSTRAINT `fk_product_material_rfq_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= product --> sustainability (14 constraint(s)) =========
-- Requires: product schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`colorway` ADD CONSTRAINT `fk_product_colorway_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`tech_pack` ADD CONSTRAINT `fk_product_tech_pack_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material` ADD CONSTRAINT `fk_product_material_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_tna_calendar` ADD CONSTRAINT `fk_product_product_tna_calendar_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_target_id` FOREIGN KEY (`target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_program_eligibility` ADD CONSTRAINT `fk_product_material_program_eligibility_circular_program_id` FOREIGN KEY (`circular_program_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_program`(`circular_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`style_certification` ADD CONSTRAINT `fk_product_style_certification_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection_sustainability_contribution` ADD CONSTRAINT `fk_product_collection_sustainability_contribution_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= product --> workforce (10 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`product`.`style` ADD CONSTRAINT `fk_product_style_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`product_sample` ADD CONSTRAINT `fk_product_product_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection` ADD CONSTRAINT `fk_product_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`msrp_price` ADD CONSTRAINT `fk_product_msrp_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`cost_sheet` ADD CONSTRAINT `fk_product_cost_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`collection_allocation` ADD CONSTRAINT `fk_product_collection_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`wholesale_style_agreement` ADD CONSTRAINT `fk_product_wholesale_style_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`product`.`material_rfq_line` ADD CONSTRAINT `fk_product_material_rfq_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= production --> compliance (12 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ADD CONSTRAINT `fk_production_production_factory_certification_certification_compliance_certification_id` FOREIGN KEY (`certification_compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ADD CONSTRAINT `fk_production_production_factory_certification_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);

-- ========= production --> customer (4 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= production --> design (11 constraint(s)) =========
-- Requires: production schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ADD CONSTRAINT `fk_production_factory_designer_collaboration_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ADD CONSTRAINT `fk_production_factory_embellishment_capability_embellishment_id` FOREIGN KEY (`embellishment_id`) REFERENCES `apparel_fashion_ecm`.`design`.`embellishment`(`embellishment_id`);

-- ========= production --> finance (15 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ADD CONSTRAINT `fk_production_production_factory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ADD CONSTRAINT `fk_production_production_factory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= production --> inventory (3 constraint(s)) =========
-- Requires: production schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ADD CONSTRAINT `fk_production_fabric_roll_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= production --> merchandising (4 constraint(s)) =========
-- Requires: production schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= production --> order (2 constraint(s)) =========
-- Requires: production schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= production --> product (19 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `apparel_fashion_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ADD CONSTRAINT `fk_production_fabric_roll_fabric_type_id` FOREIGN KEY (`fabric_type_id`) REFERENCES `apparel_fashion_ecm`.`product`.`fabric_type`(`fabric_type_id`);

-- ========= production --> sourcing (1 constraint(s)) =========
-- Requires: production schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ADD CONSTRAINT `fk_production_fabric_roll_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= production --> supplier (5 constraint(s)) =========
-- Requires: production schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ADD CONSTRAINT `fk_production_fabric_roll_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= production --> sustainability (5 constraint(s)) =========
-- Requires: production schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_packaging_sustainability_id` FOREIGN KEY (`packaging_sustainability_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`packaging_sustainability`(`packaging_sustainability_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ADD CONSTRAINT `fk_production_factory_initiative_implementation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);

-- ========= production --> workforce (14 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_tertiary_work_confirmed_by_user_employee_id` FOREIGN KEY (`tertiary_work_confirmed_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ADD CONSTRAINT `fk_production_production_factory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_tertiary_cut_updated_by_user_employee_id` FOREIGN KEY (`tertiary_cut_updated_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> compliance (8 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ADD CONSTRAINT `fk_quality_standard_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= quality --> design (11 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_cad_file_id` FOREIGN KEY (`cad_file_id`) REFERENCES `apparel_fashion_ecm`.`design`.`cad_file`(`cad_file_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);

-- ========= quality --> finance (10 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);

-- ========= quality --> inventory (1 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);

-- ========= quality --> marketing (3 constraint(s)) =========
-- Requires: quality schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_seasonal_launch_id` FOREIGN KEY (`seasonal_launch_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`seasonal_launch`(`seasonal_launch_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= quality --> order (11 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_backorder_id` FOREIGN KEY (`backorder_id`) REFERENCES `apparel_fashion_ecm`.`order`.`backorder`(`backorder_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `apparel_fashion_ecm`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= quality --> product (18 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= quality --> production (16 constraint(s)) =========
-- Requires: quality schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_work_order_operation_id` FOREIGN KEY (`work_order_operation_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order_operation`(`work_order_operation_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);

-- ========= quality --> sourcing (18 constraint(s)) =========
-- Requires: quality schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_vendor_quote_id` FOREIGN KEY (`vendor_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_fabric_development_id` FOREIGN KEY (`fabric_development_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`fabric_development`(`fabric_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_rtv_order_id` FOREIGN KEY (`rtv_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rtv_order`(`rtv_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_rtv_order_id` FOREIGN KEY (`rtv_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rtv_order`(`rtv_order_id`);

-- ========= quality --> supplier (9 constraint(s)) =========
-- Requires: quality schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= quality --> sustainability (13 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ADD CONSTRAINT `fk_quality_standard_ecolabel_id` FOREIGN KEY (`ecolabel_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`ecolabel`(`ecolabel_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);

-- ========= quality --> workforce (11 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_tertiary_non_closed_by_user_employee_id` FOREIGN KEY (`tertiary_non_closed_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sourcing --> compliance (10 constraint(s)) =========
-- Requires: sourcing schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= sourcing --> design (12 constraint(s)) =========
-- Requires: sourcing schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `apparel_fashion_ecm`.`design`.`milestone`(`milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_print_colorway_id` FOREIGN KEY (`print_colorway_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_colorway`(`print_colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_collaboration_id` FOREIGN KEY (`collaboration_id`) REFERENCES `apparel_fashion_ecm`.`design`.`collaboration`(`collaboration_id`);

-- ========= sourcing --> finance (15 constraint(s)) =========
-- Requires: sourcing schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sourcing --> inventory (2 constraint(s)) =========
-- Requires: sourcing schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);

-- ========= sourcing --> logistics (6 constraint(s)) =========
-- Requires: sourcing schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);

-- ========= sourcing --> merchandising (2 constraint(s)) =========
-- Requires: sourcing schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= sourcing --> order (1 constraint(s)) =========
-- Requires: sourcing schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_order_purchase_order_id` FOREIGN KEY (`order_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`order_purchase_order`(`order_purchase_order_id`);

-- ========= sourcing --> product (26 constraint(s)) =========
-- Requires: sourcing schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_product_sample_id` FOREIGN KEY (`product_sample_id`) REFERENCES `apparel_fashion_ecm`.`product`.`product_sample`(`product_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_colorway_id` FOREIGN KEY (`colorway_id`) REFERENCES `apparel_fashion_ecm`.`product`.`colorway`(`colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_category_id` FOREIGN KEY (`category_id`) REFERENCES `apparel_fashion_ecm`.`product`.`category`(`category_id`);

-- ========= sourcing --> production (13 constraint(s)) =========
-- Requires: sourcing schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_production_tna_milestone_id` FOREIGN KEY (`production_tna_milestone_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_tna_milestone`(`production_tna_milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_pp_sample_id` FOREIGN KEY (`pp_sample_id`) REFERENCES `apparel_fashion_ecm`.`production`.`pp_sample`(`pp_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= sourcing --> supplier (11 constraint(s)) =========
-- Requires: sourcing schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_supplier_material_supplier_id` FOREIGN KEY (`supplier_material_supplier_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier`(`supplier_material_supplier_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= sourcing --> sustainability (19 constraint(s)) =========
-- Requires: sourcing schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_higg_index_assessment_id` FOREIGN KEY (`higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_higg_index_assessment_id` FOREIGN KEY (`higg_index_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment`(`higg_index_assessment_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_material_certification_id` FOREIGN KEY (`material_certification_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`material_certification`(`material_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_environmental_impact_id` FOREIGN KEY (`environmental_impact_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`environmental_impact`(`environmental_impact_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_sustainable_material_id` FOREIGN KEY (`sustainable_material_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`sustainable_material`(`sustainable_material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_carbon_target_id` FOREIGN KEY (`carbon_target_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_target`(`carbon_target_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_supplier_esg_assessment_id` FOREIGN KEY (`supplier_esg_assessment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`(`supplier_esg_assessment_id`);

-- ========= sourcing --> workforce (17 constraint(s)) =========
-- Requires: sourcing schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ADD CONSTRAINT `fk_sourcing_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_tertiary_sourcing_approved_by_employee_id` FOREIGN KEY (`tertiary_sourcing_approved_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_agreement_sourcing_agent_employee_id` FOREIGN KEY (`agreement_sourcing_agent_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= store --> compliance (5 constraint(s)) =========
-- Requires: store schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_ftc_label_id` FOREIGN KEY (`ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= store --> customer (6 constraint(s)) =========
-- Requires: store schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);

-- ========= store --> ecommerce (7 constraint(s)) =========
-- Requires: store schema, ecommerce schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_site_promotion_id` FOREIGN KEY (`site_promotion_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`site_promotion`(`site_promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ADD CONSTRAINT `fk_store_storefront_fulfillment_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);

-- ========= store --> finance (8 constraint(s)) =========
-- Requires: store schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= store --> logistics (4 constraint(s)) =========
-- Requires: store schema, logistics schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_return_shipment_id` FOREIGN KEY (`return_shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`return_shipment`(`return_shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= store --> marketing (8 constraint(s)) =========
-- Requires: store schema, marketing schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ADD CONSTRAINT `fk_store_campaign_participation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `apparel_fashion_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= store --> merchandising (9 constraint(s)) =========
-- Requires: store schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_merchandise_hierarchy_id` FOREIGN KEY (`merchandise_hierarchy_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`merchandise_hierarchy`(`merchandise_hierarchy_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_otb_budget_id` FOREIGN KEY (`otb_budget_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`otb_budget`(`otb_budget_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_price_change_event_id` FOREIGN KEY (`price_change_event_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`price_change_event`(`price_change_event_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`promotion`(`promotion_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`region`(`region_id`);

-- ========= store --> order (5 constraint(s)) =========
-- Requires: store schema, order schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `apparel_fashion_ecm`.`order`.`sales_order`(`sales_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `apparel_fashion_ecm`.`order`.`rma`(`rma_id`);

-- ========= store --> product (7 constraint(s)) =========
-- Requires: store schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `apparel_fashion_ecm`.`product`.`collection`(`collection_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `apparel_fashion_ecm`.`product`.`sku`(`sku_id`);

-- ========= store --> production (5 constraint(s)) =========
-- Requires: store schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `apparel_fashion_ecm`.`production`.`schedule`(`schedule_id`);

-- ========= store --> quality (4 constraint(s)) =========
-- Requires: store schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);

-- ========= store --> sourcing (2 constraint(s)) =========
-- Requires: store schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);

-- ========= store --> supplier (1 constraint(s)) =========
-- Requires: store schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= store --> sustainability (8 constraint(s)) =========
-- Requires: store schema, sustainability schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_energy_consumption_id` FOREIGN KEY (`energy_consumption_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`energy_consumption`(`energy_consumption_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_renewable_energy_certificate_id` FOREIGN KEY (`renewable_energy_certificate_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate`(`renewable_energy_certificate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_water_usage_id` FOREIGN KEY (`water_usage_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`water_usage`(`water_usage_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ADD CONSTRAINT `fk_store_associate_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_carbon_emission_id` FOREIGN KEY (`carbon_emission_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`carbon_emission`(`carbon_emission_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_circular_enrollment_id` FOREIGN KEY (`circular_enrollment_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`circular_enrollment`(`circular_enrollment_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_waste_record_id` FOREIGN KEY (`waste_record_id`) REFERENCES `apparel_fashion_ecm`.`sustainability`.`waste_record`(`waste_record_id`);

-- ========= store --> workforce (15 constraint(s)) =========
-- Requires: store schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ADD CONSTRAINT `fk_store_associate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ADD CONSTRAINT `fk_store_associate_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_position_id` FOREIGN KEY (`position_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` ADD CONSTRAINT `fk_store_zone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supplier --> compliance (4 constraint(s)) =========
-- Requires: supplier schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ADD CONSTRAINT `fk_supplier_supplier_factory_certification_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ADD CONSTRAINT `fk_supplier_sustainability_profile_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ADD CONSTRAINT `fk_supplier_vendor_certification_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ADD CONSTRAINT `fk_supplier_vendor_substance_compliance_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);

-- ========= supplier --> design (4 constraint(s)) =========
-- Requires: supplier schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ADD CONSTRAINT `fk_supplier_supplier_material_supplier_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);

-- ========= supplier --> finance (8 constraint(s)) =========
-- Requires: supplier schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ADD CONSTRAINT `fk_supplier_supplier_factory_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ADD CONSTRAINT `fk_supplier_supplier_factory_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ADD CONSTRAINT `fk_supplier_sustainability_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= supplier --> merchandising (4 constraint(s)) =========
-- Requires: supplier schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_buy_plan_id` FOREIGN KEY (`buy_plan_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`buy_plan`(`buy_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);

-- ========= supplier --> product (2 constraint(s)) =========
-- Requires: supplier schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ADD CONSTRAINT `fk_supplier_supplier_material_supplier_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);

-- ========= supplier --> production (5 constraint(s)) =========
-- Requires: supplier schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ADD CONSTRAINT `fk_supplier_supplier_factory_certification_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ADD CONSTRAINT `fk_supplier_vendor_document_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= supplier --> quality (7 constraint(s)) =========
-- Requires: supplier schema, quality schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ADD CONSTRAINT `fk_supplier_oem_odm_agreement_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ADD CONSTRAINT `fk_supplier_vendor_defect_occurrence_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ADD CONSTRAINT `fk_supplier_vendor_quality_compliance_quality_standard_id` FOREIGN KEY (`quality_standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ADD CONSTRAINT `fk_supplier_vendor_quality_compliance_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);

-- ========= supplier --> sourcing (2 constraint(s)) =========
-- Requires: supplier schema, sourcing schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ADD CONSTRAINT `fk_supplier_factory_sourcing_allocation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ADD CONSTRAINT `fk_supplier_factory_sourcing_allocation_sourcing_agreement_id` FOREIGN KEY (`sourcing_agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);

-- ========= supplier --> workforce (9 constraint(s)) =========
-- Requires: supplier schema, workforce schema
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ADD CONSTRAINT `fk_supplier_supplier_factory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ADD CONSTRAINT `fk_supplier_vendor_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ADD CONSTRAINT `fk_supplier_supplier_material_supplier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ADD CONSTRAINT `fk_supplier_vendor_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> customer (2 constraint(s)) =========
-- Requires: sustainability schema, customer schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= sustainability --> design (7 constraint(s)) =========
-- Requires: sustainability schema, design schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ADD CONSTRAINT `fk_sustainability_chemical_compliance_colorway_development_id` FOREIGN KEY (`colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ADD CONSTRAINT `fk_sustainability_chemical_compliance_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);

-- ========= sustainability --> inventory (2 constraint(s)) =========
-- Requires: sustainability schema, inventory schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`rfid_tag`(`rfid_tag_id`);

-- ========= sustainability --> product (5 constraint(s)) =========
-- Requires: sustainability schema, product schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ADD CONSTRAINT `fk_sustainability_material_certification_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_style_id` FOREIGN KEY (`style_id`) REFERENCES `apparel_fashion_ecm`.`product`.`style`(`style_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ADD CONSTRAINT `fk_sustainability_chemical_compliance_material_id` FOREIGN KEY (`material_id`) REFERENCES `apparel_fashion_ecm`.`product`.`material`(`material_id`);

-- ========= sustainability --> production (8 constraint(s)) =========
-- Requires: sustainability schema, production schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ADD CONSTRAINT `fk_sustainability_material_certification_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);

-- ========= sustainability --> store (1 constraint(s)) =========
-- Requires: sustainability schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`circular_enrollment` ADD CONSTRAINT `fk_sustainability_circular_enrollment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= sustainability --> supplier (12 constraint(s)) =========
-- Requires: sustainability schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`carbon_emission` ADD CONSTRAINT `fk_sustainability_carbon_emission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`sustainable_material` ADD CONSTRAINT `fk_sustainability_sustainable_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`material_certification` ADD CONSTRAINT `fk_sustainability_material_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`environmental_impact` ADD CONSTRAINT `fk_sustainability_environmental_impact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment` ADD CONSTRAINT `fk_sustainability_supplier_esg_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`traceability_record` ADD CONSTRAINT `fk_sustainability_traceability_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`chemical_compliance` ADD CONSTRAINT `fk_sustainability_chemical_compliance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`higg_index_assessment` ADD CONSTRAINT `fk_sustainability_higg_index_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`biodiversity_impact` ADD CONSTRAINT `fk_sustainability_biodiversity_impact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= workforce --> compliance (6 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= workforce --> finance (11 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ADD CONSTRAINT `fk_workforce_role_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `apparel_fashion_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> merchandising (2 constraint(s)) =========
-- Requires: workforce schema, merchandising schema
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_season_id` FOREIGN KEY (`season_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`season`(`season_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_division_id` FOREIGN KEY (`division_id`) REFERENCES `apparel_fashion_ecm`.`merchandising`.`division`(`division_id`);

-- ========= workforce --> store (5 constraint(s)) =========
-- Requires: workforce schema, store schema
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `apparel_fashion_ecm`.`store`.`shift`(`shift_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_proposed_shift_id` FOREIGN KEY (`proposed_shift_id`) REFERENCES `apparel_fashion_ecm`.`store`.`shift`(`shift_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);

-- ========= workforce --> supplier (1 constraint(s)) =========
-- Requires: workforce schema, supplier schema
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` ADD CONSTRAINT `fk_workforce_course_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

