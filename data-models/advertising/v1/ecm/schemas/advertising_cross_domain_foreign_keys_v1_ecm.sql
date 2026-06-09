-- Cross-Domain Foreign Keys for Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:07
-- Total cross-domain FK constraints: 964
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, audience, brand, campaign, client, contract, creative, finance, media, performance, project, talent, vendor

-- ========= analytics --> audience (1 constraint(s)) =========
-- Requires: analytics schema, audience schema
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= analytics --> brand (16 constraint(s)) =========
-- Requires: analytics schema, brand schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_brand_brand_profile_id` FOREIGN KEY (`brand_brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= analytics --> campaign (13 constraint(s)) =========
-- Requires: analytics schema, campaign schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ADD CONSTRAINT `fk_analytics_recipient_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= analytics --> client (21 constraint(s)) =========
-- Requires: analytics schema, client schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_client_onboarding_id` FOREIGN KEY (`client_onboarding_id`) REFERENCES `advertising_ecm`.`client`.`client_onboarding`(`client_onboarding_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `advertising_ecm`.`client`.`preference`(`preference_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_revenue_target_id` FOREIGN KEY (`revenue_target_id`) REFERENCES `advertising_ecm`.`client`.`revenue_target`(`revenue_target_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_client_brief_id` FOREIGN KEY (`client_brief_id`) REFERENCES `advertising_ecm`.`client`.`client_brief`(`client_brief_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ADD CONSTRAINT `fk_analytics_recipient_group_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= analytics --> contract (24 constraint(s)) =========
-- Requires: analytics schema, contract schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= analytics --> creative (11 constraint(s)) =========
-- Requires: analytics schema, creative schema
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `advertising_ecm`.`creative`.`concept`(`concept_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);

-- ========= analytics --> finance (12 constraint(s)) =========
-- Requires: analytics schema, finance schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= analytics --> media (23 constraint(s)) =========
-- Requires: analytics schema, media schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= analytics --> performance (1 constraint(s)) =========
-- Requires: analytics schema, performance schema
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);

-- ========= analytics --> project (12 constraint(s)) =========
-- Requires: analytics schema, project schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= analytics --> talent (19 constraint(s)) =========
-- Requires: analytics schema, talent schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_dashboard_created_by_user_worker_id` FOREIGN KEY (`dashboard_created_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_dashboard_last_modified_by_user_worker_id` FOREIGN KEY (`dashboard_last_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_dashboard_worker_id` FOREIGN KEY (`dashboard_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`insight_finding` ADD CONSTRAINT `fk_analytics_insight_finding_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_tertiary_report_modified_by_user_worker_id` FOREIGN KEY (`tertiary_report_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`report_delivery` ADD CONSTRAINT `fk_analytics_report_delivery_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`audience_insight` ADD CONSTRAINT `fk_analytics_audience_insight_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`analytics_request` ADD CONSTRAINT `fk_analytics_analytics_request_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`recipient_group` ADD CONSTRAINT `fk_analytics_recipient_group_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= analytics --> vendor (9 constraint(s)) =========
-- Requires: analytics schema, vendor schema
ALTER TABLE `advertising_ecm`.`analytics`.`insight_report` ADD CONSTRAINT `fk_analytics_insight_report_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`mmm_study` ADD CONSTRAINT `fk_analytics_mmm_study_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`attribution_study` ADD CONSTRAINT `fk_analytics_attribution_study_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`measurement_plan` ADD CONSTRAINT `fk_analytics_measurement_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`brand_lift_study` ADD CONSTRAINT `fk_analytics_brand_lift_study_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`incrementality_test` ADD CONSTRAINT `fk_analytics_incrementality_test_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`competitive_intelligence` ADD CONSTRAINT `fk_analytics_competitive_intelligence_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`creative_effectiveness_study` ADD CONSTRAINT `fk_analytics_creative_effectiveness_study_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`analytics`.`budget_optimization_scenario` ADD CONSTRAINT `fk_analytics_budget_optimization_scenario_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= audience --> analytics (5 constraint(s)) =========
-- Requires: audience schema, analytics schema
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_audience_insight_id` FOREIGN KEY (`audience_insight_id`) REFERENCES `advertising_ecm`.`analytics`.`audience_insight`(`audience_insight_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_insight_report_id` FOREIGN KEY (`insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_brand_lift_study_id` FOREIGN KEY (`brand_lift_study_id`) REFERENCES `advertising_ecm`.`analytics`.`brand_lift_study`(`brand_lift_study_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_experiment_incrementality_test_id` FOREIGN KEY (`experiment_incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_incrementality_test_id` FOREIGN KEY (`incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);

-- ========= audience --> brand (9 constraint(s)) =========
-- Requires: audience schema, brand schema
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= audience --> campaign (8 constraint(s)) =========
-- Requires: audience schema, campaign schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= audience --> client (4 constraint(s)) =========
-- Requires: audience schema, client schema
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= audience --> contract (9 constraint(s)) =========
-- Requires: audience schema, contract schema
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ADD CONSTRAINT `fk_audience_dmp_integration_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ADD CONSTRAINT `fk_audience_segment_activation_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);

-- ========= audience --> creative (3 constraint(s)) =========
-- Requires: audience schema, creative schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= audience --> finance (3 constraint(s)) =========
-- Requires: audience schema, finance schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);

-- ========= audience --> media (5 constraint(s)) =========
-- Requires: audience schema, media schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= audience --> performance (2 constraint(s)) =========
-- Requires: audience schema, performance schema
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_tracking_pixel_id` FOREIGN KEY (`tracking_pixel_id`) REFERENCES `advertising_ecm`.`performance`.`tracking_pixel`(`tracking_pixel_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);

-- ========= audience --> project (7 constraint(s)) =========
-- Requires: audience schema, project schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ADD CONSTRAINT `fk_audience_segment_usage_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= audience --> talent (13 constraint(s)) =========
-- Requires: audience schema, talent schema
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ADD CONSTRAINT `fk_audience_third_party_feed_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ADD CONSTRAINT `fk_audience_dmp_integration_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ADD CONSTRAINT `fk_audience_taxonomy_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_last_modified_by_user_worker_id` FOREIGN KEY (`last_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ADD CONSTRAINT `fk_audience_segment_usage_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= audience --> vendor (6 constraint(s)) =========
-- Requires: audience schema, vendor schema
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ADD CONSTRAINT `fk_audience_third_party_feed_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ADD CONSTRAINT `fk_audience_dmp_integration_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= brand --> analytics (4 constraint(s)) =========
-- Requires: brand schema, analytics schema
ALTER TABLE `advertising_ecm`.`brand`.`share_of_voice` ADD CONSTRAINT `fk_brand_share_of_voice_competitive_intelligence_id` FOREIGN KEY (`competitive_intelligence_id`) REFERENCES `advertising_ecm`.`analytics`.`competitive_intelligence`(`competitive_intelligence_id`);
ALTER TABLE `advertising_ecm`.`brand`.`health_metric` ADD CONSTRAINT `fk_brand_health_metric_brand_lift_study_id` FOREIGN KEY (`brand_lift_study_id`) REFERENCES `advertising_ecm`.`analytics`.`brand_lift_study`(`brand_lift_study_id`);
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ADD CONSTRAINT `fk_brand_crisis_event_insight_report_id` FOREIGN KEY (`insight_report_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_report`(`insight_report_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_audience_insight_id` FOREIGN KEY (`audience_insight_id`) REFERENCES `advertising_ecm`.`analytics`.`audience_insight`(`audience_insight_id`);

-- ========= brand --> campaign (3 constraint(s)) =========
-- Requires: brand schema, campaign schema
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`press_release` ADD CONSTRAINT `fk_brand_press_release_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= brand --> client (13 constraint(s)) =========
-- Requires: brand schema, client schema
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ADD CONSTRAINT `fk_brand_guideline_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ADD CONSTRAINT `fk_brand_positioning_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`brand`.`positioning` ADD CONSTRAINT `fk_brand_positioning_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ADD CONSTRAINT `fk_brand_media_coverage_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ADD CONSTRAINT `fk_brand_crisis_event_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ADD CONSTRAINT `fk_brand_advertiser_policy_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= brand --> contract (1 constraint(s)) =========
-- Requires: brand schema, contract schema
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ADD CONSTRAINT `fk_brand_brand_spokesperson_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= brand --> creative (1 constraint(s)) =========
-- Requires: brand schema, creative schema
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= brand --> project (1 constraint(s)) =========
-- Requires: brand schema, project schema
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= brand --> talent (9 constraint(s)) =========
-- Requires: brand schema, talent schema
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ADD CONSTRAINT `fk_brand_guideline_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`crisis_event` ADD CONSTRAINT `fk_brand_crisis_event_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_primary_brand_worker_id` FOREIGN KEY (`primary_brand_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`architecture` ADD CONSTRAINT `fk_brand_architecture_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`partnership` ADD CONSTRAINT `fk_brand_partnership_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ADD CONSTRAINT `fk_brand_advertiser_policy_approved_by_user_worker_id` FOREIGN KEY (`approved_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`brand`.`advertiser_policy` ADD CONSTRAINT `fk_brand_advertiser_policy_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= brand --> vendor (7 constraint(s)) =========
-- Requires: brand schema, vendor schema
ALTER TABLE `advertising_ecm`.`brand`.`brand_profile` ADD CONSTRAINT `fk_brand_brand_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`brand`.`guideline` ADD CONSTRAINT `fk_brand_guideline_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_asset` ADD CONSTRAINT `fk_brand_brand_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`brand`.`pr_campaign` ADD CONSTRAINT `fk_brand_pr_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`brand`.`media_coverage` ADD CONSTRAINT `fk_brand_media_coverage_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_spokesperson` ADD CONSTRAINT `fk_brand_brand_spokesperson_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`brand`.`brand_compliance_check` ADD CONSTRAINT `fk_brand_brand_compliance_check_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= campaign --> analytics (4 constraint(s)) =========
-- Requires: campaign schema, analytics schema
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_budget_optimization_scenario_id` FOREIGN KEY (`budget_optimization_scenario_id`) REFERENCES `advertising_ecm`.`analytics`.`budget_optimization_scenario`(`budget_optimization_scenario_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_competitive_intelligence_id` FOREIGN KEY (`competitive_intelligence_id`) REFERENCES `advertising_ecm`.`analytics`.`competitive_intelligence`(`competitive_intelligence_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_incrementality_test_id` FOREIGN KEY (`incrementality_test_id`) REFERENCES `advertising_ecm`.`analytics`.`incrementality_test`(`incrementality_test_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_insight_finding_id` FOREIGN KEY (`insight_finding_id`) REFERENCES `advertising_ecm`.`analytics`.`insight_finding`(`insight_finding_id`);

-- ========= campaign --> audience (2 constraint(s)) =========
-- Requires: campaign schema, audience schema
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= campaign --> brand (11 constraint(s)) =========
-- Requires: campaign schema, brand schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ADD CONSTRAINT `fk_campaign_campaign_spokesperson_brand_spokesperson_id` FOREIGN KEY (`brand_spokesperson_id`) REFERENCES `advertising_ecm`.`brand`.`brand_spokesperson`(`brand_spokesperson_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ADD CONSTRAINT `fk_campaign_competitive_targeting_competitive_brand_id` FOREIGN KEY (`competitive_brand_id`) REFERENCES `advertising_ecm`.`brand`.`competitive_brand`(`competitive_brand_id`);

-- ========= campaign --> client (4 constraint(s)) =========
-- Requires: campaign schema, client schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);

-- ========= campaign --> contract (2 constraint(s)) =========
-- Requires: campaign schema, contract schema
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= campaign --> creative (3 constraint(s)) =========
-- Requires: campaign schema, creative schema
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ADD CONSTRAINT `fk_campaign_creative_usage_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= campaign --> media (3 constraint(s)) =========
-- Requires: campaign schema, media schema
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ADD CONSTRAINT `fk_campaign_booking_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ADD CONSTRAINT `fk_campaign_ad_placement_rotation_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);

-- ========= campaign --> project (1 constraint(s)) =========
-- Requires: campaign schema, project schema
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_workflow_step_id` FOREIGN KEY (`workflow_step_id`) REFERENCES `advertising_ecm`.`project`.`workflow_step`(`workflow_step_id`);

-- ========= campaign --> talent (12 constraint(s)) =========
-- Requires: campaign schema, talent schema
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ADD CONSTRAINT `fk_campaign_pacing_rule_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_approval_created_by_user_worker_id` FOREIGN KEY (`approval_created_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_approval_escalated_to_user_worker_id` FOREIGN KEY (`approval_escalated_to_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_approval_modified_by_user_worker_id` FOREIGN KEY (`approval_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_approval_worker_id` FOREIGN KEY (`approval_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ADD CONSTRAINT `fk_campaign_booking_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= campaign --> vendor (7 constraint(s)) =========
-- Requires: campaign schema, vendor schema
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ADD CONSTRAINT `fk_campaign_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= client --> audience (6 constraint(s)) =========
-- Requires: client schema, audience schema
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`preference` ADD CONSTRAINT `fk_client_preference_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_segment_license` ADD CONSTRAINT `fk_client_advertiser_segment_license_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= client --> brand (3 constraint(s)) =========
-- Requires: client schema, brand schema
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ADD CONSTRAINT `fk_client_client_brand_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= client --> campaign (3 constraint(s)) =========
-- Requires: client schema, campaign schema
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ADD CONSTRAINT `fk_client_survey_wave_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= client --> contract (3 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> creative (2 constraint(s)) =========
-- Requires: client schema, creative schema
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`client`.`brief_approver` ADD CONSTRAINT `fk_client_brief_approver_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);

-- ========= client --> finance (4 constraint(s)) =========
-- Requires: client schema, finance schema
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ADD CONSTRAINT `fk_client_advertiser_cost_center_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= client --> media (2 constraint(s)) =========
-- Requires: client schema, media schema
ALTER TABLE `advertising_ecm`.`client`.`advertiser_cost_center_allocation` ADD CONSTRAINT `fk_client_advertiser_cost_center_allocation_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `advertising_ecm`.`media`.`allocation`(`allocation_id`);
ALTER TABLE `advertising_ecm`.`client`.`io_authorization` ADD CONSTRAINT `fk_client_io_authorization_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);

-- ========= client --> project (7 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ADD CONSTRAINT `fk_client_competitive_conflict_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ADD CONSTRAINT `fk_client_relationship_history_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_workfront_project_initiative_id` FOREIGN KEY (`workfront_project_initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= client --> talent (14 constraint(s)) =========
-- Requires: client schema, talent schema
ALTER TABLE `advertising_ecm`.`client`.`client_brand` ADD CONSTRAINT `fk_client_client_brand_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_tertiary_account_approved_by_employee_worker_id` FOREIGN KEY (`tertiary_account_approved_by_employee_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_interaction_worker_id` FOREIGN KEY (`interaction_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`nps_response` ADD CONSTRAINT `fk_client_nps_response_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`competitive_conflict` ADD CONSTRAINT `fk_client_competitive_conflict_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`revenue_target` ADD CONSTRAINT `fk_client_revenue_target_primary_revenue_worker_id` FOREIGN KEY (`primary_revenue_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`relationship_history` ADD CONSTRAINT `fk_client_relationship_history_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_onboarding` ADD CONSTRAINT `fk_client_client_onboarding_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_talent_engagement_id` FOREIGN KEY (`talent_engagement_id`) REFERENCES `advertising_ecm`.`talent`.`talent_engagement`(`talent_engagement_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_engagement` ADD CONSTRAINT `fk_client_client_engagement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `advertising_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= client --> vendor (8 constraint(s)) =========
-- Requires: client schema, vendor schema
ALTER TABLE `advertising_ecm`.`client`.`account_team` ADD CONSTRAINT `fk_client_account_team_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`agency_relationship` ADD CONSTRAINT `fk_client_agency_relationship_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`client_brief` ADD CONSTRAINT `fk_client_client_brief_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ADD CONSTRAINT `fk_client_preferred_vendor_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`client`.`preferred_vendor` ADD CONSTRAINT `fk_client_preferred_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`brand_supplier_approval` ADD CONSTRAINT `fk_client_brand_supplier_approval_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`client`.`survey_wave` ADD CONSTRAINT `fk_client_survey_wave_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= contract --> brand (5 constraint(s)) =========
-- Requires: contract schema, brand schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= contract --> campaign (5 constraint(s)) =========
-- Requires: contract schema, campaign schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ADD CONSTRAINT `fk_contract_scope_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= contract --> client (12 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_team_id` FOREIGN KEY (`account_team_id`) REFERENCES `advertising_ecm`.`client`.`account_team`(`account_team_id`);
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_sow_client_advertiser_id` FOREIGN KEY (`sow_client_advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_renewal_client_contact_id` FOREIGN KEY (`renewal_client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);

-- ========= contract --> creative (1 constraint(s)) =========
-- Requires: contract schema, creative schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= contract --> finance (9 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= contract --> media (2 constraint(s)) =========
-- Requires: contract schema, media schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_flowchart_id` FOREIGN KEY (`flowchart_id`) REFERENCES `advertising_ecm`.`media`.`flowchart`(`flowchart_id`);

-- ========= contract --> project (2 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= contract --> talent (7 constraint(s)) =========
-- Requires: contract schema, talent schema
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_sow_worker_id` FOREIGN KEY (`sow_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_last_modified_by_user_worker_id` FOREIGN KEY (`last_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_primary_rfp_worker_id` FOREIGN KEY (`primary_rfp_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= contract --> vendor (5 constraint(s)) =========
-- Requires: contract schema, vendor schema
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= creative --> audience (6 constraint(s)) =========
-- Requires: creative schema, audience schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= creative --> brand (9 constraint(s)) =========
-- Requires: creative schema, brand schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_positioning_id` FOREIGN KEY (`positioning_id`) REFERENCES `advertising_ecm`.`brand`.`positioning`(`positioning_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ADD CONSTRAINT `fk_creative_brand_guideline_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= creative --> campaign (12 constraint(s)) =========
-- Requires: creative schema, campaign schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);

-- ========= creative --> client (10 constraint(s)) =========
-- Requires: creative schema, client schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ADD CONSTRAINT `fk_creative_brand_guideline_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ADD CONSTRAINT `fk_creative_proof_review_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_review` ADD CONSTRAINT `fk_creative_proof_review_contact_client_contact_id` FOREIGN KEY (`contact_client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);

-- ========= creative --> contract (7 constraint(s)) =========
-- Requires: creative schema, contract schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= creative --> finance (11 constraint(s)) =========
-- Requires: creative schema, finance schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `advertising_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_budget_allocation` ADD CONSTRAINT `fk_creative_asset_budget_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `advertising_ecm`.`finance`.`budget_line`(`budget_line_id`);

-- ========= creative --> media (8 constraint(s)) =========
-- Requires: creative schema, media schema
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_usage` ADD CONSTRAINT `fk_creative_asset_usage_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);

-- ========= creative --> project (27 constraint(s)) =========
-- Requires: creative schema, project schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_project_brief_id` FOREIGN KEY (`project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_workfront_project_initiative_id` FOREIGN KEY (`workfront_project_initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `advertising_ecm`.`project`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `advertising_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `advertising_ecm`.`project`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `advertising_ecm`.`project`.`change_request`(`change_request_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `advertising_ecm`.`project`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `advertising_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `advertising_ecm`.`project`.`change_request`(`change_request_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= creative --> talent (22 constraint(s)) =========
-- Requires: creative schema, talent schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`asset_version` ADD CONSTRAINT `fk_creative_asset_version_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_concept_created_by_user_worker_id` FOREIGN KEY (`concept_created_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_concept_modified_by_user_worker_id` FOREIGN KEY (`concept_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`concept` ADD CONSTRAINT `fk_creative_concept_concept_worker_id` FOREIGN KEY (`concept_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ADD CONSTRAINT `fk_creative_proof_comment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof_comment` ADD CONSTRAINT `fk_creative_proof_comment_tertiary_proof_deleted_by_worker_id` FOREIGN KEY (`tertiary_proof_deleted_by_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`brand_guideline` ADD CONSTRAINT `fk_creative_brand_guideline_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`rights_clearance` ADD CONSTRAINT `fk_creative_rights_clearance_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_adaptation_modified_by_user_worker_id` FOREIGN KEY (`adaptation_modified_by_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_adaptation_worker_id` FOREIGN KEY (`adaptation_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_assigned_to_user_worker_id` FOREIGN KEY (`assigned_to_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_escalated_to_user_worker_id` FOREIGN KEY (`escalated_to_user_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`creative`.`review_cycle` ADD CONSTRAINT `fk_creative_review_cycle_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= creative --> vendor (8 constraint(s)) =========
-- Requires: creative schema, vendor schema
ALTER TABLE `advertising_ecm`.`creative`.`creative_brief` ADD CONSTRAINT `fk_creative_creative_brief_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_asset` ADD CONSTRAINT `fk_creative_creative_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`production_job` ADD CONSTRAINT `fk_creative_production_job_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`proof` ADD CONSTRAINT `fk_creative_proof_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_compliance_check` ADD CONSTRAINT `fk_creative_creative_compliance_check_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_deliverable` ADD CONSTRAINT `fk_creative_creative_deliverable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`adaptation` ADD CONSTRAINT `fk_creative_adaptation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`creative`.`creative_request` ADD CONSTRAINT `fk_creative_creative_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= finance --> brand (11 constraint(s)) =========
-- Requires: finance schema, brand schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= finance --> campaign (10 constraint(s)) =========
-- Requires: finance schema, campaign schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= finance --> client (10 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_client_brief_id` FOREIGN KEY (`client_brief_id`) REFERENCES `advertising_ecm`.`client`.`client_brief`(`client_brief_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `advertising_ecm`.`client`.`legal_entity`(`legal_entity_id`);

-- ========= finance --> contract (9 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `advertising_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_scope_item_id` FOREIGN KEY (`scope_item_id`) REFERENCES `advertising_ecm`.`contract`.`scope_item`(`scope_item_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= finance --> creative (3 constraint(s)) =========
-- Requires: finance schema, creative schema
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_creative_deliverable_id` FOREIGN KEY (`creative_deliverable_id`) REFERENCES `advertising_ecm`.`creative`.`creative_deliverable`(`creative_deliverable_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_production_job_id` FOREIGN KEY (`production_job_id`) REFERENCES `advertising_ecm`.`creative`.`production_job`(`production_job_id`);

-- ========= finance --> media (21 constraint(s)) =========
-- Requires: finance schema, media schema
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);

-- ========= finance --> performance (20 constraint(s)) =========
-- Requires: finance schema, performance schema
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`client_invoice` ADD CONSTRAINT `fk_finance_client_invoice_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_video_completion_event_id` FOREIGN KEY (`video_completion_event_id`) REFERENCES `advertising_ecm`.`performance`.`video_completion_event`(`video_completion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_performance_kpi_target_id` FOREIGN KEY (`performance_kpi_target_id`) REFERENCES `advertising_ecm`.`performance`.`performance_kpi_target`(`performance_kpi_target_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_delivery_pacing_id` FOREIGN KEY (`delivery_pacing_id`) REFERENCES `advertising_ecm`.`performance`.`delivery_pacing`(`delivery_pacing_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_viewability_measurement_id` FOREIGN KEY (`viewability_measurement_id`) REFERENCES `advertising_ecm`.`performance`.`viewability_measurement`(`viewability_measurement_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_click_event_id` FOREIGN KEY (`click_event_id`) REFERENCES `advertising_ecm`.`performance`.`click_event`(`click_event_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_impression_event_id` FOREIGN KEY (`impression_event_id`) REFERENCES `advertising_ecm`.`performance`.`impression_event`(`impression_event_id`);

-- ========= finance --> talent (1 constraint(s)) =========
-- Requires: finance schema, talent schema
ALTER TABLE `advertising_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= finance --> vendor (9 constraint(s)) =========
-- Requires: finance schema, vendor schema
ALTER TABLE `advertising_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`vendor_payable` ADD CONSTRAINT `fk_finance_vendor_payable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`media_cost_reconciliation` ADD CONSTRAINT `fk_finance_media_cost_reconciliation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`finance`.`credit_memo` ADD CONSTRAINT `fk_finance_credit_memo_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= media --> audience (11 constraint(s)) =========
-- Requires: media schema, audience schema
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ADD CONSTRAINT `fk_media_sov_benchmark_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ADD CONSTRAINT `fk_media_audience_rating_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);

-- ========= media --> brand (7 constraint(s)) =========
-- Requires: media schema, brand schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ADD CONSTRAINT `fk_media_sov_benchmark_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= media --> campaign (7 constraint(s)) =========
-- Requires: media schema, campaign schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= media --> client (5 constraint(s)) =========
-- Requires: media schema, client schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ADD CONSTRAINT `fk_media_sov_benchmark_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= media --> contract (6 constraint(s)) =========
-- Requires: media schema, contract schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= media --> creative (9 constraint(s)) =========
-- Requires: media schema, creative schema
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_creative_brief_id` FOREIGN KEY (`creative_brief_id`) REFERENCES `advertising_ecm`.`creative`.`creative_brief`(`creative_brief_id`);
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ADD CONSTRAINT `fk_media_io_creative_trafficking_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ADD CONSTRAINT `fk_media_plan_asset_assignment_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= media --> finance (9 constraint(s)) =========
-- Requires: media schema, finance schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= media --> project (6 constraint(s)) =========
-- Requires: media schema, project schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`media`.`allocation` ADD CONSTRAINT `fk_media_allocation_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);

-- ========= media --> talent (9 constraint(s)) =========
-- Requires: media schema, talent schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan` ADD CONSTRAINT `fk_media_plan_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ADD CONSTRAINT `fk_media_io_creative_trafficking_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ADD CONSTRAINT `fk_media_plan_asset_assignment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= media --> vendor (14 constraint(s)) =========
-- Requires: media schema, vendor schema
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ADD CONSTRAINT `fk_media_audience_rating_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ADD CONSTRAINT `fk_media_publisher_property_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ADD CONSTRAINT `fk_media_channel_rate_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ADD CONSTRAINT `fk_media_channel_rate_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ADD CONSTRAINT `fk_media_channel_supplier_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ADD CONSTRAINT `fk_media_format_availability_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);

-- ========= performance --> audience (6 constraint(s)) =========
-- Requires: performance schema, audience schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `advertising_ecm`.`audience`.`activation`(`activation_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_holdout_group_id` FOREIGN KEY (`holdout_group_id`) REFERENCES `advertising_ecm`.`audience`.`holdout_group`(`holdout_group_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `advertising_ecm`.`audience`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= performance --> brand (7 constraint(s)) =========
-- Requires: performance schema, brand schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ADD CONSTRAINT `fk_performance_brand_safety_signal_advertiser_policy_id` FOREIGN KEY (`advertiser_policy_id`) REFERENCES `advertising_ecm`.`brand`.`advertiser_policy`(`advertiser_policy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ADD CONSTRAINT `fk_performance_brand_safety_signal_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= performance --> campaign (19 constraint(s)) =========
-- Requires: performance schema, campaign schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`performance`.`session` ADD CONSTRAINT `fk_performance_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);

-- ========= performance --> client (9 constraint(s)) =========
-- Requires: performance schema, client schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= performance --> contract (8 constraint(s)) =========
-- Requires: performance schema, contract schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ADD CONSTRAINT `fk_performance_measurement_discrepancy_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);

-- ========= performance --> creative (7 constraint(s)) =========
-- Requires: performance schema, creative schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= performance --> media (18 constraint(s)) =========
-- Requires: performance schema, media schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`performance`.`click_event` ADD CONSTRAINT `fk_performance_click_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`conversion_event` ADD CONSTRAINT `fk_performance_conversion_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ADD CONSTRAINT `fk_performance_brand_safety_signal_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ADD CONSTRAINT `fk_performance_measurement_discrepancy_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ADD CONSTRAINT `fk_performance_measurement_discrepancy_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`session` ADD CONSTRAINT `fk_performance_session_placement_id` FOREIGN KEY (`placement_id`) REFERENCES `advertising_ecm`.`media`.`placement`(`placement_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_placement_id` FOREIGN KEY (`placement_id`) REFERENCES `advertising_ecm`.`media`.`placement`(`placement_id`);

-- ========= performance --> vendor (14 constraint(s)) =========
-- Requires: performance schema, vendor schema
ALTER TABLE `advertising_ecm`.`performance`.`impression_event` ADD CONSTRAINT `fk_performance_impression_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`viewability_measurement` ADD CONSTRAINT `fk_performance_viewability_measurement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`tracking_pixel` ADD CONSTRAINT `fk_performance_tracking_pixel_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`delivery_pacing` ADD CONSTRAINT `fk_performance_delivery_pacing_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`ivt_classification` ADD CONSTRAINT `fk_performance_ivt_classification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`brand_safety_signal` ADD CONSTRAINT `fk_performance_brand_safety_signal_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`measurement_discrepancy` ADD CONSTRAINT `fk_performance_measurement_discrepancy_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `advertising_ecm`.`performance`.`attribution_model` ADD CONSTRAINT `fk_performance_attribution_model_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`performance`.`performance_kpi_target` ADD CONSTRAINT `fk_performance_performance_kpi_target_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`performance`.`video_completion_event` ADD CONSTRAINT `fk_performance_video_completion_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`rtb_bid_event` ADD CONSTRAINT `fk_performance_rtb_bid_event_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`performance`.`pixel_deployment` ADD CONSTRAINT `fk_performance_pixel_deployment_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`performance`.`model_platform_configuration` ADD CONSTRAINT `fk_performance_model_platform_configuration_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`performance`.`auction` ADD CONSTRAINT `fk_performance_auction_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);

-- ========= project --> audience (2 constraint(s)) =========
-- Requires: project schema, audience schema
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `advertising_ecm`.`audience`.`persona`(`persona_id`);

-- ========= project --> brand (7 constraint(s)) =========
-- Requires: project schema, brand schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `advertising_ecm`.`brand`.`guideline`(`guideline_id`);

-- ========= project --> campaign (6 constraint(s)) =========
-- Requires: project schema, campaign schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= project --> client (8 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_primary_change_client_contact_id` FOREIGN KEY (`primary_change_client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_client_brief_id` FOREIGN KEY (`client_brief_id`) REFERENCES `advertising_ecm`.`client`.`client_brief`(`client_brief_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `advertising_ecm`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= project --> contract (15 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`status_update` ADD CONSTRAINT `fk_project_status_update_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `advertising_ecm`.`contract`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_template` ADD CONSTRAINT `fk_project_project_template_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);

-- ========= project --> finance (7 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `advertising_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `advertising_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= project --> media (4 constraint(s)) =========
-- Requires: project schema, media schema
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= project --> performance (2 constraint(s)) =========
-- Requires: project schema, performance schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `advertising_ecm`.`performance`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_tracking_pixel_id` FOREIGN KEY (`tracking_pixel_id`) REFERENCES `advertising_ecm`.`performance`.`tracking_pixel`(`tracking_pixel_id`);

-- ========= project --> talent (21 constraint(s)) =========
-- Requires: project schema, talent schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_primary_project_worker_id` FOREIGN KEY (`primary_project_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `advertising_ecm`.`talent`.`position`(`position_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `advertising_ecm`.`talent`.`position`(`position_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_talent_engagement_id` FOREIGN KEY (`talent_engagement_id`) REFERENCES `advertising_ecm`.`talent`.`talent_engagement`(`talent_engagement_id`);
ALTER TABLE `advertising_ecm`.`project`.`status_update` ADD CONSTRAINT `fk_project_status_update_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `advertising_ecm`.`talent`.`org_unit`(`org_unit_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_primary_time_worker_id` FOREIGN KEY (`primary_time_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_primary_project_worker_id` FOREIGN KEY (`primary_project_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`sprint` ADD CONSTRAINT `fk_project_sprint_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`project`.`sprint` ADD CONSTRAINT `fk_project_sprint_sprint_worker_id` FOREIGN KEY (`sprint_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

-- ========= project --> vendor (1 constraint(s)) =========
-- Requires: project schema, vendor schema
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= talent --> brand (4 constraint(s)) =========
-- Requires: talent schema, brand schema
ALTER TABLE `advertising_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);
ALTER TABLE `advertising_ecm`.`talent`.`performance_review` ADD CONSTRAINT `fk_talent_performance_review_brand_profile_id` FOREIGN KEY (`brand_profile_id`) REFERENCES `advertising_ecm`.`brand`.`brand_profile`(`brand_profile_id`);

-- ========= talent --> campaign (3 constraint(s)) =========
-- Requires: talent schema, campaign schema
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);

-- ========= talent --> client (6 constraint(s)) =========
-- Requires: talent schema, client schema
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_address_id` FOREIGN KEY (`address_id`) REFERENCES `advertising_ecm`.`client`.`address`(`address_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ADD CONSTRAINT `fk_talent_talent_rate_card_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= talent --> contract (5 constraint(s)) =========
-- Requires: talent schema, contract schema
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= talent --> creative (1 constraint(s)) =========
-- Requires: talent schema, creative schema
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `advertising_ecm`.`creative`.`creative_asset`(`creative_asset_id`);

-- ========= talent --> finance (6 constraint(s)) =========
-- Requires: talent schema, finance schema
ALTER TABLE `advertising_ecm`.`talent`.`position` ADD CONSTRAINT `fk_talent_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_record` ADD CONSTRAINT `fk_talent_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `advertising_ecm`.`talent`.`payroll_run` ADD CONSTRAINT `fk_talent_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `advertising_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= talent --> media (1 constraint(s)) =========
-- Requires: talent schema, media schema
ALTER TABLE `advertising_ecm`.`talent`.`capacity_plan` ADD CONSTRAINT `fk_talent_capacity_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= talent --> performance (1 constraint(s)) =========
-- Requires: talent schema, performance schema
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `advertising_ecm`.`performance`.`conversion_event`(`conversion_event_id`);

-- ========= talent --> project (7 constraint(s)) =========
-- Requires: talent schema, project schema
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`talent`.`resource_allocation` ADD CONSTRAINT `fk_talent_resource_allocation_project_assignment_id` FOREIGN KEY (`project_assignment_id`) REFERENCES `advertising_ecm`.`project`.`project_assignment`(`project_assignment_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`talent`.`timesheet` ADD CONSTRAINT `fk_talent_timesheet_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`talent`.`leave_request` ADD CONSTRAINT `fk_talent_leave_request_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_assignment` ADD CONSTRAINT `fk_talent_talent_assignment_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= talent --> vendor (4 constraint(s)) =========
-- Requires: talent schema, vendor schema
ALTER TABLE `advertising_ecm`.`talent`.`talent_engagement` ADD CONSTRAINT `fk_talent_talent_engagement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`talent`.`talent_rate_card` ADD CONSTRAINT `fk_talent_talent_rate_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`talent`.`representation` ADD CONSTRAINT `fk_talent_representation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);

-- ========= vendor --> campaign (9 constraint(s)) =========
-- Requires: vendor schema, campaign schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);

-- ========= vendor --> client (6 constraint(s)) =========
-- Requires: vendor schema, client schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_client_brand_id` FOREIGN KEY (`client_brand_id`) REFERENCES `advertising_ecm`.`client`.`client_brand`(`client_brand_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ADD CONSTRAINT `fk_vendor_preferred_vendor_list_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_agency_relationship_id` FOREIGN KEY (`agency_relationship_id`) REFERENCES `advertising_ecm`.`client`.`agency_relationship`(`agency_relationship_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `advertising_ecm`.`client`.`advertiser`(`advertiser_id`);

-- ========= vendor --> contract (10 constraint(s)) =========
-- Requires: vendor schema, contract schema
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ADD CONSTRAINT `fk_vendor_vendor_onboarding_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ADD CONSTRAINT `fk_vendor_preferred_vendor_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ADD CONSTRAINT `fk_vendor_supply_chain_profile_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);

-- ========= vendor --> media (7 constraint(s)) =========
-- Requires: vendor schema, media schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_vendor_io_media_insertion_order_id` FOREIGN KEY (`vendor_io_media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_ssp_platform_id` FOREIGN KEY (`ssp_platform_id`) REFERENCES `advertising_ecm`.`media`.`ssp_platform`(`ssp_platform_id`);

-- ========= vendor --> project (6 constraint(s)) =========
-- Requires: vendor schema, project schema
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ADD CONSTRAINT `fk_vendor_platform_activation_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);

-- ========= vendor --> talent (6 constraint(s)) =========
-- Requires: vendor schema, talent schema
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ADD CONSTRAINT `fk_vendor_vendor_onboarding_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ADD CONSTRAINT `fk_vendor_vendor_onboarding_primary_vendor_worker_id` FOREIGN KEY (`primary_vendor_worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_talent_engagement_id` FOREIGN KEY (`talent_engagement_id`) REFERENCES `advertising_ecm`.`talent`.`talent_engagement`(`talent_engagement_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_talent_engagement_id` FOREIGN KEY (`talent_engagement_id`) REFERENCES `advertising_ecm`.`talent`.`talent_engagement`(`talent_engagement_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ADD CONSTRAINT `fk_vendor_platform_activation_worker_id` FOREIGN KEY (`worker_id`) REFERENCES `advertising_ecm`.`talent`.`worker`(`worker_id`);

