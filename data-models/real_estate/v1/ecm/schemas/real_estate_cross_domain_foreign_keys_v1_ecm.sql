-- Cross-Domain Foreign Keys for Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:47:00
-- Total cross-domain FK constraints: 2040
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: brokerage, compliance, development, finance, insurance, investment, lease, maintenance, marketing, owner, property, reference, tenant, transaction, valuation, workforce

-- ========= brokerage --> compliance (12 constraint(s)) =========
-- Requires: brokerage schema, compliance schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_license` ADD CONSTRAINT `fk_brokerage_broker_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_program_enrollment` ADD CONSTRAINT `fk_brokerage_broker_program_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`deal_compliance` ADD CONSTRAINT `fk_brokerage_deal_compliance_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_disclosure` ADD CONSTRAINT `fk_brokerage_listing_disclosure_requirement_id` FOREIGN KEY (`requirement_id`) REFERENCES `real_estate_ecm`.`compliance`.`requirement`(`requirement_id`);

-- ========= brokerage --> development (6 constraint(s)) =========
-- Requires: brokerage schema, development schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_environmental_review_id` FOREIGN KEY (`environmental_review_id`) REFERENCES `real_estate_ecm`.`development`.`environmental_review`(`environmental_review_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_proforma_id` FOREIGN KEY (`proforma_id`) REFERENCES `real_estate_ecm`.`development`.`proforma`(`proforma_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_environmental_review_id` FOREIGN KEY (`environmental_review_id`) REFERENCES `real_estate_ecm`.`development`.`environmental_review`(`environmental_review_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_proforma_id` FOREIGN KEY (`proforma_id`) REFERENCES `real_estate_ecm`.`development`.`proforma`(`proforma_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= brokerage --> finance (13 constraint(s)) =========
-- Requires: brokerage schema, finance schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= brokerage --> lease (4 constraint(s)) =========
-- Requires: brokerage schema, lease schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= brokerage --> marketing (11 constraint(s)) =========
-- Requires: brokerage schema, marketing schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ADD CONSTRAINT `fk_brokerage_mls_syndication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`mls_syndication` ADD CONSTRAINT `fk_brokerage_mls_syndication_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `real_estate_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= brokerage --> owner (1 constraint(s)) =========
-- Requires: brokerage schema, owner schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= brokerage --> property (19 constraint(s)) =========
-- Requires: brokerage schema, property schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= brokerage --> reference (46 constraint(s)) =========
-- Requires: brokerage schema, reference schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_prospect` ADD CONSTRAINT `fk_brokerage_brokerage_prospect_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`co_broker_agreement` ADD CONSTRAINT `fk_brokerage_co_broker_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ADD CONSTRAINT `fk_brokerage_brokerage_broker_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`buyer_representation` ADD CONSTRAINT `fk_brokerage_buyer_representation_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_market_coverage` ADD CONSTRAINT `fk_brokerage_broker_market_coverage_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);

-- ========= brokerage --> transaction (7 constraint(s)) =========
-- Requires: brokerage schema, transaction schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing_agreement` ADD CONSTRAINT `fk_brokerage_listing_agreement_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`negotiation_instrument` ADD CONSTRAINT `fk_brokerage_negotiation_instrument_deal_party_id` FOREIGN KEY (`deal_party_id`) REFERENCES `real_estate_ecm`.`transaction`.`deal_party`(`deal_party_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission` ADD CONSTRAINT `fk_brokerage_commission_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`commission_split` ADD CONSTRAINT `fk_brokerage_commission_split_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`referral` ADD CONSTRAINT `fk_brokerage_referral_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal_document` ADD CONSTRAINT `fk_brokerage_brokerage_deal_document_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`broker_commission` ADD CONSTRAINT `fk_brokerage_broker_commission_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= brokerage --> workforce (5 constraint(s)) =========
-- Requires: brokerage schema, workforce schema
ALTER TABLE `real_estate_ecm`.`brokerage`.`listing` ADD CONSTRAINT `fk_brokerage_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_deal` ADD CONSTRAINT `fk_brokerage_brokerage_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`showing` ADD CONSTRAINT `fk_brokerage_showing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ADD CONSTRAINT `fk_brokerage_brokerage_broker_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`brokerage`.`brokerage_broker` ADD CONSTRAINT `fk_brokerage_brokerage_broker_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> brokerage (6 constraint(s)) =========
-- Requires: compliance schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_listing_agreement_id` FOREIGN KEY (`listing_agreement_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing_agreement`(`listing_agreement_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_showing_id` FOREIGN KEY (`showing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`showing`(`showing_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_training` ADD CONSTRAINT `fk_compliance_compliance_training_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);

-- ========= compliance --> finance (5 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> insurance (1 constraint(s)) =========
-- Requires: compliance schema, insurance schema
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);

-- ========= compliance --> investment (15 constraint(s)) =========
-- Requires: compliance schema, investment schema
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);

-- ========= compliance --> lease (1 constraint(s)) =========
-- Requires: compliance schema, lease schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= compliance --> marketing (4 constraint(s)) =========
-- Requires: compliance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `real_estate_ecm`.`marketing`.`ad_creative`(`ad_creative_id`);

-- ========= compliance --> property (10 constraint(s)) =========
-- Requires: compliance schema, property schema
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= compliance --> reference (25 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`requirement` ADD CONSTRAINT `fk_compliance_requirement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`green_certification` ADD CONSTRAINT `fk_compliance_green_certification_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_training` ADD CONSTRAINT `fk_compliance_compliance_training_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);

-- ========= compliance --> tenant (6 constraint(s)) =========
-- Requires: compliance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_notice_id` FOREIGN KEY (`notice_id`) REFERENCES `real_estate_ecm`.`tenant`.`notice`(`notice_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_screening_id` FOREIGN KEY (`screening_id`) REFERENCES `real_estate_ecm`.`tenant`.`screening`(`screening_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= compliance --> workforce (14 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`osha_incident` ADD CONSTRAINT `fk_compliance_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`fair_housing_record` ADD CONSTRAINT `fk_compliance_fair_housing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`esg_metric` ADD CONSTRAINT `fk_compliance_esg_metric_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_training` ADD CONSTRAINT `fk_compliance_compliance_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`compliance_training` ADD CONSTRAINT `fk_compliance_compliance_training_workforce_training_id` FOREIGN KEY (`workforce_training_id`) REFERENCES `real_estate_ecm`.`workforce`.`workforce_training`(`workforce_training_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= development --> brokerage (1 constraint(s)) =========
-- Requires: development schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`development`.`project_broker_engagement` ADD CONSTRAINT `fk_development_project_broker_engagement_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);

-- ========= development --> compliance (21 constraint(s)) =========
-- Requires: development schema, compliance schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_procore_permit_id` FOREIGN KEY (`procore_permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`rfi` ADD CONSTRAINT `fk_development_rfi_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`submittal` ADD CONSTRAINT `fk_development_submittal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);

-- ========= development --> finance (17 constraint(s)) =========
-- Requires: development schema, finance schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `real_estate_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= development --> investment (13 constraint(s)) =========
-- Requires: development schema, investment schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_waterfall_id` FOREIGN KEY (`waterfall_id`) REFERENCES `real_estate_ecm`.`investment`.`waterfall`(`waterfall_id`);

-- ========= development --> lease (2 constraint(s)) =========
-- Requires: development schema, lease schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_ground_lease_id` FOREIGN KEY (`ground_lease_id`) REFERENCES `real_estate_ecm`.`lease`.`ground_lease`(`ground_lease_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_ground_lease_id` FOREIGN KEY (`ground_lease_id`) REFERENCES `real_estate_ecm`.`lease`.`ground_lease`(`ground_lease_id`);

-- ========= development --> marketing (4 constraint(s)) =========
-- Requires: development schema, marketing schema
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_sap_vendor_id` FOREIGN KEY (`sap_vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_yardi_vendor_id` FOREIGN KEY (`yardi_vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);

-- ========= development --> owner (2 constraint(s)) =========
-- Requires: development schema, owner schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);

-- ========= development --> property (12 constraint(s)) =========
-- Requires: development schema, property schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);

-- ========= development --> reference (33 constraint(s)) =========
-- Requires: development schema, reference schema
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`dev_project` ADD CONSTRAINT `fk_development_dev_project_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`development`.`entitlement` ADD CONSTRAINT `fk_development_entitlement_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_permit` ADD CONSTRAINT `fk_development_construction_permit_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`development`.`contractor` ADD CONSTRAINT `fk_development_contractor_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`submittal` ADD CONSTRAINT `fk_development_submittal_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`development`.`design_document` ADD CONSTRAINT `fk_development_design_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`development`.`environmental_review` ADD CONSTRAINT `fk_development_environmental_review_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);

-- ========= development --> transaction (1 constraint(s)) =========
-- Requires: development schema, transaction schema
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_financing_id` FOREIGN KEY (`financing_id`) REFERENCES `real_estate_ecm`.`transaction`.`financing`(`financing_id`);

-- ========= development --> valuation (2 constraint(s)) =========
-- Requires: development schema, valuation schema
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_dcf_model_id` FOREIGN KEY (`dcf_model_id`) REFERENCES `real_estate_ecm`.`valuation`.`dcf_model`(`dcf_model_id`);

-- ========= development --> workforce (9 constraint(s)) =========
-- Requires: development schema, workforce schema
ALTER TABLE `real_estate_ecm`.`development`.`construction_contract` ADD CONSTRAINT `fk_development_construction_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`construction_budget` ADD CONSTRAINT `fk_development_construction_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`change_order` ADD CONSTRAINT `fk_development_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`draw_request` ADD CONSTRAINT `fk_development_draw_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`submittal` ADD CONSTRAINT `fk_development_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`inspection_event` ADD CONSTRAINT `fk_development_inspection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_schedule` ADD CONSTRAINT `fk_development_project_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`proforma` ADD CONSTRAINT `fk_development_proforma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`development`.`project_assignment` ADD CONSTRAINT `fk_development_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> compliance (14 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= finance --> development (3 constraint(s)) =========
-- Requires: finance schema, development schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= finance --> insurance (2 constraint(s)) =========
-- Requires: finance schema, insurance schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);

-- ========= finance --> investment (18 constraint(s)) =========
-- Requires: finance schema, investment schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`segment` ADD CONSTRAINT `fk_finance_segment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= finance --> lease (6 constraint(s)) =========
-- Requires: finance schema, lease schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= finance --> maintenance (2 constraint(s)) =========
-- Requires: finance schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `real_estate_ecm`.`maintenance`.`service_contract`(`service_contract_id`);

-- ========= finance --> marketing (5 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lockbox_batch` ADD CONSTRAINT `fk_finance_lockbox_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);

-- ========= finance --> property (41 constraint(s)) =========
-- Requires: finance schema, property schema
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lockbox_batch` ADD CONSTRAINT `fk_finance_lockbox_batch_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`segment` ADD CONSTRAINT `fk_finance_segment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= finance --> reference (39 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);

-- ========= finance --> tenant (8 constraint(s)) =========
-- Requires: finance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_application_id` FOREIGN KEY (`application_id`) REFERENCES `real_estate_ecm`.`tenant`.`application`(`application_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_household_id` FOREIGN KEY (`household_id`) REFERENCES `real_estate_ecm`.`tenant`.`household`(`household_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= finance --> transaction (5 constraint(s)) =========
-- Requires: finance schema, transaction schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_exchange_1031_id` FOREIGN KEY (`exchange_1031_id`) REFERENCES `real_estate_ecm`.`transaction`.`exchange_1031`(`exchange_1031_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_exchange_1031_id` FOREIGN KEY (`exchange_1031_id`) REFERENCES `real_estate_ecm`.`transaction`.`exchange_1031`(`exchange_1031_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= finance --> valuation (3 constraint(s)) =========
-- Requires: finance schema, valuation schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_tax_appeal_id` FOREIGN KEY (`tax_appeal_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_appeal`(`tax_appeal_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= finance --> workforce (26 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `real_estate_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`noi_statement` ADD CONSTRAINT `fk_finance_noi_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_buyer_employee_id` FOREIGN KEY (`buyer_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_cancelled_by_user_employee_id` FOREIGN KEY (`cancelled_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_executed_by_user_employee_id` FOREIGN KEY (`executed_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lockbox_batch` ADD CONSTRAINT `fk_finance_lockbox_batch_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lockbox_batch` ADD CONSTRAINT `fk_finance_lockbox_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`lockbox_batch` ADD CONSTRAINT `fk_finance_lockbox_batch_voided_by_user_employee_id` FOREIGN KEY (`voided_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`netting_run` ADD CONSTRAINT `fk_finance_netting_run_executed_by_user_employee_id` FOREIGN KEY (`executed_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ADD CONSTRAINT `fk_finance_reporting_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`finance`.`reporting_period` ADD CONSTRAINT `fk_finance_reporting_period_locked_by_user_employee_id` FOREIGN KEY (`locked_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= insurance --> brokerage (6 constraint(s)) =========
-- Requires: insurance schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_showing_id` FOREIGN KEY (`showing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`showing`(`showing_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);

-- ========= insurance --> compliance (7 constraint(s)) =========
-- Requires: insurance schema, compliance schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= insurance --> development (3 constraint(s)) =========
-- Requires: insurance schema, development schema
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `real_estate_ecm`.`development`.`contractor`(`contractor_id`);

-- ========= insurance --> finance (24 constraint(s)) =========
-- Requires: insurance schema, finance schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_ar_receipt_id` FOREIGN KEY (`ar_receipt_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `real_estate_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_ar_receipt_id` FOREIGN KEY (`ar_receipt_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_receipt`(`ar_receipt_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= insurance --> investment (1 constraint(s)) =========
-- Requires: insurance schema, investment schema
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);

-- ========= insurance --> lease (4 constraint(s)) =========
-- Requires: insurance schema, lease schema
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_lease_demised_space_id` FOREIGN KEY (`lease_demised_space_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_demised_space`(`lease_demised_space_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `real_estate_ecm`.`lease`.`clause`(`clause_id`);

-- ========= insurance --> maintenance (1 constraint(s)) =========
-- Requires: insurance schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= insurance --> marketing (2 constraint(s)) =========
-- Requires: insurance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`insurance`.`adjuster` ADD CONSTRAINT `fk_insurance_adjuster_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `real_estate_ecm`.`marketing`.`event`(`event_id`);

-- ========= insurance --> owner (9 constraint(s)) =========
-- Requires: insurance schema, owner schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_ownership_structure_id` FOREIGN KEY (`ownership_structure_id`) REFERENCES `real_estate_ecm`.`owner`.`ownership_structure`(`ownership_structure_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= insurance --> property (30 constraint(s)) =========
-- Requires: insurance schema, property schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);

-- ========= insurance --> reference (44 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy` ADD CONSTRAINT `fk_insurance_policy_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium` ADD CONSTRAINT `fk_insurance_premium_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_payment` ADD CONSTRAINT `fk_insurance_claim_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`loss_run` ADD CONSTRAINT `fk_insurance_loss_run_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurer` ADD CONSTRAINT `fk_insurance_insurer_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_broker` ADD CONSTRAINT `fk_insurance_insurance_broker_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim_reserve` ADD CONSTRAINT `fk_insurance_claim_reserve_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`captive_account` ADD CONSTRAINT `fk_insurance_captive_account_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`excess_layer` ADD CONSTRAINT `fk_insurance_excess_layer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_document` ADD CONSTRAINT `fk_insurance_policy_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);

-- ========= insurance --> tenant (2 constraint(s)) =========
-- Requires: insurance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `real_estate_ecm`.`tenant`.`document`(`document_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= insurance --> transaction (1 constraint(s)) =========
-- Requires: insurance schema, transaction schema
ALTER TABLE `real_estate_ecm`.`insurance`.`policy_assignment` ADD CONSTRAINT `fk_insurance_policy_assignment_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= insurance --> valuation (9 constraint(s)) =========
-- Requires: insurance schema, valuation schema
ALTER TABLE `real_estate_ecm`.`insurance`.`coverage` ADD CONSTRAINT `fk_insurance_coverage_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insured_property` ADD CONSTRAINT `fk_insurance_insured_property_cost_approach_id` FOREIGN KEY (`cost_approach_id`) REFERENCES `real_estate_ecm`.`valuation`.`cost_approach`(`cost_approach_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`renewal` ADD CONSTRAINT `fk_insurance_renewal_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`premium_allocation` ADD CONSTRAINT `fk_insurance_premium_allocation_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);

-- ========= insurance --> workforce (8 constraint(s)) =========
-- Requires: insurance schema, workforce schema
ALTER TABLE `real_estate_ecm`.`insurance`.`statement_of_values` ADD CONSTRAINT `fk_insurance_statement_of_values_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`claim` ADD CONSTRAINT `fk_insurance_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`risk_assessment` ADD CONSTRAINT `fk_insurance_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`certificate_of_insurance` ADD CONSTRAINT `fk_insurance_certificate_of_insurance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`endorsement` ADD CONSTRAINT `fk_insurance_endorsement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`liability_event` ADD CONSTRAINT `fk_insurance_liability_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`insurance_program` ADD CONSTRAINT `fk_insurance_insurance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`insurance`.`subrogation` ADD CONSTRAINT `fk_insurance_subrogation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= investment --> brokerage (2 constraint(s)) =========
-- Requires: investment schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= investment --> compliance (26 constraint(s)) =========
-- Requires: investment schema, compliance schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= investment --> development (1 constraint(s)) =========
-- Requires: investment schema, development schema
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_proforma_id` FOREIGN KEY (`proforma_id`) REFERENCES `real_estate_ecm`.`development`.`proforma`(`proforma_id`);

-- ========= investment --> finance (31 constraint(s)) =========
-- Requires: investment schema, finance schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_tax_provision_id` FOREIGN KEY (`tax_provision_id`) REFERENCES `real_estate_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_custodian_entity_id` FOREIGN KEY (`custodian_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_fund_administrator_entity_id` FOREIGN KEY (`fund_administrator_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_legal_counsel_entity_id` FOREIGN KEY (`legal_counsel_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_sponsor_entity_id` FOREIGN KEY (`sponsor_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= investment --> insurance (6 constraint(s)) =========
-- Requires: investment schema, insurance schema
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `real_estate_ecm`.`insurance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `real_estate_ecm`.`insurance`.`risk_assessment`(`risk_assessment_id`);

-- ========= investment --> maintenance (1 constraint(s)) =========
-- Requires: investment schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= investment --> property (8 constraint(s)) =========
-- Requires: investment schema, property schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= investment --> reference (45 constraint(s)) =========
-- Requires: investment schema, reference schema
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund` ADD CONSTRAINT `fk_investment_fund_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`vehicle` ADD CONSTRAINT `fk_investment_vehicle_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`commitment` ADD CONSTRAINT `fk_investment_commitment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`tax_allocation` ADD CONSTRAINT `fk_investment_tax_allocation_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`offering` ADD CONSTRAINT `fk_investment_offering_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= investment --> valuation (14 constraint(s)) =========
-- Requires: investment schema, valuation schema
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_dcf_model_id` FOREIGN KEY (`dcf_model_id`) REFERENCES `real_estate_ecm`.`valuation`.`dcf_model`(`dcf_model_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_dcf_model_id` FOREIGN KEY (`dcf_model_id`) REFERENCES `real_estate_ecm`.`valuation`.`dcf_model`(`dcf_model_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_cap_rate_benchmark_id` FOREIGN KEY (`cap_rate_benchmark_id`) REFERENCES `real_estate_ecm`.`valuation`.`cap_rate_benchmark`(`cap_rate_benchmark_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_dcf_model_id` FOREIGN KEY (`dcf_model_id`) REFERENCES `real_estate_ecm`.`valuation`.`dcf_model`(`dcf_model_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_account` ADD CONSTRAINT `fk_investment_capital_account_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);

-- ========= investment --> workforce (12 constraint(s)) =========
-- Requires: investment schema, workforce schema
ALTER TABLE `real_estate_ecm`.`investment`.`investor` ADD CONSTRAINT `fk_investment_investor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`capital_call` ADD CONSTRAINT `fk_investment_capital_call_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_distribution` ADD CONSTRAINT `fk_investment_investment_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`portfolio_asset` ADD CONSTRAINT `fk_investment_portfolio_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fund_performance` ADD CONSTRAINT `fk_investment_fund_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`asset_performance` ADD CONSTRAINT `fk_investment_asset_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_facility` ADD CONSTRAINT `fk_investment_debt_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`debt_covenant` ADD CONSTRAINT `fk_investment_debt_covenant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`investment_deal` ADD CONSTRAINT `fk_investment_investment_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`ic_memo` ADD CONSTRAINT `fk_investment_ic_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`waterfall` ADD CONSTRAINT `fk_investment_waterfall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`investment`.`fee_structure` ADD CONSTRAINT `fk_investment_fee_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= lease --> brokerage (5 constraint(s)) =========
-- Requires: lease schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_representation` ADD CONSTRAINT `fk_lease_lease_representation_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_representation` ADD CONSTRAINT `fk_lease_lease_representation_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);

-- ========= lease --> compliance (21 constraint(s)) =========
-- Requires: lease schema, compliance schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`clause` ADD CONSTRAINT `fk_lease_clause_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`regulatory_applicability` ADD CONSTRAINT `fk_lease_regulatory_applicability_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`enrollment` ADD CONSTRAINT `fk_lease_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= lease --> development (3 constraint(s)) =========
-- Requires: lease schema, development schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`underwriting_input` ADD CONSTRAINT `fk_lease_underwriting_input_proforma_id` FOREIGN KEY (`proforma_id`) REFERENCES `real_estate_ecm`.`development`.`proforma`(`proforma_id`);

-- ========= lease --> finance (39 constraint(s)) =========
-- Requires: lease schema, finance schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `real_estate_ecm`.`finance`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= lease --> insurance (6 constraint(s)) =========
-- Requires: lease schema, insurance schema
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_premium_id` FOREIGN KEY (`premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_premium_id` FOREIGN KEY (`premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`coverage_requirement` ADD CONSTRAINT `fk_lease_coverage_requirement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);

-- ========= lease --> investment (7 constraint(s)) =========
-- Requires: lease schema, investment schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_fund_performance_id` FOREIGN KEY (`fund_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`collateral_assignment` ADD CONSTRAINT `fk_lease_collateral_assignment_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);

-- ========= lease --> maintenance (6 constraint(s)) =========
-- Requires: lease schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `real_estate_ecm`.`maintenance`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_billable_charge_id` FOREIGN KEY (`billable_charge_id`) REFERENCES `real_estate_ecm`.`maintenance`.`billable_charge`(`billable_charge_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`meter_allocation` ADD CONSTRAINT `fk_lease_meter_allocation_energy_meter_id` FOREIGN KEY (`energy_meter_id`) REFERENCES `real_estate_ecm`.`maintenance`.`energy_meter`(`energy_meter_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_charge_allocation` ADD CONSTRAINT `fk_lease_cam_charge_allocation_billable_charge_id` FOREIGN KEY (`billable_charge_id`) REFERENCES `real_estate_ecm`.`maintenance`.`billable_charge`(`billable_charge_id`);

-- ========= lease --> marketing (2 constraint(s)) =========
-- Requires: lease schema, marketing schema
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);

-- ========= lease --> owner (6 constraint(s)) =========
-- Requires: lease schema, owner schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= lease --> property (32 constraint(s)) =========
-- Requires: lease schema, property schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_pool` ADD CONSTRAINT `fk_lease_cam_pool_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= lease --> reference (34 constraint(s)) =========
-- Requires: lease schema, reference schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`rent_schedule` ADD CONSTRAINT `fk_lease_rent_schedule_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`lease_demised_space` ADD CONSTRAINT `fk_lease_lease_demised_space_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`disclosure` ADD CONSTRAINT `fk_lease_disclosure_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);

-- ========= lease --> tenant (17 constraint(s)) =========
-- Requires: lease schema, tenant schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ti_allowance` ADD CONSTRAINT `fk_lease_ti_allowance_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`payment` ADD CONSTRAINT `fk_lease_payment_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`security_deposit` ADD CONSTRAINT `fk_lease_security_deposit_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`percentage_rent` ADD CONSTRAINT `fk_lease_percentage_rent_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_sublease_subtenant_profile_tenant_id` FOREIGN KEY (`sublease_subtenant_profile_tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`sublease` ADD CONSTRAINT `fk_lease_sublease_sublease_tenant_id` FOREIGN KEY (`sublease_tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`ground_lease` ADD CONSTRAINT `fk_lease_ground_lease_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `real_estate_ecm`.`tenant`.`guarantor`(`guarantor_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`guaranty` ADD CONSTRAINT `fk_lease_guaranty_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= lease --> transaction (3 constraint(s)) =========
-- Requires: lease schema, transaction schema
ALTER TABLE `real_estate_ecm`.`lease`.`termination` ADD CONSTRAINT `fk_lease_termination_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`snda_agreement` ADD CONSTRAINT `fk_lease_snda_agreement_financing_id` FOREIGN KEY (`financing_id`) REFERENCES `real_estate_ecm`.`transaction`.`financing`(`financing_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`accounting_entry` ADD CONSTRAINT `fk_lease_accounting_entry_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= lease --> valuation (3 constraint(s)) =========
-- Requires: lease schema, valuation schema
ALTER TABLE `real_estate_ecm`.`lease`.`renewal_option` ADD CONSTRAINT `fk_lease_renewal_option_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_schedule` ADD CONSTRAINT `fk_lease_cam_schedule_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`cam_estimate` ADD CONSTRAINT `fk_lease_cam_estimate_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= lease --> workforce (3 constraint(s)) =========
-- Requires: lease schema, workforce schema
ALTER TABLE `real_estate_ecm`.`lease`.`lease_agreement` ADD CONSTRAINT `fk_lease_lease_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`loi` ADD CONSTRAINT `fk_lease_loi_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`lease`.`amendment` ADD CONSTRAINT `fk_lease_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= maintenance --> brokerage (4 constraint(s)) =========
-- Requires: maintenance schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= maintenance --> compliance (17 constraint(s)) =========
-- Requires: maintenance schema, compliance schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `real_estate_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= maintenance --> development (15 constraint(s)) =========
-- Requires: maintenance schema, development schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `real_estate_ecm`.`development`.`contractor`(`contractor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_design_document_id` FOREIGN KEY (`design_document_id`) REFERENCES `real_estate_ecm`.`development`.`design_document`(`design_document_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `real_estate_ecm`.`development`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `real_estate_ecm`.`development`.`contractor`(`contractor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_environmental_review_id` FOREIGN KEY (`environmental_review_id`) REFERENCES `real_estate_ecm`.`development`.`environmental_review`(`environmental_review_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_design_document_id` FOREIGN KEY (`design_document_id`) REFERENCES `real_estate_ecm`.`development`.`design_document`(`design_document_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);

-- ========= maintenance --> finance (25 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `real_estate_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`parts_inventory` ADD CONSTRAINT `fk_maintenance_parts_inventory_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`parts_inventory` ADD CONSTRAINT `fk_maintenance_parts_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `real_estate_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_execution` ADD CONSTRAINT `fk_maintenance_pm_execution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_execution` ADD CONSTRAINT `fk_maintenance_pm_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= maintenance --> insurance (4 constraint(s)) =========
-- Requires: maintenance schema, insurance schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `real_estate_ecm`.`insurance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`asset_coverage_schedule` ADD CONSTRAINT `fk_maintenance_asset_coverage_schedule_coverage_id` FOREIGN KEY (`coverage_id`) REFERENCES `real_estate_ecm`.`insurance`.`coverage`(`coverage_id`);

-- ========= maintenance --> lease (3 constraint(s)) =========
-- Requires: maintenance schema, lease schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_cam_pool_id` FOREIGN KEY (`cam_pool_id`) REFERENCES `real_estate_ecm`.`lease`.`cam_pool`(`cam_pool_id`);

-- ========= maintenance --> marketing (4 constraint(s)) =========
-- Requires: maintenance schema, marketing schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `real_estate_ecm`.`marketing`.`vendor`(`vendor_id`);

-- ========= maintenance --> owner (3 constraint(s)) =========
-- Requires: maintenance schema, owner schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);

-- ========= maintenance --> property (71 constraint(s)) =========
-- Requires: maintenance schema, property schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`building_asset` ADD CONSTRAINT `fk_maintenance_building_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_contract` ADD CONSTRAINT `fk_maintenance_service_contract_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`parts_inventory` ADD CONSTRAINT `fk_maintenance_parts_inventory_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_execution` ADD CONSTRAINT `fk_maintenance_pm_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_amenity_id` FOREIGN KEY (`amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_suite_unit_id` FOREIGN KEY (`suite_unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`energy_meter` ADD CONSTRAINT `fk_maintenance_energy_meter_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= maintenance --> tenant (7 constraint(s)) =========
-- Requires: maintenance schema, tenant schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_tenant_contact_id` FOREIGN KEY (`tenant_contact_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_contact`(`tenant_contact_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);

-- ========= maintenance --> workforce (10 constraint(s)) =========
-- Requires: maintenance schema, workforce schema
ALTER TABLE `real_estate_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`service_request` ADD CONSTRAINT `fk_maintenance_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`vendor_dispatch` ADD CONSTRAINT `fk_maintenance_vendor_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`ops_inspection` ADD CONSTRAINT `fk_maintenance_ops_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`capex_project` ADD CONSTRAINT `fk_maintenance_capex_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`sla_policy` ADD CONSTRAINT `fk_maintenance_sla_policy_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`billable_charge` ADD CONSTRAINT `fk_maintenance_billable_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`safety_incident` ADD CONSTRAINT `fk_maintenance_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`maintenance`.`pm_execution` ADD CONSTRAINT `fk_maintenance_pm_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> brokerage (10 constraint(s)) =========
-- Requires: marketing schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);

-- ========= marketing --> compliance (8 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_green_certification_id` FOREIGN KEY (`green_certification_id`) REFERENCES `real_estate_ecm`.`compliance`.`green_certification`(`green_certification_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= marketing --> development (6 constraint(s)) =========
-- Requires: marketing schema, development schema
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= marketing --> finance (15 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ADD CONSTRAINT `fk_marketing_vendor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= marketing --> insurance (1 constraint(s)) =========
-- Requires: marketing schema, insurance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_certificate_of_insurance_id` FOREIGN KEY (`certificate_of_insurance_id`) REFERENCES `real_estate_ecm`.`insurance`.`certificate_of_insurance`(`certificate_of_insurance_id`);

-- ========= marketing --> investment (18 constraint(s)) =========
-- Requires: marketing schema, investment schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= marketing --> lease (2 constraint(s)) =========
-- Requires: marketing schema, lease schema
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= marketing --> maintenance (1 constraint(s)) =========
-- Requires: marketing schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= marketing --> owner (6 constraint(s)) =========
-- Requires: marketing schema, owner schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= marketing --> property (33 constraint(s)) =========
-- Requires: marketing schema, property schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_unit_inclusion` ADD CONSTRAINT `fk_marketing_campaign_unit_inclusion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);

-- ========= marketing --> reference (57 constraint(s)) =========
-- Requires: marketing schema, reference schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`listing_syndication` ADD CONSTRAINT `fk_marketing_listing_syndication_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`competitor_property` ADD CONSTRAINT `fk_marketing_competitor_property_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_survey` ADD CONSTRAINT `fk_marketing_market_survey_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_spend` ADD CONSTRAINT `fk_marketing_ad_spend_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`seo_keyword` ADD CONSTRAINT `fk_marketing_seo_keyword_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ADD CONSTRAINT `fk_marketing_vendor_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_property` ADD CONSTRAINT `fk_marketing_campaign_property_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);

-- ========= marketing --> transaction (2 constraint(s)) =========
-- Requires: marketing schema, transaction schema
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= marketing --> workforce (24 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead` ADD CONSTRAINT `fk_marketing_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_activity` ADD CONSTRAINT `fk_marketing_lead_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`lead_attribution` ADD CONSTRAINT `fk_marketing_lead_attribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`digital_listing` ADD CONSTRAINT `fk_marketing_digital_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`market_research` ADD CONSTRAINT `fk_marketing_market_research_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`event_registration` ADD CONSTRAINT `fk_marketing_event_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_primary_audience_employee_id` FOREIGN KEY (`primary_audience_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`email_campaign` ADD CONSTRAINT `fk_marketing_email_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`content_calendar` ADD CONSTRAINT `fk_marketing_content_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`vendor` ADD CONSTRAINT `fk_marketing_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`press_release` ADD CONSTRAINT `fk_marketing_press_release_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`marketing`.`campaign_contribution` ADD CONSTRAINT `fk_marketing_campaign_contribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= owner --> brokerage (9 constraint(s)) =========
-- Requires: owner schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_representation` ADD CONSTRAINT `fk_owner_owner_representation_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);

-- ========= owner --> compliance (19 constraint(s)) =========
-- Requires: owner schema, compliance schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`kyc_profile` ADD CONSTRAINT `fk_owner_kyc_profile_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`kyc_profile` ADD CONSTRAINT `fk_owner_kyc_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);

-- ========= owner --> development (6 constraint(s)) =========
-- Requires: owner schema, development schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_draw_request_id` FOREIGN KEY (`draw_request_id`) REFERENCES `real_estate_ecm`.`development`.`draw_request`(`draw_request_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= owner --> finance (13 constraint(s)) =========
-- Requires: owner schema, finance schema
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_lender_id` FOREIGN KEY (`lender_id`) REFERENCES `real_estate_ecm`.`finance`.`lender`(`lender_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_tax_provision_id` FOREIGN KEY (`tax_provision_id`) REFERENCES `real_estate_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_primary_legal_entity_id` FOREIGN KEY (`primary_legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= owner --> insurance (1 constraint(s)) =========
-- Requires: owner schema, insurance schema
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);

-- ========= owner --> investment (15 constraint(s)) =========
-- Requires: owner schema, investment schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_investment_distribution_id` FOREIGN KEY (`investment_distribution_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_distribution`(`investment_distribution_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_waterfall_id` FOREIGN KEY (`waterfall_id`) REFERENCES `real_estate_ecm`.`investment`.`waterfall`(`waterfall_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `real_estate_ecm`.`investment`.`commitment`(`commitment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_tax_allocation_id` FOREIGN KEY (`tax_allocation_id`) REFERENCES `real_estate_ecm`.`investment`.`tax_allocation`(`tax_allocation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `real_estate_ecm`.`investment`.`offering`(`offering_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`subscription` ADD CONSTRAINT `fk_owner_subscription_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);

-- ========= owner --> maintenance (3 constraint(s)) =========
-- Requires: owner schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `real_estate_ecm`.`maintenance`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= owner --> property (11 constraint(s)) =========
-- Requires: owner schema, property schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= owner --> reference (37 constraint(s)) =========
-- Requires: owner schema, reference schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_contact` ADD CONSTRAINT `fk_owner_owner_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_ownership_interest` ADD CONSTRAINT `fk_owner_owner_ownership_interest_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`kyc_profile` ADD CONSTRAINT `fk_owner_kyc_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`kyc_profile` ADD CONSTRAINT `fk_owner_kyc_profile_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`capital_contribution` ADD CONSTRAINT `fk_owner_capital_contribution_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`entity_hierarchy` ADD CONSTRAINT `fk_owner_entity_hierarchy_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`power_of_attorney` ADD CONSTRAINT `fk_owner_power_of_attorney_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);

-- ========= owner --> transaction (1 constraint(s)) =========
-- Requires: owner schema, transaction schema
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

-- ========= owner --> valuation (4 constraint(s)) =========
-- Requires: owner schema, valuation schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_nav_calculation_id` FOREIGN KEY (`nav_calculation_id`) REFERENCES `real_estate_ecm`.`valuation`.`nav_calculation`(`nav_calculation_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_tax_appeal_id` FOREIGN KEY (`tax_appeal_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_appeal`(`tax_appeal_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`tax_record` ADD CONSTRAINT `fk_owner_tax_record_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= owner --> workforce (8 constraint(s)) =========
-- Requires: owner schema, workforce schema
ALTER TABLE `real_estate_ecm`.`owner`.`owner` ADD CONSTRAINT `fk_owner_owner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_structure` ADD CONSTRAINT `fk_owner_ownership_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`beneficial_owner` ADD CONSTRAINT `fk_owner_beneficial_owner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`kyc_profile` ADD CONSTRAINT `fk_owner_kyc_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_agreement` ADD CONSTRAINT `fk_owner_owner_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`owner_distribution` ADD CONSTRAINT `fk_owner_owner_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`ownership_transfer` ADD CONSTRAINT `fk_owner_ownership_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`owner`.`accreditation` ADD CONSTRAINT `fk_owner_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= property --> compliance (8 constraint(s)) =========
-- Requires: property schema, compliance schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `real_estate_ecm`.`compliance`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ADD CONSTRAINT `fk_property_building_compliance_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ADD CONSTRAINT `fk_property_asset_audit_scope_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);

-- ========= property --> development (2 constraint(s)) =========
-- Requires: property schema, development schema
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= property --> finance (3 constraint(s)) =========
-- Requires: property schema, finance schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= property --> insurance (2 constraint(s)) =========
-- Requires: property schema, insurance schema
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ADD CONSTRAINT `fk_property_building_policy_coverage_blanket_group_id` FOREIGN KEY (`blanket_group_id`) REFERENCES `real_estate_ecm`.`insurance`.`blanket_group`(`blanket_group_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ADD CONSTRAINT `fk_property_building_policy_coverage_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);

-- ========= property --> investment (6 constraint(s)) =========
-- Requires: property schema, investment schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_debt_covenant_id` FOREIGN KEY (`debt_covenant_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_covenant`(`debt_covenant_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_asset_performance_id` FOREIGN KEY (`asset_performance_id`) REFERENCES `real_estate_ecm`.`investment`.`asset_performance`(`asset_performance_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ADD CONSTRAINT `fk_property_deal_asset_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);

-- ========= property --> lease (3 constraint(s)) =========
-- Requires: property schema, lease schema
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ADD CONSTRAINT `fk_property_property_demised_space_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ADD CONSTRAINT `fk_property_allocation_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= property --> maintenance (1 constraint(s)) =========
-- Requires: property schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_hvac_zone_id` FOREIGN KEY (`hvac_zone_id`) REFERENCES `real_estate_ecm`.`maintenance`.`hvac_zone`(`hvac_zone_id`);

-- ========= property --> marketing (1 constraint(s)) =========
-- Requires: property schema, marketing schema
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ADD CONSTRAINT `fk_property_space_campaign_inclusion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= property --> owner (1 constraint(s)) =========
-- Requires: property schema, owner schema
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= property --> reference (36 constraint(s)) =========
-- Requires: property schema, reference schema
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`address` ADD CONSTRAINT `fk_property_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`property`.`address` ADD CONSTRAINT `fk_property_address_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_amenity_type_id` FOREIGN KEY (`amenity_type_id`) REFERENCES `real_estate_ecm`.`reference`.`amenity_type`(`amenity_type_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ADD CONSTRAINT `fk_property_common_area_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parking` ADD CONSTRAINT `fk_property_parking_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ADD CONSTRAINT `fk_property_building_certification_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);

-- ========= property --> tenant (1 constraint(s)) =========
-- Requires: property schema, tenant schema
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ADD CONSTRAINT `fk_property_property_occupancy_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant`(`tenant_id`);

-- ========= property --> workforce (1 constraint(s)) =========
-- Requires: property schema, workforce schema
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ADD CONSTRAINT `fk_property_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reference --> insurance (1 constraint(s)) =========
-- Requires: reference schema, insurance schema
ALTER TABLE `real_estate_ecm`.`reference`.`program_property_type_coverage` ADD CONSTRAINT `fk_reference_program_property_type_coverage_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);

-- ========= tenant --> brokerage (12 constraint(s)) =========
-- Requires: tenant schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_negotiation_instrument_id` FOREIGN KEY (`negotiation_instrument_id`) REFERENCES `real_estate_ecm`.`brokerage`.`negotiation_instrument`(`negotiation_instrument_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_negotiation_instrument_id` FOREIGN KEY (`negotiation_instrument_id`) REFERENCES `real_estate_ecm`.`brokerage`.`negotiation_instrument`(`negotiation_instrument_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_negotiation_instrument_id` FOREIGN KEY (`negotiation_instrument_id`) REFERENCES `real_estate_ecm`.`brokerage`.`negotiation_instrument`(`negotiation_instrument_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_brokerage_prospect_id` FOREIGN KEY (`brokerage_prospect_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_prospect`(`brokerage_prospect_id`);

-- ========= tenant --> compliance (1 constraint(s)) =========
-- Requires: tenant schema, compliance schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= tenant --> development (3 constraint(s)) =========
-- Requires: tenant schema, development schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= tenant --> insurance (3 constraint(s)) =========
-- Requires: tenant schema, insurance schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);

-- ========= tenant --> investment (1 constraint(s)) =========
-- Requires: tenant schema, investment schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);

-- ========= tenant --> lease (12 constraint(s)) =========
-- Requires: tenant schema, lease schema
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_loi_id` FOREIGN KEY (`loi_id`) REFERENCES `real_estate_ecm`.`lease`.`loi`(`loi_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_loi_id` FOREIGN KEY (`loi_id`) REFERENCES `real_estate_ecm`.`lease`.`loi`(`loi_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `real_estate_ecm`.`lease`.`amendment`(`amendment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_termination_id` FOREIGN KEY (`termination_id`) REFERENCES `real_estate_ecm`.`lease`.`termination`(`termination_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_renewal_option_id` FOREIGN KEY (`renewal_option_id`) REFERENCES `real_estate_ecm`.`lease`.`renewal_option`(`renewal_option_id`);

-- ========= tenant --> maintenance (1 constraint(s)) =========
-- Requires: tenant schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `real_estate_ecm`.`maintenance`.`service_request`(`service_request_id`);

-- ========= tenant --> marketing (9 constraint(s)) =========
-- Requires: tenant schema, marketing schema
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ADD CONSTRAINT `fk_tenant_household_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `real_estate_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_digital_listing_id` FOREIGN KEY (`digital_listing_id`) REFERENCES `real_estate_ecm`.`marketing`.`digital_listing`(`digital_listing_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= tenant --> owner (6 constraint(s)) =========
-- Requires: tenant schema, owner schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_owner_ownership_interest_id` FOREIGN KEY (`owner_ownership_interest_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_ownership_interest`(`owner_ownership_interest_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_owner_agreement_id` FOREIGN KEY (`owner_agreement_id`) REFERENCES `real_estate_ecm`.`owner`.`owner_agreement`(`owner_agreement_id`);

-- ========= tenant --> property (17 constraint(s)) =========
-- Requires: tenant schema, property schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= tenant --> reference (33 constraint(s)) =========
-- Requires: tenant schema, reference schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_contact` ADD CONSTRAINT `fk_tenant_tenant_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`corporate_entity` ADD CONSTRAINT `fk_tenant_corporate_entity_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ADD CONSTRAINT `fk_tenant_household_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ADD CONSTRAINT `fk_tenant_household_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`household` ADD CONSTRAINT `fk_tenant_household_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);

-- ========= tenant --> valuation (1 constraint(s)) =========
-- Requires: tenant schema, valuation schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);

-- ========= tenant --> workforce (13 constraint(s)) =========
-- Requires: tenant schema, workforce schema
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant` ADD CONSTRAINT `fk_tenant_tenant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`credit_profile` ADD CONSTRAINT `fk_tenant_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_prospect` ADD CONSTRAINT `fk_tenant_tenant_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`application` ADD CONSTRAINT `fk_tenant_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`tenant_occupancy` ADD CONSTRAINT `fk_tenant_tenant_occupancy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`guarantor` ADD CONSTRAINT `fk_tenant_guarantor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`interaction` ADD CONSTRAINT `fk_tenant_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`notice` ADD CONSTRAINT `fk_tenant_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`document` ADD CONSTRAINT `fk_tenant_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`arrears_event` ADD CONSTRAINT `fk_tenant_arrears_event_relationship_manager_employee_id` FOREIGN KEY (`relationship_manager_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`retention_action` ADD CONSTRAINT `fk_tenant_retention_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`tenant`.`screening` ADD CONSTRAINT `fk_tenant_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= transaction --> brokerage (13 constraint(s)) =========
-- Requires: transaction schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_buyer_representation_id` FOREIGN KEY (`buyer_representation_id`) REFERENCES `real_estate_ecm`.`brokerage`.`buyer_representation`(`buyer_representation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_commission_id` FOREIGN KEY (`commission_id`) REFERENCES `real_estate_ecm`.`brokerage`.`commission`(`commission_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ADD CONSTRAINT `fk_transaction_bulk_sale_pool_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);

-- ========= transaction --> compliance (10 constraint(s)) =========
-- Requires: transaction schema, compliance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `real_estate_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= transaction --> development (10 constraint(s)) =========
-- Requires: transaction schema, development schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_proforma_id` FOREIGN KEY (`proforma_id`) REFERENCES `real_estate_ecm`.`development`.`proforma`(`proforma_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_construction_permit_id` FOREIGN KEY (`construction_permit_id`) REFERENCES `real_estate_ecm`.`development`.`construction_permit`(`construction_permit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `real_estate_ecm`.`development`.`entitlement`(`entitlement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= transaction --> finance (12 constraint(s)) =========
-- Requires: transaction schema, finance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `real_estate_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `real_estate_ecm`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ADD CONSTRAINT `fk_transaction_bulk_sale_pool_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= transaction --> insurance (15 constraint(s)) =========
-- Requires: transaction schema, insurance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_certificate_of_insurance_id` FOREIGN KEY (`certificate_of_insurance_id`) REFERENCES `real_estate_ecm`.`insurance`.`certificate_of_insurance`(`certificate_of_insurance_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_premium_id` FOREIGN KEY (`premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_endorsement_id` FOREIGN KEY (`endorsement_id`) REFERENCES `real_estate_ecm`.`insurance`.`endorsement`(`endorsement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `real_estate_ecm`.`insurance`.`claim`(`claim_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_loss_run_id` FOREIGN KEY (`loss_run_id`) REFERENCES `real_estate_ecm`.`insurance`.`loss_run`(`loss_run_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `real_estate_ecm`.`insurance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `real_estate_ecm`.`insurance`.`policy`(`policy_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_premium_id` FOREIGN KEY (`premium_id`) REFERENCES `real_estate_ecm`.`insurance`.`premium`(`premium_id`);

-- ========= transaction --> investment (15 constraint(s)) =========
-- Requires: transaction schema, investment schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `real_estate_ecm`.`investment`.`vehicle`(`vehicle_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_debt_facility_id` FOREIGN KEY (`debt_facility_id`) REFERENCES `real_estate_ecm`.`investment`.`debt_facility`(`debt_facility_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_investment_deal_id` FOREIGN KEY (`investment_deal_id`) REFERENCES `real_estate_ecm`.`investment`.`investment_deal`(`investment_deal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_investor_id` FOREIGN KEY (`investor_id`) REFERENCES `real_estate_ecm`.`investment`.`investor`(`investor_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_capital_call_id` FOREIGN KEY (`capital_call_id`) REFERENCES `real_estate_ecm`.`investment`.`capital_call`(`capital_call_id`);

-- ========= transaction --> lease (5 constraint(s)) =========
-- Requires: transaction schema, lease schema
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_security_deposit_id` FOREIGN KEY (`security_deposit_id`) REFERENCES `real_estate_ecm`.`lease`.`security_deposit`(`security_deposit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_ground_lease_id` FOREIGN KEY (`ground_lease_id`) REFERENCES `real_estate_ecm`.`lease`.`ground_lease`(`ground_lease_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_clause_id` FOREIGN KEY (`clause_id`) REFERENCES `real_estate_ecm`.`lease`.`clause`(`clause_id`);

-- ========= transaction --> maintenance (9 constraint(s)) =========
-- Requires: transaction schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_building_asset_id` FOREIGN KEY (`building_asset_id`) REFERENCES `real_estate_ecm`.`maintenance`.`building_asset`(`building_asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= transaction --> marketing (4 constraint(s)) =========
-- Requires: transaction schema, marketing schema
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ADD CONSTRAINT `fk_transaction_sale_attribution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `real_estate_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ADD CONSTRAINT `fk_transaction_sale_attribution_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead`(`lead_id`);

-- ========= transaction --> owner (10 constraint(s)) =========
-- Requires: transaction schema, owner schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ADD CONSTRAINT `fk_transaction_auction_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `real_estate_ecm`.`owner`.`owner`(`owner_id`);

-- ========= transaction --> property (21 constraint(s)) =========
-- Requires: transaction schema, property schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `real_estate_ecm`.`property`.`inspection`(`inspection_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);

-- ========= transaction --> reference (34 constraint(s)) =========
-- Requires: transaction schema, reference schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `real_estate_ecm`.`reference`.`document_type`(`document_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ADD CONSTRAINT `fk_transaction_sale_type_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);

-- ========= transaction --> tenant (2 constraint(s)) =========
-- Requires: transaction schema, tenant schema
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `real_estate_ecm`.`tenant`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_document_id` FOREIGN KEY (`document_id`) REFERENCES `real_estate_ecm`.`tenant`.`document`(`document_id`);

-- ========= transaction --> valuation (10 constraint(s)) =========
-- Requires: transaction schema, valuation schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_tax_assessment_id` FOREIGN KEY (`tax_assessment_id`) REFERENCES `real_estate_ecm`.`valuation`.`tax_assessment`(`tax_assessment_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_bpo_id` FOREIGN KEY (`bpo_id`) REFERENCES `real_estate_ecm`.`valuation`.`bpo`(`bpo_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_appraisal_id` FOREIGN KEY (`appraisal_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal`(`appraisal_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_appraisal_report_id` FOREIGN KEY (`appraisal_report_id`) REFERENCES `real_estate_ecm`.`valuation`.`appraisal_report`(`appraisal_report_id`);

-- ========= transaction --> workforce (8 constraint(s)) =========
-- Requires: transaction schema, workforce schema
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ADD CONSTRAINT `fk_transaction_auction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ADD CONSTRAINT `fk_transaction_bulk_sale_pool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ADD CONSTRAINT `fk_transaction_bulk_sale_pool_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= valuation --> brokerage (5 constraint(s)) =========
-- Requires: valuation schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_listing_id` FOREIGN KEY (`listing_id`) REFERENCES `real_estate_ecm`.`brokerage`.`listing`(`listing_id`);

-- ========= valuation --> compliance (27 constraint(s)) =========
-- Requires: valuation schema, compliance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `real_estate_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `real_estate_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `real_estate_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `real_estate_ecm`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `real_estate_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `real_estate_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= valuation --> development (7 constraint(s)) =========
-- Requires: valuation schema, development schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= valuation --> finance (11 constraint(s)) =========
-- Requires: valuation schema, finance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `real_estate_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `real_estate_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_financial_period_close_id` FOREIGN KEY (`financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_financial_period_financial_period_close_id` FOREIGN KEY (`financial_period_financial_period_close_id`) REFERENCES `real_estate_ecm`.`finance`.`financial_period_close`(`financial_period_close_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_noi_statement_id` FOREIGN KEY (`noi_statement_id`) REFERENCES `real_estate_ecm`.`finance`.`noi_statement`(`noi_statement_id`);

-- ========= valuation --> insurance (1 constraint(s)) =========
-- Requires: valuation schema, insurance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_insurance_program_id` FOREIGN KEY (`insurance_program_id`) REFERENCES `real_estate_ecm`.`insurance`.`insurance_program`(`insurance_program_id`);

-- ========= valuation --> investment (2 constraint(s)) =========
-- Requires: valuation schema, investment schema
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);

-- ========= valuation --> lease (1 constraint(s)) =========
-- Requires: valuation schema, lease schema
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= valuation --> maintenance (3 constraint(s)) =========
-- Requires: valuation schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_ops_inspection_id` FOREIGN KEY (`ops_inspection_id`) REFERENCES `real_estate_ecm`.`maintenance`.`ops_inspection`(`ops_inspection_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_building_asset_id` FOREIGN KEY (`building_asset_id`) REFERENCES `real_estate_ecm`.`maintenance`.`building_asset`(`building_asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `real_estate_ecm`.`maintenance`.`capex_project`(`capex_project_id`);

-- ========= valuation --> marketing (8 constraint(s)) =========
-- Requires: valuation schema, marketing schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_market_survey_id` FOREIGN KEY (`market_survey_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_survey`(`market_survey_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_market_research_id` FOREIGN KEY (`market_research_id`) REFERENCES `real_estate_ecm`.`marketing`.`market_research`(`market_research_id`);

-- ========= valuation --> property (24 constraint(s)) =========
-- Requires: valuation schema, property schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);

-- ========= valuation --> reference (63 constraint(s)) =========
-- Requires: valuation schema, reference schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_sustainability_rating_id` FOREIGN KEY (`sustainability_rating_id`) REFERENCES `real_estate_ecm`.`reference`.`sustainability_rating`(`sustainability_rating_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_zoning_code_id` FOREIGN KEY (`zoning_code_id`) REFERENCES `real_estate_ecm`.`reference`.`zoning_code`(`zoning_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_tenure_type_id` FOREIGN KEY (`tenure_type_id`) REFERENCES `real_estate_ecm`.`reference`.`tenure_type`(`tenure_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_sale` ADD CONSTRAINT `fk_valuation_comparable_sale_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_uom_id` FOREIGN KEY (`uom_id`) REFERENCES `real_estate_ecm`.`reference`.`uom`(`uom_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_industry_classification_id` FOREIGN KEY (`industry_classification_id`) REFERENCES `real_estate_ecm`.`reference`.`industry_classification`(`industry_classification_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_lease_type_id` FOREIGN KEY (`lease_type_id`) REFERENCES `real_estate_ecm`.`reference`.`lease_type`(`lease_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_space_use_type_id` FOREIGN KEY (`space_use_type_id`) REFERENCES `real_estate_ecm`.`reference`.`space_use_type`(`space_use_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_construction_type_id` FOREIGN KEY (`construction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`construction_type`(`construction_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cost_approach` ADD CONSTRAINT `fk_valuation_cost_approach_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_building_class_id` FOREIGN KEY (`building_class_id`) REFERENCES `real_estate_ecm`.`reference`.`building_class`(`building_class_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_country_id` FOREIGN KEY (`country_id`) REFERENCES `real_estate_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_investment_vehicle_id` FOREIGN KEY (`investment_vehicle_id`) REFERENCES `real_estate_ecm`.`reference`.`investment_vehicle`(`investment_vehicle_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_currency_code_id` FOREIGN KEY (`currency_code_id`) REFERENCES `real_estate_ecm`.`reference`.`currency_code`(`currency_code_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);

-- ========= valuation --> tenant (2 constraint(s)) =========
-- Requires: valuation schema, tenant schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_report` ADD CONSTRAINT `fk_valuation_appraisal_report_document_id` FOREIGN KEY (`document_id`) REFERENCES `real_estate_ecm`.`tenant`.`document`(`document_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_tenant_occupancy_id` FOREIGN KEY (`tenant_occupancy_id`) REFERENCES `real_estate_ecm`.`tenant`.`tenant_occupancy`(`tenant_occupancy_id`);

-- ========= valuation --> workforce (14 constraint(s)) =========
-- Requires: valuation schema, workforce schema
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal` ADD CONSTRAINT `fk_valuation_appraisal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`bpo` ADD CONSTRAINT `fk_valuation_bpo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cma` ADD CONSTRAINT `fk_valuation_cma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`comparable_lease` ADD CONSTRAINT `fk_valuation_comparable_lease_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`approach` ADD CONSTRAINT `fk_valuation_approach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`dcf_model` ADD CONSTRAINT `fk_valuation_dcf_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`cap_rate_benchmark` ADD CONSTRAINT `fk_valuation_cap_rate_benchmark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_calculation` ADD CONSTRAINT `fk_valuation_nav_calculation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`appraisal_review` ADD CONSTRAINT `fk_valuation_appraisal_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`value_history` ADD CONSTRAINT `fk_valuation_value_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_assessment` ADD CONSTRAINT `fk_valuation_tax_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`tax_appeal` ADD CONSTRAINT `fk_valuation_tax_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`valuation`.`nav_appraisal_input` ADD CONSTRAINT `fk_valuation_nav_appraisal_input_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> brokerage (2 constraint(s)) =========
-- Requires: workforce schema, brokerage schema
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ADD CONSTRAINT `fk_workforce_license_certification_brokerage_broker_id` FOREIGN KEY (`brokerage_broker_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_broker`(`brokerage_broker_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_brokerage_deal_id` FOREIGN KEY (`brokerage_deal_id`) REFERENCES `real_estate_ecm`.`brokerage`.`brokerage_deal`(`brokerage_deal_id`);

-- ========= workforce --> development (3 constraint(s)) =========
-- Requires: workforce schema, development schema
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_dev_project_id` FOREIGN KEY (`dev_project_id`) REFERENCES `real_estate_ecm`.`development`.`dev_project`(`dev_project_id`);

-- ========= workforce --> finance (15 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `real_estate_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ADD CONSTRAINT `fk_workforce_license_renewal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `real_estate_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `real_estate_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `real_estate_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> investment (5 constraint(s)) =========
-- Requires: workforce schema, investment schema
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `real_estate_ecm`.`investment`.`fund`(`fund_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_portfolio_asset_id` FOREIGN KEY (`portfolio_asset_id`) REFERENCES `real_estate_ecm`.`investment`.`portfolio_asset`(`portfolio_asset_id`);

-- ========= workforce --> lease (1 constraint(s)) =========
-- Requires: workforce schema, lease schema
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_lease_agreement_id` FOREIGN KEY (`lease_agreement_id`) REFERENCES `real_estate_ecm`.`lease`.`lease_agreement`(`lease_agreement_id`);

-- ========= workforce --> maintenance (1 constraint(s)) =========
-- Requires: workforce schema, maintenance schema
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `real_estate_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= workforce --> marketing (1 constraint(s)) =========
-- Requires: workforce schema, marketing schema
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_lead_attribution_id` FOREIGN KEY (`lead_attribution_id`) REFERENCES `real_estate_ecm`.`marketing`.`lead_attribution`(`lead_attribution_id`);

-- ========= workforce --> property (10 constraint(s)) =========
-- Requires: workforce schema, property schema
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);

-- ========= workforce --> reference (20 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ADD CONSTRAINT `fk_workforce_license_certification_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ADD CONSTRAINT `fk_workforce_license_certification_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ADD CONSTRAINT `fk_workforce_license_renewal_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ADD CONSTRAINT `fk_workforce_workforce_training_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_regulatory_framework_id` FOREIGN KEY (`regulatory_framework_id`) REFERENCES `real_estate_ecm`.`reference`.`regulatory_framework`(`regulatory_framework_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_geographic_hierarchy_id` FOREIGN KEY (`geographic_hierarchy_id`) REFERENCES `real_estate_ecm`.`reference`.`geographic_hierarchy`(`geographic_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `real_estate_ecm`.`reference`.`market_segment`(`market_segment_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `real_estate_ecm`.`reference`.`property_type`(`property_type_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_transaction_type_id` FOREIGN KEY (`transaction_type_id`) REFERENCES `real_estate_ecm`.`reference`.`transaction_type`(`transaction_type_id`);

-- ========= workforce --> transaction (1 constraint(s)) =========
-- Requires: workforce schema, transaction schema
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);

