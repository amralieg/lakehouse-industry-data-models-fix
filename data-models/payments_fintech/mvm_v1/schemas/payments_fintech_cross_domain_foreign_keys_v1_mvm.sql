-- Cross-Domain Foreign Keys for Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:52
-- Total cross-domain FK constraints: 1121
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: cardholder, compliance, dispute, fraud, fx, gateway, interchange, ledger, merchant, network, partner, product, risk, settlement, transaction

-- ========= cardholder --> compliance (3 constraint(s)) =========
-- Requires: cardholder schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= cardholder --> fraud (3 constraint(s)) =========
-- Requires: cardholder schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_auth_3ds_result_id` FOREIGN KEY (`auth_3ds_result_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`auth_3ds_result`(`auth_3ds_result_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ADD CONSTRAINT `fk_cardholder_device_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_score_event_id` FOREIGN KEY (`score_event_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`score_event`(`score_event_id`);

-- ========= cardholder --> fx (5 constraint(s)) =========
-- Requires: cardholder schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_dcc_config_id` FOREIGN KEY (`dcc_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`dcc_config`(`dcc_config_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= cardholder --> gateway (2 constraint(s)) =========
-- Requires: cardholder schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_threeds_config_id` FOREIGN KEY (`threeds_config_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`threeds_config`(`threeds_config_id`);

-- ========= cardholder --> interchange (2 constraint(s)) =========
-- Requires: cardholder schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);

-- ========= cardholder --> ledger (6 constraint(s)) =========
-- Requires: cardholder schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ADD CONSTRAINT `fk_cardholder_account_holder_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= cardholder --> merchant (1 constraint(s)) =========
-- Requires: cardholder schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= cardholder --> network (8 constraint(s)) =========
-- Requires: cardholder schema, network schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ADD CONSTRAINT `fk_cardholder_payment_credential_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_multi_network_routing_id` FOREIGN KEY (`multi_network_routing_id`) REFERENCES `payments_fintech_ecm`.`network`.`multi_network_routing`(`multi_network_routing_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= cardholder --> partner (10 constraint(s)) =========
-- Requires: cardholder schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_bin_sponsorship_id` FOREIGN KEY (`bin_sponsorship_id`) REFERENCES `payments_fintech_ecm`.`partner`.`bin_sponsorship`(`bin_sponsorship_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_bin_sponsorship_id` FOREIGN KEY (`bin_sponsorship_id`) REFERENCES `payments_fintech_ecm`.`partner`.`bin_sponsorship`(`bin_sponsorship_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ADD CONSTRAINT `fk_cardholder_linked_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= cardholder --> product (10 constraint(s)) =========
-- Requires: cardholder schema, product schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ADD CONSTRAINT `fk_cardholder_payment_credential_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_a2a_product_id` FOREIGN KEY (`a2a_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`a2a_product`(`a2a_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_p2p_product_id` FOREIGN KEY (`p2p_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`p2p_product`(`p2p_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_product_pricing_plan_id` FOREIGN KEY (`product_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_pricing_plan`(`product_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_virtual_account_product_id` FOREIGN KEY (`virtual_account_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`virtual_account_product`(`virtual_account_product_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_limit_id` FOREIGN KEY (`limit_id`) REFERENCES `payments_fintech_ecm`.`product`.`limit`(`limit_id`);

-- ========= cardholder --> risk (7 constraint(s)) =========
-- Requires: cardholder schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_model_id` FOREIGN KEY (`model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`model`(`model_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `payments_fintech_ecm`.`risk`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_model_id` FOREIGN KEY (`model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`model`(`model_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);

-- ========= cardholder --> settlement (4 constraint(s)) =========
-- Requires: cardholder schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_funding_schedule_id` FOREIGN KEY (`funding_schedule_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`funding_schedule`(`funding_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ADD CONSTRAINT `fk_cardholder_linked_account_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);

-- ========= cardholder --> transaction (1 constraint(s)) =========
-- Requires: cardholder schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= compliance --> cardholder (7 constraint(s)) =========
-- Requires: compliance schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ADD CONSTRAINT `fk_compliance_party_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);

-- ========= compliance --> fx (4 constraint(s)) =========
-- Requires: compliance schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_beneficiary_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `payments_fintech_ecm`.`fx`.`beneficiary`(`beneficiary_id`);

-- ========= compliance --> gateway (4 constraint(s)) =========
-- Requires: compliance schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);

-- ========= compliance --> ledger (13 constraint(s)) =========
-- Requires: compliance schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ADD CONSTRAINT `fk_compliance_watchlist_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ADD CONSTRAINT `fk_compliance_party_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> merchant (2 constraint(s)) =========
-- Requires: compliance schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= compliance --> network (7 constraint(s)) =========
-- Requires: compliance schema, network schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_scheme_membership_id` FOREIGN KEY (`scheme_membership_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_membership`(`scheme_membership_id`);

-- ========= compliance --> partner (3 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= compliance --> product (4 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= compliance --> settlement (1 constraint(s)) =========
-- Requires: compliance schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);

-- ========= compliance --> transaction (4 constraint(s)) =========
-- Requires: compliance schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);

-- ========= dispute --> cardholder (6 constraint(s)) =========
-- Requires: dispute schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);

-- ========= dispute --> compliance (2 constraint(s)) =========
-- Requires: dispute schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);

-- ========= dispute --> fx (3 constraint(s)) =========
-- Requires: dispute schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= dispute --> gateway (1 constraint(s)) =========
-- Requires: dispute schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_webhook_delivery_id` FOREIGN KEY (`webhook_delivery_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`webhook_delivery`(`webhook_delivery_id`);

-- ========= dispute --> interchange (1 constraint(s)) =========
-- Requires: dispute schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);

-- ========= dispute --> ledger (11 constraint(s)) =========
-- Requires: dispute schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);

-- ========= dispute --> merchant (9 constraint(s)) =========
-- Requires: dispute schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_merchant_contact_id` FOREIGN KEY (`merchant_contact_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_contact`(`merchant_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= dispute --> network (17 constraint(s)) =========
-- Requires: dispute schema, network schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`lifecycle_event` ADD CONSTRAINT `fk_dispute_lifecycle_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_scheme_parameter_id` FOREIGN KEY (`scheme_parameter_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_parameter`(`scheme_parameter_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`rule_config` ADD CONSTRAINT `fk_dispute_rule_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`rule_config` ADD CONSTRAINT `fk_dispute_rule_config_scheme_parameter_id` FOREIGN KEY (`scheme_parameter_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_parameter`(`scheme_parameter_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_scheme_parameter_id` FOREIGN KEY (`scheme_parameter_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_parameter`(`scheme_parameter_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);

-- ========= dispute --> partner (6 constraint(s)) =========
-- Requires: dispute schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= dispute --> product (16 constraint(s)) =========
-- Requires: dispute schema, product schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`evidence_package` ADD CONSTRAINT `fk_dispute_evidence_package_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`fee` ADD CONSTRAINT `fk_dispute_fee_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);

-- ========= dispute --> settlement (8 constraint(s)) =========
-- Requires: dispute schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`ratio_monitor` ADD CONSTRAINT `fk_dispute_ratio_monitor_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= dispute --> transaction (17 constraint(s)) =========
-- Requires: dispute schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`chargeback` ADD CONSTRAINT `fk_dispute_chargeback_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`retrieval_request` ADD CONSTRAINT `fk_dispute_retrieval_request_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`representment` ADD CONSTRAINT `fk_dispute_representment_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`arbitration_case` ADD CONSTRAINT `fk_dispute_arbitration_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`dispute_case` ADD CONSTRAINT `fk_dispute_dispute_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`financial_adjustment` ADD CONSTRAINT `fk_dispute_financial_adjustment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`lifecycle_event` ADD CONSTRAINT `fk_dispute_lifecycle_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`pre_arbitration` ADD CONSTRAINT `fk_dispute_pre_arbitration_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`claim` ADD CONSTRAINT `fk_dispute_claim_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`dispute`.`merchant_response` ADD CONSTRAINT `fk_dispute_merchant_response_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);

-- ========= fraud --> cardholder (5 constraint(s)) =========
-- Requires: fraud schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_payment_credential_id` FOREIGN KEY (`payment_credential_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`payment_credential`(`payment_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);

-- ========= fraud --> compliance (8 constraint(s)) =========
-- Requires: fraud schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ADD CONSTRAINT `fk_fraud_blocklist_entry_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);

-- ========= fraud --> dispute (5 constraint(s)) =========
-- Requires: fraud schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_package_id` FOREIGN KEY (`evidence_package_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`evidence_package`(`evidence_package_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);

-- ========= fraud --> fx (9 constraint(s)) =========
-- Requires: fraud schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= fraud --> gateway (6 constraint(s)) =========
-- Requires: fraud schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= fraud --> interchange (3 constraint(s)) =========
-- Requires: fraud schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);

-- ========= fraud --> ledger (6 constraint(s)) =========
-- Requires: fraud schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= fraud --> merchant (9 constraint(s)) =========
-- Requires: fraud schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_application_id` FOREIGN KEY (`application_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`application`(`application_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_sub_merchant_id` FOREIGN KEY (`sub_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`sub_merchant`(`sub_merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= fraud --> network (9 constraint(s)) =========
-- Requires: fraud schema, network schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ADD CONSTRAINT `fk_fraud_blocklist_entry_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= fraud --> partner (8 constraint(s)) =========
-- Requires: fraud schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ADD CONSTRAINT `fk_fraud_device_fingerprint_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ADD CONSTRAINT `fk_fraud_blocklist_entry_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= fraud --> product (13 constraint(s)) =========
-- Requires: fraud schema, product schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= fraud --> risk (12 constraint(s)) =========
-- Requires: fraud schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_model_id` FOREIGN KEY (`model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`model`(`model_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_threshold_id` FOREIGN KEY (`threshold_id`) REFERENCES `payments_fintech_ecm`.`risk`.`threshold`(`threshold_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_event_id` FOREIGN KEY (`event_id`) REFERENCES `payments_fintech_ecm`.`risk`.`event`(`event_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ADD CONSTRAINT `fk_fraud_blocklist_entry_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_model_id` FOREIGN KEY (`model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`model`(`model_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `payments_fintech_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_event_id` FOREIGN KEY (`event_id`) REFERENCES `payments_fintech_ecm`.`risk`.`event`(`event_id`);

-- ========= fraud --> transaction (17 constraint(s)) =========
-- Requires: fraud schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_txn_type_id` FOREIGN KEY (`txn_type_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`txn_type`(`txn_type_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`authorization`(`authorization_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_transaction_id` FOREIGN KEY (`evidence_transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= fx --> cardholder (1 constraint(s)) =========
-- Requires: fx schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= fx --> compliance (2 constraint(s)) =========
-- Requires: fx schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ADD CONSTRAINT `fk_fx_fx_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= fx --> fraud (2 constraint(s)) =========
-- Requires: fx schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);

-- ========= fx --> gateway (1 constraint(s)) =========
-- Requires: fx schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);

-- ========= fx --> ledger (4 constraint(s)) =========
-- Requires: fx schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ADD CONSTRAINT `fk_fx_nostro_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`beneficiary` ADD CONSTRAINT `fk_fx_beneficiary_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= fx --> merchant (1 constraint(s)) =========
-- Requires: fx schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= fx --> network (10 constraint(s)) =========
-- Requires: fx schema, network schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`nostro_account` ADD CONSTRAINT `fk_fx_nostro_account_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`payment_corridor` ADD CONSTRAINT `fk_fx_payment_corridor_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`exposure` ADD CONSTRAINT `fk_fx_exposure_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_config` ADD CONSTRAINT `fk_fx_dcc_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`fx_fee_schedule` ADD CONSTRAINT `fk_fx_fx_fee_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`rate_margin_config` ADD CONSTRAINT `fk_fx_rate_margin_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= fx --> product (2 constraint(s)) =========
-- Requires: fx schema, product schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= fx --> settlement (1 constraint(s)) =========
-- Requires: fx schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`cross_border_payment` ADD CONSTRAINT `fk_fx_cross_border_payment_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);

-- ========= fx --> transaction (1 constraint(s)) =========
-- Requires: fx schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`fx`.`dcc_transaction` ADD CONSTRAINT `fk_fx_dcc_transaction_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);

-- ========= gateway --> cardholder (8 constraint(s)) =========
-- Requires: gateway schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_payment_credential_id` FOREIGN KEY (`payment_credential_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`payment_credential`(`payment_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);

-- ========= gateway --> fraud (1 constraint(s)) =========
-- Requires: gateway schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);

-- ========= gateway --> fx (4 constraint(s)) =========
-- Requires: gateway schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= gateway --> interchange (4 constraint(s)) =========
-- Requires: gateway schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);

-- ========= gateway --> ledger (7 constraint(s)) =========
-- Requires: gateway schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= gateway --> merchant (11 constraint(s)) =========
-- Requires: gateway schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= gateway --> network (12 constraint(s)) =========
-- Requires: gateway schema, network schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_network_routing_rule_id` FOREIGN KEY (`network_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_routing_rule`(`network_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_multi_network_routing_id` FOREIGN KEY (`multi_network_routing_id`) REFERENCES `payments_fintech_ecm`.`network`.`multi_network_routing`(`multi_network_routing_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `payments_fintech_ecm`.`network`.`sla`(`sla_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `payments_fintech_ecm`.`network`.`sla`(`sla_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_scheme_parameter_id` FOREIGN KEY (`scheme_parameter_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_parameter`(`scheme_parameter_id`);

-- ========= gateway --> partner (11 constraint(s)) =========
-- Requires: gateway schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_bin_sponsorship_id` FOREIGN KEY (`bin_sponsorship_id`) REFERENCES `payments_fintech_ecm`.`partner`.`bin_sponsorship`(`bin_sponsorship_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_network_participation_id` FOREIGN KEY (`network_participation_id`) REFERENCES `payments_fintech_ecm`.`partner`.`network_participation`(`network_participation_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_partner_settlement_account_id` FOREIGN KEY (`partner_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_settlement_account`(`partner_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ADD CONSTRAINT `fk_gateway_rate_limit_policy_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= gateway --> product (4 constraint(s)) =========
-- Requires: gateway schema, product schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= gateway --> settlement (1 constraint(s)) =========
-- Requires: gateway schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= interchange --> compliance (4 constraint(s)) =========
-- Requires: interchange schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= interchange --> dispute (1 constraint(s)) =========
-- Requires: interchange schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_ratio_monitor_id` FOREIGN KEY (`ratio_monitor_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`ratio_monitor`(`ratio_monitor_id`);

-- ========= interchange --> fx (11 constraint(s)) =========
-- Requires: interchange schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ADD CONSTRAINT `fk_interchange_scheme_fee_table_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= interchange --> ledger (10 constraint(s)) =========
-- Requires: interchange schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ADD CONSTRAINT `fk_interchange_scheme_fee_table_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_payable_id` FOREIGN KEY (`payable_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`payable`(`payable_id`);

-- ========= interchange --> merchant (11 constraint(s)) =========
-- Requires: interchange schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_merchant_pricing_plan_id` FOREIGN KEY (`merchant_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`(`merchant_pricing_plan_id`);

-- ========= interchange --> network (11 constraint(s)) =========
-- Requires: interchange schema, network schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_table` ADD CONSTRAINT `fk_interchange_irf_table_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`irf_rate_category` ADD CONSTRAINT `fk_interchange_irf_rate_category_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_fee_table` ADD CONSTRAINT `fk_interchange_scheme_fee_table_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= interchange --> partner (6 constraint(s)) =========
-- Requires: interchange schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);

-- ========= interchange --> product (8 constraint(s)) =========
-- Requires: interchange schema, product schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= interchange --> risk (6 constraint(s)) =========
-- Requires: interchange schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`bin_interchange_rule` ADD CONSTRAINT `fk_interchange_bin_interchange_rule_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`program` ADD CONSTRAINT `fk_interchange_program_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule` ADD CONSTRAINT `fk_interchange_cross_border_fee_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);

-- ========= interchange --> settlement (11 constraint(s)) =========
-- Requires: interchange schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`mdr_config` ADD CONSTRAINT `fk_interchange_mdr_config_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`msf_schedule` ADD CONSTRAINT `fk_interchange_msf_schedule_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`billing` ADD CONSTRAINT `fk_interchange_billing_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`cost_of_acceptance` ADD CONSTRAINT `fk_interchange_cost_of_acceptance_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`downgrade` ADD CONSTRAINT `fk_interchange_downgrade_clearing_record_id` FOREIGN KEY (`clearing_record_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`clearing_record`(`clearing_record_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`scheme_invoice` ADD CONSTRAINT `fk_interchange_scheme_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`pricing_exception` ADD CONSTRAINT `fk_interchange_pricing_exception_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`interchange`.`volume_tier_threshold` ADD CONSTRAINT `fk_interchange_volume_tier_threshold_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= interchange --> transaction (1 constraint(s)) =========
-- Requires: interchange schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`interchange`.`qualification` ADD CONSTRAINT `fk_interchange_qualification_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= ledger --> cardholder (3 constraint(s)) =========
-- Requires: ledger schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);

-- ========= ledger --> compliance (3 constraint(s)) =========
-- Requires: ledger schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);

-- ========= ledger --> fx (2 constraint(s)) =========
-- Requires: ledger schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_entry` ADD CONSTRAINT `fk_ledger_journal_entry_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`journal_line` ADD CONSTRAINT `fk_ledger_journal_line_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);

-- ========= ledger --> merchant (4 constraint(s)) =========
-- Requires: ledger schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= ledger --> partner (2 constraint(s)) =========
-- Requires: ledger schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`payable` ADD CONSTRAINT `fk_ledger_payable_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= ledger --> product (2 constraint(s)) =========
-- Requires: ledger schema, product schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_ledger_revenue_recognition_schedule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= ledger --> settlement (1 constraint(s)) =========
-- Requires: ledger schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);

-- ========= ledger --> transaction (12 constraint(s)) =========
-- Requires: ledger schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_fx_conversion_id` FOREIGN KEY (`fx_conversion_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`fx_conversion`(`fx_conversion_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`refund`(`refund_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`subledger_entry` ADD CONSTRAINT `fk_ledger_subledger_entry_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`capture`(`capture_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`revenue_recognition_event` ADD CONSTRAINT `fk_ledger_revenue_recognition_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`account_reconciliation` ADD CONSTRAINT `fk_ledger_account_reconciliation_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_payment_txn_id` FOREIGN KEY (`payment_txn_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`payment_txn`(`payment_txn_id`);
ALTER TABLE `payments_fintech_ecm`.`ledger`.`receivable` ADD CONSTRAINT `fk_ledger_receivable_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);

-- ========= merchant --> cardholder (1 constraint(s)) =========
-- Requires: merchant schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);

-- ========= merchant --> compliance (19 constraint(s)) =========
-- Requires: merchant schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_compliance_kyc_verification_id` FOREIGN KEY (`compliance_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification`(`compliance_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`beneficial_owner` ADD CONSTRAINT `fk_merchant_beneficial_owner_watchlist_entry_id` FOREIGN KEY (`watchlist_entry_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`watchlist_entry`(`watchlist_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`pci_compliance` ADD CONSTRAINT `fk_merchant_pci_compliance_pci_dss_audit_id` FOREIGN KEY (`pci_dss_audit_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`pci_dss_audit`(`pci_dss_audit_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);

-- ========= merchant --> fraud (1 constraint(s)) =========
-- Requires: merchant schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_fraud_velocity_control_id` FOREIGN KEY (`fraud_velocity_control_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_velocity_control`(`fraud_velocity_control_id`);

-- ========= merchant --> fx (6 constraint(s)) =========
-- Requires: merchant schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_dcc_config_id` FOREIGN KEY (`dcc_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`dcc_config`(`dcc_config_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ADD CONSTRAINT `fk_merchant_merchant_settlement_account_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);

-- ========= merchant --> gateway (6 constraint(s)) =========
-- Requires: merchant schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_threeds_config_id` FOREIGN KEY (`threeds_config_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`threeds_config`(`threeds_config_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);

-- ========= merchant --> interchange (10 constraint(s)) =========
-- Requires: merchant schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`location` ADD CONSTRAINT `fk_merchant_location_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ADD CONSTRAINT `fk_merchant_merchant_pricing_plan_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ADD CONSTRAINT `fk_merchant_merchant_pricing_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);

-- ========= merchant --> ledger (13 constraint(s)) =========
-- Requires: merchant schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`kyb_verification` ADD CONSTRAINT `fk_merchant_kyb_verification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ADD CONSTRAINT `fk_merchant_merchant_pricing_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_settlement_account` ADD CONSTRAINT `fk_merchant_merchant_settlement_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= merchant --> network (5 constraint(s)) =========
-- Requires: merchant schema, network schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_multi_network_routing_id` FOREIGN KEY (`multi_network_routing_id`) REFERENCES `payments_fintech_ecm`.`network`.`multi_network_routing`(`multi_network_routing_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`mcc_assignment` ADD CONSTRAINT `fk_merchant_mcc_assignment_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= merchant --> partner (6 constraint(s)) =========
-- Requires: merchant schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_onboarding_application_id` FOREIGN KEY (`onboarding_application_id`) REFERENCES `payments_fintech_ecm`.`partner`.`onboarding_application`(`onboarding_application_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_pricing_plan` ADD CONSTRAINT `fk_merchant_merchant_pricing_plan_revenue_share_schedule_id` FOREIGN KEY (`revenue_share_schedule_id`) REFERENCES `payments_fintech_ecm`.`partner`.`revenue_share_schedule`(`revenue_share_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= merchant --> product (4 constraint(s)) =========
-- Requires: merchant schema, product schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule` ADD CONSTRAINT `fk_merchant_merchant_fee_schedule_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= merchant --> risk (9 constraint(s)) =========
-- Requires: merchant schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`application` ADD CONSTRAINT `fk_merchant_application_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`processing_limit` ADD CONSTRAINT `fk_merchant_processing_limit_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`sub_merchant` ADD CONSTRAINT `fk_merchant_sub_merchant_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`risk_profile` ADD CONSTRAINT `fk_merchant_risk_profile_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);

-- ========= merchant --> settlement (5 constraint(s)) =========
-- Requires: merchant schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant` ADD CONSTRAINT `fk_merchant_merchant_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`merchant_account` ADD CONSTRAINT `fk_merchant_merchant_account_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`participant`(`participant_id`);
ALTER TABLE `payments_fintech_ecm`.`merchant`.`acquiring_agreement` ADD CONSTRAINT `fk_merchant_acquiring_agreement_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);

-- ========= network --> compliance (19 constraint(s)) =========
-- Requires: network schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_pci_dss_audit_id` FOREIGN KEY (`pci_dss_audit_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`pci_dss_audit`(`pci_dss_audit_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= network --> fx (5 constraint(s)) =========
-- Requires: network schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_rate_feed_id` FOREIGN KEY (`rate_feed_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_feed`(`rate_feed_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= network --> gateway (1 constraint(s)) =========
-- Requires: network schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);

-- ========= network --> interchange (4 constraint(s)) =========
-- Requires: network schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);

-- ========= network --> ledger (6 constraint(s)) =========
-- Requires: network schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ADD CONSTRAINT `fk_network_scheme_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= network --> partner (2 constraint(s)) =========
-- Requires: network schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= network --> risk (2 constraint(s)) =========
-- Requires: network schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);

-- ========= partner --> compliance (4 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= partner --> fx (5 constraint(s)) =========
-- Requires: partner schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);

-- ========= partner --> interchange (2 constraint(s)) =========
-- Requires: partner schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);

-- ========= partner --> ledger (11 constraint(s)) =========
-- Requires: partner schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ADD CONSTRAINT `fk_partner_revenue_share_schedule_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= partner --> network (3 constraint(s)) =========
-- Requires: partner schema, network schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ADD CONSTRAINT `fk_partner_network_participation_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= partner --> risk (2 constraint(s)) =========
-- Requires: partner schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);

-- ========= product --> compliance (4 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ADD CONSTRAINT `fk_product_feature_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= product --> fx (7 constraint(s)) =========
-- Requires: product schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_dcc_config_id` FOREIGN KEY (`dcc_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`dcc_config`(`dcc_config_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);

-- ========= product --> gateway (4 constraint(s)) =========
-- Requires: product schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);

-- ========= product --> interchange (4 constraint(s)) =========
-- Requires: product schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);

-- ========= product --> ledger (9 constraint(s)) =========
-- Requires: product schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ADD CONSTRAINT `fk_product_feature_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);

-- ========= product --> network (8 constraint(s)) =========
-- Requires: product schema, network schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_multi_network_routing_id` FOREIGN KEY (`multi_network_routing_id`) REFERENCES `payments_fintech_ecm`.`network`.`multi_network_routing`(`multi_network_routing_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= product --> partner (8 constraint(s)) =========
-- Requires: product schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ADD CONSTRAINT `fk_product_payment_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ADD CONSTRAINT `fk_product_product_fee_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= risk --> cardholder (5 constraint(s)) =========
-- Requires: risk schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);

-- ========= risk --> compliance (13 constraint(s)) =========
-- Requires: risk schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model` ADD CONSTRAINT `fk_risk_model_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_compliance_kyc_verification_id` FOREIGN KEY (`compliance_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification`(`compliance_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);

-- ========= risk --> dispute (2 constraint(s)) =========
-- Requires: risk schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);

-- ========= risk --> fraud (1 constraint(s)) =========
-- Requires: risk schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= risk --> fx (19 constraint(s)) =========
-- Requires: risk schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_risk_profile` ADD CONSTRAINT `fk_risk_risk_risk_profile_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_risk_profile` ADD CONSTRAINT `fk_risk_risk_risk_profile_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_cross_border_payment_id` FOREIGN KEY (`cross_border_payment_id`) REFERENCES `payments_fintech_ecm`.`fx`.`cross_border_payment`(`cross_border_payment_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);

-- ========= risk --> gateway (5 constraint(s)) =========
-- Requires: risk schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);

-- ========= risk --> ledger (15 constraint(s)) =========
-- Requires: risk schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_risk_profile` ADD CONSTRAINT `fk_risk_risk_risk_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model` ADD CONSTRAINT `fk_risk_model_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= risk --> merchant (3 constraint(s)) =========
-- Requires: risk schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= risk --> network (7 constraint(s)) =========
-- Requires: risk schema, network schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);

-- ========= risk --> partner (8 constraint(s)) =========
-- Requires: risk schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ADD CONSTRAINT `fk_risk_underwriting_policy_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= risk --> product (20 constraint(s)) =========
-- Requires: risk schema, product schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= risk --> settlement (2 constraint(s)) =========
-- Requires: risk schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_settlement_account_id` FOREIGN KEY (`settlement_account_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_account`(`settlement_account_id`);

-- ========= risk --> transaction (3 constraint(s)) =========
-- Requires: risk schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`event` ADD CONSTRAINT `fk_risk_event_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);

-- ========= settlement --> compliance (11 constraint(s)) =========
-- Requires: settlement schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= settlement --> dispute (1 constraint(s)) =========
-- Requires: settlement schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);

-- ========= settlement --> fraud (1 constraint(s)) =========
-- Requires: settlement schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= settlement --> fx (14 constraint(s)) =========
-- Requires: settlement schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_correspondent_bank_id` FOREIGN KEY (`correspondent_bank_id`) REFERENCES `payments_fintech_ecm`.`fx`.`correspondent_bank`(`correspondent_bank_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_nostro_account_id` FOREIGN KEY (`nostro_account_id`) REFERENCES `payments_fintech_ecm`.`fx`.`nostro_account`(`nostro_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);

-- ========= settlement --> gateway (4 constraint(s)) =========
-- Requires: settlement schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);

-- ========= settlement --> interchange (15 constraint(s)) =========
-- Requires: settlement schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_downgrade_id` FOREIGN KEY (`downgrade_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`downgrade`(`downgrade_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`qualification`(`qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_msf_schedule_id` FOREIGN KEY (`msf_schedule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`msf_schedule`(`msf_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_pricing_exception_id` FOREIGN KEY (`pricing_exception_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`pricing_exception`(`pricing_exception_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_downgrade_id` FOREIGN KEY (`downgrade_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`downgrade`(`downgrade_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_downgrade_id` FOREIGN KEY (`downgrade_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`downgrade`(`downgrade_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_scheme_invoice_id` FOREIGN KEY (`scheme_invoice_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_invoice`(`scheme_invoice_id`);

-- ========= settlement --> ledger (11 constraint(s)) =========
-- Requires: settlement schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= settlement --> merchant (3 constraint(s)) =========
-- Requires: settlement schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= settlement --> network (18 constraint(s)) =========
-- Requires: settlement schema, network schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`cycle` ADD CONSTRAINT `fk_settlement_cycle_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `payments_fintech_ecm`.`network`.`sla`(`sla_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `payments_fintech_ecm`.`network`.`sla`(`sla_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_scheme_membership_id` FOREIGN KEY (`scheme_membership_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_membership`(`scheme_membership_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= settlement --> partner (16 constraint(s)) =========
-- Requires: settlement schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_batch` ADD CONSTRAINT `fk_settlement_settlement_batch_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_confirmation` ADD CONSTRAINT `fk_settlement_funding_confirmation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_partner_settlement_account_id` FOREIGN KEY (`partner_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_settlement_account`(`partner_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_partner_settlement_account_id` FOREIGN KEY (`partner_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_settlement_account`(`partner_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_partner_settlement_account_id` FOREIGN KEY (`partner_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_settlement_account`(`partner_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement` ADD CONSTRAINT `fk_settlement_settlement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= settlement --> product (8 constraint(s)) =========
-- Requires: settlement schema, product schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reconciliation_record` ADD CONSTRAINT `fk_settlement_reconciliation_record_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_exception` ADD CONSTRAINT `fk_settlement_settlement_exception_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= settlement --> risk (11 constraint(s)) =========
-- Requires: settlement schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`instruction` ADD CONSTRAINT `fk_settlement_instruction_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`net_position` ADD CONSTRAINT `fk_settlement_net_position_exposure_limit_id` FOREIGN KEY (`exposure_limit_id`) REFERENCES `payments_fintech_ecm`.`risk`.`exposure_limit`(`exposure_limit_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`settlement_account` ADD CONSTRAINT `fk_settlement_settlement_account_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`reserve_account` ADD CONSTRAINT `fk_settlement_reserve_account_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`merchant_payout` ADD CONSTRAINT `fk_settlement_merchant_payout_underwriting_decision_id` FOREIGN KEY (`underwriting_decision_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_decision`(`underwriting_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_exposure_limit_id` FOREIGN KEY (`exposure_limit_id`) REFERENCES `payments_fintech_ecm`.`risk`.`exposure_limit`(`exposure_limit_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`participant` ADD CONSTRAINT `fk_settlement_participant_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`adjustment` ADD CONSTRAINT `fk_settlement_adjustment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`acquirer` ADD CONSTRAINT `fk_settlement_acquirer_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);

-- ========= settlement --> transaction (3 constraint(s)) =========
-- Requires: settlement schema, transaction schema
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_clearing_submission_id` FOREIGN KEY (`clearing_submission_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`clearing_submission`(`clearing_submission_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`clearing_record` ADD CONSTRAINT `fk_settlement_clearing_record_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction`(`transaction_id`);
ALTER TABLE `payments_fintech_ecm`.`settlement`.`funding_schedule` ADD CONSTRAINT `fk_settlement_funding_schedule_transaction_batch_id` FOREIGN KEY (`transaction_batch_id`) REFERENCES `payments_fintech_ecm`.`transaction`.`transaction_batch`(`transaction_batch_id`);

-- ========= transaction --> cardholder (22 constraint(s)) =========
-- Requires: transaction schema, cardholder schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);

-- ========= transaction --> compliance (12 constraint(s)) =========
-- Requires: transaction schema, compliance schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ADD CONSTRAINT `fk_transaction_txn_type_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= transaction --> dispute (3 constraint(s)) =========
-- Requires: transaction schema, dispute schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_dispute_case_id` FOREIGN KEY (`dispute_case_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`dispute_case`(`dispute_case_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `payments_fintech_ecm`.`dispute`.`chargeback`(`chargeback_id`);

-- ========= transaction --> fraud (1 constraint(s)) =========
-- Requires: transaction schema, fraud schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);

-- ========= transaction --> fx (18 constraint(s)) =========
-- Requires: transaction schema, fx schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_payment_corridor_id` FOREIGN KEY (`payment_corridor_id`) REFERENCES `payments_fintech_ecm`.`fx`.`payment_corridor`(`payment_corridor_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_fx_fee_schedule_id` FOREIGN KEY (`fx_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`fx`.`fx_fee_schedule`(`fx_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_rate_id` FOREIGN KEY (`rate_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate`(`rate_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_rate_margin_config_id` FOREIGN KEY (`rate_margin_config_id`) REFERENCES `payments_fintech_ecm`.`fx`.`rate_margin_config`(`rate_margin_config_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_currency_pair_id` FOREIGN KEY (`currency_pair_id`) REFERENCES `payments_fintech_ecm`.`fx`.`currency_pair`(`currency_pair_id`);

-- ========= transaction --> gateway (15 constraint(s)) =========
-- Requires: transaction schema, gateway schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_response_id` FOREIGN KEY (`response_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`response`(`response_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_threeds_config_id` FOREIGN KEY (`threeds_config_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`threeds_config`(`threeds_config_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);

-- ========= transaction --> interchange (26 constraint(s)) =========
-- Requires: transaction schema, interchange schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_mdr_config_id` FOREIGN KEY (`mdr_config_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`mdr_config`(`mdr_config_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_billing_id` FOREIGN KEY (`billing_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`billing`(`billing_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_downgrade_id` FOREIGN KEY (`downgrade_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`downgrade`(`downgrade_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`qualification`(`qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_bin_interchange_rule_id` FOREIGN KEY (`bin_interchange_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`bin_interchange_rule`(`bin_interchange_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_cross_border_fee_rule_id` FOREIGN KEY (`cross_border_fee_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule`(`cross_border_fee_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_program_id` FOREIGN KEY (`program_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`program`(`program_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_cross_border_fee_rule_id` FOREIGN KEY (`cross_border_fee_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule`(`cross_border_fee_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_downgrade_id` FOREIGN KEY (`downgrade_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`downgrade`(`downgrade_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_irf_table_id` FOREIGN KEY (`irf_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_table`(`irf_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_pricing_exception_id` FOREIGN KEY (`pricing_exception_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`pricing_exception`(`pricing_exception_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`qualification`(`qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_scheme_fee_table_id` FOREIGN KEY (`scheme_fee_table_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`scheme_fee_table`(`scheme_fee_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_cross_border_fee_rule_id` FOREIGN KEY (`cross_border_fee_rule_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`cross_border_fee_rule`(`cross_border_fee_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ADD CONSTRAINT `fk_transaction_txn_type_irf_rate_category_id` FOREIGN KEY (`irf_rate_category_id`) REFERENCES `payments_fintech_ecm`.`interchange`.`irf_rate_category`(`irf_rate_category_id`);

-- ========= transaction --> ledger (4 constraint(s)) =========
-- Requires: transaction schema, ledger schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_accounting_period_id` FOREIGN KEY (`accounting_period_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`accounting_period`(`accounting_period_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`cost_center`(`cost_center_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`gl_account`(`gl_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `payments_fintech_ecm`.`ledger`.`legal_entity`(`legal_entity_id`);

-- ========= transaction --> merchant (21 constraint(s)) =========
-- Requires: transaction schema, merchant schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_sub_merchant_id` FOREIGN KEY (`sub_merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`sub_merchant`(`sub_merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_location_id` FOREIGN KEY (`location_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`location`(`location_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_merchant_fee_schedule_id` FOREIGN KEY (`merchant_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_fee_schedule`(`merchant_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `payments_fintech_ecm`.`merchant`.`merchant`(`merchant_id`);

-- ========= transaction --> network (17 constraint(s)) =========
-- Requires: transaction schema, network schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `payments_fintech_ecm`.`network`.`sla`(`sla_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_multi_network_routing_id` FOREIGN KEY (`multi_network_routing_id`) REFERENCES `payments_fintech_ecm`.`network`.`multi_network_routing`(`multi_network_routing_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_network_routing_rule_id` FOREIGN KEY (`network_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_routing_rule`(`network_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_scheme_fee_schedule_id` FOREIGN KEY (`scheme_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_fee_schedule`(`scheme_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= transaction --> partner (10 constraint(s)) =========
-- Requires: transaction schema, partner schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_partner_api_credential_id` FOREIGN KEY (`partner_api_credential_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_api_credential`(`partner_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_revenue_share_schedule_id` FOREIGN KEY (`revenue_share_schedule_id`) REFERENCES `payments_fintech_ecm`.`partner`.`revenue_share_schedule`(`revenue_share_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= transaction --> product (12 constraint(s)) =========
-- Requires: transaction schema, product schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_interchange_qualification_id` FOREIGN KEY (`interchange_qualification_id`) REFERENCES `payments_fintech_ecm`.`product`.`interchange_qualification`(`interchange_qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `payments_fintech_ecm`.`product`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_product_pricing_plan_id` FOREIGN KEY (`product_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_pricing_plan`(`product_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_interchange_qualification_id` FOREIGN KEY (`interchange_qualification_id`) REFERENCES `payments_fintech_ecm`.`product`.`interchange_qualification`(`interchange_qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_a2a_product_id` FOREIGN KEY (`a2a_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`a2a_product`(`a2a_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_interchange_qualification_id` FOREIGN KEY (`interchange_qualification_id`) REFERENCES `payments_fintech_ecm`.`product`.`interchange_qualification`(`interchange_qualification_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_p2p_product_id` FOREIGN KEY (`p2p_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`p2p_product`(`p2p_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_product_pricing_plan_id` FOREIGN KEY (`product_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_pricing_plan`(`product_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_virtual_account_product_id` FOREIGN KEY (`virtual_account_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`virtual_account_product`(`virtual_account_product_id`);

-- ========= transaction --> risk (7 constraint(s)) =========
-- Requires: transaction schema, risk schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_lifecycle_event` ADD CONSTRAINT `fk_transaction_txn_lifecycle_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `payments_fintech_ecm`.`risk`.`event`(`event_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `payments_fintech_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_type` ADD CONSTRAINT `fk_transaction_txn_type_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_limit_rule` ADD CONSTRAINT `fk_transaction_txn_limit_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`policy`(`policy_id`);

-- ========= transaction --> settlement (24 constraint(s)) =========
-- Requires: transaction schema, settlement schema
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`payment_txn` ADD CONSTRAINT `fk_transaction_payment_txn_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`authorization` ADD CONSTRAINT `fk_transaction_authorization_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`capture` ADD CONSTRAINT `fk_transaction_capture_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`clearing_submission` ADD CONSTRAINT `fk_transaction_clearing_submission_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reversal` ADD CONSTRAINT `fk_transaction_reversal_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`refund` ADD CONSTRAINT `fk_transaction_refund_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction_batch` ADD CONSTRAINT `fk_transaction_transaction_batch_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`cycle`(`cycle_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`reconciliation` ADD CONSTRAINT `fk_transaction_reconciliation_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_routing_decision` ADD CONSTRAINT `fk_transaction_txn_routing_decision_acquirer_id` FOREIGN KEY (`acquirer_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`acquirer`(`acquirer_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_merchant_payout_id` FOREIGN KEY (`merchant_payout_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`merchant_payout`(`merchant_payout_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`txn_fee` ADD CONSTRAINT `fk_transaction_txn_fee_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`fx_conversion` ADD CONSTRAINT `fk_transaction_fx_conversion_instruction_id` FOREIGN KEY (`instruction_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`instruction`(`instruction_id`);
ALTER TABLE `payments_fintech_ecm`.`transaction`.`transaction` ADD CONSTRAINT `fk_transaction_transaction_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `payments_fintech_ecm`.`settlement`.`settlement`(`settlement_id`);

