-- Cross-Domain Foreign Keys for Business: Real Estate | Version: v1_mvm
-- Generated on: 2026-05-02 05:06:39
-- Total cross-domain FK constraints: 1883
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: brokerage, compliance, development, finance, investment, lease, maintenance, marketing, owner, property, reference, tenant, transaction, valuation

-- ========= brokerage --> compliance (24 constraint(s)) =========
-- Requires: brokerage schema, compliance schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= brokerage --> development (5 constraint(s)) =========
-- Requires: brokerage schema, development schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= brokerage --> finance (20 constraint(s)) =========
-- Requires: brokerage schema, finance schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker` ADD CONSTRAINT `fk_brokerage_broker_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= brokerage --> lease (4 constraint(s)) =========
-- Requires: brokerage schema, lease schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);

-- ========= brokerage --> marketing (11 constraint(s)) =========
-- Requires: brokerage schema, marketing schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);

-- ========= brokerage --> owner (1 constraint(s)) =========
-- Requires: brokerage schema, owner schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= brokerage --> property (27 constraint(s)) =========
-- Requires: brokerage schema, property schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_property_ownership_interest_id` FOREIGN KEY (`property_ownership_interest_id`) REFERENCES `real_estate_ecm`.`property`.`property_ownership_interest`(`property_ownership_interest_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= brokerage --> reference (62 constraint(s)) =========
-- Requires: brokerage schema, reference schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker` ADD CONSTRAINT `fk_brokerage_broker_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker` ADD CONSTRAINT `fk_brokerage_broker_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker` ADD CONSTRAINT `fk_brokerage_broker_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);

-- ========= brokerage --> tenant (4 constraint(s)) =========
-- Requires: brokerage schema, tenant schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= brokerage --> transaction (4 constraint(s)) =========
-- Requires: brokerage schema, transaction schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= compliance --> brokerage (3 constraint(s)) =========
-- Requires: compliance schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);

-- ========= compliance --> finance (4 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> investment (10 constraint(s)) =========
-- Requires: compliance schema, investment schema
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);

-- ========= compliance --> lease (1 constraint(s)) =========
-- Requires: compliance schema, lease schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= compliance --> marketing (3 constraint(s)) =========
-- Requires: compliance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_listing_syndication_id` FOREIGN KEY (`listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);

-- ========= compliance --> property (27 constraint(s)) =========
-- Requires: compliance schema, property schema
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= compliance --> reference (37 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);

-- ========= compliance --> tenant (6 constraint(s)) =========
-- Requires: compliance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_screening_id` FOREIGN KEY (`screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= development --> compliance (17 constraint(s)) =========
-- Requires: development schema, compliance schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_schedule` ADD CONSTRAINT `fk_development_project_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= development --> finance (26 constraint(s)) =========
-- Requires: development schema, finance schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `real_estate_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `real_estate_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_schedule` ADD CONSTRAINT `fk_development_project_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_schedule` ADD CONSTRAINT `fk_development_project_schedule_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);

-- ========= development --> investment (8 constraint(s)) =========
-- Requires: development schema, investment schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);

-- ========= development --> maintenance (4 constraint(s)) =========
-- Requires: development schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_building_asset_id` FOREIGN KEY (`building_asset_id`) REFERENCES `real_estate_ecm`.`maintenance`.`building_asset`(`building_asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= development --> owner (3 constraint(s)) =========
-- Requires: development schema, owner schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);

-- ========= development --> property (19 constraint(s)) =========
-- Requires: development schema, property schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_schedule` ADD CONSTRAINT `fk_development_project_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);

-- ========= development --> reference (24 constraint(s)) =========
-- Requires: development schema, reference schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= development --> transaction (1 constraint(s)) =========
-- Requires: development schema, transaction schema
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_financing_id` FOREIGN KEY (`financing_id`) REFERENCES `real_estate_ecm`.`transaction`.`financing`(`financing_id`);

-- ========= finance --> compliance (19 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= finance --> development (2 constraint(s)) =========
-- Requires: finance schema, development schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= finance --> investment (11 constraint(s)) =========
-- Requires: finance schema, investment schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= finance --> lease (12 constraint(s)) =========
-- Requires: finance schema, lease schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_rent_schedule_id` FOREIGN KEY (`rent_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`rent_schedule`(`rent_schedule_id`);

-- ========= finance --> maintenance (2 constraint(s)) =========
-- Requires: finance schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `real_estate_ecm`.`maintenance`.`service_contract`(`service_contract_id`);

-- ========= finance --> marketing (3 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);

-- ========= finance --> property (33 constraint(s)) =========
-- Requires: finance schema, property schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= finance --> reference (33 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_amenity_type_id` FOREIGN KEY (`amenity_type_id`) REFERENCES `real_estate_ecm`.`reference`.`amenity_type`(`amenity_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lender` ADD CONSTRAINT `fk_finance_lender_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);

-- ========= finance --> tenant (10 constraint(s)) =========
-- Requires: finance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= finance --> transaction (1 constraint(s)) =========
-- Requires: finance schema, transaction schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= finance --> valuation (6 constraint(s)) =========
-- Requires: finance schema, valuation schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= investment --> brokerage (1 constraint(s)) =========
-- Requires: investment schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);

-- ========= investment --> compliance (22 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= investment --> finance (35 constraint(s)) =========
-- Requires: investment schema, finance schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);

-- ========= investment --> maintenance (2 constraint(s)) =========
-- Requires: investment schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= investment --> property (10 constraint(s)) =========
-- Requires: investment schema, property schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);

-- ========= investment --> reference (60 constraint(s)) =========
-- Requires: investment schema, reference schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= investment --> valuation (9 constraint(s)) =========
-- Requires: investment schema, valuation schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);

-- ========= lease --> brokerage (2 constraint(s)) =========
-- Requires: lease schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= lease --> compliance (19 constraint(s)) =========
-- Requires: lease schema, compliance schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= lease --> development (5 constraint(s)) =========
-- Requires: lease schema, development schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_construction_budget_id` FOREIGN KEY (`construction_budget_id`) REFERENCES `real_estate_ecm`.`development`.`construction_budget`(`construction_budget_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= lease --> finance (54 constraint(s)) =========
-- Requires: lease schema, finance schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= lease --> investment (8 constraint(s)) =========
-- Requires: lease schema, investment schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);

-- ========= lease --> maintenance (1 constraint(s)) =========
-- Requires: lease schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_billable_charge_id` FOREIGN KEY (`billable_charge_id`) REFERENCES `real_estate_ecm`.`maintenance`.`billable_charge`(`billable_charge_id`);

-- ========= lease --> marketing (2 constraint(s)) =========
-- Requires: lease schema, marketing schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);

-- ========= lease --> owner (4 constraint(s)) =========
-- Requires: lease schema, owner schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= lease --> property (24 constraint(s)) =========
-- Requires: lease schema, property schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= lease --> reference (36 constraint(s)) =========
-- Requires: lease schema, reference schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`demised_space` ADD CONSTRAINT `fk_lease_demised_space_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);

-- ========= lease --> tenant (13 constraint(s)) =========
-- Requires: lease schema, tenant schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_sublease_subtenant_profile_tenant_id` FOREIGN KEY (`sublease_subtenant_profile_tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_sublease_tenant_id` FOREIGN KEY (`sublease_tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= lease --> transaction (2 constraint(s)) =========
-- Requires: lease schema, transaction schema
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= lease --> valuation (3 constraint(s)) =========
-- Requires: lease schema, valuation schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= maintenance --> brokerage (6 constraint(s)) =========
-- Requires: maintenance schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);

-- ========= maintenance --> compliance (36 constraint(s)) =========
-- Requires: maintenance schema, compliance schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= maintenance --> development (12 constraint(s)) =========
-- Requires: maintenance schema, development schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `real_estate_ecm`.`development`.`contractor`(`contractor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `real_estate_ecm`.`development`.`contractor`(`contractor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);

-- ========= maintenance --> finance (27 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `real_estate_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `real_estate_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= maintenance --> lease (9 constraint(s)) =========
-- Requires: maintenance schema, lease schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_cam_schedule_id` FOREIGN KEY (`cam_schedule_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_schedule`(`cam_schedule_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);

-- ========= maintenance --> marketing (3 constraint(s)) =========
-- Requires: maintenance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);

-- ========= maintenance --> owner (4 constraint(s)) =========
-- Requires: maintenance schema, owner schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);

-- ========= maintenance --> property (60 constraint(s)) =========
-- Requires: maintenance schema, property schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);

-- ========= maintenance --> reference (19 constraint(s)) =========
-- Requires: maintenance schema, reference schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);

-- ========= maintenance --> tenant (11 constraint(s)) =========
-- Requires: maintenance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);

-- ========= marketing --> brokerage (6 constraint(s)) =========
-- Requires: marketing schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);

-- ========= marketing --> compliance (9 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= marketing --> development (5 constraint(s)) =========
-- Requires: marketing schema, development schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= marketing --> finance (11 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= marketing --> investment (14 constraint(s)) =========
-- Requires: marketing schema, investment schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);

-- ========= marketing --> owner (3 constraint(s)) =========
-- Requires: marketing schema, owner schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_owner_contact_id` FOREIGN KEY (`owner_contact_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_contact`(`owner_contact_id`);

-- ========= marketing --> property (25 constraint(s)) =========
-- Requires: marketing schema, property schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= marketing --> reference (54 constraint(s)) =========
-- Requires: marketing schema, reference schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);

-- ========= owner --> brokerage (8 constraint(s)) =========
-- Requires: owner schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= owner --> compliance (18 constraint(s)) =========
-- Requires: owner schema, compliance schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= owner --> development (7 constraint(s)) =========
-- Requires: owner schema, development schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_construction_budget_id` FOREIGN KEY (`construction_budget_id`) REFERENCES `real_estate_ecm`.`development`.`construction_budget`(`construction_budget_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_draw_request_id` FOREIGN KEY (`draw_request_id`) REFERENCES `real_estate_ecm`.`development`.`draw_request`(`draw_request_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= owner --> finance (31 constraint(s)) =========
-- Requires: owner schema, finance schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_primary_legal_entity_id` FOREIGN KEY (`primary_legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= owner --> investment (22 constraint(s)) =========
-- Requires: owner schema, investment schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_capital_account_id` FOREIGN KEY (`capital_account_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_account`(`capital_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_investment_distribution_id` FOREIGN KEY (`investment_distribution_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_distribution`(`investment_distribution_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_capital_account_id` FOREIGN KEY (`capital_account_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_account`(`capital_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_capital_account_id` FOREIGN KEY (`capital_account_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_account`(`capital_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_investment_distribution_id` FOREIGN KEY (`investment_distribution_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_distribution`(`investment_distribution_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);

-- ========= owner --> maintenance (3 constraint(s)) =========
-- Requires: owner schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= owner --> property (18 constraint(s)) =========
-- Requires: owner schema, property schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= owner --> reference (24 constraint(s)) =========
-- Requires: owner schema, reference schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_contact` ADD CONSTRAINT `fk_owner_owner_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);

-- ========= owner --> transaction (1 constraint(s)) =========
-- Requires: owner schema, transaction schema
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= owner --> valuation (6 constraint(s)) =========
-- Requires: owner schema, valuation schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= property --> brokerage (1 constraint(s)) =========
-- Requires: property schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);

-- ========= property --> compliance (6 constraint(s)) =========
-- Requires: property schema, compliance schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= property --> development (7 constraint(s)) =========
-- Requires: property schema, development schema
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= property --> finance (4 constraint(s)) =========
-- Requires: property schema, finance schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);

-- ========= property --> investment (3 constraint(s)) =========
-- Requires: property schema, investment schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_asset_performance_id` FOREIGN KEY (`asset_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`asset_performance`(`asset_performance_id`);

-- ========= property --> lease (6 constraint(s)) =========
-- Requires: property schema, lease schema
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);

-- ========= property --> owner (1 constraint(s)) =========
-- Requires: property schema, owner schema
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= property --> reference (38 constraint(s)) =========
-- Requires: property schema, reference schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`address` ADD CONSTRAINT `fk_property_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`property`.`address` ADD CONSTRAINT `fk_property_address_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_amenity_type_id` FOREIGN KEY (`amenity_type_id`) REFERENCES `real_estate_ecm`.`reference`.`amenity_type`(`amenity_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);

-- ========= property --> tenant (2 constraint(s)) =========
-- Requires: property schema, tenant schema
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= tenant --> brokerage (15 constraint(s)) =========
-- Requires: tenant schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);

-- ========= tenant --> compliance (5 constraint(s)) =========
-- Requires: tenant schema, compliance schema
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= tenant --> development (4 constraint(s)) =========
-- Requires: tenant schema, development schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= tenant --> investment (1 constraint(s)) =========
-- Requires: tenant schema, investment schema
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);

-- ========= tenant --> lease (14 constraint(s)) =========
-- Requires: tenant schema, lease schema
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_demised_space_id` FOREIGN KEY (`demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`demised_space`(`demised_space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_guaranty_id` FOREIGN KEY (`guaranty_id`) REFERENCES `real_estate_ecm`.`lease`.`guaranty`(`guaranty_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_ti_allowance_id` FOREIGN KEY (`ti_allowance_id`) REFERENCES `real_estate_ecm`.`lease`.`ti_allowance`(`ti_allowance_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= tenant --> marketing (5 constraint(s)) =========
-- Requires: tenant schema, marketing schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= tenant --> owner (5 constraint(s)) =========
-- Requires: tenant schema, owner schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_owner_ownership_interest_id` FOREIGN KEY (`owner_ownership_interest_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_ownership_interest`(`owner_ownership_interest_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);

-- ========= tenant --> property (22 constraint(s)) =========
-- Requires: tenant schema, property schema
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= tenant --> reference (35 constraint(s)) =========
-- Requires: tenant schema, reference schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= tenant --> transaction (2 constraint(s)) =========
-- Requires: tenant schema, transaction schema
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= tenant --> valuation (6 constraint(s)) =========
-- Requires: tenant schema, valuation schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_cma_id` FOREIGN KEY (`cma_id`) REFERENCES `real_estate_ecm`.`valuation`.`cma`(`cma_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_cma_id` FOREIGN KEY (`cma_id`) REFERENCES `real_estate_ecm`.`valuation`.`cma`(`cma_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`occupancy` ADD CONSTRAINT `fk_tenant_occupancy_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= transaction --> brokerage (7 constraint(s)) =========
-- Requires: transaction schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_showing_id` FOREIGN KEY (`showing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`showing`(`showing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);

-- ========= transaction --> compliance (44 constraint(s)) =========
-- Requires: transaction schema, compliance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_fair_housing_record_id` FOREIGN KEY (`fair_housing_record_id`) REFERENCES `real_estate_ecm`.`compliance`.`fair_housing_record`(`fair_housing_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_fair_housing_record_id` FOREIGN KEY (`fair_housing_record_id`) REFERENCES `real_estate_ecm`.`compliance`.`fair_housing_record`(`fair_housing_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);

-- ========= transaction --> development (12 constraint(s)) =========
-- Requires: transaction schema, development schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_construction_budget_id` FOREIGN KEY (`construction_budget_id`) REFERENCES `real_estate_ecm`.`development`.`construction_budget`(`construction_budget_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `real_estate_ecm`.`development`.`inspection_event`(`inspection_event_id`);

-- ========= transaction --> finance (21 constraint(s)) =========
-- Requires: transaction schema, finance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `real_estate_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);

-- ========= transaction --> investment (28 constraint(s)) =========
-- Requires: transaction schema, investment schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);

-- ========= transaction --> lease (6 constraint(s)) =========
-- Requires: transaction schema, lease schema
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_guaranty_id` FOREIGN KEY (`guaranty_id`) REFERENCES `real_estate_ecm`.`lease`.`guaranty`(`guaranty_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `real_estate_ecm`.`lease`.`clause`(`clause_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_sublease_id` FOREIGN KEY (`sublease_id`) REFERENCES `real_estate_ecm`.`lease`.`sublease`(`sublease_id`);

-- ========= transaction --> maintenance (14 constraint(s)) =========
-- Requires: transaction schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_building_asset_id` FOREIGN KEY (`building_asset_id`) REFERENCES `real_estate_ecm`.`maintenance`.`building_asset`(`building_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_building_asset_id` FOREIGN KEY (`building_asset_id`) REFERENCES `real_estate_ecm`.`maintenance`.`building_asset`(`building_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `real_estate_ecm`.`maintenance`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= transaction --> marketing (7 constraint(s)) =========
-- Requires: transaction schema, marketing schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_listing_syndication_id` FOREIGN KEY (`listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_event_registration_id` FOREIGN KEY (`event_registration_id`) REFERENCES `real_estate_ecm`.`marketing`.`event_registration`(`event_registration_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_listing_syndication_id` FOREIGN KEY (`listing_syndication_id`) REFERENCES `real_estate_ecm`.`marketing`.`listing_syndication`(`listing_syndication_id`);

-- ========= transaction --> owner (12 constraint(s)) =========
-- Requires: transaction schema, owner schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= transaction --> property (35 constraint(s)) =========
-- Requires: transaction schema, property schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= transaction --> reference (27 constraint(s)) =========
-- Requires: transaction schema, reference schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= transaction --> tenant (2 constraint(s)) =========
-- Requires: transaction schema, tenant schema
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= transaction --> valuation (17 constraint(s)) =========
-- Requires: transaction schema, valuation schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_dcf_model_id` FOREIGN KEY (`dcf_model_id`) REFERENCES `real_estate_ecm`.`valuation`.`dcf_model`(`dcf_model_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_cma_id` FOREIGN KEY (`cma_id`) REFERENCES `real_estate_ecm`.`valuation`.`cma`(`cma_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= valuation --> brokerage (15 constraint(s)) =========
-- Requires: valuation schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`broker`(`broker_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= valuation --> compliance (24 constraint(s)) =========
-- Requires: valuation schema, compliance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_remediation_action_id` FOREIGN KEY (`remediation_action_id`) REFERENCES `real_estate_ecm`.`compliance`.`remediation_action`(`remediation_action_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= valuation --> development (5 constraint(s)) =========
-- Requires: valuation schema, development schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= valuation --> finance (28 constraint(s)) =========
-- Requires: valuation schema, finance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `real_estate_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `real_estate_ecm`.`finance`.`ledger`(`ledger_id`);

-- ========= valuation --> investment (2 constraint(s)) =========
-- Requires: valuation schema, investment schema
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= valuation --> lease (1 constraint(s)) =========
-- Requires: valuation schema, lease schema
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= valuation --> maintenance (2 constraint(s)) =========
-- Requires: valuation schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= valuation --> marketing (12 constraint(s)) =========
-- Requires: valuation schema, marketing schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);

-- ========= valuation --> property (31 constraint(s)) =========
-- Requires: valuation schema, property schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_property_ownership_interest_id` FOREIGN KEY (`property_ownership_interest_id`) REFERENCES `real_estate_ecm`.`property`.`property_ownership_interest`(`property_ownership_interest_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_occupancy_record_id` FOREIGN KEY (`occupancy_record_id`) REFERENCES `real_estate_ecm`.`property`.`occupancy_record`(`occupancy_record_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= valuation --> reference (97 constraint(s)) =========
-- Requires: valuation schema, reference schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);

-- ========= valuation --> tenant (1 constraint(s)) =========
-- Requires: valuation schema, tenant schema
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_occupancy_id` FOREIGN KEY (`occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`occupancy`(`occupancy_id`);

