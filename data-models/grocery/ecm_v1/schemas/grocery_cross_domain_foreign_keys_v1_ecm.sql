-- Cross-Domain Foreign Keys for Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:35:00
-- Total cross-domain FK constraints: 1014
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, assortment, compliance, customer, finance, fuel, fulfillment, inventory, loyalty, order, payment, pharmacy, pricing, product, promotion, store, supply, vendor, workforce

-- ========= analytics --> assortment (2 constraint(s)) =========
-- Requires: analytics schema, assortment schema
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= analytics --> compliance (2 constraint(s)) =========
-- Requires: analytics schema, compliance schema
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= analytics --> customer (1 constraint(s)) =========
-- Requires: analytics schema, customer schema
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ADD CONSTRAINT `fk_analytics_shopper_behavior_fact_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= analytics --> finance (4 constraint(s)) =========
-- Requires: analytics schema, finance schema
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= analytics --> fuel (2 constraint(s)) =========
-- Requires: analytics schema, fuel schema
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);

-- ========= analytics --> fulfillment (2 constraint(s)) =========
-- Requires: analytics schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);

-- ========= analytics --> inventory (2 constraint(s)) =========
-- Requires: analytics schema, inventory schema
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= analytics --> loyalty (2 constraint(s)) =========
-- Requires: analytics schema, loyalty schema
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= analytics --> payment (2 constraint(s)) =========
-- Requires: analytics schema, payment schema
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= analytics --> pricing (6 constraint(s)) =========
-- Requires: analytics schema, pricing schema
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_pricing_recommendation_id` FOREIGN KEY (`pricing_recommendation_id`) REFERENCES `grocery_ecm`.`pricing`.`pricing_recommendation`(`pricing_recommendation_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `grocery_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_promo_price_link_id` FOREIGN KEY (`promo_price_link_id`) REFERENCES `grocery_ecm`.`pricing`.`promo_price_link`(`promo_price_link_id`);

-- ========= analytics --> product (9 constraint(s)) =========
-- Requires: analytics schema, product schema
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ADD CONSTRAINT `fk_analytics_dq_result_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_item_attribute_id` FOREIGN KEY (`item_attribute_id`) REFERENCES `grocery_ecm`.`product`.`item_attribute`(`item_attribute_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ADD CONSTRAINT `fk_analytics_shopper_behavior_fact_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= analytics --> promotion (3 constraint(s)) =========
-- Requires: analytics schema, promotion schema
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_promo_zone_id` FOREIGN KEY (`promo_zone_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_zone`(`promo_zone_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= analytics --> store (18 constraint(s)) =========
-- Requires: analytics schema, store schema
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `grocery_ecm`.`store`.`banner`(`banner_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ADD CONSTRAINT `fk_analytics_basket_summary_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ADD CONSTRAINT `fk_analytics_shopper_behavior_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ADD CONSTRAINT `fk_analytics_channel_performance_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ADD CONSTRAINT `fk_analytics_shrink_analytics_fact_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ADD CONSTRAINT `fk_analytics_shrink_analytics_fact_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ADD CONSTRAINT `fk_analytics_forecast_baseline_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ADD CONSTRAINT `fk_analytics_scorecard_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= analytics --> vendor (2 constraint(s)) =========
-- Requires: analytics schema, vendor schema
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ADD CONSTRAINT `fk_analytics_vendor_analytics_fact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= analytics --> workforce (10 constraint(s)) =========
-- Requires: analytics schema, workforce schema
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_owner_associate_id` FOREIGN KEY (`owner_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ADD CONSTRAINT `fk_analytics_bi_access_request_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ADD CONSTRAINT `fk_analytics_bi_access_request_primary_bi_associate_id` FOREIGN KEY (`primary_bi_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `grocery_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= assortment --> analytics (2 constraint(s)) =========
-- Requires: assortment schema, analytics schema
ALTER TABLE `grocery_ecm`.`assortment`.`category` ADD CONSTRAINT `fk_assortment_category_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`review` ADD CONSTRAINT `fk_assortment_review_scorecard_id` FOREIGN KEY (`scorecard_id`) REFERENCES `grocery_ecm`.`analytics`.`scorecard`(`scorecard_id`);

-- ========= assortment --> compliance (1 constraint(s)) =========
-- Requires: assortment schema, compliance schema
ALTER TABLE `grocery_ecm`.`assortment`.`planogram_compliance` ADD CONSTRAINT `fk_assortment_planogram_compliance_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= assortment --> payment (1 constraint(s)) =========
-- Requires: assortment schema, payment schema
ALTER TABLE `grocery_ecm`.`assortment`.`tender_eligibility` ADD CONSTRAINT `fk_assortment_tender_eligibility_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= assortment --> product (2 constraint(s)) =========
-- Requires: assortment schema, product schema
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`sku_rationalization` ADD CONSTRAINT `fk_assortment_sku_rationalization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= assortment --> promotion (2 constraint(s)) =========
-- Requires: assortment schema, promotion schema
ALTER TABLE `grocery_ecm`.`assortment`.`seasonal_plan` ADD CONSTRAINT `fk_assortment_seasonal_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`slotting_fee` ADD CONSTRAINT `fk_assortment_slotting_fee_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= assortment --> store (5 constraint(s)) =========
-- Requires: assortment schema, store schema
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram_compliance` ADD CONSTRAINT `fk_assortment_planogram_compliance_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`slotting_fee` ADD CONSTRAINT `fk_assortment_slotting_fee_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`fixture` ADD CONSTRAINT `fk_assortment_fixture_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= assortment --> vendor (7 constraint(s)) =========
-- Requires: assortment schema, vendor schema
ALTER TABLE `grocery_ecm`.`assortment`.`category` ADD CONSTRAINT `fk_assortment_category_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_item` ADD CONSTRAINT `fk_assortment_assortment_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_category_captain` ADD CONSTRAINT `fk_assortment_assortment_category_captain_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_category_captain` ADD CONSTRAINT `fk_assortment_assortment_category_captain_tertiary_assortment_vendor_supplier_id` FOREIGN KEY (`tertiary_assortment_vendor_supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`slotting_fee` ADD CONSTRAINT `fk_assortment_slotting_fee_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= assortment --> workforce (17 constraint(s)) =========
-- Requires: assortment schema, workforce schema
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ADD CONSTRAINT `fk_assortment_planogram_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram` ADD CONSTRAINT `fk_assortment_planogram_planogram_associate_id` FOREIGN KEY (`planogram_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_plan` ADD CONSTRAINT `fk_assortment_assortment_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_plan` ADD CONSTRAINT `fk_assortment_assortment_plan_tertiary_assortment_buyer_user_associate_id` FOREIGN KEY (`tertiary_assortment_buyer_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`new_item_intro` ADD CONSTRAINT `fk_assortment_new_item_intro_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`sku_rationalization` ADD CONSTRAINT `fk_assortment_sku_rationalization_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`sku_rationalization` ADD CONSTRAINT `fk_assortment_sku_rationalization_tertiary_sku_last_modified_by_user_associate_id` FOREIGN KEY (`tertiary_sku_last_modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`space_allocation` ADD CONSTRAINT `fk_assortment_space_allocation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram_compliance` ADD CONSTRAINT `fk_assortment_planogram_compliance_assigned_crew_associate_id` FOREIGN KEY (`assigned_crew_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`planogram_compliance` ADD CONSTRAINT `fk_assortment_planogram_compliance_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`seasonal_plan` ADD CONSTRAINT `fk_assortment_seasonal_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`assortment_category_captain` ADD CONSTRAINT `fk_assortment_assortment_category_captain_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`slotting_fee` ADD CONSTRAINT `fk_assortment_slotting_fee_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`review` ADD CONSTRAINT `fk_assortment_review_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`review` ADD CONSTRAINT `fk_assortment_review_review_associate_id` FOREIGN KEY (`review_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`review` ADD CONSTRAINT `fk_assortment_review_review_category_manager_associate_id` FOREIGN KEY (`review_category_manager_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`assortment`.`category_captain_assignment` ADD CONSTRAINT `fk_assortment_category_captain_assignment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= compliance --> analytics (1 constraint(s)) =========
-- Requires: compliance schema, analytics schema
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);

-- ========= compliance --> customer (2 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= compliance --> finance (3 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `grocery_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> loyalty (2 constraint(s)) =========
-- Requires: compliance schema, loyalty schema
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);

-- ========= compliance --> payment (3 constraint(s)) =========
-- Requires: compliance schema, payment schema
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= compliance --> pharmacy (5 constraint(s)) =========
-- Requires: compliance schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);

-- ========= compliance --> product (5 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ADD CONSTRAINT `fk_compliance_food_safety_violation_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= compliance --> store (10 constraint(s)) =========
-- Requires: compliance schema, store schema
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ADD CONSTRAINT `fk_compliance_food_safety_inspection_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_violation` ADD CONSTRAINT `fk_compliance_food_safety_violation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`osha_citation` ADD CONSTRAINT `fk_compliance_osha_citation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ADD CONSTRAINT `fk_compliance_weights_measures_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= compliance --> supply (1 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= compliance --> vendor (4 constraint(s)) =========
-- Requires: compliance schema, vendor schema
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= compliance --> workforce (14 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_obligation_escalation_contact_associate_id` FOREIGN KEY (`obligation_escalation_contact_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`food_safety_inspection` ADD CONSTRAINT `fk_compliance_food_safety_inspection_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`age_restricted_sale` ADD CONSTRAINT `fk_compliance_age_restricted_sale_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_risk_associate_id` FOREIGN KEY (`risk_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`risk` ADD CONSTRAINT `fk_compliance_risk_risk_escalation_contact_associate_id` FOREIGN KEY (`risk_escalation_contact_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`compliance`.`weights_measures` ADD CONSTRAINT `fk_compliance_weights_measures_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= customer --> assortment (1 constraint(s)) =========
-- Requires: customer schema, assortment schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= customer --> compliance (1 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= customer --> finance (2 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> fulfillment (6 constraint(s)) =========
-- Requires: customer schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);

-- ========= customer --> loyalty (3 constraint(s)) =========
-- Requires: customer schema, loyalty schema
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `grocery_ecm`.`customer`.`personalized_promotion_assignment` ADD CONSTRAINT `fk_customer_personalized_promotion_assignment_loyalty_redemption_id` FOREIGN KEY (`loyalty_redemption_id`) REFERENCES `grocery_ecm`.`loyalty`.`loyalty_redemption`(`loyalty_redemption_id`);

-- ========= customer --> payment (1 constraint(s)) =========
-- Requires: customer schema, payment schema
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= customer --> pharmacy (2 constraint(s)) =========
-- Requires: customer schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= customer --> product (7 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_ab_test_experiment_id` FOREIGN KEY (`ab_test_experiment_id`) REFERENCES `grocery_ecm`.`product`.`ab_test_experiment`(`ab_test_experiment_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `grocery_ecm`.`product`.`web_session`(`web_session_id`);
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);

-- ========= customer --> promotion (1 constraint(s)) =========
-- Requires: customer schema, promotion schema
ALTER TABLE `grocery_ecm`.`customer`.`personalized_promotion_assignment` ADD CONSTRAINT `fk_customer_personalized_promotion_assignment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= customer --> store (13 constraint(s)) =========
-- Requires: customer schema, store schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_format_id` FOREIGN KEY (`format_id`) REFERENCES `grocery_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_region_id` FOREIGN KEY (`region_id`) REFERENCES `grocery_ecm`.`store`.`region`(`region_id`);
ALTER TABLE `grocery_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`contact_info` ADD CONSTRAINT `fk_customer_contact_info_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`customer_benefit_enrollment` ADD CONSTRAINT `fk_customer_customer_benefit_enrollment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`cltv_profile` ADD CONSTRAINT `fk_customer_cltv_profile_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`customer`.`personalized_promotion_assignment` ADD CONSTRAINT `fk_customer_personalized_promotion_assignment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_supply_supplier_contract_id` FOREIGN KEY (`supply_supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supply_supplier_contract`(`supply_supplier_contract_id`);

-- ========= customer --> vendor (3 constraint(s)) =========
-- Requires: customer schema, vendor schema
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_edi_partner_profile_id` FOREIGN KEY (`edi_partner_profile_id`) REFERENCES `grocery_ecm`.`vendor`.`edi_partner_profile`(`edi_partner_profile_id`);
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= customer --> workforce (8 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `grocery_ecm`.`customer`.`shopper` ADD CONSTRAINT `fk_customer_shopper_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`segment_assignment` ADD CONSTRAINT `fk_customer_segment_assignment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`pharmacy_patient` ADD CONSTRAINT `fk_customer_pharmacy_patient_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_escalated_to_agent_associate_id` FOREIGN KEY (`escalated_to_agent_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`customer`.`status_history` ADD CONSTRAINT `fk_customer_status_history_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= finance --> assortment (2 constraint(s)) =========
-- Requires: finance schema, assortment schema
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `grocery_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_space_allocation_id` FOREIGN KEY (`space_allocation_id`) REFERENCES `grocery_ecm`.`assortment`.`space_allocation`(`space_allocation_id`);

-- ========= finance --> compliance (1 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `grocery_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);

-- ========= finance --> fulfillment (2 constraint(s)) =========
-- Requires: finance schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);

-- ========= finance --> store (1 constraint(s)) =========
-- Requires: finance schema, store schema
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= finance --> supply (2 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `grocery_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= finance --> vendor (3 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= finance --> workforce (10 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `grocery_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_quaternary_journal_posted_by_user_associate_id` FOREIGN KEY (`quaternary_journal_posted_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_quinary_journal_parking_user_associate_id` FOREIGN KEY (`quinary_journal_parking_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tertiary_journal_approved_by_user_associate_id` FOREIGN KEY (`tertiary_journal_approved_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_sox_performer_associate_id` FOREIGN KEY (`sox_performer_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= fuel --> assortment (1 constraint(s)) =========
-- Requires: fuel schema, assortment schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= fuel --> compliance (2 constraint(s)) =========
-- Requires: fuel schema, compliance schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= fuel --> customer (2 constraint(s)) =========
-- Requires: fuel schema, customer schema
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= fuel --> finance (15 constraint(s)) =========
-- Requires: fuel schema, finance schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ADD CONSTRAINT `fk_fuel_inventory_reconciliation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ADD CONSTRAINT `fk_fuel_tax_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ADD CONSTRAINT `fk_fuel_tax_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= fuel --> fulfillment (4 constraint(s)) =========
-- Requires: fuel schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ADD CONSTRAINT `fk_fuel_delivery_schedule_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);

-- ========= fuel --> loyalty (2 constraint(s)) =========
-- Requires: fuel schema, loyalty schema
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= fuel --> payment (2 constraint(s)) =========
-- Requires: fuel schema, payment schema
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= fuel --> pricing (4 constraint(s)) =========
-- Requires: fuel schema, pricing schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= fuel --> product (2 constraint(s)) =========
-- Requires: fuel schema, product schema
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= fuel --> promotion (5 constraint(s)) =========
-- Requires: fuel schema, promotion schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ADD CONSTRAINT `fk_fuel_price_change_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= fuel --> store (6 constraint(s)) =========
-- Requires: fuel schema, store schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ADD CONSTRAINT `fk_fuel_tank_level_reading_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ADD CONSTRAINT `fk_fuel_delivery_schedule_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ADD CONSTRAINT `fk_fuel_inventory_reconciliation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= fuel --> supply (1 constraint(s)) =========
-- Requires: fuel schema, supply schema
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= fuel --> vendor (9 constraint(s)) =========
-- Requires: fuel schema, vendor schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ADD CONSTRAINT `fk_fuel_pump_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ADD CONSTRAINT `fk_fuel_grade_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ADD CONSTRAINT `fk_fuel_tank_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ADD CONSTRAINT `fk_fuel_delivery_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= fuel --> workforce (10 constraint(s)) =========
-- Requires: fuel schema, workforce schema
ALTER TABLE `grocery_ecm`.`fuel`.`center` ADD CONSTRAINT `fk_fuel_center_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ADD CONSTRAINT `fk_fuel_price_change_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ADD CONSTRAINT `fk_fuel_fleet_card_account_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ADD CONSTRAINT `fk_fuel_fleet_card_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ADD CONSTRAINT `fk_fuel_inventory_reconciliation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ADD CONSTRAINT `fk_fuel_environmental_incident_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= fulfillment --> assortment (3 constraint(s)) =========
-- Requires: fulfillment schema, assortment schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= fulfillment --> compliance (3 constraint(s)) =========
-- Requires: fulfillment schema, compliance schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_food_safety_violation_id` FOREIGN KEY (`food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ADD CONSTRAINT `fk_fulfillment_carrier_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= fulfillment --> customer (1 constraint(s)) =========
-- Requires: fulfillment schema, customer schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= fulfillment --> inventory (3 constraint(s)) =========
-- Requires: fulfillment schema, inventory schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `grocery_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= fulfillment --> loyalty (1 constraint(s)) =========
-- Requires: fulfillment schema, loyalty schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_member_offer_id` FOREIGN KEY (`member_offer_id`) REFERENCES `grocery_ecm`.`loyalty`.`member_offer`(`member_offer_id`);

-- ========= fulfillment --> pharmacy (3 constraint(s)) =========
-- Requires: fulfillment schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);

-- ========= fulfillment --> product (16 constraint(s)) =========
-- Requires: fulfillment schema, product schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ADD CONSTRAINT `fk_fulfillment_substitution_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ADD CONSTRAINT `fk_fulfillment_substitution_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= fulfillment --> promotion (5 constraint(s)) =========
-- Requires: fulfillment schema, promotion schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_promo_calendar_id` FOREIGN KEY (`promo_calendar_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_calendar`(`promo_calendar_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= fulfillment --> store (4 constraint(s)) =========
-- Requires: fulfillment schema, store schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= fulfillment --> supply (3 constraint(s)) =========
-- Requires: fulfillment schema, supply schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ADD CONSTRAINT `fk_fulfillment_slot_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ADD CONSTRAINT `fk_fulfillment_node_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= fulfillment --> workforce (16 constraint(s)) =========
-- Requires: fulfillment schema, workforce schema
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_created_by_user_associate_id` FOREIGN KEY (`created_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_modified_by_user_associate_id` FOREIGN KEY (`modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ADD CONSTRAINT `fk_fulfillment_pickup_staging_primary_pickup_handoff_associate_id` FOREIGN KEY (`primary_pickup_handoff_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_route_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ADD CONSTRAINT `fk_fulfillment_substitution_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_created_by_user_associate_id` FOREIGN KEY (`created_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_modified_by_user_associate_id` FOREIGN KEY (`modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ADD CONSTRAINT `fk_fulfillment_vehicle_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= inventory --> assortment (5 constraint(s)) =========
-- Requires: inventory schema, assortment schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ADD CONSTRAINT `fk_inventory_stock_snapshot_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);

-- ========= inventory --> compliance (5 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_food_safety_violation_id` FOREIGN KEY (`food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_food_safety_violation_id` FOREIGN KEY (`food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ADD CONSTRAINT `fk_inventory_recall_hold_food_safety_violation_id` FOREIGN KEY (`food_safety_violation_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_violation`(`food_safety_violation_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_food_safety_inspection_id` FOREIGN KEY (`food_safety_inspection_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_inspection`(`food_safety_inspection_id`);

-- ========= inventory --> customer (1 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= inventory --> finance (8 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> fuel (1 constraint(s)) =========
-- Requires: inventory schema, fuel schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);

-- ========= inventory --> pharmacy (2 constraint(s)) =========
-- Requires: inventory schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= inventory --> pricing (1 constraint(s)) =========
-- Requires: inventory schema, pricing schema
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_markdown_id` FOREIGN KEY (`markdown_id`) REFERENCES `grocery_ecm`.`pricing`.`markdown`(`markdown_id`);

-- ========= inventory --> product (13 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_fulfillment_slot_id` FOREIGN KEY (`fulfillment_slot_id`) REFERENCES `grocery_ecm`.`product`.`fulfillment_slot`(`fulfillment_slot_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ADD CONSTRAINT `fk_inventory_recall_hold_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`pick` ADD CONSTRAINT `fk_inventory_pick_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_allocation` ADD CONSTRAINT `fk_inventory_lot_allocation_product_order_line_id` FOREIGN KEY (`product_order_line_id`) REFERENCES `grocery_ecm`.`product`.`product_order_line`(`product_order_line_id`);

-- ========= inventory --> promotion (5 constraint(s)) =========
-- Requires: inventory schema, promotion schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= inventory --> store (12 constraint(s)) =========
-- Requires: inventory schema, store schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_mfc_profile_id` FOREIGN KEY (`mfc_profile_id`) REFERENCES `grocery_ecm`.`store`.`mfc_profile`(`mfc_profile_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_snapshot` ADD CONSTRAINT `fk_inventory_stock_snapshot_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= inventory --> supply (6 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`shrink_record` ADD CONSTRAINT `fk_inventory_shrink_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `grocery_ecm`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= inventory --> vendor (9 constraint(s)) =========
-- Requires: inventory schema, vendor schema
ALTER TABLE `grocery_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`replenishment_signal` ADD CONSTRAINT `fk_inventory_replenishment_signal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`recall_hold` ADD CONSTRAINT `fk_inventory_recall_hold_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= inventory --> workforce (9 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `grocery_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`oos_event` ADD CONSTRAINT `fk_inventory_oos_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`cold_chain_log` ADD CONSTRAINT `fk_inventory_cold_chain_log_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`stock_adjustment` ADD CONSTRAINT `fk_inventory_stock_adjustment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`perishable_rotation` ADD CONSTRAINT `fk_inventory_perishable_rotation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`receiving_record` ADD CONSTRAINT `fk_inventory_receiving_record_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`inventory`.`markdown_event` ADD CONSTRAINT `fk_inventory_markdown_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= loyalty --> assortment (4 constraint(s)) =========
-- Requires: loyalty schema, assortment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ADD CONSTRAINT `fk_loyalty_offer_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= loyalty --> compliance (2 constraint(s)) =========
-- Requires: loyalty schema, compliance schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= loyalty --> customer (4 constraint(s)) =========
-- Requires: loyalty schema, customer schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ADD CONSTRAINT `fk_loyalty_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ADD CONSTRAINT `fk_loyalty_engagement_event_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= loyalty --> finance (6 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `grocery_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ADD CONSTRAINT `fk_loyalty_partner_earn_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= loyalty --> fuel (2 constraint(s)) =========
-- Requires: loyalty schema, fuel schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);

-- ========= loyalty --> fulfillment (1 constraint(s)) =========
-- Requires: loyalty schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);

-- ========= loyalty --> payment (5 constraint(s)) =========
-- Requires: loyalty schema, payment schema
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_tender_eligibility` ADD CONSTRAINT `fk_loyalty_offer_tender_eligibility_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= loyalty --> pharmacy (2 constraint(s)) =========
-- Requires: loyalty schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= loyalty --> product (7 constraint(s)) =========
-- Requires: loyalty schema, product schema
ALTER TABLE `grocery_ecm`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `grocery_ecm`.`product`.`order_header`(`order_header_id`);

-- ========= loyalty --> promotion (7 constraint(s)) =========
-- Requires: loyalty schema, promotion schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_challenge` ADD CONSTRAINT `fk_loyalty_member_challenge_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ADD CONSTRAINT `fk_loyalty_engagement_event_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ADD CONSTRAINT `fk_loyalty_partner_earn_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= loyalty --> store (8 constraint(s)) =========
-- Requires: loyalty schema, store schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_membership_store_location_id` FOREIGN KEY (`membership_store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`member_offer` ADD CONSTRAINT `fk_loyalty_member_offer_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`household_member` ADD CONSTRAINT `fk_loyalty_household_member_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`engagement_event` ADD CONSTRAINT `fk_loyalty_engagement_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`offer_category` ADD CONSTRAINT `fk_loyalty_offer_category_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= loyalty --> vendor (3 constraint(s)) =========
-- Requires: loyalty schema, vendor schema
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`reward_offer` ADD CONSTRAINT `fk_loyalty_reward_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`partner_earn` ADD CONSTRAINT `fk_loyalty_partner_earn_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= loyalty --> workforce (5 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `grocery_ecm`.`loyalty`.`membership` ADD CONSTRAINT `fk_loyalty_membership_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`points_transaction` ADD CONSTRAINT `fk_loyalty_points_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`loyalty_redemption` ADD CONSTRAINT `fk_loyalty_loyalty_redemption_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`loyalty`.`fraud_dispute` ADD CONSTRAINT `fk_loyalty_fraud_dispute_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= order --> product (1 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ADD CONSTRAINT `fk_order_catalog_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);

-- ========= order --> store (1 constraint(s)) =========
-- Requires: order schema, store schema
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ADD CONSTRAINT `fk_order_catalog_item_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);

-- ========= order --> supply (1 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ADD CONSTRAINT `fk_order_order_delivery_route_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= order --> workforce (1 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ADD CONSTRAINT `fk_order_order_delivery_route_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= payment --> compliance (4 constraint(s)) =========
-- Requires: payment schema, compliance schema
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ADD CONSTRAINT `fk_payment_gateway_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `grocery_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= payment --> customer (8 constraint(s)) =========
-- Requires: payment schema, customer schema
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ADD CONSTRAINT `fk_payment_payment_plan_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= payment --> finance (5 constraint(s)) =========
-- Requires: payment schema, finance schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= payment --> fuel (1 constraint(s)) =========
-- Requires: payment schema, fuel schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);

-- ========= payment --> fulfillment (3 constraint(s)) =========
-- Requires: payment schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_fulfillment_order_line_id` FOREIGN KEY (`fulfillment_order_line_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_order_line`(`fulfillment_order_line_id`);

-- ========= payment --> pricing (2 constraint(s)) =========
-- Requires: payment schema, pricing schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_price_rule_id` FOREIGN KEY (`price_rule_id`) REFERENCES `grocery_ecm`.`pricing`.`price_rule`(`price_rule_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= payment --> product (6 constraint(s)) =========
-- Requires: payment schema, product schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_fuel_grade_id` FOREIGN KEY (`fuel_grade_id`) REFERENCES `grocery_ecm`.`product`.`fuel_grade`(`fuel_grade_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);

-- ========= payment --> promotion (2 constraint(s)) =========
-- Requires: payment schema, promotion schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ADD CONSTRAINT `fk_payment_promotion_application_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= payment --> store (11 constraint(s)) =========
-- Requires: payment schema, store schema
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ADD CONSTRAINT `fk_payment_payment_plan_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= payment --> supply (3 constraint(s)) =========
-- Requires: payment schema, supply schema
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_vendor_chargeback_id` FOREIGN KEY (`vendor_chargeback_id`) REFERENCES `grocery_ecm`.`supply`.`vendor_chargeback`(`vendor_chargeback_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_vendor_return_id` FOREIGN KEY (`vendor_return_id`) REFERENCES `grocery_ecm`.`supply`.`vendor_return`(`vendor_return_id`);

-- ========= payment --> workforce (12 constraint(s)) =========
-- Requires: payment schema, workforce schema
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_refund_initiated_by_associate_id` FOREIGN KEY (`refund_initiated_by_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_reconciliation_associate_id` FOREIGN KEY (`reconciliation_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ADD CONSTRAINT `fk_payment_payment_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= pharmacy --> assortment (3 constraint(s)) =========
-- Requires: pharmacy schema, assortment schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= pharmacy --> customer (2 constraint(s)) =========
-- Requires: pharmacy schema, customer schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= pharmacy --> finance (4 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= pharmacy --> loyalty (1 constraint(s)) =========
-- Requires: pharmacy schema, loyalty schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);

-- ========= pharmacy --> payment (1 constraint(s)) =========
-- Requires: pharmacy schema, payment schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= pharmacy --> pricing (1 constraint(s)) =========
-- Requires: pharmacy schema, pricing schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= pharmacy --> promotion (4 constraint(s)) =========
-- Requires: pharmacy schema, promotion schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_promotion_redemption_id` FOREIGN KEY (`promotion_redemption_id`) REFERENCES `grocery_ecm`.`promotion`.`promotion_redemption`(`promotion_redemption_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= pharmacy --> store (2 constraint(s)) =========
-- Requires: pharmacy schema, store schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ADD CONSTRAINT `fk_pharmacy_patient_medication_profile_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= pharmacy --> vendor (5 constraint(s)) =========
-- Requires: pharmacy schema, vendor schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ADD CONSTRAINT `fk_pharmacy_drug_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_supplier_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= pharmacy --> workforce (2 constraint(s)) =========
-- Requires: pharmacy schema, workforce schema
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ADD CONSTRAINT `fk_pharmacy_patient_medication_profile_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= pricing --> assortment (7 constraint(s)) =========
-- Requires: pricing schema, assortment schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= pricing --> finance (5 constraint(s)) =========
-- Requires: pricing schema, finance schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ADD CONSTRAINT `fk_pricing_optimization_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ADD CONSTRAINT `fk_pricing_compliance_audit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= pricing --> payment (1 constraint(s)) =========
-- Requires: pricing schema, payment schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= pricing --> product (11 constraint(s)) =========
-- Requires: pricing schema, product schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_order_channel_id` FOREIGN KEY (`order_channel_id`) REFERENCES `grocery_ecm`.`product`.`order_channel`(`order_channel_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_order_channel_id` FOREIGN KEY (`order_channel_id`) REFERENCES `grocery_ecm`.`product`.`order_channel`(`order_channel_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= pricing --> promotion (4 constraint(s)) =========
-- Requires: pricing schema, promotion schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= pricing --> store (8 constraint(s)) =========
-- Requires: pricing schema, store schema
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`competitive_price` ADD CONSTRAINT `fk_pricing_competitive_price_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ADD CONSTRAINT `fk_pricing_compliance_audit_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= pricing --> vendor (7 constraint(s)) =========
-- Requires: pricing schema, vendor schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`tpr` ADD CONSTRAINT `fk_pricing_tpr_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`cost_price` ADD CONSTRAINT `fk_pricing_cost_price_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ADD CONSTRAINT `fk_pricing_price_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= pricing --> workforce (14 constraint(s)) =========
-- Requires: pricing schema, workforce schema
ALTER TABLE `grocery_ecm`.`pricing`.`retail_price` ADD CONSTRAINT `fk_pricing_retail_price_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_change` ADD CONSTRAINT `fk_pricing_price_change_primary_price_associate_id` FOREIGN KEY (`primary_price_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`markdown` ADD CONSTRAINT `fk_pricing_markdown_markdown_associate_id` FOREIGN KEY (`markdown_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_rule` ADD CONSTRAINT `fk_pricing_price_rule_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`optimization_run` ADD CONSTRAINT `fk_pricing_optimization_run_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`pricing_recommendation` ADD CONSTRAINT `fk_pricing_pricing_recommendation_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`channel_price` ADD CONSTRAINT `fk_pricing_channel_price_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`promo_price_link` ADD CONSTRAINT `fk_pricing_promo_price_link_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ADD CONSTRAINT `fk_pricing_price_batch_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_batch` ADD CONSTRAINT `fk_pricing_price_batch_primary_price_associate_id` FOREIGN KEY (`primary_price_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`compliance_audit` ADD CONSTRAINT `fk_pricing_compliance_audit_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`pricing`.`price_override` ADD CONSTRAINT `fk_pricing_price_override_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= product --> assortment (7 constraint(s)) =========
-- Requires: product schema, assortment schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_assortment_item_id` FOREIGN KEY (`assortment_item_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_item`(`assortment_item_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_assortment_plan_id` FOREIGN KEY (`assortment_plan_id`) REFERENCES `grocery_ecm`.`assortment`.`assortment_plan`(`assortment_plan_id`);
ALTER TABLE `grocery_ecm`.`product`.`catalog` ADD CONSTRAINT `fk_product_catalog_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= product --> compliance (1 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_age_restricted_sale_id` FOREIGN KEY (`age_restricted_sale_id`) REFERENCES `grocery_ecm`.`compliance`.`age_restricted_sale`(`age_restricted_sale_id`);

-- ========= product --> customer (14 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_contact_info_id` FOREIGN KEY (`contact_info_id`) REFERENCES `grocery_ecm`.`customer`.`contact_info`(`contact_info_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_pharmacy_patient_id` FOREIGN KEY (`pharmacy_patient_id`) REFERENCES `grocery_ecm`.`customer`.`pharmacy_patient`(`pharmacy_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`web_session` ADD CONSTRAINT `fk_product_web_session_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart` ADD CONSTRAINT `fk_product_cart_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ADD CONSTRAINT `fk_product_checkout_session_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ADD CONSTRAINT `fk_product_slot_reservation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ADD CONSTRAINT `fk_product_payment_event_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`search_query` ADD CONSTRAINT `fk_product_search_query_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= product --> finance (15 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_fiscal_week_fiscal_period_id` FOREIGN KEY (`fiscal_week_fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= product --> fuel (1 constraint(s)) =========
-- Requires: product schema, fuel schema
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ADD CONSTRAINT `fk_product_fuel_grade_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);

-- ========= product --> fulfillment (8 constraint(s)) =========
-- Requires: product schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ADD CONSTRAINT `fk_product_order_status_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ADD CONSTRAINT `fk_product_pick_assignment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);

-- ========= product --> inventory (1 constraint(s)) =========
-- Requires: product schema, inventory schema
ALTER TABLE `grocery_ecm`.`product`.`inventory_allocation` ADD CONSTRAINT `fk_product_inventory_allocation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `grocery_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= product --> loyalty (1 constraint(s)) =========
-- Requires: product schema, loyalty schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);

-- ========= product --> payment (8 constraint(s)) =========
-- Requires: product schema, payment schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_payment` ADD CONSTRAINT `fk_product_order_payment_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_primary_order_payment_transaction_id` FOREIGN KEY (`primary_order_payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`payment_event` ADD CONSTRAINT `fk_product_payment_event_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= product --> pharmacy (4 constraint(s)) =========
-- Requires: product schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_rx_claim_id` FOREIGN KEY (`rx_claim_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_claim`(`rx_claim_id`);

-- ========= product --> pricing (4 constraint(s)) =========
-- Requires: product schema, pricing schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_price_change_id` FOREIGN KEY (`price_change_id`) REFERENCES `grocery_ecm`.`pricing`.`price_change`(`price_change_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);
ALTER TABLE `grocery_ecm`.`product`.`storefront` ADD CONSTRAINT `fk_product_storefront_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `grocery_ecm`.`pricing`.`price_book`(`price_book_id`);
ALTER TABLE `grocery_ecm`.`product`.`channel_config` ADD CONSTRAINT `fk_product_channel_config_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `grocery_ecm`.`pricing`.`price_book`(`price_book_id`);

-- ========= product --> promotion (10 constraint(s)) =========
-- Requires: product schema, promotion schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart_item` ADD CONSTRAINT `fk_product_cart_item_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_recommendation` ADD CONSTRAINT `fk_product_product_recommendation_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`promo_sku_assignment` ADD CONSTRAINT `fk_product_promo_sku_assignment_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_promo_offer_id` FOREIGN KEY (`promo_offer_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_offer`(`promo_offer_id`);

-- ========= product --> store (16 constraint(s)) =========
-- Requires: product schema, store schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`web_session` ADD CONSTRAINT `fk_product_web_session_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`cart` ADD CONSTRAINT `fk_product_cart_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`checkout_session` ADD CONSTRAINT `fk_product_checkout_session_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`slot_reservation` ADD CONSTRAINT `fk_product_slot_reservation_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`search_query` ADD CONSTRAINT `fk_product_search_query_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ADD CONSTRAINT `fk_product_order_status_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_assortment` ADD CONSTRAINT `fk_product_product_assortment_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= product --> supply (2 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `grocery_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `grocery_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);

-- ========= product --> vendor (19 constraint(s)) =========
-- Requires: product schema, vendor schema
ALTER TABLE `grocery_ecm`.`product`.`product_order_line` ADD CONSTRAINT `fk_product_product_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`upc_barcode` ADD CONSTRAINT `fk_product_upc_barcode_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`plu_code` ADD CONSTRAINT `fk_product_plu_code_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ADD CONSTRAINT `fk_product_allergen_declaration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_brand_co_manufacturer_vendor_supplier_id` FOREIGN KEY (`brand_co_manufacturer_vendor_supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_brand_supplier_id` FOREIGN KEY (`brand_supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`fuel_grade` ADD CONSTRAINT `fk_product_fuel_grade_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`recall` ADD CONSTRAINT `fk_product_recall_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_packaging` ADD CONSTRAINT `fk_product_item_packaging_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`product`.`gs1_sync` ADD CONSTRAINT `fk_product_gs1_sync_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= product --> workforce (32 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_header` ADD CONSTRAINT `fk_product_order_header_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `grocery_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_history` ADD CONSTRAINT `fk_product_order_status_history_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`delivery_order` ADD CONSTRAINT `fk_product_delivery_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`pickup_appointment` ADD CONSTRAINT `fk_product_pickup_appointment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_fulfillment` ADD CONSTRAINT `fk_product_order_fulfillment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `grocery_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_discount` ADD CONSTRAINT `fk_product_order_discount_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_refund` ADD CONSTRAINT `fk_product_order_refund_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`rx_order` ADD CONSTRAINT `fk_product_rx_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_substitution` ADD CONSTRAINT `fk_product_order_substitution_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`fulfillment_slot` ADD CONSTRAINT `fk_product_fulfillment_slot_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_status_event` ADD CONSTRAINT `fk_product_order_status_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_item` ADD CONSTRAINT `fk_product_product_item_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_hierarchy` ADD CONSTRAINT `fk_product_item_hierarchy_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_attribute` ADD CONSTRAINT `fk_product_item_attribute_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`nutritional_info` ADD CONSTRAINT `fk_product_nutritional_info_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`allergen_declaration` ADD CONSTRAINT `fk_product_allergen_declaration_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`private_label` ADD CONSTRAINT `fk_product_private_label_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`brand` ADD CONSTRAINT `fk_product_brand_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_cost` ADD CONSTRAINT `fk_product_item_cost_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_lifecycle_event` ADD CONSTRAINT `fk_product_item_lifecycle_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_substitution` ADD CONSTRAINT `fk_product_item_substitution_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`item_vendor` ADD CONSTRAINT `fk_product_item_vendor_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`recall` ADD CONSTRAINT `fk_product_recall_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ADD CONSTRAINT `fk_product_ab_test_experiment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`ab_test_experiment` ADD CONSTRAINT `fk_product_ab_test_experiment_last_modified_by_user_associate_id` FOREIGN KEY (`last_modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ADD CONSTRAINT `fk_product_order_hold_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`order_hold` ADD CONSTRAINT `fk_product_order_hold_primary_order_associate_id` FOREIGN KEY (`primary_order_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`product_order_line2` ADD CONSTRAINT `fk_product_product_order_line2_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`product`.`pick_assignment` ADD CONSTRAINT `fk_product_pick_assignment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= promotion --> assortment (14 constraint(s)) =========
-- Requires: promotion schema, assortment schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= promotion --> compliance (5 constraint(s)) =========
-- Requires: promotion schema, compliance schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `grocery_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `grocery_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= promotion --> customer (10 constraint(s)) =========
-- Requires: promotion schema, customer schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_household_id` FOREIGN KEY (`household_id`) REFERENCES `grocery_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `grocery_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `grocery_ecm`.`customer`.`shopper`(`shopper_id`);

-- ========= promotion --> finance (3 constraint(s)) =========
-- Requires: promotion schema, finance schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_performance` ADD CONSTRAINT `fk_promotion_promo_performance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= promotion --> fuel (1 constraint(s)) =========
-- Requires: promotion schema, fuel schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);

-- ========= promotion --> loyalty (2 constraint(s)) =========
-- Requires: promotion schema, loyalty schema
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `grocery_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `grocery_ecm`.`loyalty`.`membership`(`membership_id`);

-- ========= promotion --> payment (1 constraint(s)) =========
-- Requires: promotion schema, payment schema
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= promotion --> pricing (3 constraint(s)) =========
-- Requires: promotion schema, pricing schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= promotion --> product (3 constraint(s)) =========
-- Requires: promotion schema, product schema
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `grocery_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= promotion --> store (4 constraint(s)) =========
-- Requires: promotion schema, store schema
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`personalized_deal` ADD CONSTRAINT `fk_promotion_personalized_deal_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotional_event` ADD CONSTRAINT `fk_promotion_promotional_event_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= promotion --> supply (1 constraint(s)) =========
-- Requires: promotion schema, supply schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= promotion --> vendor (13 constraint(s)) =========
-- Requires: promotion schema, vendor schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_vendor_category_captain_id` FOREIGN KEY (`vendor_category_captain_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_category_captain`(`vendor_category_captain_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `grocery_ecm`.`vendor`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`digital_coupon` ADD CONSTRAINT `fk_promotion_digital_coupon_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= promotion --> workforce (19 constraint(s)) =========
-- Requires: promotion schema, workforce schema
ALTER TABLE `grocery_ecm`.`promotion`.`promo_campaign` ADD CONSTRAINT `fk_promotion_promo_campaign_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_offer` ADD CONSTRAINT `fk_promotion_promo_offer_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_calendar` ADD CONSTRAINT `fk_promotion_promo_calendar_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`ad_circular` ADD CONSTRAINT `fk_promotion_ad_circular_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_item` ADD CONSTRAINT `fk_promotion_offer_item_modified_by_user_associate_id` FOREIGN KEY (`modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`offer_eligibility_rule` ADD CONSTRAINT `fk_promotion_offer_eligibility_rule_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promotion_redemption` ADD CONSTRAINT `fk_promotion_promotion_redemption_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `grocery_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`tpr_event` ADD CONSTRAINT `fk_promotion_tpr_event_tertiary_tpr_created_by_user_associate_id` FOREIGN KEY (`tertiary_tpr_created_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`vendor_funding` ADD CONSTRAINT `fk_promotion_vendor_funding_tertiary_vendor_created_by_user_associate_id` FOREIGN KEY (`tertiary_vendor_created_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`funding_claim` ADD CONSTRAINT `fk_promotion_funding_claim_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_approved_by_user_associate_id` FOREIGN KEY (`approved_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_last_modified_by_user_associate_id` FOREIGN KEY (`last_modified_by_user_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_zone` ADD CONSTRAINT `fk_promotion_promo_zone_zone_manager_associate_id` FOREIGN KEY (`zone_manager_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`promotion`.`promo_performance` ADD CONSTRAINT `fk_promotion_promo_performance_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= store --> assortment (1 constraint(s)) =========
-- Requires: store schema, assortment schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `grocery_ecm`.`assortment`.`store_cluster`(`store_cluster_id`);

-- ========= store --> finance (6 constraint(s)) =========
-- Requires: store schema, finance schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `grocery_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= store --> loyalty (1 constraint(s)) =========
-- Requires: store schema, loyalty schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `grocery_ecm`.`loyalty`.`program_config`(`program_config_id`);

-- ========= store --> payment (1 constraint(s)) =========
-- Requires: store schema, payment schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);

-- ========= store --> pricing (2 constraint(s)) =========
-- Requires: store schema, pricing schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);
ALTER TABLE `grocery_ecm`.`store`.`region` ADD CONSTRAINT `fk_store_region_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= store --> supply (3 constraint(s)) =========
-- Requires: store schema, supply schema
ALTER TABLE `grocery_ecm`.`store`.`store_location` ADD CONSTRAINT `fk_store_store_location_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`store`.`region` ADD CONSTRAINT `fk_store_region_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

-- ========= store --> vendor (3 constraint(s)) =========
-- Requires: store schema, vendor schema
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`store`.`mfc_profile` ADD CONSTRAINT `fk_store_mfc_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`store`.`location_event` ADD CONSTRAINT `fk_store_location_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= store --> workforce (2 constraint(s)) =========
-- Requires: store schema, workforce schema
ALTER TABLE `grocery_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`store`.`location_event` ADD CONSTRAINT `fk_store_location_event_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= supply --> assortment (7 constraint(s)) =========
-- Requires: supply schema, assortment schema
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_line` ADD CONSTRAINT `fk_supply_replenishment_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `grocery_ecm`.`assortment`.`planogram`(`planogram_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_category_id` FOREIGN KEY (`category_id`) REFERENCES `grocery_ecm`.`assortment`.`category`(`category_id`);

-- ========= supply --> compliance (4 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_food_safety_inspection_id` FOREIGN KEY (`food_safety_inspection_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_inspection`(`food_safety_inspection_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_food_safety_inspection_id` FOREIGN KEY (`food_safety_inspection_id`) REFERENCES `grocery_ecm`.`compliance`.`food_safety_inspection`(`food_safety_inspection_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `grocery_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `grocery_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= supply --> finance (3 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= supply --> fulfillment (14 constraint(s)) =========
-- Requires: supply schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_detail` ADD CONSTRAINT `fk_supply_allocation_detail_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_return` ADD CONSTRAINT `fk_supply_vendor_return_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);

-- ========= supply --> pharmacy (6 constraint(s)) =========
-- Requires: supply schema, pharmacy schema
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`route_stop` ADD CONSTRAINT `fk_supply_route_stop_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_return` ADD CONSTRAINT `fk_supply_vendor_return_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_appointment` ADD CONSTRAINT `fk_supply_dc_appointment_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= supply --> pricing (2 constraint(s)) =========
-- Requires: supply schema, pricing schema
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_cost_price_id` FOREIGN KEY (`cost_price_id`) REFERENCES `grocery_ecm`.`pricing`.`cost_price`(`cost_price_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_line` ADD CONSTRAINT `fk_supply_replenishment_line_retail_price_id` FOREIGN KEY (`retail_price_id`) REFERENCES `grocery_ecm`.`pricing`.`retail_price`(`retail_price_id`);

-- ========= supply --> product (7 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_product_item_id` FOREIGN KEY (`product_item_id`) REFERENCES `grocery_ecm`.`product`.`product_item`(`product_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_detail` ADD CONSTRAINT `fk_supply_allocation_detail_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);

-- ========= supply --> promotion (4 constraint(s)) =========
-- Requires: supply schema, promotion schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_tpr_event_id` FOREIGN KEY (`tpr_event_id`) REFERENCES `grocery_ecm`.`promotion`.`tpr_event`(`tpr_event_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_promo_campaign_id` FOREIGN KEY (`promo_campaign_id`) REFERENCES `grocery_ecm`.`promotion`.`promo_campaign`(`promo_campaign_id`);

-- ========= supply --> store (14 constraint(s)) =========
-- Requires: supply schema, store schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_primary_replenishment_store_location_id` FOREIGN KEY (`primary_replenishment_store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_line` ADD CONSTRAINT `fk_supply_replenishment_line_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_origin_location_id` FOREIGN KEY (`origin_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_detail` ADD CONSTRAINT `fk_supply_allocation_detail_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supply_supplier_contract` ADD CONSTRAINT `fk_supply_supply_supplier_contract_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_return` ADD CONSTRAINT `fk_supply_vendor_return_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= supply --> vendor (14 constraint(s)) =========
-- Requires: supply schema, vendor schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `grocery_ecm`.`vendor`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_line` ADD CONSTRAINT `fk_supply_replenishment_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supply_supplier_contract` ADD CONSTRAINT `fk_supply_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_return` ADD CONSTRAINT `fk_supply_vendor_return_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_appointment` ADD CONSTRAINT `fk_supply_dc_appointment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `grocery_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= supply --> workforce (19 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt_line` ADD CONSTRAINT `fk_supply_goods_receipt_line_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`route_stop` ADD CONSTRAINT `fk_supply_route_stop_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_detail` ADD CONSTRAINT `fk_supply_allocation_detail_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supply_supplier_contract` ADD CONSTRAINT `fk_supply_supply_supplier_contract_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_chargeback` ADD CONSTRAINT `fk_supply_vendor_chargeback_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_return` ADD CONSTRAINT `fk_supply_vendor_return_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_appointment` ADD CONSTRAINT `fk_supply_dc_appointment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= vendor --> compliance (1 constraint(s)) =========
-- Requires: vendor schema, compliance schema
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= vendor --> finance (8 constraint(s)) =========
-- Requires: vendor schema, finance schema
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ADD CONSTRAINT `fk_vendor_supplier_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `grocery_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ADD CONSTRAINT `fk_vendor_private_label_spec_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= vendor --> product (2 constraint(s)) =========
-- Requires: vendor schema, product schema
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `grocery_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ADD CONSTRAINT `fk_vendor_private_label_spec_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `grocery_ecm`.`product`.`brand`(`brand_id`);

-- ========= vendor --> promotion (1 constraint(s)) =========
-- Requires: vendor schema, promotion schema
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_tpr_event_id` FOREIGN KEY (`tpr_event_id`) REFERENCES `grocery_ecm`.`promotion`.`tpr_event`(`tpr_event_id`);

-- ========= vendor --> workforce (11 constraint(s)) =========
-- Requires: vendor schema, workforce schema
ALTER TABLE `grocery_ecm`.`vendor`.`supplier` ADD CONSTRAINT `fk_vendor_supplier_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`supplier_site` ADD CONSTRAINT `fk_vendor_supplier_site_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_agreement` ADD CONSTRAINT `fk_vendor_trade_agreement_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_category_captain` ADD CONSTRAINT `fk_vendor_vendor_category_captain_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`vendor_item` ADD CONSTRAINT `fk_vendor_vendor_item_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`cost_schedule` ADD CONSTRAINT `fk_vendor_cost_schedule_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`trade_allowance` ADD CONSTRAINT `fk_vendor_trade_allowance_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`performance_scorecard` ADD CONSTRAINT `fk_vendor_performance_scorecard_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`compliance_record` ADD CONSTRAINT `fk_vendor_compliance_record_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`private_label_spec` ADD CONSTRAINT `fk_vendor_private_label_spec_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`vendor`.`quality_incident` ADD CONSTRAINT `fk_vendor_quality_incident_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);

-- ========= workforce --> compliance (1 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `grocery_ecm`.`compliance`.`program`(`program_id`);

-- ========= workforce --> finance (10 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `grocery_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `grocery_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `grocery_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `grocery_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= workforce --> fulfillment (2 constraint(s)) =========
-- Requires: workforce schema, fulfillment schema
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);

-- ========= workforce --> pricing (1 constraint(s)) =========
-- Requires: workforce schema, pricing schema
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_price_zone_id` FOREIGN KEY (`price_zone_id`) REFERENCES `grocery_ecm`.`pricing`.`price_zone`(`price_zone_id`);

-- ========= workforce --> store (17 constraint(s)) =========
-- Requires: workforce schema, store schema
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ADD CONSTRAINT `fk_workforce_associate_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_department_id` FOREIGN KEY (`department_id`) REFERENCES `grocery_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_store_location_id` FOREIGN KEY (`store_location_id`) REFERENCES `grocery_ecm`.`store`.`store_location`(`store_location_id`);

-- ========= workforce --> supply (1 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);

